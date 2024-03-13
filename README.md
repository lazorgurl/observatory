# observatory

[![Package Version](https://img.shields.io/hexpm/v/observatory)](https://hex.pm/packages/observatory)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/observatory/)

A Gleam client library for Prometheus with a focus on simplicity. Currently heavily WIP.

```sh
gleam add observatory
```
```gleam
import observatory

const http_status_200_metric = "http_total_status_200"
const search_total_items_returned_metric = "search_total_items_returned"

pub fn main() {
    let observatory = observatory.init()
    |> observatory.counter_init(http_status_200_metric)
    |> observatory.counter_init(search_total_items_returned_metric)
    
    ...
    
    observatory.counter_inc("http_status_200")
    observatory.counter_inc_by("search_total_items_returned", returned_items_count)
}
```

Further documentation can be found at <https://hexdocs.pm/observatory>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
