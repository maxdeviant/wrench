import "wren-test" for Expect, Suite
import "result" for Result, Ok, Err

var TestResult = Suite.new("Result") {|it|
  it.suite(".Ok") {|it|
    it.should("produce a Ok") {
      Expect.call(Result.Ok("Hello")).toBe(Result)
      Expect.call(Result.Ok("Hello")).toEqual(Result.Ok("Hello"))
    }

    it.should("not allow null") {
      Expect.call(Fiber.new {Result.Ok(null)}).toBeARuntimeError("Ok.new: Value cannot be null.")
    }
  }

  it.suite(".Err") {|it|
    it.should("produce a Err") {
      Expect.call(Result.Err("Goodbye")).toBe(Result)
      Expect.call(Result.Err("Goodbye")).toEqual(Result.Err("Goodbye"))
    }

    it.should("not allow null") {
      Expect.call(Fiber.new {Result.Err(null)}).toBeARuntimeError("Err.new: Value cannot be null.")
    }
  }

  it.suite(".isOk") {|it|
    it.should("return true when Ok") {
      Expect.call(Result.Ok(10).isOk).toBeTrue
    }

    it.should("return false when Err") {
      Expect.call(Result.Err("oops").isOk).toBeFalse
    }
  }

  it.suite(".isErr") {|it|
    it.should("return true when Err") {
      Expect.call(Result.Err("an error occurred").isErr).toBeTrue
    }

    it.should("return false when Ok") {
      Expect.call(Result.Ok(99).isErr).toBeFalse
    }
  }

  it.suite(".map") {|it|
    it.should("run the transform when Ok") {
      Expect.call(Result.Ok(2).map {|x| x * x}).toEqual(Result.Ok(4))
    }

    it.should("not run the transform when Err") {
      Expect.call(Result.Err(2).map {|x| x * x}).toEqual(Result.Err(2))
    }
  }

  it.suite(".match") {|it|
    it.should("match the Ok case when Ok") {
      Expect.call(
        Result.Ok(2).match({
          Ok: Fn.new {|r| r},
          Err: Fn.new {0}
        })
      ).toEqual(2)
    }

    it.should("match the Err case when Err") {
      Expect.call(
        Result.Err(5).match({
          Ok: Fn.new {0},
          Err: Fn.new {|l| l}
        })
      ).toEqual(5)
    }
  }

  it.suite(".toString") {|it|
    it.should("return a string representation of a Ok") {
      Expect.call(Result.Ok("Hello, Sailor!").toString).toEqual("Ok(Hello, Sailor!)")
      Expect.call(Result.Ok(99).toString).toEqual("Ok(99)")
    }

    it.should("return a string representation of a Err") {
      Expect.call(Result.Err("Farewell, Sailor!").toString).toEqual("Err(Farewell, Sailor!)")
      Expect.call(Result.Err(-1).toString).toEqual("Err(-1)")
    }
  }

  it.suite("==") {|it|
    it.should("check if two Results are equal") {
      Expect.call(Result.Ok(21)).toEqual(Result.Ok(21))
      Expect.call(Result.Err("Here be dragons")).toEqual(Result.Err("Here be dragons"))

      Expect.call(Result.Ok(21)).not.toEqual(Result.Err(21))
      Expect.call(Result.Err("Do Re Mi")).not.toEqual(Result.Ok("Do Re Mi"))

      Expect.call(Result.Ok(36)).not.toEqual(Result.Ok(29))
      Expect.call(Result.Err(64)).not.toEqual(Result.Err(32))
    }
  }
}
