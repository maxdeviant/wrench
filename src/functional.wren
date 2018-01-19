class Functional {
  static compose(f, g) {
    return Fn.new {|x| f.call(g.call(x))}
  }
}
