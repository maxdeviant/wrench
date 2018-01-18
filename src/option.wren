import "invariant" for Invariant

class Option {
  construct Some(value) {
    _type = "some"
    _value = value
  }

  construct None() {
    _type = "none"
  }

  isSome { _type == "some" }

  isNone { _type == "none" }

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
      return matchers["Some"].call(_value)
    } else {
      return matchers["None"].call()
    }
  }

  toString {
    if (isSome) {
      return "Some(" + _value + ")"
    } else {
      return "None()"
    }
  }
}
