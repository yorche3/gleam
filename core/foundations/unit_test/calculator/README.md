# Calculator — Gleam

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Gleam**, compilado al runtime de Erlang (BEAM).

Implementa 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/calculator.gleam`](src/calculator.gleam) | Implementación de las 5 operaciones aritméticas. |
| [`test/calculator_test.gleam`](test/calculator_test.gleam) | 5 tests con gleeunit. |
| [`gleam.toml`](gleam.toml) | Manifiesto del proyecto — nombre, versión, dependencias. |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles. |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── calculator.gleam          # 5 operaciones aritméticas
├── test/
│   └── calculator_test.gleam     # 5 tests con gleeunit
├── gleam.toml                    # Manifiesto del proyecto
├── manifest.toml                 # Lock de dependencias
├── .gitignore                    # Ignora *.beam, *.ez, /build
├── README.md                     # Este archivo
└── build/                        # Código compilado (generado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Gleam** con **gleeunit** como framework de tests.

Características:
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación minimalista**: `multiplication`, `division` y `modulus` se construyen usando solo `+` y `-` como operaciones primitivas.
- **Recursión con `case`**: Los bucles se implementan con funciones auxiliares recursivas que usan `case` con guards booleanos.
- **Framework de tests**: `gleeunit` — el framework de testing oficial de Gleam, similar a `ExUnit` de Elixir.

**EN:** This project uses **Gleam** with **gleeunit** as the test framework.

Features:
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Minimalist implementation**: `multiplication`, `division` and `modulus` are built using only `+` and `-` as primitive operations.
- **Recursion with `case`**: Loops are implemented with recursive helper functions using `case` with boolean guards.
- **Test framework**: `gleeunit` — the official Gleam test library, similar to `ExUnit` in Elixir.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `gleam.toml` — Manifiesto del proyecto

**ES:** Define el nombre, versión y dependencias del proyecto.

**EN:** Defines the project name, version and dependencies.

```toml
name = "calculator"
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

### `src/calculator.gleam` — Implementación

**ES:** Las 5 operaciones como funciones públicas del módulo `calculator`. Las funciones auxiliares (`loop_sum`, `loop_subtraction`) son privadas. Usan `case` con `True`/`False` para controlar la recursión.

**EN:** The 5 operations as public functions of the `calculator` module. Helper functions (`loop_sum`, `loop_subtraction`) are private. They use `case` with `True`/`False` to control recursion.

```gleam
pub fn addition(a: Int, b: Int) -> Int {
  a + b
}

pub fn subtraction(a: Int, b: Int) -> Int {
  a - b
}

fn loop_sum(a: Int, b: Int, result: Int) -> Int {
  case b <= 0 {
    True -> result
    False -> loop_sum(a, subtraction(b, 1), addition(result, a))
  }
}

pub fn multiplication(a: Int, b: Int) -> Int {
  loop_sum(a, b, 0)
}

fn loop_subtraction(a: Int, b: Int, quotient: Int) -> Int {
  case a < b {
    True -> quotient
    False -> loop_subtraction(subtraction(a, b), b, addition(quotient, 1))
  }
}

pub fn division(a: Int, b: Int) -> Int {
  loop_subtraction(a, b, 0)
}

pub fn modulus(a: Int, b: Int) -> Int {
  subtraction(a, multiplication(b, division(a, b)))
}
```

| Elemento | Propósito |
|----------|-----------|
| `addition(a, b)` | Suma dos enteros usando el operador `+` |
| `subtraction(a, b)` | Resta dos enteros usando el operador `-` |
| `loop_sum(a, b, result)` | Función privada recursiva: suma `a` repetidamente `b` veces |
| `multiplication(a, b)` | Multiplicación implementada como suma repetitiva |
| `loop_subtraction(a, b, quotient)` | Función privada recursiva: resta `b` de `a` hasta que `a < b` |
| `division(a, b)` | División entera implementada como resta repetitiva |
| `modulus(a, b)` | Residuo: `a - (b * cociente)` |
| `case ... { True -> ... False -> ... }` | Expresión de control de flujo en Gleam |

> **ES:** Gleam no tiene `if` como expresión de control — usa `case` con pattern matching sobre `Bool`. Las funciones en Gleam son puras y no tienen efectos secundarios.
> **EN:** Gleam doesn't have `if` as a control expression — it uses `case` with pattern matching on `Bool`. Functions in Gleam are pure and have no side effects.

### `test/calculator_test.gleam` — Pruebas

**ES:** 5 tests con `gleeunit`, cada uno usando la palabra clave `assert`.

**EN:** 5 tests with `gleeunit`, each using the `assert` keyword.

```gleam
import calculator
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn addition_test() {
  assert calculator.addition(3, 2) == 5
}

pub fn subtraction_test() {
  assert calculator.subtraction(5, 2) == 3
}

pub fn multiplication_test() {
  assert calculator.multiplication(4, 3) == 12
}

pub fn division_test() {
  assert calculator.division(10, 3) == 3
}

pub fn modulus_test() {
  assert calculator.modulus(10, 3) == 1
}
```

| Elemento | Propósito |
|----------|-----------|
| `import calculator` | Importa el módulo que queremos testear |
| `import gleeunit` | Importa el framework de tests |
| `gleeunit.main()` | Punto de entrada para ejecutar los tests |
| `assert ... == ...` | Afirmación — si falla, el test se marca como error |
| `addition_test` / `subtraction_test` / ... | Nombres de funciones de test (deben terminar en `_test`) |

> **ES:** En Gleam, `assert` es una **palabra clave del lenguaje** que verifica que una expresión sea `True`. Si la expresión evaluada es `False`, el programa lanza un error. gleeunit captura este error y lo reporta como test fallido.
> **EN:** In Gleam, `assert` is a **language keyword** that checks whether an expression is `True`. If the evaluated expression is `False`, the program raises an error. gleeunit catches this error and reports it as a failed test.

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

### Ejecutar pruebas

```bash
cd core/foundations/unit_test/calculator
gleam test
```

**Salida esperada / Expected output:**

```text
  Testing calculator_test...
  5 tests, 0 failures
```

> **ES:** `gleam test` compila el proyecto y ejecuta todos los tests automáticamente usando gleeunit.
> **EN:** `gleam test` compiles the project and runs all tests automatically using gleeunit.

---

## 🧠 Algoritmos / operaciones

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(a, b)` | `a + b` | `+` |
| `subtraction(a, b)` | `a - b` | `-` |
| `multiplication(a, b)` | Suma repetitiva de `a`, `b` veces | `+`, `-` |
| `division(a, b)` | Resta repetitiva, cuenta cociente | `+`, `-` |
| `modulus(a, b)` | `a - (cociente * b)` | `+`, `-` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Gleam es un lenguaje de tipado estático con inferencia de tipos que compila a bytecode BEAM.
- **EN:** Gleam is a statically typed language with type inference that compiles to BEAM bytecode.
- **ES:** Las funciones auxiliares `loop_sum` y `loop_subtraction` son privadas (no tienen `pub`) y no son accesibles desde fuera del módulo.
- **EN:** The helper functions `loop_sum` and `loop_subtraction` are private (no `pub`) and are not accessible from outside the module.
- **ES:** Gleam no tiene `++` o `--`, ni bucles `for`/`while`. Toda iteración se hace con recursión.
- **EN:** Gleam doesn't have `++` or `--`, nor `for`/`while` loops. All iteration is done via recursion.
- **ES:** `gleeunit` es una dependencia de desarrollo (`[dev_dependencies]`), por lo que no se incluye en builds de producción.
- **EN:** `gleeunit` is a dev dependency (`[dev_dependencies]`), so it's not included in production builds.
- **ES:** El proyecto se creó con `gleam new calculator`, que genera automáticamente `src/`, `test/`, `gleam.toml`, `manifest.toml` y `.gitignore`.
- **EN:** The project was created with `gleam new calculator`, which automatically generates `src/`, `test/`, `gleam.toml`, `manifest.toml` and `.gitignore`.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
