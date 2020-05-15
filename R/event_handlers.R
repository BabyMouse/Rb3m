#' @export
pre_knit_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "pre_knit:")
}
post_knit_event_handler <- function(r_options) {
  p_options <- c("--standalone")
  css_content <- character(0)
  js_content <- character(0)
  head_content <- character(0)
  body_prefix_content <- character(0)
  body_suffix_content <- character(0)

  # Template
  if (r_options$template == "default") {
    p_options <- c(
      p_options,
      build_parg_from_res("--template", "templates/rmd_to_html", "pandoc_template_default.html5.html")
    )
    css_content <- c(
      css_content,
      read_to_string(get_pathfile_from_res("includes/rmd_to_html", "style.css"))
    )
  } else if (!is.null(r_options$template)) {
    p_options <- c(p_options, "--template", r_options$template)
  }

  # Highlight
  if (r_options$highlight == "default") {
    p_options <- c(
      p_options,
      build_parg_from_res("--highlight-style", "templates/rmd_to_html", "pandoc_highlight_haddock.theme")
    )
    css_content <- c(
      css_content,
      read_to_string(get_pathfile_from_res("includes/rmd_to_html", "style_highlight.css"))
    )
  } else if (!is.null(r_options$highlight)) {
    p_options <- c(p_options, "--highlight-style", r_options$highlight)
  }

  # Head
  head_content <- c(
    head_content,
    read_to_string(get_pathfile_from_res("includes/rmd_to_html", "header.html"))
  )

  # Navigate bar
  if (r_options$navbar == "default") {
    body_prefix_content <- c(
      body_prefix_content,
      build_internal_navbar_template_to_html_string(r_options)
    )
    css_content <- c(
      css_content,
      read_to_string(get_pathfile_from_res("includes/rmd_to_html", "style_navbar.css"))
    )
    js_content <- c(
      js_content,
      read_to_string(get_pathfile_from_res("includes/rmd_to_html", "header_navbar.js"))
    )
    if (r_options$is_folding || r_options$is_download) {
      css_content <- c(
        css_content,
        read_to_string(get_pathfile_from_res("includes/rmd_to_html", "style_code_btn.css"))
      )
      js_content <- c(
        js_content,
        build_internal_code_menu_template_to_html_string(r_options)
      )
    }
  }

  # minify CSS & JavaScript
  css_content <- paste0(css_content, collapse = "\n")
  js_content <- paste0(js_content, collapse = "\n")

  css_content <- gsub("[[:space:]]*\n[[:space:]]*", "", css_content)

  # Add CSS & JavaScript to Head tag
  head_content <- c(
    head_content,
    '<style type="text/css">', css_content, "</style>",
    "<script>", js_content, "</script>"
  )

  # body_prefix
  body_prefix_content <- c(
    body_prefix_content,
    read_to_string(get_pathfile_from_res("includes/rmd_to_html", "body_prefix.html"))
  )

  # body_suffix
  body_suffix_content <- c(
    body_suffix_content,
    read_to_string(get_pathfile_from_res("includes/rmd_to_html", "body_suffix.html"))
  )

  # Begin write all_content to tempfile
  xfun::write_utf8(head_content, r_options$head_tempfile)
  xfun::write_utf8(body_prefix_content, r_options$body_prefix)
  xfun::write_utf8(body_suffix_content, r_options$body_suffix)

  print_list(r_options, "  - ", "post_knit:")

  # Return Pandoc options
  p_options <- c(
    p_options,
    "--include-in-header", r_options$head_tempfile,
    "--include-before-body", r_options$body_prefix,
    "--include-after-body", r_options$body_suffix
  )
  return(p_options)
}
pre_processor_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "pre_processor:")
}
intermediates_generator_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "intermediates_generator:")
}
post_processor_event_handler <- function(r_options) {
  print_list(r_options, " - ", "post_processor:")
}
on_exit_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "on_exit:")
}
