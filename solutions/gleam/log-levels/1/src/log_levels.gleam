pub fn message(log_line: String) -> String {
  let ret = case log_line {
"[INFO]: " <> msg -> msg
"[ERROR]: " <> msg -> msg
"[WARNING]: " <> msg -> msg
_ -> panic
  }
ret |> string.trim
}
import gleam/string

pub fn log_level(log_line: String) -> String {
  case log_line {
"[INFO]: " <> _ -> "info"
"[ERROR]: " <> _ -> "error"
"[WARNING]: " <> _ -> "warning"
_ -> panic
  }
}

pub fn reformat(log_line: String) -> String {
  let level = log_line |> log_level
  log_line |> message <> " ("<>level<>")"
}
