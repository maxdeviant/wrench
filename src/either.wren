import "invariant" for Invariant
import "union" for Union, Case

class Either is Union {
  static Right(right) {
    return Either.new(Right.new(right))
  }

  static Left(left) {
    return Either.new(Left.new(left))
  }

  construct new(case) {
    super([Right, Left], case)
    _case = case
  }

  isRight { _case is Right }

  isLeft { _case is Left }

  bind(f) {
    return match({
      Right: Fn.new {|right| f.call(right)},
      Left: Fn.new {|left| Either.Left(left)}
    })
  }

  map(f) {
    return bind(Fn.new {|r| Either.Right(f.call(r))})
  }

  toString { _case.toString }

  // @TODO See if we can move this up into Union.
  ==(other) {
    return match({
      Right: Fn.new {|right|
        return other.match({
          Right: Fn.new {|otherRight| right == otherRight},
          Left: Fn.new {false}
        })
      },
      Left: Fn.new {|left|
        return other.match({
          Right: Fn.new {false},
          Left: Fn.new {|otherLeft| left == otherLeft}
        })
      }
    })
  }
}

class Right is Case {
  construct new(right) {
    Invariant.check(right != null, "Right.new: Value cannot be null.")
    super(Right)
    _right = right
  }

  match(f) { f.call(_right) }

  toString { "Right(%(_right))" }
}

class Left is Case {
  construct new(left) {
    Invariant.check(left != null, "Left.new: Value cannot be null.")
    super(Left)
    _left = left
  }

  match(f) { f.call(_left) }

  toString { "Left(%(_left))" }
}
