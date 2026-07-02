pub fn addition(a: Int, b: Int) -> Int {
  a + b
}

pub fn subtraction(a: Int, b: Int) -> Int {
  a - b
}

fn loop_sum(a: Int, b: Int, result: Int) -> Int {
  case b <= 0 {
    True -> result
    False -> loop_sum(a, subtraction(b, 1), addition(result, a))
  }
}

pub fn multiplication(a: Int, b: Int) -> Int {
  loop_sum(a, b, 0)
}

fn loop_subtraction(a: Int, b: Int, quotient: Int) -> Int {
  case a < b {
    True -> quotient
    False -> loop_subtraction(subtraction(a, b), b, addition(quotient, 1))
  }
}

pub fn division(a: Int, b: Int) -> Int {
  loop_subtraction(a, b, 0)
}

pub fn modulus(a: Int, b: Int) -> Int {
  subtraction(a, multiplication(b, division(a, b)))
}
