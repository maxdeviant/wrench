import "../option" for Option

var someOption = Option.Some("Some string.")
System.print(someOption.toString())
System.print(someOption.isSome())
System.print(someOption.isNone())
System.print(someOption.map {|s| s + " Hello"}.toString())

System.print(
  someOption.match(
    Fn.new {|some| some},
    Fn.new { "Bad" }
  )
)

var noneOption = Option.None()
System.print(noneOption.toString())
System.print(noneOption.isSome())
System.print(noneOption.isNone())

System.print(
  noneOption.match(
    Fn.new {|some| some},
    Fn.new { "Bad" }
  )
)
