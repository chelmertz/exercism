import gleam/set.{type Set}
import gleam/list
import gleam/result
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(collection |> set.contains(card), collection |> set.insert(card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let res = collection |> set.delete(my_card) |> set.insert(their_card)
  let possible = collection |> set.contains(my_card) && !{collection |> set.contains(their_card)}
  #(possible, res)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  collections
  |> list.reduce(fn (a, b) { set.intersection(a, b) })
  |> result.map(fn (x) { set.to_list(x) |> list.sort(string.compare) })
  |> result.unwrap([])
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections
  |> list.reduce(fn (a, b) { set.union(a, b) })
  |> result.map(fn (x) { x |> set.size() })
  |> result.unwrap(0)
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection |> set.filter(fn (x) {case x {"Shiny "<>_ -> True _ -> False}})
}
