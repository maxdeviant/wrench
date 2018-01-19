import "wren-test" for Expect, Suite
import "functional" for Functional

var TestFunctional = Suite.new("Functional") {|it|
  it.suite(".compose") {|it|
    it.should("compose f and g") {
      var f = Fn.new {|x| x + 2}
      var g = Fn.new {|x| x * 2}
      Expect.call(Functional.compose(f, g).call(3)).toEqual(8)
    }

    it.should("require f to have an arity of 1") {
      var f = Fn.new {|x, y| x + y}
      var g = Fn.new {|x| x * 2}
      Expect.call(Fiber.new {Functional.compose(f, g).call(3)}).toBeARuntimeError("Functional.compose: f must have an arity of 1.")
    }

    it.should("require g to have an arity of 1") {
      var f = Fn.new {|x| x + 2}
      var g = Fn.new {|x, y| x * y}
      Expect.call(Fiber.new {Functional.compose(f, g).call(3)}).toBeARuntimeError("Functional.compose: g must have an arity of 1.")
    }
  }
}
