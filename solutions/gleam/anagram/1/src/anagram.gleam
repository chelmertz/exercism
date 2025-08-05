import gleam/list
import gleam/string

fn comparable(s: String) -> List(String) {
  s |> string.to_graphemes() |> list.sort(string.compare)
}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word = string.lowercase(word)
  let subject = comparable(word)
  candidates
    |> list.filter(fn(x) {
      let x = string.lowercase(x)
      x != word && comparable(x) == subject
    })
}
