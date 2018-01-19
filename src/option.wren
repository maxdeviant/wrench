import "invariant" for Invariant

class Option {
  construct Some(value) {
    Invariant.check(value != null, "Option.Some: Value cannot be null.")
    _kind = "some"
    _value = value
  }

  construct None() {
    _kind = "none"
  }

  isSome { _kind == "some" }

  isNone { _kind == "none" }

  bind(f) {
    if (isSome) {
      return f.call(_value)
    } else {
      return Option.None()
    }
  }

  map(f) {
    return bind(Fn.new {|s| Option.Some(f.call(s))})
  }

  match(matchers) {
    var someFn = matchers["Some"]
    Invariant.check(someFn is Fn, "Option.match: Must provide a \"Some\" case.")
    var noneFn = matchers["None"]
    Invariant.check(noneFn is Fn, "Option.match: Must provide a \"None\" case.")
    if (isSome) {
      return someFn.call(_value)
    } else {
      return noneFn.call()
    }
  }

  toString {
    if (isSome) {
      return "Some(%(_value))"
    } else {
      return "None()"
    }
  }

  ==(other) {
    return match({
      "Some": Fn.new {|some|
        return other.match({
          "Some": Fn.new {|otherSome| some == otherSome},
          "None": Fn.new {false}
        })
      },
      "None": Fn.new {
        return other.match({
          "Some": Fn.new {false},
          "None": Fn.new {true}
        })
      }
    })
  }
}
