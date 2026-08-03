import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

type Instruction {
  A
  L
  R
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction:, position:)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  move_(
    direction,
    position,
    instructions
      |> string.to_graphemes
      |> list.map(fn(i) {
        case i {
          "A" -> A
          "L" -> L
          "R" -> R
          x -> panic as { x <> " is not a valid instruction" }
        }
      }),
  )
}

fn move_(d: Direction, p: Position, instructions: List(Instruction)) -> Robot {
  case instructions {
    [] -> Robot(direction: d, position: p)
    [A, ..t] ->
      move_(
        d,
        case d {
          North -> Position(..p, y: p.y + 1)
          East -> Position(..p, x: p.x + 1)
          South -> Position(..p, y: p.y - 1)
          West -> Position(..p, x: p.x - 1)
        },
        t,
      )
    [L, ..t] ->
      move_(
        case d {
          North -> West
          East -> North
          South -> East
          West -> South
        },
        p,
        t,
      )
    [R, ..t] ->
      move_(
        case d {
          North -> East
          East -> South
          South -> West
          West -> North
        },
        p,
        t,
      )
  }
}
