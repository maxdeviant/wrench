import "invariant" for Invariant

class Either {
  construct Left(left) {
    _kind = "left"
    _left = left
  }

  construct Right(right) {
    _kind = "right"
    _right = right
  }

  isLeft { _kind == "left" }

  isRight { _kind == "right" }

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

  match(matchers) {
    var leftFn = matchers["Left"]
    Invariant.check(leftFn is Fn, "Either.match: Must provide a \"Left\" case.")
    var rightFn = matchers["Right"]
    Invariant.check(rightFn is Fn, "Either.match: Must provide a \"Right\" case.")
    if (isRight) {
      return rightFn.call(_right)
    } else {
      return leftFn.call(_left)
    }
  }

  toString {
    if (isRight) {
      return "Right(" + _right.toString + ")"
    } else {
      return "Left(" + _left.toString + ")"
    }
  }

  ==(other) {
    return match({
      "Right": Fn.new {|right|
        return other.match({
          "Right": Fn.new {|otherRight| right == otherRight},
          "Left": Fn.new {false}
        })
      },
      "Left": Fn.new {|left|
        return other.match({
          "Right": Fn.new {false},
          "Left": Fn.new {|otherLeft| left == otherLeft}
        })
      }
    })
  }
}
