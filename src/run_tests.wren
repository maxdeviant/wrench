import "wren-test" for ConsoleReporter

import "either.test" for TestEither
import "option.test" for TestOption

var reporter = ConsoleReporter.new()

var suites = [
  TestEither,
  TestOption
]

for (suite in suites) {
  suite.run(reporter)
}

reporter.epilogue()
