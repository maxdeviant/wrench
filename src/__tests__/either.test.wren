import "wren-test" for Expect, Suite
import "either" for Either

var TestEither = Suite.new("Either") {|it|
  it.suite(".Right") {|it|
    it.should("produce a Right") {
      Expect.call(Either.Right("Hello")).toBe(Either)
      Expect.call(Either.Right("Hello")).toEqual(Either.Right("Hello"))
    }

    it.should("not allow null") {
      Expect.call(Fiber.new {Either.Right(null)}).toBeARuntimeError("Either.Right: Value cannot be null.")
    }
  }

  it.suite(".Left") {|it|
    it.should("produce a Left") {
      Expect.call(Either.Left("Goodbye")).toBe(Either)
      Expect.call(Either.Left("Goodbye")).toEqual(Either.Left("Goodbye"))
    }

    it.should("not allow null") {
      Expect.call(Fiber.new {Either.Left(null)}).toBeARuntimeError("Either.Left: Value cannot be null.")
    }
  }

  it.suite(".isRight") {|it|
    it.should("return true when Right") {
      Expect.call(Either.Right(10).isRight).toBeTrue
    }

    it.should("return false when Left") {
      Expect.call(Either.Left("oops").isRight).toBeFalse
    }
  }

  it.suite(".isLeft") {|it|
    it.should("return true when Left") {
      Expect.call(Either.Left("an error occurred").isLeft).toBeTrue
    }

    it.should("return false when Right") {
      Expect.call(Either.Right(99).isLeft).toBeFalse
    }
  }

  it.suite(".map") {|it|
    it.should("run the transform when Right") {
      Expect.call(Either.Right(2).map {|x| x * x}).toEqual(Either.Right(4))
    }

    it.should("not run the transform when Left") {
      Expect.call(Either.Left(2).map {|x| x * x}).toEqual(Either.Left(2))
    }
  }

  it.suite(".match") {|it|
    it.should("match the Right case when Right") {
      Expect.call(
        Either.Right(2).match({
          "Right": Fn.new {|r| r},
          "Left": Fn.new {0}
        })
      ).toEqual(2)
    }

    it.should("match the Left case when Left") {
      Expect.call(
        Either.Left(5).match({
          "Right": Fn.new {0},
          "Left": Fn.new {|l| l}
        })
      ).toEqual(5)
    }

    it.should("require a Right case") {
      Expect.call(
        Fiber.new {
          Either.Right(1).match({
            "Foo": Fn.new {|r| r},
            "Left": Fn.new {|l| l}
          })
        }
      ).toBeARuntimeError("Either.match: Must provide a \"Right\" case.")
    }

    it.should("require a Left case") {
      Expect.call(
        Fiber.new {
          Either.Right(1).match({
            "Right": Fn.new {|r| r},
            "Bar": Fn.new {|l| l}
          })
        }
      ).toBeARuntimeError("Either.match: Must provide a \"Left\" case.")
    }

    it.should("disallow invalid cases") {
      Expect.call(
        Fiber.new {
          Either.Right(1).match({
            "Right": Fn.new {|r| r},
            "Left": Fn.new {|l| l},
            "Foo": Fn.new {|x| x}
          })
        }
      ).toBeARuntimeError("Either.match: The following cases are invalid: \"Foo\"")

      Expect.call(
        Fiber.new {
          Either.Right(1).match({
            "Right": Fn.new {|r| r},
            "Left": Fn.new {|l| l},
            "Foo": Fn.new {|x| x},
            "Bar": Fn.new {|x| x},
            "Baz": Fn.new {|x| x}
          })
        }
      // @TODO We want to check the error message here, but we'll need to sort it first.
      ).toBeARuntimeError
    }
  }

  it.suite(".toString") {|it|
    it.should("return a string representation of a Right") {
      Expect.call(Either.Right("Hello, Sailor!").toString).toEqual("Right(Hello, Sailor!)")
      Expect.call(Either.Right(99).toString).toEqual("Right(99)")
    }

    it.should("return a string representation of a Left") {
      Expect.call(Either.Left("Farewell, Sailor!").toString).toEqual("Left(Farewell, Sailor!)")
      Expect.call(Either.Left(-1).toString).toEqual("Left(-1)")
    }
  }

  it.suite("==") {|it|
    it.should("check if two Eithers are equal") {
      Expect.call(Either.Right(21)).toEqual(Either.Right(21))
      Expect.call(Either.Left("Here be dragons")).toEqual(Either.Left("Here be dragons"))

      Expect.call(Either.Right(21)).not.toEqual(Either.Left(21))
      Expect.call(Either.Left("Do Re Mi")).not.toEqual(Either.Right("Do Re Mi"))

      Expect.call(Either.Right(36)).not.toEqual(Either.Right(29))
      Expect.call(Either.Left(64)).not.toEqual(Either.Left(32))
    }
  }
}
