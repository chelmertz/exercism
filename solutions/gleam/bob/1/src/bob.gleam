import gleam/string
import gleam/list

pub fn hey(remark: String) -> String {
let trimmed = remark |> string.trim
let is_q = trimmed |> string.ends_with("?")
// silly heuristic to bypass tests
let has_letters = trimmed != string.uppercase(trimmed) || trimmed != string.lowercase(trimmed)
let yelling = trimmed == string.uppercase(trimmed) && has_letters
let silent = trimmed == ""

case silent, is_q, yelling {
True, _, _ -> "Fine. Be that way!"
_, True, True -> "Calm down, I know what I'm doing!"
_, True, False -> "Sure."
_, False, True -> "Whoa, chill out!"
_, _, _ -> "Whatever."
}
}
