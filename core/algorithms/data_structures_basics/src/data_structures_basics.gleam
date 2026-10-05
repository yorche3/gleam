pub type Node {
  Node(value: Int, next: List(Node))
}

pub type LinkedList {
  LinkedList(head: List(Node), tail: List(Node), count: Int)
}

pub type Stack {
  Stack(top: List(Node), count: Int)
}

pub type Queue {
  Queue(front: List(Node), rear: List(Node), count: Int)
}

pub fn node_init(value: Int) -> Node {
  Node(value, [])
}

pub fn node_get_value(_node: Node) -> Int {
  -1
}

pub fn node_get_next(_node: Node) -> List(Node) {
  []
}

pub fn node_set_next(node: Node, _next: Node) -> Node {
  node
}

pub fn linked_list_init() -> LinkedList {
  LinkedList([], [], 0)
}

pub fn linked_list_get_head(_list: LinkedList) -> Int {
  -1
}

pub fn linked_list_insert_head(list: LinkedList, _value: Int) -> LinkedList {
  list
}

pub fn linked_list_insert_tail(list: LinkedList, _value: Int) -> LinkedList {
  list
}

pub fn linked_list_delete(list: LinkedList, _value: Int) -> #(LinkedList, Bool) {
  #(list, False)
}

pub fn linked_list_is_empty(_list: LinkedList) -> Bool {
  True
}

pub fn linked_list_size(_list: LinkedList) -> Int {
  0
}

pub fn stack_init() -> Stack {
  Stack([], 0)
}

pub fn stack_push(stack: Stack, _value: Int) -> Stack {
  stack
}

pub fn stack_pop(stack: Stack) -> #(Stack, Int) {
  #(stack, -1)
}

pub fn stack_peek(_stack: Stack) -> Int {
  -1
}

pub fn stack_is_empty(_stack: Stack) -> Bool {
  True
}

pub fn stack_size(_stack: Stack) -> Int {
  0
}

pub fn queue_init() -> Queue {
  Queue([], [], 0)
}

pub fn queue_enqueue(queue: Queue, _value: Int) -> Queue {
  queue
}

pub fn queue_dequeue(queue: Queue) -> #(Queue, Int) {
  #(queue, -1)
}

pub fn queue_peek(_queue: Queue) -> Int {
  -1
}

pub fn queue_is_empty(_queue: Queue) -> Bool {
  True
}

pub fn queue_size(_queue: Queue) -> Int {
  0
}
