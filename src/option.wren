class Option {
  construct Some(value) {
    _type = "some"
    _value = value
  }

  construct None() {
    _type = "none"
  }

  isSome() {
    return _type == "some"
  }

  isNone() {
    return _type == "none"
  }

  bind(f) {
    if (isSome()) {
      return f.call(_value)
    } else {
      return Option.None()
    }
  }

  map(f) {
    return bind(Fn.new {|s| Option.Some(f.call(s))})
  }

  match(Some, None) {
    if (isSome()) {
      return Some.call(_value)
    } else {
      return None.call()
    }
  }

  toString {
    if (isSome()) {
      return "Some(" + _value + ")"
    } else {
      return "None()"
    }
  }
}
