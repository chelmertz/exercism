import gleam/dict.{type Dict}
import gleam/result

pub type ScoreBoard =
  Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  let sb = dict.new()
  sb |> add_player("The Best Ever", 1_000_000)
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  score_board |> dict.insert(player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  score_board |> dict.delete(player)
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  score_board
    |> dict.get(player)
    |> result.map(fn(x) {
      score_board |> dict.insert(player, points+x)
    })
    |> result.unwrap(score_board)
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  score_board |> dict.map_values(fn(_, x) {x+100}) 
}
