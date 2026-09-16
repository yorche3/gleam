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
    [x] -> [x]
    [x, ..xs] -> {
      let #(min_val, rest) = pick_min(x, [], xs)
      [min_val, ..selection_sort(rest)]
    }
  }
}

fn pick_min(
  min_val: Int,
  acc: List(Int),
  remaining: List(Int),
) -> #(Int, List(Int)) {
  case remaining {
    [] -> #(min_val, acc)
    [x, ..xs] -> {
      case x < min_val {
        True -> pick_min(x, [min_val, ..acc], xs)
        False -> pick_min(min_val, [x, ..acc], xs)
      }
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

fn bubble_pass(arr: List(Int), swapped: Bool) -> #(List(Int), Bool) {
  case arr {
    [] -> #([], swapped)
    [x] -> #([x], swapped)
    [x, y, ..rest] -> {
      case x > y {
        True -> {
          let #(new_rest, new_swapped) = bubble_pass([x, ..rest], True)
          #([y, ..new_rest], new_swapped)
        }
        False -> {
          let #(new_rest, new_swapped) = bubble_pass([y, ..rest], swapped)
          #([x, ..new_rest], new_swapped)
        }
      }
    }
  }
}

pub fn insertion_sort(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    [x] -> [x]
    [x, ..xs] -> {
      let head = x
      let tail = xs
      let sorted_tail = insertion_sort(tail)
      insert(head, sorted_tail)
    }
  }
}

fn insert(x: Int, arr: List(Int)) -> List(Int) {
  case arr {
    [] -> [x]
    [y, ..ys] -> {
      case x <= y {
        True -> [x, y, ..ys]
        False -> [y, ..insert(x, ys)]
      }
    }
  }
}
