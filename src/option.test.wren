import "option" for Option

var someOption = Option.Some("Some string.")
System.print(someOption)
System.print(someOption.isSome)
System.print(someOption.isNone)
System.print(someOption.map {|s| s + " Hello"})
System.print(
  "Matched with " +
  someOption.match({
    "Some": Fn.new {|some| some},
    "None": Fn.new {"Bad"}
  })
)

var noneOption = Option.None()
System.print(noneOption)
System.print(noneOption.isSome)
System.print(noneOption.isNone)
System.print(
  "Matched with " +
  someOption.match({
    "Some": Fn.new {|some| some},
    "None": Fn.new {"Bad"}
  })
)
