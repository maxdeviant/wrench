import "io" for Directory, File

var path = "src"
var ignore = ["run_tests.wren", "wren-test.wren"]

var getFilePath = Fn.new {|filename| "%(path)/%(filename)"}

var files = Directory.list(path).where {|filename| File.exists(getFilePath.call(filename))}.where {|filename| !ignore.contains(filename)}.toList

var wrenchBundle = files.map {|file|
  var moduleName = file.replace(".wren", "")
  var filepath = getFilePath.call(file)
  var content = File.read(filepath)
  return content.split("\n").where {|line| !line.startsWith("import")}.join("\n")
}.join("\n")

File.create("wrench.wren") {|file|
  file.writeBytes(wrenchBundle)
}
