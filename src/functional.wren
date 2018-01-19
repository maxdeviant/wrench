import "invariant" for Invariant

class Functional {
  static compose(f, g) {
    Invariant.check(f.arity == 1, "Functional.compose: f must have an arity of 1.")
    Invariant.check(g.arity == 1, "Functional.compose: g must have an arity of 1.")
    return Fn.new {|x| f.call(g.call(x))}
  }
}
