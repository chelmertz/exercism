import gleam/int
import gleam/list
import gleam/string
import gleam/result

// having the public functions first (and "main()" later) seems like a good idea
pub fn is_valid(isbn: String) -> Bool {
  isbn
    |> string.to_graphemes()
    |> check_recur(0, 0)
}

fn check_recur(left: List(String), index: Int, checksum: Int) -> Bool {
  case index, left, checksum {
    10, [], sum -> sum % 11 == 0 // done 
    10, _, _ -> False // too many chars, left is not empty
    i, [], _ if i < 9 -> False // too few chars, left is prematurely empty
    i, ["-", ..tail], sum -> check_recur(tail, i, sum) // "-" is valid but must not inc. index (of valid output)
    9, ["X"], sum -> check_recur([], 10, sum+10) // "X" can only be at the end (no tail + index is 9)
    i, [head, ..tail], sum -> {
      let as_num = int.parse(head)
      case as_num {
        Error(_) -> False
        Ok(x) -> check_recur(tail, i+1, sum + {{10-i}*x})
      }
    }
    _, _, _ -> False
  }
}
