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

fn validate(nums: List(Int)) -> Bool {
  int.sum(nums) % 10 == 0
}

pub fn valid(value: String) -> Bool {
  let res = value
    |> string.to_graphemes()
    |> list.filter(fn(x) { x != " "})
    |> list.map_fold(
      from: True,
      with: fn(acc, curr) {
        int.parse(curr)
          |> result.map(fn(x) { #(acc, x) })
          |> result.unwrap(#(False, 0))
      }
    )
  case res {
    // eh, this is layman Result.. refactor!
    #(False, _) -> False
    // "Strings of length 1 or less are not valid"
    #(_, []) | #(_, [_]) -> False
    // instructions says "start from the right" and test cases looks weird, best to take "from right" literally (reverse)
    #(True, [_, _, ..] as nums) -> nums |> list.reverse() |> double_some([]) |> validate()
  }

}
