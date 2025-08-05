pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(on: Pizza)
  ExtraToppings(on: Pizza)
}

fn pprice(pizza: Pizza, total: Int) -> Int {
  case pizza {
    Margherita -> 7 + total
    Caprese -> 9 + total
    Formaggio -> 10 + total
    ExtraSauce(on: x) -> pprice(x, total + 1)
    ExtraToppings(on: x) -> pprice(x, total + 2)
  }
}
pub fn pizza_price(pizza: Pizza) -> Int {
  pprice(pizza, 0)
}

fn order_inc_fee(rest: List(Pizza), sum: Int, count: Int) -> Int {
  case rest, count {
    [], 1 -> sum + 3
    [], 2 -> sum + 2
    [], _ -> sum
    [h, ..tail], _ -> order_inc_fee(tail, sum+pizza_price(h), count+1)
  }
}
pub fn order_price(order: List(Pizza)) -> Int {
  order_inc_fee(order, 0, 0)
}
