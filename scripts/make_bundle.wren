import "io" for Directory, File

var path = "src"
var ignore = ["run_tests.wren", "wren-test.wren"]

var getFilePath = Fn.new {|filename| "%(path)/%(filename)"}

// @TODO We need to be able to compute the dependency graph for
// the various modules so that we can bundle them in the correct
// order. Otherwise, inheritance falls over because we cannot
// inherit from a class that has not yet been defined in the bundle.
// var files = Directory.list(path).where {|filename| File.exists(getFilePath.call(filename))}.where {|filename| !ignore.contains(filename)}.toList

var files = [
  "invariant.wren",
  "functional.wren",
  "union.wren",
  "option.wren",
  "result.wren"
]

var wrenchBundle = files.map {|file|
  var moduleName = file.replace(".wren", "")
  var filepath = getFilePath.call(file)
  var content = File.read(filepath)
  return content.split("\n").where {|line| !line.startsWith("import")}.join("\n")
}.join("\n")

File.create("wrench.wren") {|file|
  file.writeBytes(wrenchBundle)
}
