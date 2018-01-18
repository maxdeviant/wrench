import "../either" for Either

var rightEither = Either.Right("Hello")
System.print(rightEither.toString)
System.print(rightEither.isRight)
System.print(rightEither.isLeft)
System.print(rightEither.map {|r| r + ", Sailor!"})
System.print(
  "Matched with " +
  rightEither.match(
    Fn.new {"Left"},
    Fn.new {|right| right}
  )
)

var leftEither = Either.Left("Goodbye")
System.print(leftEither.toString)
System.print(leftEither.isRight)
System.print(leftEither.isLeft)
System.print(leftEither.map {|r| r + ", Sailor!"})
System.print(
  "Matched with " +
  leftEither.match(
    Fn.new {|left| left},
    Fn.new {"Right"}
  )
)