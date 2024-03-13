import gleam/pair
import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{type Option, None, Some}

pub type CollectorRegistry =
  Dict(String, Collector)

pub type Observatory {
  Observatory(registry: CollectorRegistry)
}

pub fn init() -> Observatory {
  Observatory(registry: dict.new())
}

pub type Counter =
  Float

pub type Collector {
  ACounter(Counter)
}

pub fn collect(observatory: Observatory) -> List(#(String, Float)) {
  dict.to_list(observatory.registry)
  |> list.map(fn(entry: #(String, Collector)) -> #(String, Float) {
    case pair.second(entry) {
      ACounter(counter) -> #(pair.first(entry), counter)
    }
  })
}

pub fn counter_init(observatory: Observatory, name: String) -> Observatory {
  Observatory(registry: dict.insert(observatory.registry, name, ACounter(0.0)))
}

pub fn counter_inc(observatory: Observatory, name: String) -> Observatory {
  counter_inc_by(observatory, name, 1.0)
}

pub fn counter_inc_by(
  observatory: Observatory,
  name: String,
  increment: Float,
) -> Observatory {
  Observatory(registry: dict.update(
    observatory.registry,
    name,
    inc_collector_by(increment),
  ))
}

fn inc_collector_by(increment: Float) -> fn(Option(Collector)) -> Collector {
  fn(opt_collector: Option(Collector)) -> Collector {
    case opt_collector {
      Some(collector) ->
        case collector {
          ACounter(collector) -> ACounter(collector +. increment)
        }
      None -> ACounter(increment)
    }
  }
}
