import gleam/string

pub fn reverse(value: String) -> String {
  rev(value, [])
}

fn rev(left: String, done: List(String)) {
  case string.pop_grapheme(left) {
    Error(Nil) -> string.join(done, "")
    Ok(#(head, tail)) -> rev(tail, [head, ..done])
  }
}
