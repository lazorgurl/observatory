import gleeunit
import gleeunit/should
import observatory
import gleam/list
import gleam/pair

pub fn main() {
  gleeunit.main()
}

const test_counter_metric = "test_counter"

pub fn counter_inc_test() {
  let output =
    observatory.init()
    |> observatory.counter_init(test_counter_metric)
    |> observatory.counter_inc(test_counter_metric)
    |> observatory.counter_inc(test_counter_metric)
    |> observatory.collect()

  should.be_ok(list.at(output, 0))
  |> pair.second()
  |> should.equal(2.0)
}

pub fn counter_inc_by_test() {
  let output =
    observatory.init()
    |> observatory.counter_init(test_counter_metric)
    |> observatory.counter_inc_by(test_counter_metric, 112.19)
    |> observatory.collect()

  should.be_ok(list.at(output, 0))
  |> pair.second()
  |> should.equal(112.19)
}
