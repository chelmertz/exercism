// Please define the TreasureChest generic custom type
pub type TreasureChest(a) {
TreasureChest(password: String, value: a)
}
// Please define the UnlockResult generic custom type
pub type UnlockResult(a) {
Unlocked(a)
WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  pw: String,
) -> UnlockResult(treasure) {
  case chest {
TreasureChest(password:, value:) if password == pw -> Unlocked(value)
_ -> WrongPassword
  }
}
