import gleam/dynamic
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import gleam/uri.{type Uri}
import lustre
import lustre/attribute
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/event
import lustre_http
import modem

import alpha_input

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub type Cat {
  Cat(id: String, url: String)
}

pub type Route {
  CatCounter
  Info
}

pub type Model {
  Model(
    count: Int,
    cats: List(Cat),
    ip: Option(Result(String, String)),
    route: Route,
    input: alpha_input.Model,
  )
}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  let ip_effect =
    lustre_http.get(
      "https://api.ipify.org",
      lustre_http.expect_text(ApiReturnedIpAddress),
    )
  #(
    Model(
      count: 0,
      cats: [],
      ip: None,
      route: CatCounter,
      input: alpha_input.init(),
    ),
    effect.batch([ip_effect, modem.init(on_url_change)]),
  )
}

fn on_url_change(uri: Uri) -> Msg {
  case uri.path_segments(uri.path) {
    ["cats"] -> OnRouteChange(CatCounter)
    ["info"] -> OnRouteChange(Info)
    _ -> OnRouteChange(Info)
  }
}

pub type Msg {
  UserIncrementedCount
  UserDecrementedCount
  ApiReturnedCats(Result(List(Cat), lustre_http.HttpError))
  ApiReturnedIpAddress(Result(String, lustre_http.HttpError))
  OnRouteChange(Route)
  NameUpdated(alpha_input.Msg)
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
    OnRouteChange(new_route) -> #(
      Model(..model, route: new_route),
      effect.none(),
    )
    NameUpdated(msg) -> #(
      Model(..model, input: alpha_input.update(model.input, msg)),
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
  let ip_view = case model.ip {
    None -> element.none()
    Some(Ok(ip)) -> html.span([], [html.text("Your ip is: "), html.text(ip)])
    Some(Error(err)) ->
      html.span([attribute.style([#("color", "red")])], [html.text(err)])
  }

  html.div([attribute.class("page__container")], [
    html.h1([], [html.text("Hello Gleam!")]),
    html.main([attribute.class("page__main")], [
      case model.route {
        CatCounter -> cat_counter_view(model)
        Info -> info_view(model)
      },
    ]),
    html.footer([attribute.class("page__footer")], [
      html.div([], [html.text("this is an example gleam app")]),
      ip_view,
      alpha_input.view(model.input, NameUpdated),
    ]),
  ])
}

fn info_view(_: Model) -> element.Element(a) {
  html.div([], [
    html.h2([], [html.text("Info page")]),
    html.ul([], [
      html.li([], [html.a([attribute.href("/foo")], [html.text("foo")])]),
      html.li([], [
        html.a([attribute.href("/cats")], [html.text("cat counter")]),
      ]),
    ]),
  ])
}

fn cat_counter_view(model: Model) -> element.Element(Msg) {
  let count = int.to_string(model.count)

  element.fragment([
    html.a([attribute.href("/info")], [element.text("go to info")]),
    number_selector_view(count),
    element.keyed(
      html.div(
        [
          attribute.style([
            #("display", "flex"),
            #("flex-wrap", "wrap"),
            #("gap", "1rem"),
            #("padding-bottom", "1.5rem"),
          ]),
        ],
        _,
      ),
      list.map(model.cats, fn(cat) { #(cat.url, cat_picture(cat)) }),
    ),
  ])
}

fn number_selector_view(count: String) -> element.Element(Msg) {
  html.div([attribute.class("counter")], [
    html.button([event.on_click(UserIncrementedCount), attribute.class("btn")], [
      element.text("+"),
    ]),
    html.span([attribute.class("counter__text")], [element.text(count)]),
    html.button([event.on_click(UserDecrementedCount), attribute.class("btn")], [
      element.text("-"),
    ]),
  ])
}

fn cat_picture(cat: Cat) -> element.Element(a) {
  html.img([
    attribute.src(cat.url),
    attribute.class("cat-img"),
    attribute.height(200),
    attribute.style([
      #("flex", "1"),
      #("object-fit", "cover"),
      #("border", "1px solid #ddd"),
    ]),
  ])
}
