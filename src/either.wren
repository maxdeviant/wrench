class Either {
  construct Left(left) {
    _type = "left"
    _left = left
  }

  construct Right(right) {
    _type = "right"
    _right = right
  }

  isLeft { _type == "left" }

  isRight { _type == "right" }

  bind(f) {
    if (isRight) {
      return f.call(_right)
    } else {
      return Either.Left(_left)
    }
  }

  map(f) {
    return bind(Fn.new {|r| Either.Right(f.call(r))})
  }

  match(leftFn, rightFn) {
    if (isRight) {
      return rightFn.call(_right)
    } else {
      return leftFn.call(_left)
    }
  }

  toString {
    if (isRight) {
      return "Right(" + _right + ")"
    } else {
      return "Left(" + _left + ")"
    }
  }
}