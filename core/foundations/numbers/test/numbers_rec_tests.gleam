import numbers

// gleeunit test functions end in `_test`
pub fn sum_first_n_rec_test() {
  assert numbers.sum_first_n_rec(0) == 0
  assert numbers.sum_first_n_rec(3) == 6
}

pub fn factorial_rec_test() {
  assert numbers.factorial_rec(0) == 1
  assert numbers.factorial_rec(4) == 24
}

pub fn fibonacci_rec_test() {
  assert numbers.fibonacci_rec(0) == 0
  assert numbers.fibonacci_rec(1) == 1
  assert numbers.fibonacci_rec(6) == 8
}

pub fn gcd_rec_test() {
  assert numbers.greatest_common_divisior_rec(12, 8) == 4
  assert numbers.greatest_common_divisior_rec(7, 5) == 1
}

pub fn lcm_rec_test() {
  assert numbers.least_common_multiple_rec(6, 8) == 24
  assert numbers.least_common_multiple_rec(4, 6) == 12
}
