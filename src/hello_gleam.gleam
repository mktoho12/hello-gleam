import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list

pub fn main() -> Nil {
  // Run loads of green threads, no problem
  list.range(0, 200_000)
  |> list.each(spawn_greeter)
}

fn spawn_greeter(i: Int) {
  process.spawn(fn() {
    let n = int.to_string(i)
    io.println("Hello from " <> n)
  })
}
