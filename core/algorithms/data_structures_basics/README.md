# Data Structures Basics — Gleam

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Gleam**, compilado al runtime de Erlang (BEAM), con pruebas unitarias con **gleeunit**.

Implementation of the [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) specification in **Gleam**, compiled to the Erlang runtime (BEAM), with **gleeunit** unit tests.

**ES:** La celda enlazada compartida (`Node`) y los tres ADT —lista enlazada, pila y cola— se implementan a mano sobre datos inmutables, sin ninguna colección de la biblioteca estándar. Cada operación devuelve la estructura resultante: no hay mutación ni identidad de instancia, y el enlace ausente (`None`) solo aparece en `Node`.

**EN:** The shared linked cell (`Node`) and the three ADTs —linked list, stack and queue— are implemented by hand over immutable data, without any standard-library collection. Every operation returns the resulting structure: there is no mutation and no instance identity, and the absent link (`None`) appears only in `Node`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / File | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.gleam`](src/data_structures_basics.gleam) | Los cuatro tipos —`Node`, `LinkedList`, `Stack`, `Queue`—, las 23 funciones del contrato y 4 helpers privados de cola / The four types, the contract's 23 functions and 4 private tail-recursive helpers |
| [`test/data_structures_basics_test.gleam`](test/data_structures_basics_test.gleam) | `main()` de gleeunit y los 4 tests que reproducen los 15 casos de la especificación / gleeunit's `main()` and the 4 tests replaying the specification's 15 cases |
| [`gleam.toml`](gleam.toml) | Manifiesto del paquete: nombre, versión y dependencias / Package manifest: name, version and dependencies |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles / Dependency lock — exact versions for reproducible builds |
| [`.github/workflows/test.yml`](.github/workflows/test.yml) | CI: `gleam deps download`, `gleam test` y `gleam format --check src test` / CI: dependency download, tests and format check |
| [`.gitignore`](.gitignore) | Artefactos generados excluidos (`*.beam`, `*.ez`, `/build`, `erl_crash.dump`) / Ignored generated artifacts |
| `build/` | Salida de la compilación (generada, ignorada) / Compilation output (generated, ignored) |

**Estructura de directorios / Directory structure:**

```text
data_structures_basics/
├── src/
│   └── data_structures_basics.gleam      # Tipos, contrato y helpers de cola
├── test/
│   └── data_structures_basics_test.gleam # main() de gleeunit + 4 tests
├── gleam.toml                            # Manifiesto / Manifest
├── manifest.toml                         # Lock de dependencias
├── .github/workflows/test.yml            # CI
├── .gitignore                            # Ignora /build y artefactos
├── README.md                             # Este archivo / This file
└── build/                                # Generado, ignorado / Generated, ignored
```

**Desviación respecto a la ubicación esperada / Deviation from expected location:**

**ES:** La especificación propone `src/data_structures_basics.ext`, `test/data_structures_basics_test.ext` y `test/run_tests.ext`. Los dos primeros **coinciden** con el *naming* de Gleam (el archivo de un módulo lleva su nombre y el de pruebas, `<paquete>_test`). El tercero no existe porque en Gleam el punto de entrada de gleeunit es una función `main` **dentro del propio módulo de pruebas**: `test/data_structures_basics_test.gleam` contiene tanto `main` como los tests.

**EN:** The specification suggests `src/data_structures_basics.ext`, `test/data_structures_basics_test.ext` and `test/run_tests.ext`. The first two **match** Gleam naming (a module file is named after the module and the test file is `<package>_test`). The third does not exist because in Gleam gleeunit's entry point is a `main` function **inside the test module itself**: `test/data_structures_basics_test.gleam` holds both `main` and the tests.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El paquete se creó con el comando de la guía de inicialización, `gleam new data_structures_basics`, que genera las dos carpetas, el manifiesto, el lock, el `.gitignore` y el *workflow* de CI con los nombres del módulo; el código, las pruebas y este README se escribieron después a mano. Gleam compila al runtime de Erlang por defecto (no hay campo `target` en `gleam.toml`).

El contrato se declara con **tipos propios** y funciones públicas: cuatro tipos (`Node`, `LinkedList`, `Stack`, `Queue`) y 23 funciones. `Stack` y `Queue` **no** envuelven `LinkedList`: cada ADT guarda sus propios punteros (`top`, o `front`/`rear`) y su contador, y los tres comparten el mismo `Node`. No se importa ningún módulo del roadmap; las únicas dependencias son `gleam_stdlib` y `gleeunit`.

**EN:** The package was created with the initialisation guide's command, `gleam new data_structures_basics`, which generates both folders, the manifest, the lock, the `.gitignore` and the CI workflow with the module's names; the code, the tests and this README were written by hand afterwards. Gleam compiles to the Erlang runtime by default (there is no `target` field in `gleam.toml`).

The contract is declared with **custom types** and public functions: four types (`Node`, `LinkedList`, `Stack`, `Queue`) and 23 functions. `Stack` and `Queue` do **not** wrap `LinkedList`: each ADT keeps its own pointers (`top`, or `front`/`rear`) and its counter, and all three share the same `Node`. No roadmap module is imported; the only dependencies are `gleam_stdlib` and `gleeunit`.

---

## 📄 Configuración clave / Key Configuration

### `gleam.toml` — Manifiesto / Manifest

```toml
name = "data_structures_basics"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 1.0.0 and < 2.0.0"

[dev_dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```

| Elemento / Element | Propósito / Purpose |
|---|---|
| `name`, `version` | Identidad del paquete / Package identity |
| `[dependencies] gleam_stdlib` | Biblioteca estándar de Gleam / Gleam's standard library |
| `[dev_dependencies] gleeunit` | Framework de pruebas, solo en desarrollo / Test framework, development only |

**ES:** `manifest.toml` fija las versiones resueltas (`gleam_stdlib` 1.0.5 y `gleeunit` 1.11.0) y su suma de comprobación; lo gestiona `gleam deps download` y no se edita a mano. El indicador de fallo del contrato (`-1`) es un valor de las funciones, no una constante de un módulo aparte, porque en Gleam un tipo no admite miembros estáticos.

**EN:** `manifest.toml` locks the resolved versions (`gleam_stdlib` 1.0.5 and `gleeunit` 1.11.0) and their checksum; it is managed by `gleam deps download` and is never edited by hand. The contract's failure indicator (`-1`) is a value used by the functions, not a constant in a separate module, because a Gleam type admits no static members.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
gleam build                    # Compila el paquete / Builds the package
gleam test                     # Compila y ejecuta la suite / Builds and runs the suite
gleam format --check src test  # Comprueba el formato / Checks formatting
```

**Salida real / Actual output** (Gleam `1.18.1`, 2026-10-04):

```text
$ gleam build
   Compiled in 0.25s

$ gleam test
   Compiled in 0.23s
    Running data_structures_basics_test.main
....
4 passed, no failures
```

**ES:** `gleam format --check src test` no imprime nada y devuelve `0`; `gleam build` tampoco emite avisos. Salida copiada de la última ejecución real; el acta de evidencia del sprint se encuentra en [`docs/evidence/algorithms/data_structures_basics/gleam.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/gleam.md).

**EN:** `gleam format --check src test` prints nothing and returns `0`; `gleam build` emits no warnings either. Output copied from the last real run; the sprint evidence record is at [`docs/evidence/algorithms/data_structures_basics/gleam.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/gleam.md).

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `node_new` | `Int → Node` | `O(1)` | `init`: valor fijado y enlace `None` / value set and `None` link |
| `node_value` | `Node → Int` | `O(1)` | `get_value`; no muta / does not mutate |
| `node_next` | `Node → Option(Node)` | `O(1)` | `get_next`; `None` es el enlace ausente / `None` is the absent link |
| `node_with_next` | `Node → Node → Node` | `O(1)` | `set_next`: devuelve una celda nueva / returns a new cell |
| `linked_list_new` | `LinkedList` | `O(1)` | `init` |
| `linked_list_head` | `LinkedList → Int` | `O(1)` | `-1` si la lista está vacía / `-1` when the list is empty |
| `linked_list_insert_head` | `LinkedList → Int → LinkedList` | `O(1)` | La cabeza nueva enlaza con la anterior / the new head links to the previous one |
| `linked_list_insert_tail` | `LinkedList → Int → LinkedList` | `O(n)` | Reconstruye el camino hasta la cola; ver adaptaciones / rebuilds the path to the tail; see adaptations |
| `linked_list_delete` | `LinkedList → Int → #(Bool, LinkedList)` | `O(n)` | Primera aparición; en el fallo, la misma lista / first occurrence; on failure, the same list |
| `linked_list_is_empty` | `LinkedList → Bool` | `O(1)` | Contador a cero / counter equals zero |
| `linked_list_size` | `LinkedList → Int` | `O(1)` | Contador guardado / stored counter |
| `stack_new` | `Stack` | `O(1)` | `init` |
| `stack_push` | `Stack → Int → Stack` | `O(1)` | El tope nuevo enlaza con el anterior / the new top links to the previous one |
| `stack_pop` | `Stack → #(Int, Stack)` | `O(1)` | `-1` y la misma pila si está vacía / `-1` and the same stack when empty |
| `stack_peek` | `Stack → Int` | `O(1)` | `-1` si la pila está vacía / `-1` when the stack is empty |
| `stack_is_empty` | `Stack → Bool` | `O(1)` | Contador a cero / counter equals zero |
| `stack_size` | `Stack → Int` | `O(1)` | Contador guardado / stored counter |
| `queue_new` | `Queue` | `O(1)` | `init` |
| `queue_enqueue` | `Queue → Int → Queue` | `O(n)` | Reconstruye el camino hasta el `rear`; ver adaptaciones / rebuilds the path to `rear`; see adaptations |
| `queue_dequeue` | `Queue → #(Int, Queue)` | `O(1)` | `-1` y la misma cola si está vacía / `-1` and the same queue when empty |
| `queue_peek` | `Queue → Int` | `O(1)` | `-1` si la cola está vacía / `-1` when the queue is empty |
| `queue_is_empty` | `Queue → Bool` | `O(1)` | Contador a cero / counter equals zero |
| `queue_size` | `Queue → Int` | `O(1)` | Contador guardado / stored counter |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Un único tipo `Node` compartido por los tres ADT / a single `Node` type shared by the three ADTs | Un tipo de nodo por estructura, o `Stack`/`Queue` envolviendo `LinkedList` / one node type per structure, or `Stack`/`Queue` wrapping `LinkedList` | Lo fija la especificación: `Node` es la única celda enlazada y cada ADT gestiona sus punteros; así el lector ve una sola representación y tres contratos de acceso distintos / the specification fixes it: `Node` is the only linked cell and each ADT manages its own pointers, so the reader sees one representation and three different access contracts. |
| ADT **inmutables** que devuelven la estructura nueva / **immutable** ADTs returning the new structure | Estado mutable con `Ref` o un proceso que guarda la estructura / mutable state with `Ref` or a process holding the structure | Gleam no tiene variables mutables: devolver el resultado hace explícito el efecto de cada operación y la suite puede encadenarlas sin copias defensivas / Gleam has no mutable variables: returning the result makes each operation's effect explicit and the suite can chain them without defensive copies. |
| `init` como funciones (`node_new`, `linked_list_new`, `stack_new`, `queue_new`) / `init` as functions | Un procedimiento que inicializa una instancia declarada antes / a procedure initialising a previously declared instance | Sin mutación no hay nada que inicializar en el sitio: el valor vacío se construye y se devuelve, y no puede quedarse a medias / with no mutation there is nothing to initialise in place: the empty value is built and returned, and cannot be left half-done. |
| Helperes privados **de cola** para reconstruir la cadena (`relink`, `collect_path`, `last_node`, `take_prefix`) / **tail** private helpers rebuilding the chain | Recursión directa que reconstruye al volver de la llamada / direct recursion rebuilding on the way back | Gleam solo optimiza las llamadas de cola: con el acumulador la cadena no consume pila y la inserción al final o el borrado funcionan con listas largas / Gleam optimises tail calls only: with the accumulator the chain does not consume stack and tail insertion or deletion work on long lists. |
| Indicador `-1` y tuplas `#(valor, estructura)` / `-1` indicator and `#(value, structure)` tuples | `Result`/`Option` en las extracciones / `Result`/`Option` on extractions | Regla de la casa: solo `Node` puede devolver o comparar con `None`; así el enlace ausente y el fallo de una operación no se confunden / house rule: only `Node` may return or compare with `None`, so an absent link and an operation failure cannot be confused. |
| Cuatro tests, uno por estructura, con los casos como pasos encadenados / four tests, one per structure, with the cases as chained steps | Un test por operación con un ejecutor que filtra aserciones / one test per operation with an assertion-filtering executor | La especificación pide pasos sucesivos sobre el mismo estado; encadenar los valores con `\|>` mantiene el escenario completo y deja el fallo en el test de su estructura / the specification asks for successive steps on the same state; chaining values with `\|>` keeps the whole scenario and leaves a failure in its structure's test. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `Node`, `LinkedList`, `Stack` y `Queue` son **tipos nuevos** / new types | Cuatro tipos propios en un módulo / four custom types in one module | Gleam declara tipos con `pub type`; la ausencia de enlace se expresa con `Option(Node)`, sin `null` / Gleam declares types with `pub type`; the absent link is expressed with `Option(Node)`, without `null`. |
| `init()`, `get_value()`, `get_next()`, `set_next()` / `init()`, `get_value()`, `get_next()`, `set_next()` | `node_new`, `node_value`, `node_next`, `node_with_next` | Gleam nombra en `snake_case` y sin `this`: la celda se pasa como primer argumento; el resto de las estructuras usan el prefijo del tipo (`linked_list_*`, `stack_*`, `queue_*`) / Gleam names in `snake_case` and has no `this`: the cell is passed as the first argument; the other structures use their type prefix (`linked_list_*`, `stack_*`, `queue_*`). |
| `set_next(next)` «devuelve un nodo nuevo si el lenguaje es inmutable» / "returns a new node when the language is immutable" | `node_with_next` devuelve la celda copiada / returns the copied cell | Gleam es inmutable: la celda original no se toca, como la propia especificación contempla / Gleam is immutable: the original cell is not touched, as the specification itself contemplates. |
| Inserciones al final y `enqueue` en `O(1)` / tail insertions and `enqueue` in `O(1)` | **`O(n)`**: reconstruyen el camino hasta la cola / they rebuild the path to the tail | Con un único `Node` compartido y un solo puntero `tail`/`rear`, la celda de cola no se puede enlazar sin copiar el camino; usar dos cadenas daría O(1) amortizado pero cambiaría la representación que fija la especificación / with a single shared `Node` and a single `tail`/`rear` pointer, the tail cell cannot be linked without copying the path; two chains would give amortised O(1) but would change the representation the specification fixes. |
| Indicador natural de fallo / natural failure indicator | `-1` en las consultas que devuelven `Int`, `#(Int, estructura)` en `pop`/`dequeue` y `#(Bool, LinkedList)` en `delete` / `-1` on `Int` queries, `#(Int, structure)` on `pop`/`dequeue` and `#(Bool, LinkedList)` on `delete` | Solo `Node` usa `None`; las extracciones devuelven el indicador con la **misma** estructura, sin excepciones: Gleam no lanza errores de dominio / only `Node` uses `None`; extractions return the indicator with the **same** structure, with no exceptions: Gleam throws no domain errors. |
| Ausencia de enlace con la representación nativa / absent link with the native representation | `Option(Node)`, importado de `gleam/option` / `Option(Node)`, imported from `gleam/option` | Gleam no tiene `null`/`nil`: su tipo nativo de ausencia es `Option`, que aquí solo aparece en el enlace de `Node` / Gleam has no `null`/`nil`: its native absence type is `Option`, used here only for `Node`'s link. |
| Caso nulo o entrada inválida / null case or invalid input | **No aplica / Not applicable** | La especificación 06 no define entrada nula: sus casos son pasos sobre el mismo estado y todos los valores son enteros positivos / specification 06 defines no null input: its cases are steps on the same state and every value is a positive integer. |
| `src/…ext`, `test/…_test.ext` y `test/run_tests.ext` | `src/data_structures_basics.gleam` y `test/data_structures_basics_test.gleam` con `main()` | Los dos primeros coinciden con el *naming* de Gleam; no hay `run_tests` porque el punto de entrada de gleeunit es `main()` en el módulo de pruebas / the first two match Gleam naming; there is no `run_tests` because gleeunit's entry point is `main()` in the test module. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `linked_list_head` | Lista vacía / empty list | `-1` | `linked_list_head(linked_list_new())` → `-1` |
| `linked_list_delete` | Valor ausente / absent value | `#(False, la misma lista)` / `#(False, the same list)` | `linked_list_delete(list, 99)` → `#(False, list)` |
| `stack_pop` | Pila vacía / empty stack | `#(-1, la misma pila)` / `#(-1, the same stack)` | `stack_pop(stack_new())` → `#(-1, stack_new())` |
| `stack_peek` | Pila vacía / empty stack | `-1` | `stack_peek(stack_new())` → `-1` |
| `queue_dequeue` | Cola vacía / empty queue | `#(-1, la misma cola)` / `#(-1, the same queue)` | `queue_dequeue(queue_new())` → `#(-1, queue_new())` |
| `queue_peek` | Cola vacía / empty queue | `-1` | `queue_peek(queue_new())` → `-1` |
| `node_next` | Enlace ausente / absent link | `None` | `node_next(node_new(10))` → `None` |
| Caso nulo o inválido / null or invalid input | — | **No aplica / Not applicable** | La especificación no define entrada nula / the specification defines no null input |

**ES:** No hay excepciones en el contrato: `pop`, `dequeue` y `delete` devuelven siempre una tupla, y solo `Node` usa `None`.

**EN:** The contract has no exceptions: `pop`, `dequeue` and `delete` always return a tuple, and only `Node` uses `None`.

---

## ✅ Cobertura de pruebas / Test coverage

**ES:** Los 15 casos de la especificación se reparten en **4 tests**, uno por estructura, que reproducen los pasos sucesivos sobre la misma instancia encadenando el valor que devuelve cada operación con `|>`. La columna _Prueba_ indica el test y la línea donde empieza el bloque del caso.

**EN:** The specification's 15 cases are split into **4 tests**, one per structure, replaying the successive steps on the same instance by chaining each operation's returned value with `|>`. The _Test_ column names the test and the line where the case's block starts.

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Node: inicializar y observar valor/enlace | Sí / Yes | `node_test` (`test/data_structures_basics_test.gleam:26`) | `node_value` = 10; `node_next` = `None` |
| Node: inicializar otro nodo, enlazar y recorrer | Sí / Yes | `node_test` (`test/data_structures_basics_test.gleam:35`) | `node_with_next` enlaza la celda `b`; su valor es 20 y su enlace, `None` |
| LinkedList: estado vacío | Sí / Yes | `linked_list_test` (`:47`) | `is_empty` = `True`, `size` = 0, `head` = `-1` |
| LinkedList: insertar por ambos extremos | Sí / Yes | `linked_list_test` (`:59`) | `size` = 4 y cabeza `5` tras `insert_tail(10)`, `insert_tail(20)`, `insert_head(5)`, `insert_tail(10)` |
| LinkedList: eliminar primera aparición | Sí / Yes | `linked_list_test` (`:73`) | `#(True, …)`; cabeza `5`; `size` = 3 |
| LinkedList: valor ausente | Sí / Yes | `linked_list_test` (`:85`) | `#(False, misma lista)`: la instancia no cambia / the instance does not change |
| LinkedList: vaciar | Sí / Yes | `linked_list_test` (`:92`) | Tres borrados con `True`; luego `is_empty` = `True`, `size` = 0 y `head` = `-1` |
| Stack: estado vacío y extracción fallida | Sí / Yes | `stack_test` (`:112`) | `is_empty` = `True`, `size` = 0; `peek` = `-1` y `pop` = `#(-1, pila)` |
| Stack: LIFO y `peek` no mutante | Sí / Yes | `stack_test` (`:124`) | `peek` = 30 y `size` = 3 tras tres `push` |
| Stack: extracción y reutilización | Sí / Yes | `stack_test` (`:135`) | Resultados `30, 40, 20, 10`; al final `is_empty` = `True` y `size` = 0 |
| Stack: vacío tras extracción | Sí / Yes | `stack_test` (`:152`) | `pop` = `-1` con la misma pila; sigue vacía / stays empty |
| Queue: estado vacío y extracción fallida | Sí / Yes | `queue_test` (`:159`) | `is_empty` = `True`, `size` = 0; `peek` = `-1` y `dequeue` = `#(-1, cola)` |
| Queue: FIFO y `peek` no mutante | Sí / Yes | `queue_test` (`:171`) | `peek` = 10 y `size` = 3 tras tres `enqueue` |
| Queue: extracción y reutilización | Sí / Yes | `queue_test` (`:184`) | Resultados `10, 20, 30, 40`; al final `is_empty` = `True` y `size` = 0 |
| Queue: vacío tras extracción | Sí / Yes | `queue_test` (`:202`) | `dequeue` = `-1` con la misma cola; sigue vacía / stays empty |

**ES:** Total: **15 casos en 4 tests**, sin casos omitidos; el total aparece en la salida real de `gleam test` (`4 passed, no failures`). Las líneas son de `test/data_structures_basics_test.gleam`.

**EN:** Total: **15 cases in 4 tests**, with no omitted cases; the total appears in the real `gleam test` output (`4 passed, no failures`). Line numbers refer to `test/data_structures_basics_test.gleam`.

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| `linked_list_insert_tail` y `queue_enqueue` son `O(n)` / are `O(n)` | Añadir al final cuesta un recorrido de la cadena / appending costs one chain walk | Viene de la representación inmutable de un único `Node`; se documenta en _Adaptaciones idiomáticas_ y se mide en la tabla de operaciones / it comes from the immutable single-`Node` representation; documented under _Idiomatic adaptations_ and measured in the operations table. |
| Cada operación que reconstruye la cadena asigna celdas nuevas / operations rebuilding the chain allocate new cells | Coste de asignación `O(n)` por inserción al final o borrado / `O(n)` allocation cost per tail insertion or deletion | El recolector de basura de BEAM recupera las cadenas que dejan de ser accesibles; no hay fugas ni enlaces colgando / BEAM's garbage collector reclaims chains that become unreachable; there are no leaks or dangling links. |
| El TCO solo cubre las llamadas de cola / TCO covers tail calls only | Una recursión no final sobre una cadena larga consumiría pila / a non-tail recursion over a long chain would consume stack | Los cuatro helpers privados (`relink`, `last_node`, `collect_path`, `take_prefix`) son de cola y se comprobó en el código generado para JavaScript; la suite no construye cadenas largas / the four private helpers are tail-recursive and it was checked in the generated JavaScript; the suite builds no long chains. |
| Los recorridos destructivos reconstruyen la lista (`delete`) / destructive traversals rebuild the list | Vaciar la lista consume `O(n)` copias intermedias / draining the list consumes `O(n)` intermediate copies | Es la única forma de avanzar con las operaciones del contrato; la suite recorre una lista nueva y no daña el escenario / it is the only way to advance with the contract's operations; the suite walks a fresh list and does not damage the scenario. |

---

## 📝 Notas de implementación / Implementation Notes

### 🧊 ADT inmutables y `Node` compartido / Immutable ADTs and shared `Node`

**ES:** Los cuatro tipos son propios: `Node(value, next)` es la única celda enlazada y guarda su enlace como `Option(Node)`; `LinkedList(head, tail, count)`, `Stack(top, count)` y `Queue(front, rear, count)` guardan solo punteros y contador, y ninguno envuelve a otro. Como Gleam no muta nada, cada operación **devuelve** la estructura resultante y el `count` se conserva en el registro para que `size` e `is_empty` sean `O(1)`.

**EN:** The four types are custom: `Node(value, next)` is the only linked cell and stores its link as `Option(Node)`; `LinkedList(head, tail, count)`, `Stack(top, count)` and `Queue(front, rear, count)` keep only pointers and a counter, and none wraps another. Since Gleam mutates nothing, every operation **returns** the resulting structure and `count` is kept in the record so that `size` and `is_empty` are `O(1)`.

### ⚠️ Enlazar la celda nueva es obligatorio / Linking the new cell is mandatory

**ES:** En una estructura inmutable, crear la celda y colocarla en la cabeza **no basta**: hay que enlazarla con la cadena anterior, o el ADT se queda con un solo elemento y el recorrido lo delata. Lo mismo al final de la cadena, donde además hay que reconstruir el camino (`linked_list_insert_tail`, `queue_enqueue`).

**EN:** In an immutable structure, creating the cell and placing it at the head is **not enough**: it must be linked to the previous chain, or the ADT keeps a single element and the traversal shows it. The same applies at the tail, where the path must also be rebuilt (`linked_list_insert_tail`, `queue_enqueue`).

### 🔁 TCO: solo las llamadas de cola se optimizan / only tail calls are optimised

**ES:** Gleam optimiza la **llamada de cola**, no la recursión en general. Las funciones locales que reconstruyen la cadena son de cola: `relink` reengancha una lista de valores delante de un enlace, `collect_path` copia el camino hasta la celda de cola en orden inverso, `last_node` busca la última celda y `take_prefix` devuelve el prefijo anterior a un valor más el resto. Reconstruir dentro de `Some(Node(v, f(…)))` **no** sería de cola y consumiría pila. La comprobación se hizo compilando a JavaScript (`gleam build --target javascript`): los cuatro aparecen en el código generado como bucles `while (true)` con parámetros `loop$`, que es la forma que Gleam da a una llamada de cola optimizada.

**EN:** Gleam optimises the **tail call**, not recursion in general. The local functions rebuilding the chain are tail calls: `relink` re-hooks a list of values in front of a link, `collect_path` copies the path down to the tail cell in reverse order, `last_node` finds the last cell and `take_prefix` returns the prefix before a value plus the rest. Rebuilding inside `Some(Node(v, f(…)))` would **not** be a tail call and would consume stack. The check was done by compiling to JavaScript (`gleam build --target javascript`): all four appear in the generated code as `while (true)` loops with `loop$` parameters, which is the shape Gleam gives an optimised tail call.

### 🧷 `None` solo en `Node` / `None` only in `Node`

**ES:** El enlace ausente es `None` y se compara dentro de los helpers, pero ninguna operación pública lo devuelve: los fallos son `-1` o tuplas con la misma estructura, y `None` solo se observa a través de `node_next`. Así el enlace ausente y el fallo de una operación no se confunden.

**EN:** The absent link is `None` and it is matched inside the helpers, but no public operation returns it: failures are `-1` or tuples carrying the same structure, and `None` is only observed through `node_next`. This way an absent link and an operation failure cannot be confused.

### 🚧 Restricciones de Gleam encontradas / Gleam restrictions met

**ES:** `Option`, `None` y `Some` **no** están en el prelude: hay que importarlos con `import gleam/option.{type Option, None, Some}`. Y en los *guards* de un `case` no se pueden llamar funciones (`Some(n) if node_value(n) == v` es un error), así que las comparaciones se hacen en un `case` anidado o comparando el nodo completo, que sí es un operador.

**EN:** `Option`, `None` and `Some` are **not** in the prelude: they must be imported with `import gleam/option.{type Option, None, Some}`. And `case` guards cannot call functions (`Some(n) if node_value(n) == v` is an error), so comparisons use a nested `case` or compare the whole node, which is an operator.

### 🧪 Cómo funciona la suite / How the suite works

**ES:** La suite tiene 4 tests —uno por tipo— y reproduce los 15 casos encadenando los valores que devuelven las operaciones con `|>`; como las instancias son inmutables, no hacen falta copias defensivas. `main()` llama a `gleeunit.main()`, que descubre y ejecuta las funciones públicas que terminan en `_test`. La suite no consulta campos internos: solo usa las operaciones del contrato.

**EN:** The suite has 4 tests —one per type— and replays the 15 cases by chaining the values returned by the operations with `|>`; since instances are immutable, no defensive copies are needed. `main()` calls `gleeunit.main()`, which discovers and runs the public functions ending in `_test`. The suite never inspects internal fields: it only uses the contract's operations.

### 💾 Memoria y asignación / Memory and allocation

**ES:** Las operaciones que reconstruyen la cadena (`linked_list_insert_tail`, `queue_enqueue`, `linked_list_delete`) crean copias del camino afectado; el recolector de basura de BEAM libera las cadenas que dejan de ser accesibles. No hay memoria manual ni fugas.

**EN:** Operations that rebuild the chain (`linked_list_insert_tail`, `queue_enqueue`, `linked_list_delete`) copy the affected path; BEAM's garbage collector releases chains that become unreachable. There is no manual memory management and no leaks.

### 🚫 Caso nulo / Null case

**ES:** **No aplica.** La especificación 06 no define ninguna entrada nula o inválida; sus casos son pasos sucesivos sobre el mismo estado y todos los valores son enteros positivos que no chocan con el indicador `-1`. La única ausencia del módulo —el enlace de una celda— se representa con `None` dentro de `Node`.

**EN:** **Not applicable.** Specification 06 defines no null or invalid input; its cases are successive steps on the same state and every value is a positive integer that does not collide with the `-1` indicator. The module's only absence —a cell's link— is represented with `None` inside `Node`.

### 📁 Desviación de ubicación y nombres / Location and naming deviation

**ES:** La especificación espera `src/data_structures_basics.ext`, `test/data_structures_basics_test.ext` y `test/run_tests.ext`. El paquete Gleam usa `src/data_structures_basics.gleam` y `test/data_structures_basics_test.gleam` —los mismos nombres con la extensión del lenguaje, porque en Gleam el archivo se llama como el módulo— y **no hay `run_tests`**: el punto de entrada es la función `main` del propio fichero de pruebas, que delega en `gleeunit.main()`. Las funciones siguen el `snake_case` de Gleam y llevan el prefijo de su tipo.

**EN:** The specification expects `src/data_structures_basics.ext`, `test/data_structures_basics_test.ext` and `test/run_tests.ext`. The Gleam package uses `src/data_structures_basics.gleam` and `test/data_structures_basics_test.gleam` —the same names with the language's extension, because in Gleam a file is named after its module— and there is **no `run_tests`**: the entry point is the `main` function of the test file itself, delegating to `gleeunit.main()`. Functions follow Gleam's `snake_case` and carry their type's prefix.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see all the versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README / Native suite was executed and its real output is copied into this README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón) / Each specification case has its row in _Test coverage_ (or `Omitted` with reason).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_ / Each deviation from pseudocode or expected location is in _Idiomatic adaptations_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_ / Each operation with potential failure is in _Failure indicators_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas / No author absolute paths, credentials, or fabricated outputs.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe / Relative links resolve within the repository and the document is bilingual.
- [x] Ninguna sección repite lo que ya dice la especificación / No section repeats what the specification already states.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Acta de evidencia / Evidence record | [`docs/evidence/algorithms/data_structures_basics/gleam.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/gleam.md) |
| Módulo homologado del lenguaje / Homologated module | [`../naive_sort/README.md`](../naive_sort/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW/) |
| Plantilla del README / README template | [`README_Template.md`](https://yorche3.github.io/programming_languages/README_Template/) |
| Documentación oficial del lenguaje / Language official docs | [Gleam Documentation](https://gleam.run/documentation/) · [gleeunit](https://hexdocs.pm/gleeunit/) |

---

*[← Volver a Algorithms Pure](../README.md) | [↑ Volver a Gleam Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
