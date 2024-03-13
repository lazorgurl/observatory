import gleeunit
import gleeunit/should
import observatory
import gleam/list
import gleam/pair

pub fn main() {
  gleeunit.main()
}

pub fn counter_inc_test() {
  let key = "test_counter"
  let output =
    observatory.init()
    |> observatory.counter_init(key)
    |> observatory.counter_inc(key)
    |> observatory.counter_inc(key)
    |> observatory.collect()

  should.be_ok(list.at(output, 0))
  |> pair.second()
  |> should.equal(2.0)
}

pub fn counter_inc_by_test() {
  let key = "test_counter"
  let output =
    observatory.init()
    |> observatory.counter_init(key)
    |> observatory.counter_inc_by(key, 112.19)
    |> observatory.collect()

  should.be_ok(list.at(output, 0))
  |> pair.second()
  |> should.equal(112.19)
}
