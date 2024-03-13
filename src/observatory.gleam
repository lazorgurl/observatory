import gleam/pair
import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{type Option, None, Some}

/// A CollectorRegistry contains a map of all metric names to their respective Collectors
/// 
pub type CollectorRegistry =
  Dict(String, Collector)

/// Observatory is a Gleam client library for Prometheus
/// 
pub type Observatory {
  Observatory(registry: CollectorRegistry)
}

/// Initialize Observatory with an empty Collector Registry
/// 
pub fn init() -> Observatory {
  Observatory(registry: dict.new())
}

pub type Counter =
  Float

pub type Collector {
  ACounter(Counter)
}

/// Return a list of metric names and samples from all Collectors in the CollectorRegistry
/// 
pub fn collect(observatory: Observatory) -> List(#(String, Float)) {
  dict.to_list(observatory.registry)
  |> list.map(fn(entry: #(String, Collector)) -> #(String, Float) {
    case pair.second(entry) {
      ACounter(counter) -> #(pair.first(entry), counter)
    }
  })
}

/// Initialize a counter to 0.0.
/// 
pub fn counter_init(observatory: Observatory, name: String) -> Observatory {
  Observatory(registry: dict.insert(observatory.registry, name, ACounter(0.0)))
}

/// Increment a counter by 1.0.
/// 
pub fn counter_inc(observatory: Observatory, name: String) -> Observatory {
  counter_inc_by(observatory, name, 1.0)
}

/// Increment a counter by a specified Float.
/// 
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
