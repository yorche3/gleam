import numbers

// gleeunit test functions end in `_test`
pub fn sum_first_n_acc_test() {
  assert numbers.sum_first_n_acc(0) == 0
  assert numbers.sum_first_n_acc(3) == 6
}

pub fn factorial_acc_test() {
  assert numbers.factorial_acc(0) == 1
  assert numbers.factorial_acc(4) == 24
}

pub fn fibonacci_acc_test() {
  assert numbers.fibonacci_acc(0) == 0
  assert numbers.fibonacci_acc(1) == 1
  assert numbers.fibonacci_acc(6) == 8
}

pub fn gcd_acc_test() {
  assert numbers.greatest_common_divisior_acc(12, 8) == 4
  assert numbers.greatest_common_divisior_acc(7, 5) == 1
}

pub fn lcm_acc_test() {
  assert numbers.least_common_multiple_acc(6, 8) == 24
  assert numbers.least_common_multiple_acc(4, 6) == 12
}
