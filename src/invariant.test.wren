import "wren-test" for Expect, Suite
import "invariant" for Invariant

var TestInvariant = Suite.new("Invariant") {|it|
  it.suite(".check") {|it|
    it.should("abort with the given message when the condition is false") {
      var message = "3 is not less than 2"
      Expect.call(Fiber.new {Invariant.check(3 < 2, message)}).toBeARuntimeError(message)
    }

    it.should("do nothing when the condition is true") {
      Expect.call(Fiber.new {Invariant.check(1 == 1, "1 does not equal 1")}).not.toBeARuntimeError
    }
  }
}
