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

  it.suite(".None") {|it|
    it.should("produce a None") {
      Expect.call(Option.None()).toBe(Option)
      Expect.call(Option.None()).toEqual(Option.None())
    }
  }

  it.suite(".isSome") {|it|
    it.should("return true when Some") {
      Expect.call(Option.Some("Apple").isSome).toBeTrue
    }

    it.should("return false when None") {
      Expect.call(Option.None().isSome).toBeFalse
    }
  }

  it.suite(".isNone") {|it|
    it.should("return true when None") {
      Expect.call(Option.None().isNone).toBeTrue
    }

    it.should("return false when Some") {
      Expect.call(Option.Some("Pear").isNone).toBeFalse
    }
  }

  it.suite(".map") {|it|
    it.should("run the transform when Some") {
      Expect.call(Option.Some(10).map {|x| x * 10}).toEqual(Option.Some(100))
    }

    it.should("not run the transform when None") {
      Expect.call(Option.None().map {|x| x * 10}).toEqual(Option.None())
    }
  }

  it.suite(".toString") {|it|
    it.should("return a string representation of a Some") {
      Expect.call(Option.Some("Hello, Sailor!").toString).toEqual("Some(Hello, Sailor!)")
    }

    it.should("return a string representation of a None") {
      Expect.call(Option.None().toString).toEqual("None()")
    }
  }
}
