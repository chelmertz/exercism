import gleam/string
import gleam/list
import gleam/dict.{type Dict}

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  legacy |> dict.fold(dict.new(), fn(acc, k, v) { v |> list.fold(acc, fn(acc_, x) { acc_ |> dict.insert(string.lowercase(x), k) }) })
}
