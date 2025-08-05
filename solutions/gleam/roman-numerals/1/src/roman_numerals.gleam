pub fn convert(number: Int) -> String {
  number |> helper("")
}

fn helper(left: Int, done: String) -> String {
  case left {
    0 -> done
    x if x > 3999 -> panic as "too large"
    x if x < 0 -> panic as "too small"
    x if x >= 1000 -> helper(left - 1000, done<>"M")
    x if x >= 900 -> helper(left - 900, done<>"CM")
    x if x >= 500 -> helper(left - 500, done<>"D")
    x if x >= 400 -> helper(left - 400, done<>"CD")
    x if x >= 100 -> helper(left - 100, done<>"C")
    x if x >= 90 -> helper(left - 90, done<>"XC")
    x if x >= 50 -> helper(left - 50, done<>"L")
    x if x >= 40 -> helper(left - 40, done<>"XL")
    x if x >= 10 -> helper(left - 10, done<>"X")
    x if x >= 9 -> helper(left - 9, done<>"IX")
    x if x >= 5 -> helper(left - 5, done<>"V")
    x if x >= 4 -> helper(left - 4, done<>"IV")
    x if x >= 1 -> helper(left - 1, done<>"I")
    x -> panic as "unmatched"
  }
}
