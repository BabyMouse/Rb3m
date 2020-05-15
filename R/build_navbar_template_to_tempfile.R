build_internal_navbar_template_to_html_string <- function(r_options) {
  html_content <- read_to_string(get_pathfile_from_res(
    "includes/rmd_to_html",
    "body_prefix_navbar.template.html"
  ))
  if (r_options$is_folding || r_options$is_download) {
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
    if (r_options$is_folding && r_options$is_download) {
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
    if (r_options$is_download) {
      html_content <- gsub(
        "[[:space:]]*<Rb3m:code_download>([[:print:][:space:]]*)</Rb3m:code_download>[[:space:]]*",
        "\\1", html_content
      )
      html_content <- gsub("\\$\\{download_file_name\\}", r_options$download_file_name, html_content)
      html_content <- gsub(
        "\\$\\{download_file_data\\}",
        paste0(
          "data:", mime::guess_type(r_options$pre_knit$source_input), ";base64,",
          base64enc::base64encode(r_options$pre_knit$source_input)
        ),
        html_content
      )
      html_content <- gsub("\\$\\{download_file_title\\}", r_options$download_file_title, html_content)
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
  return(html_content)
}

build_internal_code_menu_template_to_html_string <- function(r_options) {
  js_code_content <- ""
  js_code_menu <- read_to_string(get_pathfile_from_res(
    "includes/rmd_to_html",
    "header_code_menu.template.js"
  ))
  if (r_options$is_folding || r_options$is_download) {
    if (r_options$is_folding) {
      js_code_content <- c(
        js_code_content,
        read_to_string(get_pathfile_from_res("includes/rmd_to_html", "header_code_folding.js"))
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
    if (r_options$is_download) {
      js_code_content <- c(
        js_code_content,
        read_to_string(get_pathfile_from_res("includes/rmd_to_html", "header_code_download.js"))
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
    return(c(js_code_content, js_code_menu))
  }
  else {
    return(NULL)
  }
}
