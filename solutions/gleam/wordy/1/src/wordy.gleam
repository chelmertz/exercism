import gleam/list
import gleam/int
import gleam/string
import exercism/test_runner.{ debug }

pub type Error {
  SyntaxError
  UnknownOperation
  ImpossibleOperation
}

type Term {
  Number(num: Int)
  Mult
  Div
  Plus
  Minus
  Err(error: Error)
}

pub fn answer(question: String) -> Result(Int, Error) {
  case question {
    "What is " <> term -> {
      let cleaned = case term |> string.ends_with("?") {
        True -> term |> string.drop_end(1)
        False -> term
      }
      cleaned |> string.split(" ") |> lex([]) |> debug |> solve(0)
    }
    "What is?" -> Error(SyntaxError) // sigh, this is a cop-out.. the rules are fuzzy
    _ -> Error(UnknownOperation)
  }
}

fn lex(terms: List(String), out: List(Term)) -> List(Term) {
  case terms {
    [] -> list.reverse(out)
    ["multiplied", "by", num, ..tail] -> lex([num, ..tail], [Mult, ..out])
    // the rules for SyntaxError vs UnknownOperation is a bit loosy-goosy IMO.. OK then, let's match the "no operands or operators" tests
    ["multiplied", "by"] -> lex([], [Err(SyntaxError), ..out])
    ["divided", "by", num, ..tail] -> lex([num, ..tail], [Div, ..out])
    ["divided", "by"] -> lex([], [Err(SyntaxError), ..out])
    ["minus", num, ..tail] -> lex([num, ..tail], [Minus, ..out])
    ["minus"] -> lex([], [Err(SyntaxError), ..out])
    ["plus", num, ..tail] -> lex([num, ..tail], [Plus, ..out])
    ["plus"] -> lex([], [Err(SyntaxError), ..out])
    [head, ..tail] -> {
      debug("looking at head=" <> head <>", tail="<>string.join(tail, ","))
      case int.parse(head), out {
        // leading number:
        Ok(num), [] -> lex(tail, [Number(num), ..out])
        Ok(num), [h, .._] -> case h {
          // number after a number, without a prefiexed operation:
          Number(_) -> lex([], [Err(SyntaxError), ..out])
          // number after an operation:
          Mult | Div | Plus | Minus -> lex(tail, [Number(num), ..out])
          // number after Err, will be caught in solve():
          Err(_) -> lex([], [Number(num), ..out])
        }
        Error(Nil), _ -> lex([], [Err(UnknownOperation), ..out])
      }
    }
  }
}

fn solve(input: List(Term), done: Int) -> Result(Int, Error) {
  case input {
    [] -> Ok(done)
    [Number(n), ..t] -> solve(t, n)
    [Mult, Number(n), ..t] -> solve(t, done*n)
    [Div, Number(n), ..t] -> case n {
      0 -> Error(ImpossibleOperation)
      _ -> solve(t, done/n)      
    }
    [Minus, Number(n), ..t] -> solve(t, done-n)
    [Plus, Number(n), ..t] -> solve(t, done+n)
    [Err(err), .._] -> Error(err)
    _ -> Error(SyntaxError)
  }
}