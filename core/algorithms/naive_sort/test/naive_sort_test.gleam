import gleam/list
import gleeunit
import naive_sort

// Casos de prueba de la especificación 05_Naive_Sort.md
const standard_input: List(Int) = [5, 2, 9, 1, 5, 6]

const standard_output: List(Int) = [1, 2, 5, 5, 6, 9]

const sorted_input: List(Int) = [1, 2, 3, 4, 5]

const sorted_output: List(Int) = [1, 2, 3, 4, 5]

const reverse_input: List(Int) = [5, 4, 3, 2, 1]

const reverse_output: List(Int) = [1, 2, 3, 4, 5]

const identical_input: List(Int) = [7, 7, 7, 7]

const identical_output: List(Int) = [7, 7, 7, 7]

const negative_input: List(Int) = [3, -1, 4, -5, 0]

const negative_output: List(Int) = [-5, -1, 0, 3, 4]

const single_input: List(Int) = [42]

const single_output: List(Int) = [42]

const empty_input: List(Int) = []

const empty_output: List(Int) = []

const cases: List(#(String, List(Int), List(Int))) = [
  #("an unsorted array", standard_input, standard_output),
  #("an already sorted array", sorted_input, sorted_output),
  #("a reverse ordered array", reverse_input, reverse_output),
  #("an array of identical elements", identical_input, identical_output),
  #("an array with negative numbers", negative_input, negative_output),
  #("a single element array", single_input, single_output),
  #("an empty array", empty_input, empty_output),
]

// Las listas de Gleam son inmutables: no hace falta copiar los fixtures porque
// ninguna función puede mutarlos entre casos.
fn assert_sorts_all_cases(
  sort: fn(List(Int)) -> List(Int),
  algorithm: String,
) -> Nil {
  list.each(cases, fn(test_case) {
    let #(description, input, expected) = test_case
    let message = algorithm <> " should sort " <> description
    case sort(input) == expected {
      True -> Nil
      False -> panic as message
    }
  })
}

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn selection_sort_test() {
  assert_sorts_all_cases(naive_sort.selection_sort, "selection_sort")
}

pub fn bubble_sort_test() {
  assert_sorts_all_cases(naive_sort.bubble_sort, "bubble_sort")
}

pub fn insertion_sort_test() {
  assert_sorts_all_cases(naive_sort.insertion_sort, "insertion_sort")
}
