class Invariant {
  static check(condition, message) {
    if (!condition) {
      Fiber.abort(message)
    }
  }
}
