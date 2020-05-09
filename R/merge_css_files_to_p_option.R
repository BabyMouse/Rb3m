merge_css_files_to_p_option <- function(css_files) {
  len <- length(css_files)
  if (len > 0) {
    css_tempfile <- tempfile(fileext = ".css")
    css_content <- ""
    for (i in 1:len) {
      if (length(css_files[[i]] > 0)) {
        css_content <- c(css_content, xfun::read_utf8(css_files[[i]]))
      }
    }
    xfun::write_utf8(css_content, css_tempfile)
    c("--css", css_tempfile)
  }
  else {
    return(NULL)
  }
}
