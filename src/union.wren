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

    // @TODO: Add invariant to check if `_case.kind` is null.
    for (key in matchers.keys) {
      if (_validCases.contains(key) && _case.kind == key) {
        return _case.match(matchers[key])
      }
    }

    Fiber.abort("No matching case found.")
  }

  toString { Union.name }
}

class Case {
  construct new(kind) {
    _kind = kind
  }

  kind { _kind }

  match(f) { f.call() }

  ==(other) { kind == other.kind }

  toString { "%(kind.name)()" }
}
