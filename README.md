# AsianBreak

> Line Break for East Asian People

[travis-image]: https://travis-ci.org/hakatashi/AsianBreak.svg?branch=master
[travis-url]: https://travis-ci.org/hakatashi/AsianBreak
[gemnasium-image]: https://gemnasium.com/hakatashi/AsianBreak.svg
[gemnasium-url]: https://gemnasium.com/hakatashi/AsianBreak
[npm-image]: https://img.shields.io/npm/v/asianbreak.svg
[nodeico-image]: https://nodei.co/npm/asianbreak.png?downloads=true
[npm-url]: http://npmjs.com/package/asianbreak
[license-image]: https://img.shields.io/npm/l/asianbreak.svg

[![npm status][nodeico-image]][npm-url]

[![Build Status][travis-image]][travis-url]
[![Dependency Status][gemnasium-image]][gemnasium-url]
[![npm version][npm-image]][npm-url]
[![LICENSE][license-image]][npm-url]

```js
const asianbreak = require('asianbreak');

asianbreak(`

    　そのとき汽車はだんだん川からはなれて崖の上を通るようになりました。
    向う岸もまた黒いいろの崖が川の岸を下流に下るにしたがってだんだん高くなって行くのでした。
    そしてちらっと大きなとうもろこしの木を見ました。
    その葉はぐるぐるに縮れ葉の下にはもう美しい緑いろの大きな苞が赤い毛を吐いて
    真珠のような実もちらっと見えたのでした。

`);
```

## API

This module exposes single `asianbreak(texts[, options])` function.

### texts

* Type: String[] | String

An array of string which supporse to constitute [Inline Formatting Context](http://www.w3.org/TR/CSS21/visuren.html#inline-formatting) of CSS2.1.

For this example:

```html
<p>
    日本語は、<ruby>
        <rb>分</rb><rb>かち</rb><rb>書</rb><rb>き</rb>
        <rp>(</rp><rt>わ</rt><rt>かち</rt><rt>が</rt><rt>き</rt><rp>)</rp>
    </ruby>を用いない。
</p>
```

only `<p>` creates inline formatting context and `<rp>` and `<rt>` is supporsed to be removed from inline context tree (in modern browsers), and `texts` should be:

```js
const texts = ['\n    日本語は、', '\n        ', '分', 'かち', '書', 'き', '\n        ', '\n    ', 'を用いない。\n'];
```

then you'll get:

```js
const result = asianbreak(texts);
console.log(result); // ['\n    日本語は、', '', '分', 'かち', '書', 'き', '', '', 'を用いない。\n'];
```

If you restored it to original HTML, it should be:

```html
<p>
    日本語は、<ruby><rb>分</rb><rb>かち</rb><rb>書</rb><rb>き</rb><rp>(</rp><rt>わ</rt><rt>かち</rt><rt>が</rt><rt>き</rt><rp>)</rp></ruby>を用いない。
</p>
```

How great deed is this!

If a string is supplied, it assume that context is constituted by single segment, and returns transformed segment as string.

### options

* Type: Object

**Not Implemented**
