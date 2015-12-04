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
  white-space:
    title: 'White space collapse'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/white-space-collapse-000.html'
    cases:
      * '    hello   \t       there    '
        'hello   \t       there'
        'hello there'
      * '    缔造真正全球通行       \t   的万维网    '
        '缔造真正全球通行       \t   的万维网'
        '缔造真正全球通行 的万维网'
      * '    ＦＵＬＬ   \t        ＷＩＤＴＨ    '
        'ＦＵＬＬ   \t        ＷＩＤＴＨ'
        'ＦＵＬＬ ＷＩＤＴＨ'
      * '    ﾊﾝ   \t         ｶｸ    '
        'ﾊﾝ   \t         ｶｸ'
        'ﾊﾝ ｶｸ'
  head:
    title: 'Wide characters with heading whitespaces'
    cases:
      * '    日本語'
        '    日本語'
        '日本語'
      * '\t\t\n\t\t日本語'
        '\t\t\n\t\t日本語'
        '日本語'
      * '  \n   \n    日本語'
        '  \n   \n    日本語'
        '日本語'
      * '\n\n\n日本語\n\n\n中国话'
        '\n\n\n日本語中国话'
        '日本語中国话'
      * '  \n   \n   日本語  \n   \n   \n   中国话'
        '  \n   \n   日本語中国话'
        '日本語中国话'
  tail:
    title: 'Wide characters with tailing whitespaces'
    cases:
      * '日本語    '
        '日本語    '
        '日本語'
      * '日本語\t\t\n\t\t'
        '日本語\t\t\n\t\t'
        '日本語'
      * '日本語  \n   \n    '
        '日本語  \n   \n    '
        '日本語'
      * '日本語\n\n\n中国话\n\n\n'
        '日本語中国话\n\n\n'
        '日本語中国话'
      * '日本語  \n   \n   \n   中国话  \n   \n   '
        '日本語中国话  \n   \n   '
        '日本語中国话'

# `it` is reserved in livescript
It = global.it

describe 'Basic Usage' ->
  describe 'Single text' ->
    It 'converts breakline(s) between wide characters nothing' ->
      for [before, after] in test-suite.wide.cases
        expect asianbreak before .to.equal after

    It 'keeps non-CJK segment break transformation rules untouched' ->
      for [test, _] in test-suite.basic.cases
        expect asianbreak test .to.equal test

    It 'keeps whitespaces among line untouched' ->
      for [_, test, _] in test-suite.white-space.cases
        expect asianbreak test .to.equal test

    It 'keeps heading whitespaces and segment breaks untouched' ->
      for [before, after, _] in test-suite.head.cases
        expect asianbreak before .to.equal after

    It 'keeps tailing whitespaces and segment breaks untouched' ->
      for [before, after, _] in test-suite.tail.cases
        expect asianbreak before .to.equal after
