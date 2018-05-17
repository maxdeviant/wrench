import "wren-test" for ConsoleReporter

import "__tests__/result.test" for TestResult
import "__tests__/functional.test" for TestFunctional
import "__tests__/invariant.test" for TestInvariant
import "__tests__/option.test" for TestOption
import "__tests__/union.test" for TestUnion, TestCase

var reporter = ConsoleReporter.new()

var suites = [
  TestResult,
  TestFunctional,
  TestInvariant,
  TestOption,
  TestUnion,
  TestCase
]

for (suite in suites) {
  suite.run(reporter)
}

reporter.epilogue()
