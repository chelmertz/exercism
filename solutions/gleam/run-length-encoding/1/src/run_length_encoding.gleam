import gleam/string
import gleam/int

fn out_with_count(char: String, count: Int) -> String {
  case count {
    1 -> char
    _ -> int.to_string(count)<>char
  }
}

fn enc(rest: List(String), prev: String, count: Int, out: String) -> String {
  case rest {
    [] -> out<>out_with_count(prev, count)
    [h, ..tail] if h == prev -> enc(tail, h, count+1, out)
    [h, ..tail] -> enc(tail, h, 1, out<>out_with_count(prev, count))
  }
}
 
pub fn encode(plaintext: String) -> String {
  plaintext |> string.to_graphemes() |> enc("", 1, "")
}

fn dec(rest: List(String), multiplier: Int, out: String) -> String {
  case rest {
    [] -> out
    [h, ..tail]-> {
      case int.parse(h), multiplier {
        Error(Nil), _ -> {
          case multiplier {
            0 -> dec(tail, 0, out<>h)
            _ -> dec(tail, 0, out<>string.repeat(h, multiplier))
          }
        }
        Ok(num), _ -> {
          let multiplier = case multiplier {
            0 -> num
            _ -> {multiplier*10}+num
          }
          dec(tail, multiplier, out)
        }
      }
    }
  }
}

pub fn decode(ciphertext: String) -> String {
  ciphertext |> string.to_graphemes() |> dec(0, "")  
}


