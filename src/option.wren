import "invariant" for Invariant
import "union" for Union, Case

class Option is Union {
  static Some(value) {
    return Option.new(Some.new(value))
  }

  static None() {
    return Option.new(None.new())
  }

  construct new(case) {
    super([Some, None], case)
    _case = case
  }

  isSome { _case is Some }

  isNone { _case is None }

  bind(f) {
    return match({
      Some: Fn.new {|value| f.call(value)},
      None: Fn.new {Option.None()}
    })
  }

  map(f) {
    return bind(Fn.new {|s| Option.Some(f.call(s))})
  }

  toString { _case.toString }

  // @TODO See if we can move this up into Union.
  ==(other) {
    return match({
      Some: Fn.new {|some|
        return other.match({
          Some: Fn.new {|otherSome| some == otherSome},
          None: Fn.new {false}
        })
      },
      None: Fn.new {
        return other.match({
          Some: Fn.new {false},
          None: Fn.new {true}
        })
      }
    })
  }
}

class Some is Case {
  construct new(value) {
    Invariant.check(value != null, "Some.new: Value cannot be null.")
    super(Some)
    _value = value
  }

  match(f) { f.call(_value) }

  toString { "Some(%(_value))" }
}

class None is Case {
  construct new() {
    super(None)
  }

  toString { "None()" }
}
