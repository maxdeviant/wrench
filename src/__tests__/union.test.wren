import "wren-test" for Expect, Suite
import "union" for Union, Case

class Tree is Union {
  // @TODO It would be nice if we could use constructor names here
  // like construct Leaf() and construct Node(value, left, right),
  // but sadly this doesn't play nice with `super`.
  static Leaf() {
    return Tree.new(Leaf.new())
  }

  static Node(value, left, right) {
    return Tree.new(Node.new(value, left, right))
  }

  construct new(value) {
    super([Leaf, Node], value)
  }

  toString { Tree.name }
}

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

var TestUnion = Suite.new("Union") {|it|
  it.suite(".match") {|it|
    it.should("match on the cases") {
      Expect.call(
        Tree.Leaf().match({
          Leaf: Fn.new {"This is a leaf."},
          Node: Fn.new {"This is a node."}
        })
      ).toEqual("This is a leaf.")

      Expect.call(
        Tree.Node(5, Tree.Leaf(), Tree.Leaf()).match({
          Leaf: Fn.new {-1},
          Node: Fn.new {|node| node.value}
        })
      ).toEqual(5)
    }

    it.should("require exhaustive matches") {
      Expect.call(
        Fiber.new {
          Tree.Leaf().match({
            Leaf: Fn.new {"This is a leaf."}
          })
        }
      ).toBeARuntimeError("Tree.match: Match not exhaustive; missing Node.")
    }
  }
}
