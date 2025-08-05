import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  Ok(game)
    |> result.try(rule1)
    |> result.map(with: fn(x: Game) { rule2(x) })
    |> result.try(rule3)
    |> result.try(rule4)
    |> result.map(with: fn(x: Game) { Game(..x, player: case x.player {Black -> White _ -> Black}) })
    |> result.map_error(with: fn(e) { Game(..game, error: e)})
    |> result.unwrap_both()
}
