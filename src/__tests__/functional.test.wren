import "wren-test" for Expect, Suite
import "functional" for Functional

var TestFunctional = Suite.new("Functional") {|it|
  it.suite(".compose") {|it|
    it.should("compose f and g") {
      var f = Fn.new {|x| x + 2}
      var g = Fn.new {|x| x * 2}
      Expect.call(Functional.compose(f, g).call(3)).toEqual(8)
    }
  }
}
