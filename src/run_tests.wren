import "wren-test" for ConsoleReporter

import "either.test" for TestEither
import "invariant.test" for TestInvariant
import "option.test" for TestOption

var reporter = ConsoleReporter.new()

var suites = [
  TestEither,
  TestInvariant,
  TestOption
]

for (suite in suites) {
  suite.run(reporter)
}

reporter.epilogue()
