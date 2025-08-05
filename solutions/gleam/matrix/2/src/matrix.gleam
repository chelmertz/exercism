import gleam/string
import gleam/list
import gleam/int
import gleam/result
import gleam/bool

fn nth(in: List(a), index: Int) -> List(a) {
  in |> list.drop(index-1) |> list.take(1)
}

fn strs_to_ints(s: List(String)) -> List(Int) {
  s |> list.map(fn(x) {
    let assert Ok(n) = int.parse(x)
    n
  })
}

pub fn row(index: Int, s: String) -> Result(List(Int), Nil) {
  let row_: List(String) = s
  |> string.split("\n")
  |> nth(index)

  case row_ {
    [] -> Error(Nil)
    [x] -> x |> string.split(" ") |> strs_to_ints() |> Ok()
    _ -> panic as "what"
  }
}

pub fn column(index: Int, s: String) -> Result(List(Int), Nil) {
  let cols: List(String)  = s
  |> string.split("\n")
  |> list.map(string.split(_, " "))
  |> list.map(nth(_, index))
  |> list.flatten()

  case cols {
    [] -> Error(Nil) 
    _ -> Ok(strs_to_ints(cols))
  }
}
