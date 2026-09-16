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
