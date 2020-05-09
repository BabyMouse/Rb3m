merge_html_fragments_to_p_option <- function(p_option_name, fragment_files) {
  len <- length(fragment_files)
  if (len > 0) {
    fragment_tempfile <- tempfile(fileext = ".html")
    fragment_content <- ""
    for (i in 1:len) {
      if (length(fragment_files[[i]] > 0)) {
        fragment_content <- c(fragment_content, xfun::read_utf8(fragment_files[[i]]))
      }
    }
    xfun::write_utf8(fragment_content, fragment_tempfile)
    c(p_option_name, fragment_tempfile)
  }
  else {
    return(NULL)
  }
}
