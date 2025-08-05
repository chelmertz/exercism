import gleam/int
import gleam/list

pub fn convert(number: Int) -> String {
let res = list.fold(
[#(3, "Pling"), #(5, "Plang"), #(7, "Plong")],
"",
fn (acc, a) {
  acc<>case number % a.0 == 0 { True -> a.1 _ -> ""}
})
case res {"" -> int.to_string(number) x -> x}

}
