import gleam/list
import gleam/string
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/event

pub opaque type Model {
  Model(value: String)
}

pub opaque type Msg {
  OnInput(String)
}

pub fn view(model: Model, on_input: fn(Msg) -> msg) -> element.Element(msg) {
  html.input([
    attribute.value(model.value),
    event.on_input(fn(new_value) { on_input(OnInput(new_value)) }),
  ])
}

pub fn update(model: Model, msg: Msg) -> Model {
  case msg {
    OnInput(value) -> {
      Model(value: filter(value))
    }
  }
}

pub fn init() -> Model {
  Model(value: "")
}

fn filter(str: String) -> String {
  let points = string.to_utf_codepoints(str)
  list.filter(points, is_alpha_numeric) |> string.from_utf_codepoints
}

fn is_alpha_numeric(point: UtfCodepoint) -> Bool {
  let int_value = string.utf_codepoint_to_int(point)
  let assert [a_codepoint] = string.to_utf_codepoints("a")
  let assert [z_codepoint] = string.to_utf_codepoints("z")
  let assert [upper_a_codepoint] = string.to_utf_codepoints("A")
  let assert [upper_z_codepoint] = string.to_utf_codepoints("Z")
  let assert [zero_codepoint] = string.to_utf_codepoints("0")
  let assert [nine_codepoint] = string.to_utf_codepoints("9")

  let a_int = string.utf_codepoint_to_int(a_codepoint)
  let z_int = string.utf_codepoint_to_int(z_codepoint)
  let upper_a_int = string.utf_codepoint_to_int(upper_a_codepoint)
  let upper_z_int = string.utf_codepoint_to_int(upper_z_codepoint)
  let zero_int = string.utf_codepoint_to_int(zero_codepoint)
  let nine_int = string.utf_codepoint_to_int(nine_codepoint)

  case True {
    _ if a_int <= int_value && int_value <= z_int -> True
    _ if upper_a_int <= int_value && int_value <= upper_z_int -> True
    _ if zero_int <= int_value && int_value <= nine_int -> True
    _ -> False
  }
}
