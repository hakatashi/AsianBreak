require! {
  'prelude-ls': {id}
  xtend: extend
  eastasianwidth: {east-asian-width}
}

module.exports = (texts, options = {}) ->
  # Fill up default options
  default-options = {
    -collapse-head
    -collapse-tail
    -collapse-inline-white-space
    -collapse-all-break
    -remove-zwsp
  }

  options = extend {}, default-options, options

  # Normalize input
  switch typeof! texts
    | \String => segments = [texts]
    | \Array => segments = texts
    | otherwise => throw new Error 'Unsupported text type'

  # Previous and next segments are refered while iterating.
  # We store transformed new segments into new array.
  new-segments = []

  for segment-index, segment of segments
    prev-segment = segments[segment-index - 1] ? null
    next-segment = segments[segment-index + 1] ? null

    /*
      Split segment by series of white spaces

      From spec:
        document white space characters: spaces (U+0020), tabs (U+0009), and segment breaks
        segment break: CRLF sequence (U+000D U+000A), carriage return (U+000D), and line feed (U+000A)
      https://drafts.csswg.org/css-text-3/#white-space-processing
     */
    spans = segment.split /([ \t\r\n]+)/

    # Iterate over matched whitespaces
    for span-index, span in spans when span-index % 2 is 1
      prev-span = spans[span-index - 1]
      next-span = spans[span-index + 1]

      prev-character = prev-span[* - 1] ? prev-segment?[* - 1] ? null
      next-character = next-span.0 ? next-segment?.0 ? null

    new-segments.push spans.join ''

  if typeof! texts is \String
    return new-segments.0
  else
    return new-segments
