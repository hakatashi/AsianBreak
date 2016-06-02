require! {
  eastasianwidth: {east-asian-width}
  'core-js/library/fn/object/assign': extend
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
  pushed-down-remainings = false

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

      pushed-down-remainings = true
      break

  # If pushing down was not trigered, input was only with whitespaces.
  # Then we have to push empty string to new-segments.
  unless pushed-down-remainings
    new-segments.push ''

  segments = new-segments

  tailing-white-space-segments = []
  new-segments = []
  pushed-down-remainings = false

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

      pushed-down-remainings = true
      break

  # If pushing down was not trigered, input was only with whitespaces.
  # Then we have to unshift empty string to new-segments.
  unless pushed-down-remainings
    new-segments.unshift ''

  segments = new-segments

  # Implement "Phase I" of the spec
  # https://drafts.csswg.org/css-text-3/#white-space-phase-1

  # Previous and next segments are refered while iterating.
  # We store transformed new segments into new array.
  new-segments = []

  for segment, segment-index in segments
    # FIXME: This loop is not necessery. It can avoid O(N^2)
    prev-char-before-segment = null
    for index from segment-index - 1 to 0 by -1
      if segments[index] |> last-char
        prev-char-before-segment = segments[index] |> last-char
        break

    next-char-after-segment = null
    for index from segment-index + 1 til segments.length
      if segments[index] |> first-char
        next-char-after-segment = segments[index] |> first-char
        break

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
      continue if not options.collapse-inline-white-space and is-monoline-space

      prev-span = spans[span-index - 1]
      next-span = spans[span-index + 1]

      prev-char = if prev-span.length isnt 0
        then (prev-span |> last-char) ? null
        else prev-char-before-segment ? null
      next-char = if next-span.length isnt 0
        then (next-span |> first-char) ? null
        else next-char-after-segment ? null

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

  # Collapse spaces following another space character
  # From spec:
  # Any space immediately following another collapsible space—even one outside the boundary of
  # the inline containing that space, provided both spaces are within the same inline formatting
  # context—is collapsed to have zero advance width.
  if options.collapse-inline-white-space
    for segment, segment-index in new-segments
      # FIXME: This loop is not necessery. It can avoid O(N^2)
      prev-char-before-segment = null
      for index from segment-index - 1 to 0 by -1
        if new-segments[index] |> last-char
          prev-char-before-segment = new-segments[index] |> last-char
          break

      new-segment = ''

      # We don't have to consider surrogate pairs here
      for char in segment
        if char is ' '
          prev-char = new-segment[* - 1] ? prev-char-before-segment
          if prev-char isnt ' '
            new-segment += char
        else
          new-segment += char

      new-segments[segment-index] = new-segment

  # Implement "Phase II" of the spec
  # https://drafts.csswg.org/css-text-3/#white-space-phase-2

  # Note: head/tailing white spaces can be unconditionally removed.
  # Spec says: "A sequence of collapsible spaces at the beginning of a line is removed."

  unless options.collapse-head
    # Append first processed segment to the last segment of heading-white-space-segments
    heading-white-space-segments[* - 1] += new-segments.shift!

    new-segments = heading-white-space-segments.concat new-segments
  else
    # Collapse heading whitespaces: pad empty segments left to the new-segments
    pad-left-segments = [''] * (heading-white-space-segments.length - 1)
    new-segments = pad-left-segments.concat new-segments

  unless options.collapse-tail
    # Append the first segment of last-white-space-segments to the last processed segment
    new-segments[* - 1] += tailing-white-space-segments.shift!

    new-segments = new-segments.concat tailing-white-space-segments
  else
    # Collapse heading whitespaces: pad empty segments left to the new-segments
    pad-right-segments = [''] * (tailing-white-space-segments.length - 1)
    new-segments = new-segments.concat pad-right-segments

  if typeof! texts is \String
    return new-segments.0
  else
    return new-segments
