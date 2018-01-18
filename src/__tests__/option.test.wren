import "../option" for Option

var someOption = Option.Some("Some string.")
System.print(someOption.toString())
System.print(someOption.isSome())
System.print(someOption.isNone())
System.print(someOption.map {|s| s + " Hello"}.toString())

var noneOption = Option.None()
System.print(noneOption.toString())
System.print(noneOption.isSome())
System.print(noneOption.isNone())
