import gleam/list
fn keeper(list: List(t), predicate: fn(t) -> Bool, done: List(t)) -> List(t) {
  case list {
    [] -> list.reverse(done)
    [h, ..tail] -> case predicate(h) {
      True -> keeper(tail, predicate, [h, ..done])
      False -> keeper(tail, predicate, done)
    }
  }
}
pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keeper(list, predicate, [])
}

fn not(predicate: fn(t) -> Bool) -> fn(t) -> Bool {
  fn(x) { !predicate(x) }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keeper(list, not(predicate), [])
}
