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
  fullwidth:
    title: 'Fullwidth characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-002.html'
    cases:
      * 'ＦＵＬＬ\nＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
      * 'ＦＵＬＬ   \nＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
      * 'ＦＵＬＬ\n        ＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
      * 'ＦＵＬＬ   \n     ＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
      * 'ＦＵＬＬ\n\n\nＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
      * 'ＦＵＬＬ  \n   \n   \n   ＷＩＤＴＨ'
        'ＦＵＬＬＷＩＤＴＨ'
  halfwidth:
    title: 'Halfwidth characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-003.html'
    cases:
      * 'ﾊﾝ\nｶｸ'
        'ﾊﾝｶｸ'
      * 'ﾊﾝ   \nｶｸ'
        'ﾊﾝｶｸ'
      * 'ﾊﾝ\n        ｶｸ'
        'ﾊﾝｶｸ'
      * 'ﾊﾝ   \n     ｶｸ'
        'ﾊﾝｶｸ'
      * 'ﾊﾝ\n\n\nｶｸ'
        'ﾊﾝｶｸ'
      * 'ﾊﾝ  \n   \n   \n   ｶｸ'
        'ﾊﾝｶｸ'
  won-halfwidth:
    title: 'Won and halfwidth characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-004.html'
    cases:
      * '₩\n２４'
        '₩２４'
      * '₩   \n２４'
        '₩２４'
      * '₩\n        ２４'
        '₩２４'
      * '₩   \n     ２４'
        '₩２４'
      * '₩\n\n\n２４'
        '₩２４'
      * '₩  \n   \n   \n   ２４'
        '₩２４'
      * '２４\n₩'
        '２４₩'
      * '２４   \n₩'
        '２４₩'
      * '２４\n        ₩'
        '２４₩'
      * '２４   \n     ₩'
        '２４₩'
      * '２４\n\n\n₩'
        '２４₩'
      * '２４  \n   \n   \n   ₩'
        '２４₩'
  wide-non-wide:
    title: 'Wide character and non-wide character around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-005.html'
    cases:
      * '漢字\nkanji'
        '漢字 kanji'
      * '漢字   \nkanji'
        '漢字 kanji'
      * '漢字\n        kanji'
        '漢字 kanji'
      * '漢字   \n     kanji'
        '漢字 kanji'
      * '漢字\n\n\nkanji'
        '漢字 kanji'
      * '漢字  \n   \n   \n   kanji'
        '漢字 kanji'
  fullwidth-non-fullwidth:
    title: 'Fullwidth character and non-fullwidth character around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-006.html'
    cases:
      * 'ＦＵＬＬ\nwidth'
        'ＦＵＬＬ width'
      * 'ＦＵＬＬ   \nwidth'
        'ＦＵＬＬ width'
      * 'ＦＵＬＬ\n        width'
        'ＦＵＬＬ width'
      * 'ＦＵＬＬ   \n     width'
        'ＦＵＬＬ width'
      * 'ＦＵＬＬ\n\n\nwidth'
        'ＦＵＬＬ width'
      * 'ＦＵＬＬ  \n   \n   \n   width'
        'ＦＵＬＬ width'
  halfwidth-non-halfwidth:
    title: 'Halfwidth character and non-halfwidth character around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-007.html'
    cases:
      * 'han\nｶｸ'
        'han ｶｸ'
      * 'han   \nｶｸ'
        'han ｶｸ'
      * 'han\n        ｶｸ'
        'han ｶｸ'
      * 'han   \n     ｶｸ'
        'han ｶｸ'
      * 'han\n\n\nｶｸ'
        'han ｶｸ'
      * 'han  \n   \n   \n   ｶｸ'
        'han ｶｸ'
  wide-and-fullwidth:
    title: 'Wide and fullwidth characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-008.html'
    cases:
      * '日本語\nＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
      * '日本語   \nＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
      * '日本語\n        ＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
      * '日本語   \n     ＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
      * '日本語\n\n\nＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
      * '日本語  \n   \n   \n   ＷＩＤＴＨ'
        '日本語ＷＩＤＴＨ'
  fullwidth-and-halfwidth:
    title: 'Fullwidth and halfwidth characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-009.html'
    cases:
      * 'ＦＵＬＬ\nｶｸ'
        'ＦＵＬＬｶｸ'
      * 'ＦＵＬＬ   \nｶｸ'
        'ＦＵＬＬｶｸ'
      * 'ＦＵＬＬ\n        ｶｸ'
        'ＦＵＬＬｶｸ'
      * 'ＦＵＬＬ   \n     ｶｸ'
        'ＦＵＬＬｶｸ'
      * 'ＦＵＬＬ\n\n\nｶｸ'
        'ＦＵＬＬｶｸ'
      * 'ＦＵＬＬ  \n   \n   \n   ｶｸ'
        'ＦＵＬＬｶｸ'
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
    It 'converts breakline(s) between wide characters into nothing' ->
      for [before, after] in test-suite.wide.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) between fullwidth characters into nothing' ->
      for [before, after] in test-suite.fullwidth.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) between halfwidth characters into nothing' ->
      for [before, after] in test-suite.halfwidth.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) between won and halfwidth characters into nothing' ->
      for [before, after] in test-suite.won-halfwidth.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) between wide and fullwidth characters into nothing' ->
      for [before, after] in test-suite.wide-and-fullwidth.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) between fullwidth and halfwidth characters into nothing' ->
      for [before, after] in test-suite.fullwidth-and-halfwidth.cases
        expect asianbreak before .to.equal after

    It 'keeps non-CJK segment break transformation rules untouched' ->
      for [test, _] in test-suite.basic.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between CJK and non-CJK charanters untouched' ->
      for [test, _] in test-suite.wide-non-wide.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between halfwidth and non-halfwidth charanters untouched' ->
      for [test, _] in test-suite.halfwidth-non-halfwidth.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between fullwidth and non-fullwidth charanters untouched' ->
      for [test, _] in test-suite.fullwidth-non-fullwidth.cases
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
