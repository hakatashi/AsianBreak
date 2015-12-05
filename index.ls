require! {
  xtend: extend
  eastasianwidth: {east-asian-width}
  'core-js/library/fn/string/code-point-at'
  'core-js/library/fn/string/from-code-point'
  assert
}

# The surrogate-pair awared first/last character extraction
first-char = (string) ->
  code-point = string |> code-point-at _, 0

  return if code-point |> isNaN
  then undefined
  else code-point |> from-code-point

last-char = (string) ->
  return undefined if string.length is 0
  return string[0] if string.length is 1

  code-point = code-point-at string, string.length - 2

  return if code-point |> isNaN
  then undefined
  else if code-point >= 0x10000
  then string.slice -2
  else string.slice -1

# I'm new to hangul characters and not sure where they locale in unicode...
# I implemented the method according to this blog post:
# http://www.programminginkorean.com/programming/hangul-in-unicode/
# ...and added missing halfwidth hangul letters. Please help me confirming this!
is-hangul = (char) ->
  code-point = code-point-at char, 0

  return 0x1100 <= code-point <= 0x11FF
  or 0x3130 <= code-point <= 0x318F
  or 0xA960 <= code-point <= 0xA97F
  or 0xAC00 <= code-point <= 0xD7A3
  or 0xD7B0 <= code-point <= 0xD7FF
  or 0xFFA0 <= code-point <= 0xFFDF

isnt-hangul = (not) << is-hangul

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

  # Heading and tailing white spaces are processed by special rule here.
  # Now cut off heading/tailing white spaces to cope with it afterwards.

  heading-white-space-segments = []
  new-segments = []

  # The last element of heading-white-space-segments is corresponding to the
  # first element of new-segments. It may be empty string.
  for segment, segment-index in segments
    # If segment is constructed only with length of white spaces
    unless segment.match /[^ \t\r\n]/
      heading-white-space-segments.push segment
    else
      heading-white-space = segment.match /^([ \t\r\n]*)/ .1
      heading-white-space-segments.push heading-white-space

      # Push down remaining non-white-space characters
      new-segments.push segment.slice heading-white-space.length
      Array::push.apply new-segments, segments.slice segment-index + 1

      break

  segments = new-segments

  tailing-white-space-segments = []
  new-segments = []

  # The first element of tailing-white-space-segments is corresponding to the
  # last element of new-segments. It may be empty string.
  for segment, segment-index in segments by -1
    # If segment is constructed only with length of white spaces
    unless segment.match /[^ \t\r\n]/
      tailing-white-space-segments.unshift segment
    else
      tailing-white-space = segment.match /([ \t\r\n]*)$/ .1
      tailing-white-space-segments.unshift tailing-white-space

      # Unshift up remaining non-white-space characters
      if tailing-white-space.length is 0
        new-segments.unshift segment
      else
        new-segments.unshift segment.slice 0, -tailing-white-space.length
      Array::unshift.apply new-segments, segments.slice 0, segment-index

      break

  segments = new-segments

  # Implement "Phase I" of the spec
  # https://drafts.csswg.org/css-text-3/#white-space-phase-1

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
      is-monoline-space = not span.match /[\r\n]/

      # Skip if span is only with space and tab
      break if not options.collapse-inline-white-space and is-monoline-space

      # FIXME: prev-span must be prev-element
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

      if is-monoline-space
        assert options.collapse-inline-white-space is true
        assert span.match /^[ \t]+$/

        # step 1 and 2 of the spec are nonsense here.

        if prev-char in [' ' '\t' '\n' '\r']
          spans[span-index] = ''
        else
          spans[span-index] = ' '

      # If this is multiline white space
      else
        # From spec:
        # If the character immediately before or immediately after the segment break is
        # the zero-width space character (U+200B), then the break is removed, leaving
        # behind the zero-width space.

        if '\u200B' in [prev-char, next-char]

          unless options.remove-zwsp
            spans[span-index] = ''
          else
            ...

        # From spec:
        # Otherwise, if the East Asian Width property [UAX11] of both the character
        # before and after the line feed is F, W, or H (not A), and neither side is
        # Hangul, then the segment break is removed.
        else if prev-width in <[F W H]>
        and next-width in <[F W H]>
        and (prev-char |> isnt-hangul)
        and (next-char |> isnt-hangul)

          spans[span-index] = ''

        # From spec:
        # Otherwise, the segment break is converted to a space (U+0020).
        else if options.collapse-all-break

          spans[span-index] = ' '

        else

          # nop

    new-segments.push spans.join ''

  # Implement "Phase II" of the spec
  # https://drafts.csswg.org/css-text-3/#white-space-phase-2

  # Note: head/tailing white spaces can be unconditionally removed.
  # Spec says: "A sequence of collapsible spaces at the beginning of a line is removed."

  unless options.collapse-head
    # Append first processed segment to the last segment of heading-white-space-segments
    heading-white-space-segments[* - 1] += new-segments.shift!

    new-segments = heading-white-space-segments.concat new-segments

  unless options.collapse-tail
    # Append the first segment of last-white-space-segments to the last processed segment
    new-segments[* - 1] += tailing-white-space-segments.shift!

    new-segments = new-segments.concat tailing-white-space-segments

  if typeof! texts is \String
    return new-segments.0
  else
    return new-segments
