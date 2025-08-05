import gleam/order.{type Order}
import gleam/float
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.}/. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Celsius(c1), Celsius(c2) -> float.compare(c1, c2)
    Fahrenheit(c1), Fahrenheit(c2) -> float.compare(c1, c2)
    Celsius(c1), Fahrenheit(c2) -> float.compare(c1, fahrenheit_to_celsius(c2))
    Fahrenheit(c1), Celsius(c2) -> float.compare(fahrenheit_to_celsius(c1), c2)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  cities |> list.sort(fn (x, y) { compare_temperature(x.temperature, y.temperature) })
}
