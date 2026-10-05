//// data_structures_basics.gleam — Celda enlazada compartida, lista enlazada, pila y cola
////
//// Especificación: 06_Data_Structures_Basics
////
//// Contrato del paso 4b: declara los tipos nuevos y las firmas, y deja el
//// cuerpo de cada operación en su indicador natural, sin resolver ningún caso.
//// El algoritmo es del paso 5 y la suite, del 4c.
////
//// Indicadores:
////   * la ausencia de enlace es `None`, que solo aparece en `Node` (`Option(Node)`);
////   * las operaciones que extraen un entero devuelven `Int` y su fallo es `-1`;
////   * las banderas devuelven `False` y los contadores, `0`;
////   * `stack_pop`, `queue_dequeue` y `linked_list_delete` devuelven una tupla
////     con el valor (o el éxito) y la estructura resultante: en el fallo, el
////     indicador y la misma estructura, nunca una excepción.
////
//// Gleam es inmutable: cada operación devuelve un valor nuevo.

import gleam/option.{type Option, None, Some}

pub type Node {
  Node(value: Int, next: Option(Node))
}

pub type LinkedList {
  LinkedList(head: Option(Node), tail: Option(Node), count: Int)
}

pub type Stack {
  Stack(top: Option(Node), count: Int)
}

pub type Queue {
  Queue(front: Option(Node), rear: Option(Node), count: Int)
}

// ---------------------------------------------------------------------------
// Node — celda enlazada compartida por las tres estructuras
// ---------------------------------------------------------------------------

/// Crea la celda con su valor y el enlace ausente (`init`).
pub fn node_new(value: Int) -> Node {
  Node(value, None)
}

/// Valor de la celda (`get_value`).
pub fn node_value(node: Node) -> Int {
  let Node(value, _) = node
  value
}

/// Enlace de la celda; `None` cuando está ausente (`get_next`).
pub fn node_next(node: Node) -> Option(Node) {
  let Node(_, next) = node
  next
}

/// Devuelve una celda nueva enlazada con `next` (`set_next`).
pub fn node_with_next(node: Node, next: Node) -> Node {
  let Node(value, _) = node
  Node(value, Some(next))
}

// ---------------------------------------------------------------------------
// LinkedList
// ---------------------------------------------------------------------------

/// Lista vacía: sin cabeza, sin cola y contador a cero (`init`).
pub fn linked_list_new() -> LinkedList {
  LinkedList(None, None, 0)
}

pub fn linked_list_is_empty(_list: LinkedList) -> Bool {
  False
}

pub fn linked_list_size(_list: LinkedList) -> Int {
  0
}

/// Valor de la cabeza, o `-1` si la lista está vacía (`get_head`).
pub fn linked_list_head(_list: LinkedList) -> Int {
  -1
}

pub fn linked_list_insert_head(list: LinkedList, _value: Int) -> LinkedList {
  list
}

// Al insertar al final hay que reconstruir la cadena: Gleam es inmutable y la
// celda de cola no se puede enlazar en el sitio (O(n); ver la adaptación de
// complejidad en el README del módulo).
pub fn linked_list_insert_tail(list: LinkedList, _value: Int) -> LinkedList {
  list
}

/// Elimina la primera aparición: `#(True, lista resultante)` si estaba,
/// `#(False, la misma lista)` si el valor no está (`delete`).
pub fn linked_list_delete(
  list: LinkedList,
  _value: Int,
) -> #(Bool, LinkedList) {
  #(False, list)
}

// ---------------------------------------------------------------------------
// Stack — LIFO sobre el mismo Node
// ---------------------------------------------------------------------------

/// Pila vacía: sin tope y contador a cero (`init`).
pub fn stack_new() -> Stack {
  Stack(None, 0)
}

pub fn stack_is_empty(_stack: Stack) -> Bool {
  False
}

pub fn stack_size(_stack: Stack) -> Int {
  0
}

pub fn stack_push(stack: Stack, _value: Int) -> Stack {
  stack
}

/// Extrae el tope: `#(valor, pila)`; si la pila está vacía, `#(-1, la misma
/// pila)` (`pop`).
pub fn stack_pop(stack: Stack) -> #(Int, Stack) {
  #(-1, stack)
}

/// Observa el tope sin extraerlo: el valor, o `-1` si la pila está vacía (`peek`).
pub fn stack_peek(_stack: Stack) -> Int {
  -1
}

// ---------------------------------------------------------------------------
// Queue — FIFO sobre el mismo Node
// ---------------------------------------------------------------------------

/// Cola vacía: sin frente, sin cola y contador a cero (`init`).
pub fn queue_new() -> Queue {
  Queue(None, None, 0)
}

pub fn queue_is_empty(_queue: Queue) -> Bool {
  False
}

pub fn queue_size(_queue: Queue) -> Int {
  0
}

// Misma adaptación que `linked_list_insert_tail`: encolar reconstruye la cadena
// (O(n) en vez del O(1) que promete la especificación).
pub fn queue_enqueue(queue: Queue, _value: Int) -> Queue {
  queue
}

/// Extrae el frente: `#(valor, cola)`; si la cola está vacía, `#(-1, la misma
/// cola)` (`dequeue`).
pub fn queue_dequeue(queue: Queue) -> #(Int, Queue) {
  #(-1, queue)
}

/// Observa el frente sin extraerlo: el valor, o `-1` si la cola está vacía
/// (`peek`).
pub fn queue_peek(_queue: Queue) -> Int {
  -1
}
