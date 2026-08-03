import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Word =
  fn(Forth) -> Result(Forth, ForthError)

pub opaque type Forth {
  Forth(stack: List(Int), words: Dict(String, Word))
}

pub type ForthError {
  InvalidWord
  UnknownWord
  StackUnderflow
  DivisionByZero
}

fn binop(op: fn(Int, Int) -> Result(Int, ForthError)) -> Word {
  fn(f: Forth) {
    case f.stack {
      [a, b, ..t] ->
        op(b, a) |> result.map(fn(n) { Forth(..f, stack: [n, ..t]) })
      _ -> Error(StackUnderflow)
    }
  }
}

pub fn new() -> Forth {
  let words =
    dict.new()
    |> dict.insert("+", binop(fn(x, y) { Ok(x + y) }))
    |> dict.insert("-", binop(fn(x, y) { Ok(x - y) }))
    |> dict.insert("*", binop(fn(x, y) { Ok(x * y) }))
    |> dict.insert(
      "/",
      binop(fn(x, y) {
        case y {
          0 -> Error(DivisionByZero)
          _ -> Ok(x / y)
        }
      }),
    )
    |> dict.insert("dup", fn(f: Forth) {
      case f.stack {
        [h, ..t] -> Ok(Forth(..f, stack: [h, h, ..t]))
        _ -> Error(StackUnderflow)
      }
    })
    |> dict.insert("drop", fn(f: Forth) {
      case f.stack {
        [_, ..t] -> Ok(Forth(..f, stack: t))
        _ -> Error(StackUnderflow)
      }
    })
    |> dict.insert("swap", fn(f: Forth) {
      case f.stack {
        [a, b, ..t] -> Ok(Forth(..f, stack: [b, a, ..t]))
        _ -> Error(StackUnderflow)
      }
    })
    |> dict.insert("over", fn(f: Forth) {
      case f.stack {
        [a, b, ..t] -> Ok(Forth(..f, stack: [b, a, b, ..t]))
        _ -> Error(StackUnderflow)
      }
    })

  Forth(stack: [], words:)
}

pub fn format_stack(f: Forth) -> String {
  f.stack
  |> list.reverse
  |> list.map(int.to_string)
  |> string.join(" ")
}

fn resolve(f: Forth, token: String) -> Result(Word, ForthError) {
  case int.parse(token) {
    Ok(n) -> Ok(fn(f: Forth) { Ok(Forth(..f, stack: [n, ..f.stack])) })
    Error(Nil) ->
      dict.get(f.words, string.lowercase(token))
      |> result.replace_error(UnknownWord)
  }
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  eval_tokens(f, string.split(prog, " "))
}

fn eval_tokens(f: Forth, tokens: List(String)) -> Result(Forth, ForthError) {
  case tokens {
    [":", name, ..t] -> {
      use <- bool.guard(
        when: result.is_ok(int.parse(name)),
        return: Error(InvalidWord),
      )

      let #(body, rest) = t |> list.split_while(fn(e) { e != ";" })
      use rest <- result.try(case rest {
        [";", ..t] -> Ok(t)
        _ -> Error(InvalidWord)
      })

      use body <- result.try(list.try_map(body, resolve(f, _)))

      let wdef = fn(f: Forth) -> Result(Forth, ForthError) {
        body |> list.try_fold(f, fn(acc, w) { w(acc) })
      }

      // normalize name to lowercase, to sync with how words are resolved
      let name = string.lowercase(name)
      let words = f.words |> dict.insert(name, wdef)
      eval_tokens(Forth(..f, words:), rest)
    }
    [":", ..] -> Error(InvalidWord)
    [h, ..t] ->
      resolve(f, h)
      |> result.try(fn(w) { w(f) })
      |> result.try(eval_tokens(_, t))
    [] -> Ok(f)
  }
}
