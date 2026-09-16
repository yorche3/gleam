# Naive Sort — Gleam

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Gleam**, compilado al runtime de Erlang (BEAM) y probado con **gleeunit**.

Implementa los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — con recursión y pattern matching, sin invocar `list.sort` ni ninguna rutina de ordenamiento del sistema.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/naive_sort.gleam`](src/naive_sort.gleam) | Las 3 funciones del contrato + 3 helpers privados. |
| [`test/naive_sort_test.gleam`](test/naive_sort_test.gleam) | Entry point de gleeunit (`main`) y los 3 tests con sus 7 casos. |
| [`gleam.toml`](gleam.toml) | Manifiesto del proyecto — nombre, versión, dependencias. |
| [`manifest.toml`](manifest.toml) | Lock de dependencias — versiones exactas para builds reproducibles. |
| `.gitignore` | Ignora `*.beam`, `*.ez`, `/build` y `erl_crash.dump`. |
| `.github/workflows/test.yml` | CI generado por `gleam new`: `gleam deps download`, `gleam test` y `gleam format --check src test`. |

**Estructura de directorios esperada:**

```text
naive_sort/
├── src/
│   └── naive_sort.gleam          # 3 funciones públicas + 3 helpers privados
├── test/
│   └── naive_sort_test.gleam     # Entry point de gleeunit + 3 tests
├── gleam.toml                    # Manifiesto del proyecto
├── manifest.toml                 # Lock de dependencias
├── .gitignore                    # Ignora *.beam, *.ez, /build
├── README.md                     # Este archivo
└── build/                        # Código compilado (generado)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con `gleam new naive_sort`, que genera `src/`, `test/`, `gleam.toml`, `manifest.toml`, `.gitignore` y un workflow de CI. Se eliminó la función `main` de ejemplo de `src/naive_sort.gleam`, porque este módulo es una biblioteca: `core/foundations/numbers/src/numbers.gleam` tampoco la tiene.

Gleam **no tiene bucles** `for`/`while` ni estructuras mutables: los tres algoritmos se expresan con **recursión y `case` con pattern matching**, y cada uno devuelve una lista nueva en lugar de ordenar *in-place*.

**EN:** The project was created with `gleam new naive_sort`, which generates `src/`, `test/`, `gleam.toml`, `manifest.toml`, `.gitignore` and a CI workflow. The example `main` function was removed from `src/naive_sort.gleam` because this module is a library: `core/foundations/numbers/src/numbers.gleam` does not have one either.

Gleam **has no** `for`/`while` **loops** and no mutable structures: all three algorithms are expressed with **recursion and `case` pattern matching**, and each returns a new list instead of sorting in place.

```bash
gleam new naive_sort
```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `gleam.toml` — Manifiesto del proyecto

**ES:** Además del nombre y la versión, el campo `name` determina qué módulo ejecuta `gleam test`: el entry point debe llamarse `<name>_test`, y por eso el archivo de pruebas es `test/naive_sort_test.gleam`.

**EN:** Besides the name and version, the `name` field determines which module `gleam test` runs: the entry point must be called `<name>_test`, which is why the test file is `test/naive_sort_test.gleam`.

```toml
name = "naive_sort"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 1.0.0 and < 2.0.0"

[dev_dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```

### `src/naive_sort.gleam` — Implementación

**ES:** Sólo las tres funciones del contrato son públicas. Los helpers (`pick_min`, `bubble_pass`, `insert`) se declaran con `fn` —sin `pub`— y por tanto no forman parte de la API del módulo.

**EN:** Only the three contract functions are public. The helpers (`pick_min`, `bubble_pass`, `insert`) are declared with `fn` — without `pub` — and are therefore not part of the module API.

```gleam
pub fn selection_sort(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    [x] -> [x]
    [x, ..xs] -> {
      let #(min_val, rest) = pick_min(x, [], xs)
      [min_val, ..selection_sort(rest)]
    }
  }
}

pub fn bubble_sort(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    [x] -> [x]
    _ -> {
      let #(new_arr, swapped) = bubble_pass(arr, False)
      case swapped {
        True -> bubble_sort(new_arr)
        False -> new_arr
      }
    }
  }
}
```

### `test/naive_sort_test.gleam` — Pruebas

**ES:** Los siete casos se declaran como constantes con nombre (`standard_input`, `reverse_output`, …) y un único helper `assert_sorts_all_cases` recorre la lista de casos para cualquier algoritmo. Como gleeunit no permite mensajes de aserción, el mensaje se emite con `panic as`, de modo que cada fallo se identifica como `"{algoritmo} should sort {caso}"`.

**EN:** The seven cases are declared as named constants (`standard_input`, `reverse_output`, …) and a single `assert_sorts_all_cases` helper walks the case list for any algorithm. Since gleeunit does not support assertion messages, the message is emitted with `panic as`, so every failure is identified as `"{algorithm} should sort {case}"`.

```gleam
fn assert_sorts_all_cases(
  sort: fn(List(Int)) -> List(Int),
  algorithm: String,
) -> Nil {
  list.each(cases, fn(test_case) {
    let #(description, input, expected) = test_case
    let message = algorithm <> " should sort " <> description
    case sort(input) == expected {
      True -> Nil
      False -> panic as message
    }
  })
}

pub fn selection_sort_test() {
  assert_sorts_all_cases(naive_sort.selection_sort, "selection_sort")
}
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Gleam y Erlang/OTP

```bash
gleam --version   # gleam 1.18.1
erl -version      # OTP 29
```

### Compilar / Build

```bash
cd core/algorithms/naive_sort
gleam build
```

**Salida real / Actual output:**

```text
   Compiled in 0.27s
```

### Ejecutar pruebas / Run tests

```bash
gleam test
```

**Salida real / Actual output:**

```text
   Compiled in 0.29s
    Running naive_sort_test.main
...
3 passed, no failures
```

### Comprobar el formato / Check formatting

**ES:** Es el tercer paso del workflow que genera `gleam new`.

**EN:** It is the third step of the workflow generated by `gleam new`.

```bash
gleam format --check src test
```

**Salida real / Actual output:** sin salida, código de salida `0`.

---

## 🧠 Algoritmos / operaciones

| Función | Estrategia | Complejidad | In-place | Tests |
|---------|-----------|-------------|:--------:|:-----:|
| `selection_sort` | El helper `pick_min` devuelve el mínimo y el resto; el mínimo se antepone al resultado de ordenar el resto | $O(n^2)$ siempre | ❌ (lista nueva) | 7 |
| `bubble_sort` | `bubble_pass` hace una pasada y devuelve `#(lista, swapped)`; `bubble_sort` repite mientras haya intercambios | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |
| `insertion_sort` | Ordena la cola y el helper `insert` coloca la cabeza en su sitio | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |

| Helper privado | Papel |
|----------------|-------|
| `pick_min` | Devuelve el mínimo de la lista y los elementos restantes como `#(Int, List(Int))`. |
| `bubble_pass` | Una pasada de burbuja; devuelve la lista y la bandera `swapped` acumulada. |
| `insert` | Inserta un entero en una lista ya ordenada. |

**Casos cubiertos:** lista desordenada, ya ordenada, en orden inverso, elementos idénticos, con negativos, un solo elemento y lista vacía.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Divergencias idiomáticas respecto al pseudocódigo / Idiomatic divergences from the pseudocode

| Pseudocódigo | Gleam | Motivo / Reason |
|--------------|-------|-----------------|
| `swap(arr, i, min_idx)` *in-place* | Se construye una lista nueva | Las listas de Gleam son inmutables / Gleam lists are immutable |
| Bucles `for` / `while` | Recursión con `case` y pattern matching | Gleam no tiene bucles imperativos / Gleam has no imperative loops |
| `swapped = false` mutado durante la pasada | `bubble_pass` recibe y devuelve la bandera como parámetro | Equivalente funcional; conserva la salida temprana / Functional equivalent of the flag |
| `if n <= 1` | Cláusulas `[]` y `[x]` | Pattern matching idiomático / Idiomatic pattern matching |
| `if min_idx >= 0` (índices) | `let #(min_val, rest) = pick_min(...)` con tuplas | Gleam no usa índices: se trabaja por estructura / Gleam has no indices |
| `selection_sort(arr)` | `selection_sort` (`snake_case`) | Coincide con la convención de Gleam y con la especificación |

**ES:** `pick_min` devuelve los elementos restantes en el orden en que los acumuló (invertido respecto al original). Es inocuo: esa lista se vuelve a ordenar de inmediato y el mínimo devuelto es el correcto.

**EN:** `pick_min` returns the remaining elements in the order it accumulated them (reversed relative to the original). It is harmless: that list is immediately re-sorted and the returned minimum is correct.

### 🚫 Caso nulo / Null case

**ES:** El caso nulo de la especificación **se omite** porque Gleam no tiene `null`/`nil` y `List(Int)` no puede representar una entrada inválida: no existe tal entrada. La justificación está documentada en `src/naive_sort.gleam`.

**EN:** The specification's null case **is omitted** because Gleam has no `null`/`nil` and `List(Int)` cannot represent an invalid input: no such input exists. The rationale is documented in `src/naive_sort.gleam`.

### 📁 Desviación de ubicación / Location deviation

**ES:** La especificación espera `src/naive_sort.ext`, `test/naive_sort_test.ext` y un `run_tests.ext`. Los dos primeros **coinciden** con el *naming* de Gleam (el archivo de un módulo lleva su nombre, y el de pruebas `<paquete>_test`). El tercero no existe porque en Gleam el entry point de gleeunit es una función `main` dentro del propio módulo de pruebas: `test/naive_sort_test.gleam` contiene tanto `main` como los tests.

**EN:** The specification expects `src/naive_sort.ext`, `test/naive_sort_test.ext` and a `run_tests.ext`. The first two **match** Gleam naming (a module file is named after the module, and the test file is `<package>_test`). The third does not exist because in Gleam the gleeunit entry point is a `main` function inside the test module itself: `test/naive_sort_test.gleam` holds both `main` and the tests.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Algorithms Pure](README.md) | [↑ Volver a Gleam Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
