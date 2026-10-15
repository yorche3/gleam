import gleam/io
import gleam/string

pub fn main() -> Nil {
  let name = read_line("Enter your name: ")
  let name = string.trim(name)
  io.println("Hello, " <> name <> "!")
}

@external(erlang, "io", "get_line")
fn read_line(prompt: String) -> String
