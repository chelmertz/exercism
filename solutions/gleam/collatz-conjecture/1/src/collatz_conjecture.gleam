pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number {
    x if x < 1 -> Error(NonPositiveNumber)
    _ -> Ok(collatz(number, 0))
  }
}

fn collatz(num: Int, steps: Int) -> Int {
  case num {
    1 -> steps
    x if x % 2 == 0 -> collatz(x/2, steps+1)
    x -> collatz({x*3}+1, steps+1)
  }
}
