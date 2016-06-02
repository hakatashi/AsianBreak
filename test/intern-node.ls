define do
  suites: <[test/test]>

  functional-suites: []

  exclude-instrumentation: /^(?:test|node_modules)\//

  reporters:
    * 'Pretty'
    * id: 'Lcov'
      filename: 'lcov-raw.info'
