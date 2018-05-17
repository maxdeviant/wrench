import "invariant" for Invariant
import "union" for Union, Case

class Result is Union {
  static Ok(ok) {
    return Result.new(Ok.new(ok))
  }

  static Err(err) {
    return Result.new(Err.new(err))
  }

  construct new(case) {
    super([Ok, Err], case)
    _case = case
  }

  isOk { _case is Ok }

  isErr { _case is Err }

  bind(f) {
    return match({
      Ok: Fn.new {|ok| f.call(ok)},
      Err: Fn.new {|err| Result.Err(err)}
    })
  }

  map(f) {
    return bind(Fn.new {|r| Result.Ok(f.call(r))})
  }

  toString { _case.toString }

  // @TODO See if we can move this up into Union.
  ==(other) {
    return match({
      Ok: Fn.new {|ok|
        return other.match({
          Ok: Fn.new {|otherOk| ok == otherOk},
          Err: Fn.new {false}
        })
      },
      Err: Fn.new {|err|
        return other.match({
          Ok: Fn.new {false},
          Err: Fn.new {|otherErr| err == otherErr}
        })
      }
    })
  }
}

class Ok is Case {
  construct new(ok) {
    Invariant.check(ok != null, "Ok.new: Value cannot be null.")
    super(Ok)
    _ok = ok
  }

  match(f) { f.call(_ok) }

  toString { "Ok(%(_ok))" }
}

class Err is Case {
  construct new(err) {
    Invariant.check(err != null, "Err.new: Value cannot be null.")
    super(Err)
    _err = err
  }

  match(f) { f.call(_err) }

  toString { "Err(%(_err))" }
}
