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

#' add_code_menu_to_js_tempfile
#'
#' @param code_folding code_folding = { default = 'show' | NULL, 'hide', 'off' }
#' @param code_download code_download = { default = TRUE | NULL, FALSE | 'off' }
#'
#' @return NULL or js_tempfile
#' @export
#'
add_code_menu_to_js_tempfile <- function(r_options) {
  js_tempfile <- tempfile(fileext = ".js")
  js_code_content <- ""
  js_code_menu <- paste(xfun::read_utf8(get_pathfile_from_res(
    "includes/rmd_to_html",
    "header_code_menu.template.js"
  )), sep = "", collapse = "\n")
  if (r_options$is_folding || r_options$code_download) {
    if (r_options$is_folding) {
      js_code_content <- c(
        js_code_content,
        xfun::read_utf8(get_pathfile_from_res("includes/rmd_to_html", "header_code_folding.js"))
      )
      js_code_menu <- gsub(
        "[[:space:]]*/\\*Rb3m:code_folding([[:print:][:space:]]*)/Rb3m:code_folding\\*/[[:space:]]*",
        "\\1", js_code_menu
      )
      js_code_menu <- gsub("\\$\\{code_folding\\}", r_options$code_folding, js_code_menu)
    }
    else {
      js_code_menu <- gsub(
        "[[:space:]]*/\\*Rb3m:code_folding[[:print:][:space:]]*/Rb3m:code_folding\\*/[[:blank:]]*",
        "", js_code_menu
      )
    }
    if (r_options$code_download) {
      js_code_content <- c(
        js_code_content,
        xfun::read_utf8(get_pathfile_from_res("includes/rmd_to_html", "header_code_download.js"))
      )
      js_code_menu <- gsub(
        "[[:space:]]*/\\*Rb3m:code_download([[:print:][:space:]]*)/Rb3m:code_download\\*/[[:space:]]*",
        "\\1", js_code_menu
      )
    }
    else {
      js_code_menu <- gsub(
        "[[:space:]]*/\\*Rb3m:code_download[[:print:][:space:]]*/Rb3m:code_download\\*/[[:blank:]]*",
        "", js_code_menu
      )
    }
    xfun::write_utf8(c(js_code_content, js_code_menu), js_tempfile)
    return(js_tempfile)
  }
  else {
    return(NULL)
  }
}
