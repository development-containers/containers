import gleam/dynamic
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import lustre
import lustre/attribute
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/event
import lustre_http

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub type Cat {
  Cat(id: String, url: String)
}

pub type Model {
  Model(count: Int, cats: List(Cat), ip: Option(Result(String, String)))
}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  let ip_effect =
    lustre_http.get(
      "https://api.ipify.org",
      lustre_http.expect_text(ApiReturnedIpAddress),
    )
  #(Model(count: 0, cats: [], ip: None), ip_effect)
}

pub type Msg {
  UserIncrementedCount
  UserDecrementedCount
  ApiReturnedCats(Result(List(Cat), lustre_http.HttpError))
  ApiReturnedIpAddress(Result(String, lustre_http.HttpError))
}

pub fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  io.debug(msg)
  case msg {
    UserIncrementedCount -> #(Model(..model, count: model.count + 1), get_cat())
    UserDecrementedCount -> #(
      Model(..model, count: model.count - 1, cats: list.drop(model.cats, 1)),
      effect.none(),
    )
    ApiReturnedCats(Ok(api_cats)) -> {
      let assert [cat, ..] = api_cats
      #(Model(..model, cats: [cat, ..model.cats]), effect.none())
    }
    ApiReturnedCats(Error(_)) -> {
      #(model, effect.none())
    }
    ApiReturnedIpAddress(Error(err)) -> #(
      Model(..model, ip: Some(Error(string.inspect(err)))),
      effect.none(),
    )
    ApiReturnedIpAddress(Ok(ip)) -> #(
      Model(..model, ip: Some(Ok(ip))),
      effect.none(),
    )
  }
}

fn get_cat() -> effect.Effect(Msg) {
  let decoder =
    dynamic.decode2(
      Cat,
      dynamic.field("id", dynamic.string),
      dynamic.field("url", dynamic.string),
    )
  let expect = lustre_http.expect_json(dynamic.list(decoder), ApiReturnedCats)

  lustre_http.get("https://api.thecatapi.com/v1/images/search", expect)
}

pub fn view(model: Model) -> element.Element(Msg) {
  let count = int.to_string(model.count)
  let ip_view = case model.ip {
    None -> element.none()
    Some(Ok(ip)) -> html.span([], [html.text(ip)])
    Some(Error(err)) ->
      html.span([attribute.style([#("color", "red")])], [html.text(err)])
  }

  html.div([], [
    ip_view,
    number_selector_view(count),
    element.keyed(
      html.div([], _),
      list.map(model.cats, fn(cat) { #(cat.url, cat_picture(cat)) }),
    ),
  ])
}

fn number_selector_view(count: String) -> element.Element(Msg) {
  html.div([], [
    html.button([event.on_click(UserIncrementedCount)], [element.text("+")]),
    element.text(count),
    html.button([event.on_click(UserDecrementedCount)], [element.text("-")]),
  ])
}

fn cat_picture(cat: Cat) -> element.Element(a) {
  html.img([
    attribute.src(cat.url),
    attribute.class("cat-img"),
    attribute.height(200),
  ])
}
