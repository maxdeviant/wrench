import "either" for Either

var rightEither = Either.Right("Hello")
System.print(rightEither.toString)
System.print(rightEither.isRight)
System.print(rightEither.isLeft)
System.print(rightEither.map {|r| r + ", Sailor!"})
System.print(
  "Matched with " +
  rightEither.match({
    "Left": Fn.new {"Left"},
    "Right": Fn.new {|right| right}
  })
)

var leftEither = Either.Left("Goodbye")
System.print(leftEither.toString)
System.print(leftEither.isRight)
System.print(leftEither.isLeft)
System.print(leftEither.map {|r| r + ", Sailor!"})
System.print(
  "Matched with " +
  leftEither.match({
    "Left": Fn.new {|left| left},
    "Right": Fn.new {"Right"}
  })
)