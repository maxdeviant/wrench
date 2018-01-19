import "invariant" for Invariant

class Union {
  construct new(validCases, case) {
    _validCases = validCases
    _case = case
  }

  match(matchers) {
    _validCases.each {|case|
      Invariant.check(matchers.containsKey(case), "%(this.toString).match: Match not exhaustive; missing %(case).")
    }

    for (key in matchers.keys) {
      if (_validCases.contains(key) && _case.identifier == key) {
        return _case.match(matchers[key])
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

  match(f) { f.call() }
}
