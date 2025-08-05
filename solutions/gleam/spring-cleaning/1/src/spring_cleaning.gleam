import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(err) = problem
  err
}

pub fn remove_team_prefix(team: String) -> String {
  case team {
    "Team "<>x -> x
    x -> x
  }
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [region, team] = combined |> string.split(",")
  #(region, team |> remove_team_prefix)
}
