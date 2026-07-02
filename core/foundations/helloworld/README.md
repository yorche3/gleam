# Hello, World! — Gleam

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Gleam**, compilado al runtime de Erlang (BEAM).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`src/helloworld.gleam`](src/helloworld.gleam) | Código fuente: imprime `"Hello, World! from Gleam!"` en la consola. |
| [`gleam.toml`](gleam.toml) | Manifiesto del proyecto — nombre, versión, dependencias. |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles. |

**Estructura de directorios esperada:**

```text
helloworld/
├── src/
│   └── helloworld.gleam    # Código fuente
├── test/                   # Tests (generado por gleam new)
│   └── helloworld_test.gleam
├── gleam.toml              # Manifiesto del proyecto
├── manifest.toml           # Lock de dependencias
├── .gitignore              # Ignora *.beam, *.ez, /build
├── README.md               # Este archivo
└── build/                  # Código compilado (generado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto se creó con `gleam new helloworld` y sigue el enfoque estándar de Gleam: compilación a bytecode BEAM y ejecución en la máquina virtual de Erlang. Gleam tiene tipado estático, sintaxis similar a Rust y usa el gestor de paquetes Hex.

**EN:** This project was created with `gleam new helloworld` and follows the standard Gleam approach: compilation to BEAM bytecode and execution on the Erlang virtual machine. Gleam has static typing, Rust-like syntax, and uses the Hex package manager.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/helloworld.gleam`

**ES:** Punto de entrada `main()`. Importa `gleam/io` para `println` e imprime el saludo en la consola.

**EN:** Entry point `main()`. Imports `gleam/io` for `println` and prints the greeting to the console.

```gleam
import gleam/io

pub fn main() -> Nil {
  io.println("Hello, World! from Gleam!")
}
```

| Elemento | Propósito |
|----------|-----------|
| `import gleam/io` | Importa el módulo de E/S de la biblioteca estándar |
| `pub fn main() -> Nil` | Punto de entrada del programa, devuelve `Nil` |
| `io.println(...)` | Imprime una cadena con salto de línea en la consola |

> **ES:** `pub fn main() -> Nil` es el punto de entrada obligatorio en Gleam. A diferencia de C (que usa `int main()`), Gleam no requiere un código de retorno al sistema operativo.
> **EN:** `pub fn main() -> Nil` is the mandatory entry point in Gleam. Unlike C (which uses `int main()`), Gleam does not require a return code to the operating system.

### `gleam.toml` — Manifiesto del proyecto

**ES:** Archivo de configuración del proyecto Gleam en formato TOML. Define nombre, versión y dependencias.

**EN:** Gleam project configuration file in TOML format. Defines name, version and dependencies.

```toml
name = "helloworld"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 1.0.0 and < 2.0.0"

[dev_dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```

| Elemento | Propósito |
|----------|-----------|
| `name` | Nombre del paquete en el registro Hex |
| `version` | Versión semántica del proyecto |
| `[dependencies]` | Dependencias de producción |
| `[dev_dependencies]` | Dependencias solo para desarrollo y tests |
| `gleam_stdlib` | Biblioteca estándar de Gleam (E/S, cadenas, listas, etc.) |
| `gleeunit` | Framework de testing unitario para Gleam |

> **ES:** `gleeunit` es el framework de testing oficial de Gleam, equivalente a JUnit en Java o `unittest` en Python.
> **EN:** `gleeunit` is the official Gleam test framework, equivalent to JUnit in Java or `unittest` in Python.

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
cd core/foundations/helloworld
gleam run
```

**Salida esperada / Expected output:**

```text
Hello, World! from Gleam!
```

> **ES:** `gleam run` compila y ejecuta en un solo paso. Para solo compilar: `gleam build`.
> **EN:** `gleam run` compiles and runs in one step. To only build: `gleam build`.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Gleam es un lenguaje de tipado estático que compila a bytecode BEAM (la máquina virtual de Erlang/Elixir).
- **EN:** Gleam is a statically typed language that compiles to BEAM bytecode (the Erlang/Elixir virtual machine).
- **ES:** A diferencia de C o C++, Gleam tiene un gestor de paquetes (Hex) y requiere un archivo de proyecto (`gleam.toml` + `manifest.toml`).
- **EN:** Unlike C or C++, Gleam has a package manager (Hex) and requires a project file (`gleam.toml` + `manifest.toml`).
- **ES:** El proyecto se creó con `gleam new helloworld`, que genera automáticamente `src/`, `test/`, `gleam.toml`, `manifest.toml` y `.gitignore`.
- **EN:** The project was created with `gleam new helloworld`, which automatically generates `src/`, `test/`, `gleam.toml`, `manifest.toml` and `.gitignore`.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

