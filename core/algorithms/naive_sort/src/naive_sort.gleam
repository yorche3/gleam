// naive_sort.gleam — Módulo Naive Sort con ordenamientos elementales
//
// Especificación: 05_Naive_Sort
//
// Algoritmos (List(Int) -> List(Int)), de menor a mayor:
//   selection_sort  — encuentra el mínimo del tramo no ordenado
//   bubble_sort     — compara e intercambia adyacentes, con bandera `swapped`
//   insertion_sort  — inserta cada elemento en su sub-array ordenado
//
// Caso nulo: Gleam no tiene `null`/`nil` y `List(Int)` no admite entradas
// inválidas, por lo que el caso de la especificación se omite.
pub fn selection_sort(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    [x, ..xs] -> {
      let #(min_val, rest) = pick_min_loop(x, [], xs)
      [min_val, ..selection_sort(rest)]
    }
  }
}

// Encuentra el mínimo de `remaining` y devuelve `#(mínimo, resto)`. `acc`
// acumula (en orden inverso) los elementos que no son el mínimo corriente.
fn pick_min_loop(min_val: Int, acc: List(Int), remaining: List(Int)) -> #(Int, List(Int)) {
  case remaining {
    [] -> #(min_val, acc)
    [x, ..xs] ->
      case x < min_val {
        True -> pick_min_loop(x, [min_val, ..acc], xs)
        False -> pick_min_loop(min_val, [x, ..acc], xs)
      }
  }
}
