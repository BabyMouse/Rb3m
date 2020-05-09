merge_js_files_to_tempfile <- function(js_files) {
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
    js_tempfile
  }
  else {
    return(NULL)
  }
}

add_code_menu_to_js_tempfile <- function(code_folding = "show", code_download = TRUE) {
  # code_folding = { default = 'show' | NULL, 'hide', 'off' }
  # code_folding <- r_options[["code_folding"]]
  code_folding <- if (is.null(code_folding)) "show"
  c_folding <- ifelse(code_folding == "off", FALSE, TRUE)

  # code_download = { default = TRUE | NULL, 'off' }
  # code_download <- r_options[["code_download"]]
  c_download <- ifelse(is.null(code_download), TRUE, code_download != "off")

  if (c_folding || c_download) {

    c(
      get_pathfile_from_res("includes/rmd_to_html", "header_codefolding.js"),
      get_pathfile_from_res("includes/rmd_to_html", "header_sourceembed.js")
    )
  }
  else {
    return(NULL)
  }
}
