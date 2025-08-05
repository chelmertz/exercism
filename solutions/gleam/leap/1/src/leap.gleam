pub fn is_leap_year(year: Int) -> Bool {
  case year {
y if y % 4 != 0 -> False
y if y % 100 == 0 && y % 400 != 0 -> False
_ -> True
  }
}
