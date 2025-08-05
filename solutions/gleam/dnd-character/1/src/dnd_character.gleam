import gleam/int
import gleam/list

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
let cons = ability()
  Character(
    charisma: ability(),
    constitution: cons,
    dexterity: ability(),
    hitpoints: 10+modifier(cons),
    intelligence: ability(),
    strength: ability(),
    wisdom: ability(),
  )
}

pub fn modifier(score: Int) -> Int {
  case score - 10 |> int.floor_divide(2) {
Ok(x) -> x
_ -> panic as "division failed"
  }
}

pub fn ability() -> Int {
let throws = [int.random(6), int.random(6), int.random(6), int.random(6)]
// int.compare = asc
// drop smallest (first)
// increase with one because we want 1-6, not 0-5
throws |> list.sort(by: int.compare) |> list.drop(up_to: 1) |> list.map(int.add(1, _)) |> int.sum
}
