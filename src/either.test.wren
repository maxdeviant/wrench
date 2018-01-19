import "wren-test" for Expect, Suite, ConsoleReporter
import "either" for Either

var EitherTests = Suite.new("Either") {|it|
  it.suite(".Right") {|it|
    it.should("produce a Right") {
      var either = Either.Right("Hello")
      Expect.call(either).toBe(Either)
      Expect.call(either.toString).toEqual("Right(Hello)")
    }
  }

  it.suite(".Left") {|it|
    it.should("produce a Left") {
      var either = Either.Left("Goodbye")
      Expect.call(either).toBe(Either)
      Expect.call(either.toString).toEqual("Left(Goodbye)")
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
    it.should("run the transform when Right").skip {
      
    }
  }
}

{
  var reporter = ConsoleReporter.new()
  EitherTests.run(reporter)
  reporter.epilogue()
}
