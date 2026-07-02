# Hello, User! — Gleam

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Gleam**, compilado al runtime de Erlang (BEAM).

Lee un nombre desde la entrada estándar y saluda al usuario, **eliminando el salto de línea** que incluye el prompt.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/hellouser.gleam`](src/hellouser.gleam) | Código fuente: solicita un nombre al usuario y lo saluda. |
| [`test/hellouser_test.gleam`](test/hellouser_test.gleam) | Tests unitarios con gleeunit. |
| [`gleam.toml`](gleam.toml) | Manifiesto del proyecto — nombre, versión, dependencias. |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles. |

**Estructura de directorios esperada:**

```text
hellouser/
├── src/
│   └── hellouser.gleam    # Código fuente
├── test/
│   └── hellouser_test.gleam
├── gleam.toml              # Manifiesto del proyecto
├── manifest.toml           # Lock de dependencias
├── .gitignore              # Ignora *.beam, *.ez, /build
├── README.md               # Este archivo
└── build/                  # Código compilado (generado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce dos conceptos nuevos respecto a `hello_world`:

1. **Lectura de entrada** — Se usa `gleam/io` y `gleam/string` para leer una línea y procesarla.
2. **Interoperabilidad con Erlang** — La función `read_line` se declara con `@external(erlang, "io", "get_line")` para acceder directamente al módulo `io` de Erlang.
3. **Trim de cadenas** — `string.trim` elimina el salto de línea (`\n`) que incluye el prompt de Erlang.

**EN:** This program introduces two new concepts compared to `hello_world`:

1. **Input reading** — Uses `gleam/io` and `gleam/string` to read and process a line.
2. **Erlang interop** — The `read_line` function is declared with `@external(erlang, "io", "get_line")` to directly access Erlang's `io` module.
3. **String trimming** — `string.trim` removes the newline (`\n`) that Erlang's prompt includes.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/hellouser.gleam`

**ES:** El flujo del programa es:

1. Solicitar el nombre con `read_line("Enter your name: ")`.
2. Eliminar el salto de línea con `string.trim(name)`.
3. Concatenar y saludar con `io.println("Hello, " <> name <> "!")`.

**EN:** Program flow:

1. Prompt for the name with `read_line("Enter your name: ")`.
2. Remove the trailing newline with `string.trim(name)`.
3. Concatenate and greet with `io.println("Hello, " <> name <> "!")`.

```gleam
import gleam/io
import gleam/string

pub fn main() -> Nil {
  let name = read_line("Enter your name: ")
  let name = string.trim(name)
  io.println("Hello, " <> name <> "!")
}

@external(erlang, "io", "get_line")
fn read_line(prompt: String) -> String
```

| Elemento | Propósito |
|----------|-----------|
| `import gleam/io` | Importa el módulo de E/S de la biblioteca estándar |
| `import gleam/string` | Importa el módulo de manipulación de cadenas |
| `read_line(...)` | LLama a la función Erlang `io:get_line/1` mediante `@external` |
| `string.trim(name)` | Elimina espacios y saltos de línea al inicio/final de la cadena |
| `let name = ...` | Asignación (inmutable) — la segunda asignación **oculta** (shadow) a la primera |
| `io.println(...)` | Imprime el saludo con salto de línea al final |
| `@external(erlang, "io", "get_line")` | Atributo que declara interoperabilidad con el módulo `io` de Erlang |

> **ES:** A diferencia de Elixir (que usa `IO.gets/1`), Gleam no tiene una función estándar para leer de `stdin`, por lo que se recurre al `@external` para llamar directamente a Erlang. La función `string.trim/1` es necesaria porque `io:get_line/1` de Erlang **incluye** el `\n` al final.
> **EN:** Unlike Elixir (which uses `IO.gets/1`), Gleam has no standard function to read from `stdin`, so `@external` is used to call Erlang directly. The `string.trim/1` function is necessary because Erlang's `io:get_line/1` **includes** the trailing `\n`.

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

### Ejecutar

```bash
cd core/foundations/hellouser
gleam run
```

**Salida esperada / Expected output:**

```text
Enter your name: Ada
Hello, Ada!
```

> **ES:** A diferencia de la versión en Elixir (donde `IO.gets/1` incluye el `\n` y el signo de exclamación aparecía en la línea siguiente), aquí `string.trim/1` lo elimina y el saludo se imprime correctamente en una sola línea.
> **EN:** Unlike the Elixir version (where `IO.gets/1` includes the `\n` and the exclamation mark appeared on the next line), here `string.trim/1` removes it and the greeting is printed correctly on a single line.

### Ejecutar tests

```bash
gleam test
```

**Salida esperada / Expected output:**

```text
  Testing hellouser_test...
  1 tests, 0 failures
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Gleam es un lenguaje de tipado estático que compila a bytecode BEAM (la máquina virtual de Erlang/Elixir).
- **EN:** Gleam is a statically typed language that compiles to BEAM bytecode (the Erlang/Elixir virtual machine).
- **ES:** No existe una función `io.get_line` nativa en Gleam; se usa `@external(erlang, "io", "get_line")` para interoperar con Erlang directamente.
- **EN:** There is no native `io.get_line` function in Gleam; `@external(erlang, "io", "get_line")` is used to interop with Erlang directly.
- **ES:** La variable `name` se reasigna (shadowing) después de aplicar `trim`, lo cual es idiomático en Gleam.
- **EN:** The `name` variable is reassigned (shadowed) after applying `trim`, which is idiomatic in Gleam.
- **ES:** El proyecto se creó con `gleam new hellouser`, que genera automáticamente `src/`, `test/`, `gleam.toml`, `manifest.toml` y `.gitignore`.
- **EN:** The project was created with `gleam new hellouser`, which automatically generates `src/`, `test/`, `gleam.toml`, `manifest.toml` and `.gitignore`.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
