import "invariant" for Invariant

class Union {
  construct new(cases, value) {
    _cases = cases
    _value = value
  }

  match(matchers) {
    _cases.each {|case|
      Invariant.check(matchers.containsKey(case), "%(this.toString).match: Match not exhaustive; missing %(case).")
    }

    for (key in matchers.keys) {
      if (_cases.contains(key) && _value.identifier == key) {
        return _value.match(matchers[key])
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

  match(fn) { fn.call() }
}
