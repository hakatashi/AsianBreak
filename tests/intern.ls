define do
  capabilities:
    'browserstack.selenium_version': '2.45.0'

  environments:
    * browser-name: 'internet explorer'
      version: '11'
      platform: 'WIN8'
    * browser-name: 'internet explorer'
      version: '10'
      platform: 'WIN8'
    * browser-name: 'internet explorer'
      version: '9'
      platform: 'WINDOWS'
    * browser-name: 'firefox'
      version: '37'
      platform:
        * 'WINDOWS'
        * 'MAC'
    * browser-name: 'chrome'
      version: '39'
      platform:
        * 'WINDOWS'
        * 'MAC'
    * browser-name: 'safari'
      version: '8'
      platform: 'MAC'

  max-concurrency: 2

  tunnel: 'BrowserStackTunnel'

  loader-options:
    packages:
      * name: 'myPackage'
        location: '.'
      ...

  suites: <[tests/test]>

  functional-suites: []

  exclude-instrumentation: /^(?:tests|node_modules)\//

  reporters:
    * 'Pretty'
    * id: 'Lcov'
      filename: 'lcov.info'
