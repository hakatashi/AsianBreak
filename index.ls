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

  return texts
