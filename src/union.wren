import "invariant" for Invariant

class Union {
  construct new(cases, value) {
    _cases = cases
    _value = value
  }

  match(matchers) {
    for (key in _cases.keys) {
      Invariant.check(matchers.containsKey(key), "%(this.toString).match: Match not exhaustive; missing %(key).")
    }

    for (key in matchers.keys) {
      if (_cases.containsKey(key) && _value.identifier == key) {
        return matchers[key].call(_value)
      }
    }

    Fiber.abort("No matching case found.")
  }

  toString { Union.name }
}

class Case {
  construct new(identifier) {
    _identifier = identifier
  }

  identifier { _identifier }
}
