import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list

pub fn main() -> Nil {
  // Run loads of green threads, no problem
  let subjects =
    list.range(0, 200_000)
    |> list.map(spawn_greeter)

  // Wait for all threads to complete
  list.each(subjects, fn(subject) {
    process.receive(subject, 5000)
    |> fn(_) { Nil }
  })
}

fn spawn_greeter(i: Int) {
  let subject = process.new_subject()
  process.spawn(fn() {
    let n = int.to_string(i)
    io.println("Hello from " <> n)
    process.send(subject, Nil)
  })
  subject
}
