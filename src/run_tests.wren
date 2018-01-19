import "wren-test" for ConsoleReporter

import "either.test" for TestEither

var reporter = ConsoleReporter.new()

var suites = [
  TestEither
]

for (suite in suites) {
  suite.run(reporter)
}

reporter.epilogue()
