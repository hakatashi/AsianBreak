require! {
  'prelude-ls': {id}
  xtend: extend
  eastasianwidth: {east-asian-width}
  'core-js/library/fn/string/code-point-at'
  'core-js/library/fn/string/from-code-point'
}

# The surrogate-pair awared first/last character extraction
first-char = (string) ->
  code-point = string |> code-point-at _, 0

  return if code-point |> isNaN
  then undefined
  else code-point |> from-code-point

last-char = (string) ->
  code-point = code-point-at string, string.length - 2

  return if code-point |> isNaN
  then undefined
  else if code-point >= 0x10000
  then string.slice -2
  else string.slice -1

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

  for segment, segment-index in segments
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
    for span, span-index in spans when span-index % 2 is 1
      prev-span = spans[span-index - 1]
      next-span = spans[span-index + 1]

      prev-char = (prev-span |> last-char) ? if prev-segment?
        then (prev-segment |> last-char) ? null
        else null
      next-char = (next-span |> first-char) ? if next-segment?
        then (next-segment |> first-char) ? null
        else null

      prev-width = east-asian-width prev-char if prev-char?
      next-width = east-asian-width next-char if next-char?

    new-segments.push spans.join ''

  if typeof! texts is \String
    return new-segments.0
  else
    return new-segments
