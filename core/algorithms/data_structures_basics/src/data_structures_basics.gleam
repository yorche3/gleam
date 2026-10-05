//// data_structures_basics.gleam — Celda enlazada compartida, lista enlazada, pila y cola
////
//// Especificación: 06_Data_Structures_Basics
////
//// Implementación del contrato: tipos nuevos, operaciones e indicadores.
////
//// Indicadores:
////   * la ausencia de enlace es `None`, que solo aparece en `Node` (`Option(Node)`);
////   * las operaciones que extraen un entero devuelven `Int` y su fallo es `-1`;
////   * las banderas devuelven `False` y los contadores, `0`;
////   * `stack_pop`, `queue_dequeue` y `linked_list_delete` devuelven una tupla
////     con el valor (o el éxito) y la estructura resultante: en el fallo, el
////     indicador y la misma estructura, nunca una excepción.
////
//// Gleam es inmutable: cada operación devuelve un valor nuevo, así que insertar
//// al final (`linked_list_insert_tail`, `queue_enqueue`) reconstruye el camino
//// hasta la cola (O(n); ver la adaptación de complejidad en el README).
////
//// Recursión: todas las funciones locales de este módulo son **llamadas de
//// cola**, de modo que Gleam las optimiza (TCO) y la longitud de la cadena no
//// consume pila.

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
// Helpers internos: recorren la cadena con recursión de cola
// ---------------------------------------------------------------------------

// Reengancha `values` (en orden inverso) delante de `next`. Llamada de cola.
fn relink(values: List(Int), next: Option(Node)) -> Option(Node) {
  case values {
    [] -> next
    [value, ..rest] -> relink(rest, Some(Node(value, next)))
  }
}

// Última celda de una cadena. Llamada de cola.
fn last_node(node: Node) -> Node {
  case node_next(node) {
    Some(next) -> last_node(next)
    None -> node
  }
}

// Copia el camino desde `node` hasta `target`, incluidas ambas, en orden
// inverso. Llamada de cola.
fn collect_path(node: Option(Node), target: Node, acc: List(Int)) -> List(Int) {
  case node {
    Some(current) if current == target -> [node_value(current), ..acc]
    Some(current) ->
      collect_path(node_next(current), target, [node_value(current), ..acc])
    None -> acc
  }
}

// Prefijo anterior a la primera aparición de `value` (en orden inverso) y resto
// de la cadena. Llamada de cola.
fn take_prefix(
  node: Option(Node),
  value: Int,
  acc: List(Int),
) -> #(Bool, List(Int), Option(Node)) {
  case node {
    Some(current) ->
      case node_value(current) == value {
        True -> #(True, acc, node_next(current))
        False ->
          take_prefix(node_next(current), value, [node_value(current), ..acc])
      }
    None -> #(False, acc, None)
  }
}

// ---------------------------------------------------------------------------
// LinkedList
// ---------------------------------------------------------------------------

/// Lista vacía: sin cabeza, sin cola y contador a cero (`init`).
pub fn linked_list_new() -> LinkedList {
  LinkedList(None, None, 0)
}

pub fn linked_list_is_empty(list: LinkedList) -> Bool {
  let LinkedList(_, _, count) = list
  count == 0
}

pub fn linked_list_size(list: LinkedList) -> Int {
  let LinkedList(_, _, count) = list
  count
}

/// Valor de la cabeza, o `-1` si la lista está vacía (`get_head`).
pub fn linked_list_head(list: LinkedList) -> Int {
  let LinkedList(head, _, _) = list
  case head {
    Some(node) -> node_value(node)
    None -> -1
  }
}

pub fn linked_list_insert_head(list: LinkedList, value: Int) -> LinkedList {
  let LinkedList(head, tail, count) = list
  let new_head = Node(value, head)

  case tail {
    None -> LinkedList(Some(new_head), Some(new_head), 1)
    Some(_) -> LinkedList(Some(new_head), tail, count + 1)
  }
}

// Al insertar al final hay que reconstruir la cadena: Gleam es inmutable y la
// celda de cola no se puede enlazar en el sitio (O(n); ver la adaptación de
// complejidad en el README del módulo).
pub fn linked_list_insert_tail(list: LinkedList, value: Int) -> LinkedList {
  let LinkedList(head, tail, count) = list
  let new_tail = Node(value, None)

  case tail {
    None -> LinkedList(Some(new_tail), Some(new_tail), 1)
    Some(tail_node) -> {
      let prefix = collect_path(head, tail_node, [])
      LinkedList(relink(prefix, Some(new_tail)), Some(new_tail), count + 1)
    }
  }
}

/// Elimina la primera aparición: `#(True, lista resultante)` si estaba,
/// `#(False, la misma lista)` si el valor no está (`delete`).
pub fn linked_list_delete(list: LinkedList, value: Int) -> #(Bool, LinkedList) {
  let LinkedList(head, _, count) = list
  let #(found, prefix, rest) = take_prefix(head, value, [])

  case found {
    // El valor ausente no toca la lista: se devuelve la misma instancia.
    False -> #(False, list)
    True -> {
      let new_head = relink(prefix, rest)
      let new_tail = case new_head {
        Some(node) -> Some(last_node(node))
        None -> None
      }
      #(True, LinkedList(new_head, new_tail, count - 1))
    }
  }
}

// ---------------------------------------------------------------------------
// Stack — LIFO sobre el mismo Node
// ---------------------------------------------------------------------------

/// Pila vacía: sin tope y contador a cero (`init`).
pub fn stack_new() -> Stack {
  Stack(None, 0)
}

pub fn stack_is_empty(stack: Stack) -> Bool {
  let Stack(_, count) = stack
  count == 0
}

pub fn stack_size(stack: Stack) -> Int {
  let Stack(_, count) = stack
  count
}

pub fn stack_push(stack: Stack, value: Int) -> Stack {
  let Stack(top, count) = stack
  Stack(Some(Node(value, top)), count + 1)
}

/// Extrae el tope: `#(valor, pila)`; si la pila está vacía, `#(-1, la misma
/// pila)` (`pop`).
pub fn stack_pop(stack: Stack) -> #(Int, Stack) {
  let Stack(top, count) = stack
  case top {
    Some(node) -> #(node_value(node), Stack(node_next(node), count - 1))
    None -> #(-1, stack)
  }
}

/// Observa el tope sin extraerlo: el valor, o `-1` si la pila está vacía (`peek`).
pub fn stack_peek(stack: Stack) -> Int {
  let Stack(top, _) = stack
  case top {
    Some(node) -> node_value(node)
    None -> -1
  }
}

// ---------------------------------------------------------------------------
// Queue — FIFO sobre el mismo Node
// ---------------------------------------------------------------------------

/// Cola vacía: sin frente, sin cola y contador a cero (`init`).
pub fn queue_new() -> Queue {
  Queue(None, None, 0)
}

pub fn queue_is_empty(queue: Queue) -> Bool {
  let Queue(_, _, count) = queue
  count == 0
}

pub fn queue_size(queue: Queue) -> Int {
  let Queue(_, _, count) = queue
  count
}

// Misma adaptación que `linked_list_insert_tail`: encolar reconstruye la cadena
// (O(n) en vez del O(1) que promete la especificación).
pub fn queue_enqueue(queue: Queue, value: Int) -> Queue {
  let Queue(front, rear, count) = queue
  let new_rear = Node(value, None)

  case rear {
    None -> Queue(Some(new_rear), Some(new_rear), 1)
    Some(rear_node) -> {
      let prefix = collect_path(front, rear_node, [])
      Queue(relink(prefix, Some(new_rear)), Some(new_rear), count + 1)
    }
  }
}

/// Extrae el frente: `#(valor, cola)`; si la cola está vacía, `#(-1, la misma
/// cola)` (`dequeue`).
pub fn queue_dequeue(queue: Queue) -> #(Int, Queue) {
  let Queue(front, rear, count) = queue
  case front {
    Some(node) -> {
      let new_front = node_next(node)
      let new_rear = case new_front {
        None -> None
        Some(_) -> rear
      }
      #(node_value(node), Queue(new_front, new_rear, count - 1))
    }
    None -> #(-1, queue)
  }
}

/// Observa el frente sin extraerlo: el valor, o `-1` si la cola está vacía
/// (`peek`).
pub fn queue_peek(queue: Queue) -> Int {
  let Queue(front, _, _) = queue
  case front {
    Some(node) -> node_value(node)
    None -> -1
  }
}
