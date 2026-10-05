# Algorithms Pure — Gleam

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Gleam**, compilado al runtime de Erlang (**BEAM**): ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan con datos **inmutables**: `naive_sort` sobre listas (`List(Int)`) y `data_structures_basics` sobre sus propios tipos (`Node`, `LinkedList`, `Stack`, `Queue`). Ninguna función muta lo que recibe: todas devuelven el valor nuevo.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `gleam test` + `gleeunit` | 3 | ✅ |
| [`data_structures_basics/`](data_structures_basics/) | [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) | `gleam test` + `gleeunit` | 4 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
├── naive_sort/                   # 05_Naive_Sort
│   ├── gleam.toml
│   ├── manifest.toml
│   ├── src/
│   │   └── naive_sort.gleam      # selection_sort, bubble_sort, insertion_sort
│   ├── test/
│   │   └── naive_sort_test.gleam # Entry point de gleeunit + 3 tests
│   └── README.md
└── data_structures_basics/       # 06_Data_Structures_Basics
    ├── gleam.toml
    ├── manifest.toml
    ├── src/
    │   └── data_structures_basics.gleam      # Node, LinkedList, Stack, Queue
    ├── test/
    │   └── data_structures_basics_test.gleam # Entry point de gleeunit + 4 tests
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — Gleam compila a Erlang |
| **CLI** | `gleam build`, `gleam test`, `gleam format` |
| **Manifiesto** | `gleam.toml` — el campo `name` fija el módulo de entrada de tests (`<name>_test`) |
| **Lock** | `manifest.toml` — versiones exactas de dependencias |
| **Framework de tests** | `gleeunit` — en `dev_dependencies` |
| **Entry point** | `main` con `gleeunit.main()` dentro del módulo de pruebas |
| **Descubrimiento** | Toda función pública terminada en `_test` se ejecuta automáticamente |
| **Iteración** | Recursión con `case`; Gleam no tiene bucles ni mutabilidad |
| **Helpers** | Funciones privadas (`fn` sin `pub`) |
| **Indicador de fallo** | `data_structures_basics`: `-1` en las consultas que devuelven un entero y tuplas `(valor, estructura)` en las extracciones; `naive_sort` no aplica: `List(Int)` no admite entradas inválidas |
| **Formato** | `gleam format --check src test`, exigido por el CI del scaffold |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
gleam build
gleam test

# Data Structures Basics Tests
cd data_structures_basics
gleam build
gleam test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
