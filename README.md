# Gleam

Proyectos en **Gleam**, compilados al runtime de Erlang (**BEAM**).

Usa `gleam.toml` como manifiesto de proyecto, **gleam** como herramienta de construcción y **gleeunit** como framework de pruebas unitarias.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
gleam run

# Hello, User!
cd core/foundations/hellouser
gleam run

# Calculator Tests
cd core/foundations/unit_test/calculator
gleam test

# Numbers Tests
cd core/foundations/numbers
gleam test
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [Gleam](https://gleam.run/) | `brew install gleam` (macOS) / `scoop install gleam` (Windows) / [descargar](https://gleam.run/getting-started/installing-gleam/) (Linux) |
| [Erlang](https://www.erlang.org/) | `brew install erlang` (macOS) / `sudo apt install erlang-dev erlang-src` (Debian/Ubuntu) / `scoop install erlang` (Windows) |

```bash
# Verificar instalación
gleam --version
erl -version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Proyecto estándar (gleam new)

**ES:** Todo proyecto se crea con `gleam new <nombre>`, que genera automáticamente `src/`, `test/`, `gleam.toml`, `manifest.toml` y `.gitignore`. Se ejecuta con `gleam run` y los tests con `gleam test`.

**EN:** Every project is created with `gleam new <name>`, which automatically generates `src/`, `test/`, `gleam.toml`, `manifest.toml` and `.gitignore`. Run with `gleam run` and tests with `gleam test`.

```bash
gleam new <nombre>
gleam run    # Compila y ejecuta
gleam test   # Compila y ejecuta tests con gleeunit
gleam build  # Solo compila
```

### 2. Interoperabilidad con Erlang

**ES:** Gleam puede llamar directamente a funciones de Erlang mediante el atributo `@external(erlang, "módulo", "función")`. Esto es necesario cuando una funcionalidad no existe en la biblioteca estándar de Gleam (ej: lectura de `stdin`).

**EN:** Gleam can call Erlang functions directly via the `@external(erlang, "module", "function")` attribute. This is needed when a feature is not available in Gleam's standard library (e.g., reading from `stdin`).

```gleam
@external(erlang, "io", "get_line")
fn read_line(prompt: String) -> String
```

---

## 🧠 Características del lenguaje / Language Features

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | BEAM (Erlang VM) — concurrencia ligera, tolerancia a fallos |
| **Paradigma** | Funcional — datos inmutables, pattern matching, tipado estático con inferencia |
| **Iteración** | Recursión (tail-call optimization por BEAM) o funciones de orden superior |
| **Sin bucles** | No hay `for`/`while` tradicionales; se usa `case` + pattern matching |
| **Control de flujo** | `case` sobre `Bool` en lugar de `if` |
| **Tests** | `gleeunit` (dev-dependency) — `gleam test` compila y ejecuta |
| **Interop** | `@external(erlang, ...)` para llamar a módulos Erlang directamente |

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*