import gleam/string
import gleam/list
import gleam/int
import gleam/result

fn double_num(num: Int) -> Int {
  case num*2 {
    x if x < 10 -> x
    x -> x-9
  }
}

fn double_some(rest: List(Int), done: List(Int)) -> List(Int) {
  case rest {
    [] -> done |> list.reverse()
    [h, h2, ..tail] -> double_some(tail, [h, double_num(h2), ..done])
    [h, ..] -> double_some([], [h, ..done])
  }
}

fn validate_sum(nums: List(Int)) -> Bool {
  int.sum(nums) % 10 == 0
}

pub fn valid(value: String) -> Bool {
  value
    |> string.to_graphemes()
    |> list.filter(fn(x) { x != " "})
    |> list.map(int.parse)
    |> result.all() // all int.parse() calls are Ok
    |> result.try(fn(x) { case list.length(x)>1 { True -> Ok(x) False -> Error(Nil)}})
    |> result.map(fn(x) { x |> list.reverse() |> double_some([]) |> validate_sum() })
    |> result.unwrap(or: False)
}
