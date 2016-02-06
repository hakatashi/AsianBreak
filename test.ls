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
  hangul:
    title: 'Hangul characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-010.html'
    cases:
      * '한글\n쓰기'
        '한글 쓰기'
      * '한글   \n쓰기'
        '한글 쓰기'
      * '한글\n        쓰기'
        '한글 쓰기'
      * '한글   \n     쓰기'
        '한글 쓰기'
      * '한글\n\n\n쓰기'
        '한글 쓰기'
      * '한글  \n   \n   \n   쓰기'
        '한글 쓰기'
  hangul-jamo:
    title: 'Hangul jamo characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-011.html'
    cases:
      * '하ᄂ\n그ᄅ'
        '하ᄂ 그ᄅ'
      * '하ᄂ   \n그ᄅ'
        '하ᄂ 그ᄅ'
      * '하ᄂ\n        그ᄅ'
        '하ᄂ 그ᄅ'
      * '하ᄂ   \n     그ᄅ'
        '하ᄂ 그ᄅ'
      * '하ᄂ\n\n\n그ᄅ'
        '하ᄂ 그ᄅ'
      * '하ᄂ  \n   \n   \n   그ᄅ'
        '하ᄂ 그ᄅ'
  halfwidth-jamo:
    title: 'Hangul halfwidth jamo characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-012.html'
    cases:
      * 'ﾾￂﾤ\nﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
      * 'ﾾￂﾤ   \nﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
      * 'ﾾￂﾤ\n        ﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
      * 'ﾾￂﾤ   \n     ﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
      * 'ﾾￂﾤ\n\n\nﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
      * 'ﾾￂﾤ  \n   \n   \n   ﾡￚﾩ'
        'ﾾￂﾤ ﾡￚﾩ'
  thai:
    title: 'Thai characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-014.html'
    cases:
      * 'ภาษา\nไทย'
        'ภาษา ไทย'
      * 'ภาษา   \nไทย'
        'ภาษา ไทย'
      * 'ภาษา\n        ไทย'
        'ภาษา ไทย'
      * 'ภาษา   \n     ไทย'
        'ภาษา ไทย'
      * 'ภาษา\n\n\nไทย'
        'ภาษา ไทย'
      * 'ภาษา  \n   \n   \n   ไทย'
        'ภาษา ไทย'
  thai-and-latin:
    title: 'Thai and Latin characters around line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-015.html'
    cases:
      * 'ภาษา\nlatin'
        'ภาษา latin'
      * 'ภาษา   \nlatin'
        'ภาษา latin'
      * 'ภาษา\n        latin'
        'ภาษา latin'
      * 'ภาษา   \n     latin'
        'ภาษา latin'
      * 'ภาษา\n\n\nlatin'
        'ภาษา latin'
      * 'ภาษา  \n   \n   \n   latin'
        'ภาษา latin'
      * 'latin\nภาษา'
        'latin ภาษา'
      * 'latin   \nภาษา'
        'latin ภาษา'
      * 'latin\n        ภาษา'
        'latin ภาษา'
      * 'latin   \n     ภาษา'
        'latin ภาษา'
      * 'latin\n\n\nภาษา'
        'latin ภาษา'
      * 'latin  \n   \n   \n   ภาษา'
        'latin ภาษา'
  thai-zwsp:
    title: 'Thai with ZWSP before line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-016.html'
    cases:
      * 'ภาษา\u200B\nไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\u200B   \nไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\u200B\n        ไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\u200B   \n     ไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\u200B\n\n\nไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\u200B  \n   \n   \n   ไทย'
        'ภาษา\u200Bไทย'
  zwsp-thai:
    title: 'Thai with ZWSP after line break'
    source: 'https://github.com/w3c/csswg-test/blob/master/css-text-3/white-space/seg-break-transformation-016.html'
    cases:
      * 'ภาษา\n\u200Bไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา   \n\u200Bไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\n        \u200Bไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา   \n     \u200Bไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา\n\n\n\u200Bไทย'
        'ภาษา\u200Bไทย'
      * 'ภาษา  \n   \n   \n   \u200Bไทย'
        'ภาษา\u200Bไทย'
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
  surrogate-pair:
    title: 'Surrogate pairs'
    cases:
      * '𠮷\n野\n家'
        '𠮷野家'
      * '🉐\n🉐\n🉐'
        '🉐🉐🉐'
  head:
    title: 'Wide characters with heading whitespaces'
    cases:
      * '    '
        '    '
        ''
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
      * '    '
        '    '
        ''
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
  head-and-tail:
    title: 'Wide characters with heading and tailing whitespaces'
    cases:
      * '    '
        '    '
        ''
      * '    日本語    '
        '    日本語    '
        '日本語'
      * '    日本語\t\t\n\t\t'
        '    日本語\t\t\n\t\t'
        '日本語'
      * '\t\t\n\t\t日本語\n\t\t\n\t'
        '\t\t\n\t\t日本語\n\t\t\n\t'
        '日本語'
      * '\n\n\n日本語\n\n\n中国话\n\n\n'
        '\n\n\n日本語中国话\n\n\n'
        '日本語中国话'
      * '  \n   \n   \n   日本語  \n   \n   \n   中国话  \n   \n   '
        '  \n   \n   \n   日本語中国话  \n   \n   '
        '日本語中国话'
  inline:
    title: 'Inline whitespaces'
    cases:
      * '日本語   中国话'
        '日本語   中国话'
        '日本語 中国话'
      * '日本語   中国话\n日本語'
        '日本語   中国话日本語'
        '日本語 中国话日本語'
      * '   日本語   中国话   '
        '   日本語   中国话   '
        '   日本語 中国话   '
  head-and-tail-multitext:
    title: 'Wide characters with heading and tailing whitespaces for multiple texts'
    cases:
      * ['    ' '日本語' '    ']
        ['    ' '日本語' '    ']
        ['' '日本語' '']
      * ['' '    日本語    ' '']
        ['' '    日本語    ' '']
        ['' '日本語' '']
      * ['    ' '    日本語    ' '    ']
        ['    ' '    日本語    ' '    ']
        ['' '日本語' '']
      * ['   ' '    日本語\t\t\n' '\t\t\n']
        ['   ' '    日本語\t\t\n' '\t\t\n']
        ['' '日本語' '']
      * ['\n\n\n\n' '\n\n\n\n日本語\n\n\n\n' '\n\n\n\n']
        ['\n\n\n\n' '\n\n\n\n日本語\n\n\n\n' '\n\n\n\n']
        ['' '日本語' '']
      * ['\n\n\n' '日本語\n\n\n中国话' '\n\n\n']
        ['\n\n\n' '日本語中国话' '\n\n\n']
        ['' '日本語中国话' '']
      * ['\n\n\n' '\n\n\n日本語\n\n\n中国话\n\n\n' '\n\n\n']
        ['\n\n\n' '\n\n\n日本語中国话\n\n\n' '\n\n\n']
        ['' '日本語中国话' '']
  breakline-over-texts:
    title: 'Segment break(s) leans over multiple texts'
    cases:
      * ['日本語\n' '中国话']
        ['日本語' '中国话']
      * ['日本語' '\n中国话']
        ['日本語' '中国话']
      * ['日本語\t\t\n\t\t\n' '中国话']
        ['日本語' '中国话']
      * ['日本語' '\t\t\n\t\t\n中国话']
        ['日本語' '中国话']
      * ['日本語\n\n' '' '中国话']
        ['日本語' '' '中国话']
      * ['日本語' '\n\n' '中国话']
        ['日本語' '' '中国话']
      * ['日本語' '' '\n\n中国话']
        ['日本語' '' '中国话']
      * ['日本語\n\n' '' '' '中国话']
        ['日本語' '' '' '中国话']
      * ['日本語\n' '\n中国话']
        ['日本語\n' '\n中国话'] # This spec is questionable for me

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

    It 'converts breakline(s) after zero-width space character into nothing' ->
      for [before, after] in test-suite.thai-zwsp.cases
        expect asianbreak before .to.equal after

    It 'converts breakline(s) before zero-width space character into nothing' ->
      for [before, after] in test-suite.zwsp-thai.cases
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

    It 'keeps segment break between hangul charanters untouched' ->
      for [test, _] in test-suite.hangul.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between hangul jamo charanters untouched' ->
      for [test, _] in test-suite.hangul-jamo.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between halfwidth hangul jamo charanters untouched' ->
      for [test, _] in test-suite.halfwidth-jamo.cases
        expect asianbreak test .to.equal test

    It 'keeps segment break between thai charanters untouched' ->
      for [test, _] in test-suite.thai.cases
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

    It 'keeps heading and tailing whitespaces and segment breaks untouched' ->
      for [before, after, _] in test-suite.head-and-tail.cases
        expect asianbreak before .to.equal after

    It 'preserves inline whitespaces as untouched' ->
      for [before, after, _] in test-suite.inline.cases
        expect asianbreak before .to.equal after

    It 'is aware of surrogate pair characters' ->
      for [before, after] in test-suite.surrogate-pair.cases
        expect asianbreak before .to.equal after

  describe 'Multiple text' ->
    It 'returns empty list when empty list is provided' ->
      expect asianbreak [] .to.deep.equal []

    It 'keeps everything when no whitespace is proveded' ->
      expect asianbreak ['hi' 'over' 'there'] .to.deep.equal ['hi' 'over' 'there']
      expect asianbreak ['こんにちは' '世界'] .to.deep.equal ['こんにちは' '世界']

    It 'keeps heading and tailing whitespaces and segment breaks untouched' ->
      for [before, after, _] in test-suite.head-and-tail-multitext.cases
        expect asianbreak before .to.deep.equal after

    It 'correctly handles breaklines between texts' ->
      for [before, after] in test-suite.breakline-over-texts.cases
        expect asianbreak before .to.deep.equal after
