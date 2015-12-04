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
    -collapse-inline-whitespace
    -collapse-all-break
    -collapse-zwsp
  }

  options = extend {}, options, default-options

  return texts
