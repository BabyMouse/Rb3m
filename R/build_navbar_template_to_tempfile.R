build_navbar_template_to_tempfile <- function(r_options) {
  html_tempfile <- tempfile(fileext = ".html")
  html_content <- paste(xfun::read_utf8(get_pathfile_from_res(
    "includes/rmd_to_html",
    "body_prefix_navbar.template.html"
  )), sep = "", collapse = "\n")
  if (r_options$is_folding || r_options$code_download) {
    html_content <- gsub(
      "[[:space:]]*<Rb3m:code_menu>([[:print:][:space:]]*)</Rb3m:code_menu>[[:space:]]*",
      "\\1", html_content
    )
    if (r_options$is_folding) {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_folding>([[:print:][:space:]]*)</Rb3m:code_folding>[[:space:]]*",
        "\\1", html_content
      )
    }
    else {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_folding>[[:print:][:space:]]*</Rb3m:code_folding>[[:space:]]*",
        "", html_content
      )
    }
    if (r_options$is_folding && r_options$code_download) {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_folding-code_download>([[:print:][:space:]]*)</Rb3m:code_folding-code_download>[[:space:]]*",
        "\\1", html_content
      )
    }
    else {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_folding-code_download>[[:print:][:space:]]*</Rb3m:code_folding-code_download>[[:space:]]*",
        "", html_content
      )
    }
    if (r_options$code_download) {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_download>([[:print:][:space:]]*)</Rb3m:code_download>[[:space:]]*",
        "\\1", html_content
      )
    }
    else {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_download>[[:print:][:space:]]*</Rb3m:code_download>[[:space:]]*",
        "", html_content
      )
    }
  }
  else {
    html_content <- gsub(
      "[[:space:]]*<Rb3m:code_menu>[[:print:][:space:]]*</Rb3m:code_menu>[[:space:]]*",
      "", html_content
    )
  }
  xfun::write_utf8(html_content, html_tempfile)
  return(html_tempfile)
}
