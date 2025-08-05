import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list |> list.filter(predicate)
}

fn not(predicate: fn(t) -> Bool) -> fn(t) -> Bool {
  fn(x) { !predicate(x) }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list |> list.filter(not(predicate))
}
