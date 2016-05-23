define do
  suites: <[tests/test]>

  functional-suites: []

  exclude-instrumentation: /^(?:tests|node_modules)\//

  reporters:
    * 'Pretty'
    * id: 'Lcov'
      filename: 'lcov-raw.info'
