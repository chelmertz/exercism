let square_of_sum (n: int) =
  let rec aux (x: int) (acc: int) =
    if x <= 0 then acc * acc
    else aux (x-1) (acc+x)
  in
  aux n 0

let sum_of_squares n =
  let rec aux (x: int) (acc: int) =
    if x <= 0 then acc
    else aux (x-1) (acc+(x*x))
  in
  aux n 0

let difference_of_squares x =
  Int.abs ((sum_of_squares x) - (square_of_sum x))
