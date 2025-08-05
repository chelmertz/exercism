import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Ok(_) as tt -> tt
    _ -> {
      use e <- result.try(experiment())
      Ok(e)
    }
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let res = experiment()
  time_logger()
  res
} 

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use set <- result.try(setup())
  use act <- result.try(action(set))
  use rec <- result.try(record(set, act)) 
  Ok(#(name, rec))
}
