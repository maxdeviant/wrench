import "wren-test" for Expect, Suite
import "union" for Union, Case

class Leaf is Case {
  construct new() {
    super(Leaf)
  }
}

class Node is Case {
  construct new(value, left, right) {
    super(Node)
    _value = value
    _left = left
    _right = right
  }

  value { _value }
}

class Tree is Union {
  construct new(value) {
    super({
      Leaf: Fn.new {Leaf.new()},
      Node: Fn.new {|value, left, right| Node.new(value, left, right)}
    }, value)
  }
}

var TestUnion = Suite.new("Union") {|it|
  it.suite(".match") {|it|
    it.should("match") {
      var leafTree = Tree.new(Leaf.new())
      Expect.call(
        leafTree.match({
          Leaf: Fn.new {"This is a leaf."},
          Node: Fn.new {"This is a node."}
        })
      ).toEqual("This is a leaf.")

      var nodeTree = Tree.new(Node.new(5, Leaf.new(), Leaf.new()))
      Expect.call(
        nodeTree.match({
          Leaf: Fn.new {"leaf"},  
          Node: Fn.new {|node| node.value}
        })
      ).toEqual(5)
    }
  }
}
