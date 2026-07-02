# 🚀 Foundations — Gleam

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **Gleam**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | `gleam run` | — | ✅ |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | `gleam run` + `@external(erlang, ...)` | — | ✅ |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | `gleam test` + `gleeunit` | 5 | ✅ |
| [`numbers/`](numbers/) | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | `gleam test` + `gleeunit` | 10 | ✅ |

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                   # 01_Hello_World
│   ├── src/
│   │   └── helloworld.gleam      # io.println("Hello, World! from Gleam!")
│   ├── test/
│   │   └── helloworld_test.gleam
│   ├── gleam.toml
│   ├── manifest.toml
│   └── README.md
│
├── hellouser/                    # 02_Hello_User
│   ├── src/
│   │   └── hellouser.gleam       # @external(erlang, "io", "get_line")
│   ├── test/
│   │   └── hellouser_test.gleam
│   ├── gleam.toml
│   ├── manifest.toml
│   └── README.md
│
├── unit_test/
│   └── calculator/               # 03_Unit_Test_Calculator
│       ├── src/
│       │   └── calculator.gleam  # 5 operaciones (recursión con case)
│       ├── test/
│       │   └── calculator_test.gleam  # 5 tests
│       ├── gleam.toml
│       ├── manifest.toml
│       └── README.md
│
└── numbers/                      # 04_Numbers
    ├── src/
    │   └── numbers.gleam         # 10 funciones (2 enfoques × 5 algoritmos)
    ├── test/
    │   ├── numbers_test.gleam    # Entry point (gleeunit.main())
    │   ├── numbers_rec_tests.gleam   # 5 tests recursivos
    │   └── numbers_acc_tests.gleam   # 5 tests con acumulador
    ├── gleam.toml
    ├── manifest.toml
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — ejecución concurrente y tolerante a fallos |
| **CLI** | `gleam run` para ejecutar; `gleam test` para pruebas |
| **Proyectos** | Todos creados con `gleam new <nombre>` — generación automática de `src/`, `test/`, `gleam.toml`, `manifest.toml` |
| **Manifiesto** | `gleam.toml` — define nombre, versión y dependencias |
| **Framework de tests** | `gleeunit` — dependencia de desarrollo (`[dev_dependencies]`) |
| **Control de flujo** | `case` + pattern matching sobre `Bool` (no hay `if`) |
| **Recursión** | Forma principal de iteración; la BEAM garantiza TCO |
| **Sin bucles tradicionales** | No hay `for`/`while` estilo imperativo |
| **Interop con Erlang** | `@external(erlang, "módulo", "función")` para funcionalidades faltantes |
| **Tipado** | Estático con inferencia de tipos |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Hello, World!
cd helloworld
gleam run

# Hello, User!
cd hellouser
gleam run

# Calculator Tests
cd unit_test/calculator
gleam test

# Numbers Tests
cd numbers
gleam test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).  
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

---

*[← Volver a Gleam](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
