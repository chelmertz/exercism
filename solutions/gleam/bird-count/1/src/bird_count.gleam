import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [h, ..] -> h
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [h, ..tail] -> [h+1, ..tail]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [h, ..] if h == 0 -> True
    [_, ..tail] -> has_day_without_birds(tail)
  }
}

fn tot(rest: List(Int), sum: Int) -> Int {
  case rest {
    [] -> sum
    [h, ..tail] -> tot(tail, sum+h)
  }
}
pub fn total(days: List(Int)) -> Int {
  tot(days, 0)
}

pub fn busy_days(days: List(Int)) -> Int {
  days |> list.fold(0, fn(acc, curr) { case curr >= 5 { True -> acc + 1 False -> acc } })
}
