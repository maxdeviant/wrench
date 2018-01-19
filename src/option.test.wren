import "wren-test" for Expect, Suite
import "option" for Option

var TestOption = Suite.new("Option") {|it|
  it.suite(".Some") {|it|
    it.should("produce a Some") {
      Expect.call(Option.Some("Hello")).toBe(Option)
      Expect.call(Option.Some("Hello")).toEqual(Option.Some("Hello"))
    }

    it.should("not allow null") {
      Expect.call(Fiber.new {Option.Some(null)}).toBeARuntimeError("Option.Some: Value cannot be null.")
    }
  }
}
