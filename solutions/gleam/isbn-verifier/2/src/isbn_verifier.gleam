import gleam/int
import gleam/list
import gleam/string
import gleam/result

// having the public functions first (and "main()" later) seems like a good idea
pub fn is_valid(isbn: String) -> Bool {
  isbn
    |> string.to_graphemes()
    |> list.filter(fn(x) { x != "-"})
    |> check_length()
    // seems like a good pattern to do result.Xyz() in a pipeline such as this, and act on real values as input to functions (but possibly return Result(), for the pipeline to flatten later)
    |> result.try(check_digits)
    |> result.map(check_sum)
    |> result.unwrap(or: False)
}

fn check_length(input: List(String)) -> Result(List(String), String) {
  case input |> list.length() {
    10 -> Ok(input)
    l -> Error("too many or few chars in input "<>int.to_string(l))
  }
}

fn check_digits(input: List(String)) -> Result(List(Int), String) {
  // is it idiomatic to start with piping input to fold_until(), or should I extract the accumulator to a function (if so, should it be called from pipeline or should this middle-step still exist); or something completely different?
  input |> list.fold_until(Ok([]), fn(acc, curr) {  
    // let assert will never fail, because we Continue(Ok) and Stop(Error)
    let assert Ok(digits) = acc
    let previous_len = digits |> list.length()
    let new_number: Result(Int, String) = curr
      |> int.parse()
      |> result.try_recover(fn(_) {
        // feels a bit weird to reach outside "closure" for curr, this
        // might be needed though since we cannot (?) do a
        // case x { i if int.parse(i).is_ok()... } -like check
        case curr {
          "X" if previous_len == 9 -> Ok(10)
          _ -> Error("invalid char: "<>curr)
        }
      })
    
    // using previous_len to avoid unpacking the new result,
    // since we must view the result from the outside anyway, to wrap
    // the result with ContinueOrStop
    // ... this might have been easier with recursion+helper+"Result() at the end", rather than Result() for every iteration (unwrapping as in this case{} and wrapping again, feels like an anti-pattern)
    case new_number, previous_len {
      Ok(x), l if l < 10 -> {
        // transform to the checksum
        let factor = 10-previous_len
        list.Continue(Ok([x*factor, ..digits]))
      }
      Ok(_), _ -> list.Stop(Error("too many chars in input"))
      // why doesn't the compiler realize that we're on the error path
      // and that the destructured String from Result(Int, String) can become Result(List(Int), String) in this path?
      // Error(_) as e, _ -> list.Stop(e)
      Error(e), _ -> list.Stop(Error(e))
    }
  })
}

fn check_sum(digits: List(Int)) -> Bool {
  int.sum(digits) % 11 == 0
}