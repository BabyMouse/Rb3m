minify_css <- function(css) {
  css <- paste0(css, collapse = "\n")

  # Trim all comments.
  # Ref: https://blog.ostermiller.org/finding-comments-in-source-code-using-regular-expressions/
  css <- gsub("(/\\*([^*]|[\r\n]|(\\*+([^*/]|[\r\n])))*\\*+/)|(//.*)", "", css)

  # Trim all `new line`.
  css <- gsub("[[:space:]]*[\r\n][[:space:]]*", "", css)

  # Trim all spaces of [>{:,!;}].
  css <- gsub("[[:space:]]*([>\\{\\}:,!;])[[:space:]]*", "\\1", css)
  return(css)
}
minify_js <- function(js) {
  js <- paste0(js, collapse = "\n")

  # Trim all comments.
  # Ref: https://blog.ostermiller.org/finding-comments-in-source-code-using-regular-expressions/
  js <- gsub("(/\\*([^*]|[\r\n]|(\\*+([^*/]|[\r\n])))*\\*+/)|(//[[:blank:][:print:]]*\n)", "", js)

  # Trim all `new line`.
  js <- gsub("[[:space:]]*[\r\n][[:space:]]*", "", js)
  return(js)
}
