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
  
  map(f) {
    if (isSome()) {
      return Option.Some(f.call(_value))
    } else {
      return Option.None()
    }
  }

  bind(f) {
    if (isSome()) {
      return f.call(_value)
    } else {
      return Option.None()
    }
  }

  match(Some, None) {
    if (isSome()) {
      return Some.call(_value)
    } else {
      return None.call()
    }
  }

  toString() {
    if (isSome()) {
      return "Some(" + _value + ")"
    } else {
      return "None()"
    }
  }
}

