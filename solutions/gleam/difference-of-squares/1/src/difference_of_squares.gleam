import gleam/int
import gleam/float
import gleam/result

fn square_sum(n: Int, acc: Int) -> Int{
case n {
0 -> acc
x if x > 0 -> square_sum(x-1, acc+x)
_ -> panic
}
}

pub fn square_of_sum(n: Int) -> Int {
let sum = square_sum(n, 0)
squared(sum)
}

fn squared(n: Int) -> Int {
let assert Ok(res) = n |> int.power(of: 2.0) |> result.map(float.round(_))
res
}

fn squaredf(n: Int) -> Float {
let assert Ok(res) = n |> int.power(of: 2.0)
res
}

fn sum_square(n: Int, acc: Float) -> Float{
case n {
0 -> acc
x if x > 0 -> sum_square(x-1, acc +. squaredf(x))
_ -> panic
}
}
pub fn sum_of_squares(n: Int) -> Int {
sum_square(n, 0.0) |> float.round()
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
