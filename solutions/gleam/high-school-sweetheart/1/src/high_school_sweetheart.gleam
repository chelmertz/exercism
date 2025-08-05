import gleam/string
import gleam/list

pub fn first_letter(name: String) -> String {
  let assert Ok(f) = name |> string.trim() |> string.first()
  f
}

pub fn initial(name: String) -> String {
  first_letter(name) |> string.uppercase() <>"."
}

pub fn initials(full_name: String) -> String {
  full_name
    |> string.split(on: " ")
    |> list.map(initial)
    |> string.join(with: " ")
}

pub fn pair(f1: String, f2: String) -> String { 
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     "<>initials(f1)<>"  +  "<>initials(f2)<>"     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
