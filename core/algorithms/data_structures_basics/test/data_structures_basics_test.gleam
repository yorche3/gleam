import data_structures_basics
import gleam/option.{None, Some}
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn node_test() {
  run_node_cases()
}

pub fn linked_list_test() {
  run_linked_list_cases()
}

pub fn stack_test() {
  run_stack_cases()
}

pub fn queue_test() {
  run_queue_cases()
}

fn run_node_cases() {
  let standard_input = data_structures_basics.node_new(10)
  let standard_value_output = 10
  let standard_next_output = None

  assert data_structures_basics.node_value(standard_input)
    == standard_value_output
  assert data_structures_basics.node_next(standard_input)
    == standard_next_output

  let linked_input = data_structures_basics.node_new(20)
  let linked_output =
    data_structures_basics.node_with_next(standard_input, linked_input)
  let linked_value_output = 20
  let linked_next_output = None

  assert data_structures_basics.node_next(linked_output) == Some(linked_input)
  assert data_structures_basics.node_value(linked_input) == linked_value_output
  assert data_structures_basics.node_next(linked_input) == linked_next_output
}

fn run_linked_list_cases() {
  let empty_input = data_structures_basics.linked_list_new()
  let empty_output = True
  let empty_size_output = 0
  let empty_head_output = -1

  assert data_structures_basics.linked_list_is_empty(empty_input)
    == empty_output
  assert data_structures_basics.linked_list_size(empty_input)
    == empty_size_output
  assert data_structures_basics.linked_list_head(empty_input)
    == empty_head_output

  let inserted_input =
    empty_input
    |> data_structures_basics.linked_list_insert_tail(10)
    |> data_structures_basics.linked_list_insert_tail(20)
    |> data_structures_basics.linked_list_insert_head(5)
    |> data_structures_basics.linked_list_insert_tail(10)
  let inserted_size_output = 4
  let inserted_head_output = 5

  assert data_structures_basics.linked_list_size(inserted_input)
    == inserted_size_output
  assert data_structures_basics.linked_list_head(inserted_input)
    == inserted_head_output

  let #(first_delete_output, first_delete_input) =
    data_structures_basics.linked_list_delete(inserted_input, 10)
  let first_delete_success_output = True
  let first_delete_size_output = 3
  let first_delete_head_output = 5

  assert first_delete_output == first_delete_success_output
  assert data_structures_basics.linked_list_size(first_delete_input)
    == first_delete_size_output
  assert data_structures_basics.linked_list_head(first_delete_input)
    == first_delete_head_output

  let #(missing_delete_output, missing_delete_input) =
    data_structures_basics.linked_list_delete(first_delete_input, 99)
  let missing_delete_success_output = False

  assert missing_delete_output == missing_delete_success_output
  assert missing_delete_input == first_delete_input

  let #(delete_head_output, after_head_delete) =
    data_structures_basics.linked_list_delete(missing_delete_input, 5)
  let #(delete_middle_output, after_middle_delete) =
    data_structures_basics.linked_list_delete(after_head_delete, 20)
  let #(delete_tail_output, emptied_output) =
    data_structures_basics.linked_list_delete(after_middle_delete, 10)
  let emptied_size_output = 0
  let emptied_head_output = -1

  assert delete_head_output
  assert delete_middle_output
  assert delete_tail_output
  assert data_structures_basics.linked_list_is_empty(emptied_output)
  assert data_structures_basics.linked_list_size(emptied_output)
    == emptied_size_output
  assert data_structures_basics.linked_list_head(emptied_output)
    == emptied_head_output
}

fn run_stack_cases() {
  let empty_input = data_structures_basics.stack_new()
  let empty_size_output = 0
  let empty_value_output = -1

  assert data_structures_basics.stack_is_empty(empty_input)
  assert data_structures_basics.stack_size(empty_input) == empty_size_output
  assert data_structures_basics.stack_peek(empty_input) == empty_value_output
  let #(empty_pop_output, empty_pop_stack) =
    data_structures_basics.stack_pop(empty_input)
  assert empty_pop_output == empty_value_output
  assert empty_pop_stack == empty_input

  let pushed_input =
    empty_input
    |> data_structures_basics.stack_push(10)
    |> data_structures_basics.stack_push(20)
    |> data_structures_basics.stack_push(30)
  let pushed_peek_output = 30
  let pushed_size_output = 3

  assert data_structures_basics.stack_peek(pushed_input) == pushed_peek_output
  assert data_structures_basics.stack_size(pushed_input) == pushed_size_output

  let #(first_pop_output, after_first_pop) =
    data_structures_basics.stack_pop(pushed_input)
  let reused_input = data_structures_basics.stack_push(after_first_pop, 40)
  let #(second_pop_output, after_second_pop) =
    data_structures_basics.stack_pop(reused_input)
  let #(third_pop_output, after_third_pop) =
    data_structures_basics.stack_pop(after_second_pop)
  let #(fourth_pop_output, emptied_output) =
    data_structures_basics.stack_pop(after_third_pop)

  assert first_pop_output == 30
  assert second_pop_output == 40
  assert third_pop_output == 20
  assert fourth_pop_output == 10
  assert data_structures_basics.stack_is_empty(emptied_output)
  assert data_structures_basics.stack_size(emptied_output) == 0

  let #(final_pop_output, final_pop_stack) =
    data_structures_basics.stack_pop(emptied_output)
  assert final_pop_output == -1
  assert data_structures_basics.stack_is_empty(final_pop_stack)
}

fn run_queue_cases() {
  let empty_input = data_structures_basics.queue_new()
  let empty_size_output = 0
  let empty_value_output = -1

  assert data_structures_basics.queue_is_empty(empty_input)
  assert data_structures_basics.queue_size(empty_input) == empty_size_output
  assert data_structures_basics.queue_peek(empty_input) == empty_value_output
  let #(empty_dequeue_output, empty_dequeue_queue) =
    data_structures_basics.queue_dequeue(empty_input)
  assert empty_dequeue_output == empty_value_output
  assert empty_dequeue_queue == empty_input

  let enqueued_input =
    empty_input
    |> data_structures_basics.queue_enqueue(10)
    |> data_structures_basics.queue_enqueue(20)
    |> data_structures_basics.queue_enqueue(30)
  let enqueued_peek_output = 10
  let enqueued_size_output = 3

  assert data_structures_basics.queue_peek(enqueued_input)
    == enqueued_peek_output
  assert data_structures_basics.queue_size(enqueued_input)
    == enqueued_size_output

  let #(first_dequeue_output, after_first_dequeue) =
    data_structures_basics.queue_dequeue(enqueued_input)
  let reused_input =
    data_structures_basics.queue_enqueue(after_first_dequeue, 40)
  let #(second_dequeue_output, after_second_dequeue) =
    data_structures_basics.queue_dequeue(reused_input)
  let #(third_dequeue_output, after_third_dequeue) =
    data_structures_basics.queue_dequeue(after_second_dequeue)
  let #(fourth_dequeue_output, emptied_output) =
    data_structures_basics.queue_dequeue(after_third_dequeue)

  assert first_dequeue_output == 10
  assert second_dequeue_output == 20
  assert third_dequeue_output == 30
  assert fourth_dequeue_output == 40
  assert data_structures_basics.queue_is_empty(emptied_output)
  assert data_structures_basics.queue_size(emptied_output) == 0

  let #(final_dequeue_output, final_dequeue_queue) =
    data_structures_basics.queue_dequeue(emptied_output)
  assert final_dequeue_output == -1
  assert data_structures_basics.queue_is_empty(final_dequeue_queue)
}
