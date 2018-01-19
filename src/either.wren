import "invariant" for Invariant

class Either {
  construct Right(right) {
    Invariant.check(right != null, "Either.Right: Value cannot be null.")
    _kind = "right"
    _right = right
  }

  construct Left(left) {
    Invariant.check(left != null, "Either.Left: Value cannot be null.")
    _kind = "left"
    _left = left
  }

  isRight { _kind == "right" }

  isLeft { _kind == "left" }

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
    // @TODO Sort the keys since we can't depend on the built-in order of `.keys`
    var invalidKeys = matchers.keys.where {|k| k != "Left" && k != "Right"}
    Invariant.check(invalidKeys.count == 0, Fn.new {
      var invalidCases = invalidKeys.map {|k| "\"%(k)\""}.join(", ")
      return "Either.match: The following cases are invalid: %(invalidCases)"
    })
    if (isRight) {
      return rightFn.call(_right)
    } else {
      return leftFn.call(_left)
    }
  }

  toString {
    if (isRight) {
      return "Right(%(_right))"
    } else {
      return "Left(%(_left))"
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
