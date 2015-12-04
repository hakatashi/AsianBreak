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

  options = extend {}, options, default-options

  switch typeof! texts
    | \String => segments = [texts]
    | \Array => segments = texts
    | otherwise => throw new Error 'Unsupported text type'

  for index, segment of segments
    prev-segment = segments[index - 1] ? null
    next-segment = segments[index + 1] ? null

  return texts
