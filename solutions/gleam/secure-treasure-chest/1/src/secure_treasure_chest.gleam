import gleam/string

pub opaque type TreasureChest(a) {
  TreasureChest(password: String, contents: a)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case password |> string.length() {
    x if x >= 8 -> Ok(TreasureChest(password:,contents:))
    _ -> Error("Password must be at least 8 characters long")
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest {
    TreasureChest(password: p, contents: t) if p == password -> Ok(t)
    _ -> Error("Incorrect password")    
  }
}
