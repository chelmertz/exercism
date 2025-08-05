import gleam/float.{loosely_compare}
import gleam/list
import gleam/order.{Eq,Gt}

fn gt(a: Float, b: Float) -> Bool {
  loosely_compare(a, b, 0.00001) == Gt
}

fn eq(a: Float, b: Float) -> Bool {
  loosely_compare(a, b, 0.00001) == Eq
}

fn is_triangle(a: Float, b: Float, c: Float) -> Bool {
  [a, b, c] |> list.all(gt(_, 0.0)) &&
  [a, b, c]
    |> list.permutations()
    |> list.all(fn(l) {
      let assert [x, y, z] = l
      gt(x +. y, z)
    })
}

pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  is_triangle(a, b, c) && a == b && b == c
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  is_triangle(a, b, c) &&
  [a, b, c]
    |> list.permutations()
    |> list.any(fn(l) {
      let assert [x, y, _] = l
      eq(x, y)
    })
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  is_triangle(a, b, c) &&
  [a, b, c]
    |> list.permutations()
    |> list.all(fn(l) {
      let assert [x, y, _] = l
      !eq(x, y)
    })
}
