import "wren-test" for ConsoleReporter

import "__tests__/either.test" for TestEither
import "__tests__/invariant.test" for TestInvariant
import "__tests__/option.test" for TestOption

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
