class Invariant {
  static check(condition, messageOrFunc) {
    if (!condition) {
      var message = messageOrFunc is Fn ? messageOrFunc.call() : messageOrFunc
      Fiber.abort(message)
    }
  }
}
