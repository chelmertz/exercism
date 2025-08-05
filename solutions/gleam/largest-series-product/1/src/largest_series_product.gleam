import gleam/list
import gleam/string
import gleam/result
import gleam/int

fn numbers(in: String) -> Result(List(Int), Nil) {
  string.to_graphemes(in)
    |> list.map(int.parse)
    |> result.all()
}

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  case numbers(digits), span {
    _, 0 -> Ok(1)
    Error(_), _ -> Error(Nil)
    Ok(nums), _ -> nums
      |> list.window(span)
      |> list.map(int.product)
      |> list.reduce(int.max)
  }
}
