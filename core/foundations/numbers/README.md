# Numbers — Gleam

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Gleam**, compilado al runtime de Erlang (BEAM).

Implementa 5 operaciones numéricas (`sum_first_n`, `factorial`, `fibonacci`, `greatest_common_divisior`, `least_common_multiple`), cada una en **dos versiones**: recursiva ingenua y con acumulador (tail-recursive).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/numbers.gleam`](src/numbers.gleam) | Implementación de las 10 funciones (5 rec + 5 acc). |
| [`test/numbers_test.gleam`](test/numbers_test.gleam) | Punto de entrada único para gleeunit. |
| [`test/numbers_rec_tests.gleam`](test/numbers_rec_tests.gleam) | Tests de las 5 versiones recursivas. |
| [`test/numbers_acc_tests.gleam`](test/numbers_acc_tests.gleam) | Tests de las 5 versiones con acumulador. |
| [`gleam.toml`](gleam.toml) | Manifiesto del proyecto — nombre, versión, dependencias. |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles. |

**Estructura de directorios esperada:**

```text
numbers/
├── src/
│   └── numbers.gleam                  # 10 funciones numéricas
├── test/
│   ├── numbers_test.gleam             # Entry point principal (gleeunit.main())
│   ├── numbers_rec_tests.gleam        # Tests de funciones recursivas
│   └── numbers_acc_tests.gleam        # Tests de funciones con acumulador
├── gleam.toml                         # Manifiesto del proyecto
├── manifest.toml                      # Lock de dependencias
├── .gitignore                         # Ignora *.beam, *.ez, /build
├── README.md                          # Este archivo
└── build/                             # Código compilado (generado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto implementa 5 operaciones numéricas clásicas, cada una en dos estilos:

1. **Versión recursiva** (`*_rec`): Sigue la definición matemática natural, con llamadas recursivas sin acumulador.
2. **Versión con acumulador** (`*_acc`): Usa un parámetro auxiliar (acumulador) para ser tail-recursive, optimizable por el compilador de Erlang.

Características:
- **Recursión con `case`**: Gleam no tiene bucles `for`/`while`; toda iteración se expresa con recursión y `case` + pattern matching sobre `Bool`.
- **Funciones auxiliares privadas**: Las versiones con acumulador usan helpers privados (`sum_first_n_help`, `factorial_help`, `fibonacci_help`) que no se exportan.
- **Tail-call optimization (TCO)**: Las funciones con acumulador son tail-recursive, lo que permite que el runtime BEAM las optimice evitando crecimiento del stack.
- **Múltiples suites de test**: Los tests están organizados en dos archivos separados (`_rec` y `_acc`), con un único `main()` en `numbers_test.gleam` que descubre y ejecuta automáticamente todas las funciones que terminan en `_test`.

**EN:** This project implements 5 classic numeric operations, each in two styles:

1. **Recursive version** (`*_rec`): Follows the natural mathematical definition, with recursive calls without an accumulator.
2. **Accumulator version** (`*_acc`): Uses an auxiliary parameter (accumulator) to be tail-recursive, optimizable by the Erlang compiler.

Features:
- **Recursion with `case`**: Gleam has no `for`/`while` loops; all iteration is expressed with recursion and `case` + pattern matching on `Bool`.
- **Private helper functions**: Accumulator versions use private helpers (`sum_first_n_help`, `factorial_help`, `fibonacci_help`) that are not exported.
- **Tail-call optimization (TCO)**: Accumulator functions are tail-recursive, allowing the BEAM runtime to optimize them and avoid stack growth.
- **Multiple test suites**: Tests are organized in two separate files (`_rec` and `_acc`), with a single `main()` in `numbers_test.gleam` that automatically discovers and runs all functions ending in `_test`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `gleam.toml` — Manifiesto del proyecto

**ES:** Define el nombre, versión y dependencias del proyecto.

**EN:** Defines the project name, version and dependencies.

```toml
name = "numbers"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 1.0.0 and < 2.0.0"

[dev_dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```

| Elemento | Propósito |
|----------|-----------|
| `name` | Nombre del paquete en el registro Hex |
| `[dependencies]` | Dependencias de producción |
| `[dev_dependencies]` | Dependencias solo para desarrollo y tests |
| `gleam_stdlib` | Biblioteca estándar de Gleam |
| `gleeunit` | Framework de testing unitario para Gleam |

### `src/numbers.gleam` — Implementación completa

**ES:** El archivo contiene 10 funciones públicas y 3 funciones auxiliares privadas. Las funciones se agrupan en dos categorías: recursivas puras (`*_rec`) y con acumulador (`*_acc`). A continuación se muestran ambas versiones de cada operación.

**EN:** The file contains 10 public functions and 3 private helper functions. Functions are grouped into two categories: pure recursive (`*_rec`) and accumulator-based (`*_acc`). Both versions of each operation are shown below.

#### Suma de los primeros N números / Sum first N numbers

```gleam
pub fn sum_first_n_rec(n: Int) -> Int {
  case n <= 0 {
    True -> 0
    False -> n + sum_first_n_rec(n - 1)
  }
}

fn sum_first_n_help(n: Int, acc: Int) -> Int {
  case n <= 0 {
    True -> acc
    False -> sum_first_n_help(n - 1, n + acc)
  }
}

pub fn sum_first_n_acc(n: Int) -> Int {
  sum_first_n_help(n, 0)
}
```

#### Factorial

```gleam
pub fn factorial_rec(n: Int) -> Int {
  case n <= 1 {
    True -> 1
    False -> n * factorial_rec(n - 1)
  }
}

fn factorial_help(n: Int, acc: Int) -> Int {
  case n <= 0 {
    True -> acc
    False -> factorial_help(n - 1, n * acc)
  }
}

pub fn factorial_acc(n: Int) -> Int {
  factorial_help(n, 1)
}
```

#### Fibonacci

```gleam
pub fn fibonacci_rec(n: Int) -> Int {
  case n <= 1 {
    True -> n
    False -> fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
  }
}

fn fibonacci_help(n: Int, acc1: Int, acc2: Int) -> Int {
  case n <= 0 {
    True -> acc1
    False -> fibonacci_help(n - 1, acc2, acc1 + acc2)
  }
}

pub fn fibonacci_acc(n: Int) -> Int {
  fibonacci_help(n, 0, 1)
}
```

#### Máximo común divisor / Greatest common divisor

```gleam
pub fn greatest_common_divisior_rec(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> greatest_common_divisior_rec(b, a % b)
  }
}

pub fn greatest_common_divisior_acc(a: Int, b: Int) -> Int {
  case b == 0 {
    True -> a
    False -> greatest_common_divisior_acc(b, a % b)
  }
}
```

#### Mínimo común múltiplo / Least common multiple

```gleam
pub fn least_common_multiple_rec(a: Int, b: Int) -> Int {
  a * b / greatest_common_divisior_rec(a, b)
}

pub fn least_common_multiple_acc(a: Int, b: Int) -> Int {
  a * b / greatest_common_divisior_acc(a, b)
}
```

| Elemento | Propósito |
|----------|-----------|
| `sum_first_n_rec(n)` | Suma recursiva: `1 + 2 + ... + n` |
| `sum_first_n_acc(n)` | Suma tail-recursive con acumulador |
| `factorial_rec(n)` | Factorial recursivo: `n! = n * (n-1)!` |
| `factorial_acc(n)` | Factorial tail-recursive con acumulador |
| `fibonacci_rec(n)` | Fibonacci recursivo: `F(n) = F(n-1) + F(n-2)` |
| `fibonacci_acc(n)` | Fibonacci tail-recursive con dos acumuladores |
| `greatest_common_divisior_*(a, b)` | MCD con algoritmo de Euclides (`a % b`) |
| `least_common_multiple_*(a, b)` | MCM: `a * b / mcd(a, b)` |
| `case ... { True -> ... False -> ... }` | Control de flujo: pattern matching sobre `Bool` |
| `fn ..._help(...)` | Función auxiliar privada (no exportada) |

> **ES:** Las funciones con acumulador (`*_acc`) son tail-recursive: la llamada recursiva es la última operación, permitiendo TCO. La versión recursiva ingenua de `fibonacci` tiene complejidad O(2ⁿ), mientras que la versión con acumulador es O(n).
> **EN:** Accumulator functions (`*_acc`) are tail-recursive: the recursive call is the last operation, enabling TCO. The naive recursive version of `fibonacci` has O(2ⁿ) complexity, while the accumulator version is O(n).

### Tests: `numbers_test.gleam` + `numbers_rec_tests.gleam` + `numbers_acc_tests.gleam`

**ES:** Los tests están organizados en tres archivos:

- `numbers_test.gleam` — **Punto de entrada único**: solo contiene `main()` que llama a `gleeunit.main()`.
- `numbers_rec_tests.gleam` — Tests para las 5 versiones recursivas (`*_rec`).
- `numbers_acc_tests.gleam` — Tests para las 5 versiones con acumulador (`*_acc`).

gleeunit descubre automáticamente todas las funciones que terminan en `_test` en **todos los archivos** dentro del directorio `test/`. No es necesario importar los módulos de test explícitamente.

**EN:** Tests are organized in three files:

- `numbers_test.gleam` — **Single entry point**: only contains `main()` calling `gleeunit.main()`.
- `numbers_rec_tests.gleam` — Tests for the 5 recursive versions (`*_rec`).
- `numbers_acc_tests.gleam` — Tests for the 5 accumulator versions (`*_acc`).

gleeunit automatically discovers all functions ending in `_test` in **all files** inside the `test/` directory. No explicit imports of test modules are needed.

#### `test/numbers_test.gleam` — Entry point

```gleam
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}
```

#### `test/numbers_rec_tests.gleam` — Tests recursivos

```gleam
import numbers

pub fn sum_first_n_rec_test() {
  assert numbers.sum_first_n_rec(0) == 0
  assert numbers.sum_first_n_rec(3) == 6
}

pub fn factorial_rec_test() {
  assert numbers.factorial_rec(0) == 1
  assert numbers.factorial_rec(4) == 24
}

pub fn fibonacci_rec_test() {
  assert numbers.fibonacci_rec(0) == 0
  assert numbers.fibonacci_rec(1) == 1
  assert numbers.fibonacci_rec(6) == 8
}

pub fn gcd_rec_test() {
  assert numbers.greatest_common_divisior_rec(12, 8) == 4
  assert numbers.greatest_common_divisior_rec(7, 5) == 1
}

pub fn lcm_rec_test() {
  assert numbers.least_common_multiple_rec(6, 8) == 24
  assert numbers.least_common_multiple_rec(4, 6) == 12
}
```

#### `test/numbers_acc_tests.gleam` — Tests con acumulador

```gleam
import numbers

pub fn sum_first_n_acc_test() {
  assert numbers.sum_first_n_acc(0) == 0
  assert numbers.sum_first_n_acc(3) == 6
}

pub fn factorial_acc_test() {
  assert numbers.factorial_acc(0) == 1
  assert numbers.factorial_acc(4) == 24
}

pub fn fibonacci_acc_test() {
  assert numbers.fibonacci_acc(0) == 0
  assert numbers.fibonacci_acc(1) == 1
  assert numbers.fibonacci_acc(6) == 8
}

pub fn gcd_acc_test() {
  assert numbers.greatest_common_divisior_acc(12, 8) == 4
  assert numbers.greatest_common_divisior_acc(7, 5) == 1
}

pub fn lcm_acc_test() {
  assert numbers.least_common_multiple_acc(6, 8) == 24
  assert numbers.least_common_multiple_acc(4, 6) == 12
}
```

| Elemento | Propósito |
|----------|-----------|
| `import gleeunit` | Importa el framework de tests (solo en entry point) |
| `import numbers` | Importa el módulo a testear |
| `gleeunit.main()` | Descubre y ejecuta todas las funciones `*_test` |
| `assert ... == ...` | Afirmación — palabra clave del lenguaje Gleam |
| `*_rec_test` / `*_acc_test` | Convención de nombres para distinguir variantes |

> **ES:** No es necesario que cada archivo de test tenga su propio `main()`. Basta con un único `main()` que llame a `gleeunit.main()`. gleeunit escanea recursivamente el directorio `test/` en busca de funciones cuyo nombre termine en `_test`.
> **EN:** Each test file does not need its own `main()`. A single `main()` calling `gleeunit.main()` suffices. gleeunit recursively scans the `test/` directory for functions whose name ends in `_test`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Gleam y Erlang instalados

```bash
# Linux (Debian/Ubuntu) — instalar Erlang primero
sudo apt install erlang-dev erlang-src

# macOS (con Homebrew)
brew install gleam erlang

# Windows (con scoop)
scoop install gleam erlang

# O descargar desde https://gleam.run/getting-started/installing-gleam/
```

### Ejecutar tests

```bash
cd core/foundations/numbers
gleam test
```

**Salida esperada / Expected output:**

```text
  Testing numbers_test...
  10 tests, 0 failures
```

> **ES:** `gleam test` compila el proyecto y ejecuta todas las suites de test (10 tests: 5 recursivos + 5 con acumulador) en un solo comando.
> **EN:** `gleam test` compiles the project and runs all test suites (10 tests: 5 recursive + 5 accumulator) in a single command.

---

## 🧠 Algoritmos / operaciones

| Operación | Versión recursiva | Versión con acumulador | Algoritmo |
|-----------|-------------------|------------------------|-----------|
| `sum_first_n(n)` | `n + sum_first_n_rec(n-1)` | Tail-rec con `acc + n` | Suma lineal O(n) |
| `factorial(n)` | `n * factorial_rec(n-1)` | Tail-rec con `acc * n` | Producto lineal O(n) |
| `fibonacci(n)` | `fib_rec(n-1) + fib_rec(n-2)` | Tail-rec con 2 acc | Lineal O(n) vs exponencial O(2ⁿ) |
| `gcd(a, b)` | `gcd_rec(b, a % b)` | `gcd_acc(b, a % b)` | Euclides O(log min(a,b)) |
| `lcm(a, b)` | `a * b / gcd_rec(a, b)` | `a * b / gcd_acc(a, b)` | Usa MCD |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Gleam es un lenguaje de tipado estático con inferencia de tipos que compila a bytecode BEAM.
- **EN:** Gleam is a statically typed language with type inference that compiles to BEAM bytecode.
- **ES:** Las funciones auxiliares (`sum_first_n_help`, `factorial_help`, `fibonacci_help`) son privadas (sin `pub`) y no accesibles desde fuera del módulo.
- **EN:** The helper functions (`sum_first_n_help`, `factorial_help`, `fibonacci_help`) are private (no `pub`) and not accessible from outside the module.
- **ES:** Gleam no tiene bucles `for`/`while`. Toda la iteración se expresa con recursión y `case` + pattern matching.
- **EN:** Gleam has no `for`/`while` loops. All iteration is expressed via recursion and `case` + pattern matching.
- **ES:** La versión con acumulador de `fibonacci` usa **dos** acumuladores (`acc1`, `acc2`) y es O(n), mientras que la versión recursiva ingenua es O(2ⁿ).
- **EN:** The accumulator version of `fibonacci` uses **two** accumulators (`acc1`, `acc2`) and is O(n), while the naive recursive version is O(2ⁿ).
- **ES:** `gleeunit` descubre automáticamente todas las funciones `*_test` en el directorio `test/`. No hace falta que cada archivo tenga su propio `main()`.
- **EN:** `gleeunit` automatically discovers all `*_test` functions in the `test/` directory. Each file does not need its own `main()`.
- **ES:** El proyecto se creó con `gleam new numbers`, que genera automáticamente `src/`, `test/`, `gleam.toml`, `manifest.toml` y `.gitignore`.
- **EN:** The project was created with `gleam new numbers`, which automatically generates `src/`, `test/`, `gleam.toml`, `manifest.toml` and `.gitignore`.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
