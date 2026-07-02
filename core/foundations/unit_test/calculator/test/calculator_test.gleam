import calculator
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
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
