require! {
  './': asianbreak
  chai: {expect}
}

/*!
 * W3C Test Suites Destribution Notice
 *
 * Distributed under both the W3C Test Suite License and the W3C 3-clause BSD License.
 * To contribute to a W3C Test Suite, see the policies and contribution forms.
 * http://www.w3.org/Consortium/Legal/2008/04-testsuite-license
 * http://www.w3.org/Consortium/Legal/2008/03-bsd-license
 * http://www.w3.org/2004/10/27-testcases
 */
test-suite =
  basic:
    title: 'Whitespace and line break transformation'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-000.html'
    cases:
      * 'hello\nthere'
        'hello there'
      * 'hello   \nthere'
        'hello there'
      * 'hello\n        there'
        'hello there'
      * 'hello   \n     there'
        'hello there'
      * 'hello\n\n\nthere'
        'hello there'
      * 'hello  \n   \n   \n   there'
        'hello there'
  wide:
    title: 'Wide characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-001.html'
    cases:
      * '日本語\n中国话'
        '日本語中国话'
      * '日本語   \n中国话'
        '日本語中国话'
      * '日本語\n        中国话'
        '日本語中国话'
      * '日本語   \n     中国话'
        '日本語中国话'
      * '日本語\n\n\n中国话'
        '日本語中国话'
      * '日本語  \n   \n   \n   中国话'
        '日本語中国话'

# `it` is reserved in livescript
It = global.it

describe 'Basic Usage' ->
  describe 'Single text' ->
    It 'converts breakline(s) between wide characters nothing' ->
      for [before, after] in test-suite.wide.cases
        expect asianbreak before .to.equal after
