pub fn sum_first_n_rec(n: Int) -> Int {
  case n <= 0 {
    True -> 0
    False -> n + sum_first_n_rec(n - 1)
  }
}

pub fn factorial_rec(n: Int) -> Int {
  case n <= 1 {
    True -> 1
    False -> n * factorial_rec(n - 1)
  }
}

pub fn fibonacci_rec(n: Int) -> Int {
  case n <= 1 {
    True -> n
    False -> fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
  }
}

pub fn greatest_common_divisior_rec(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    _ -> greatest_common_divisior_rec(b, a % b)
  }
}

pub fn least_common_multiple_rec(a: Int, b: Int) -> Int {
  a * b / greatest_common_divisior_rec(a, b)
}

fn sum_first_n_help(n: Int, acc: Int) -> Int {
  case n <= 0 {
    True -> acc
    False -> sum_first_n_help(n - 1, n + acc)
  }
}

pub fn sum_first_n_acc(n: Int) -> Int {
  sum_first_n_help(n, 0)
}

fn factorial_help(n: Int, acc: Int) -> Int {
  case n <= 0 {
    True -> acc
    False -> factorial_help(n - 1, n * acc)
  }
}

pub fn factorial_acc(n: Int) -> Int {
  factorial_help(n, 1)
}

fn fibonacci_help(n: Int, acc1: Int, acc2: Int) -> Int {
  case n <= 0 {
    True -> acc1
    False -> fibonacci_help(n - 1, acc2, acc1 + acc2)
  }
}

pub fn fibonacci_acc(n: Int) -> Int {
  fibonacci_help(n, 0, 1)
}

pub fn greatest_common_divisior_acc(a: Int, b: Int) -> Int {
  case b == 0 {
    True -> a
    False -> greatest_common_divisior_acc(b, a % b)
  }
}

pub fn least_common_multiple_acc(a: Int, b: Int) -> Int {
  a * b / greatest_common_divisior_acc(a, b)
}
