merge_js_files_to_p_options <- function(js_files) {
  len <- length(js_files)
  if (len > 0) {
    js_tempfile <- tempfile(fileext = ".js.html")
    js_content <- ""
    for (i in 1:len) {
      if (length(js_files[[i]] > 0)) {
        js_content <- c(js_content, xfun::read_utf8(js_files[[i]]))
      }
    }
    xfun::write_utf8(c("<script>", js_content, "</script>"), js_tempfile)
    c("--include-in-header", js_tempfile)
  }
  else {
    return(NULL)
  }
}
