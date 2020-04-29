#' @inheritParams rmarkdown::html_document
#'
#' @import rmarkdown
#' @import htmltools
#'
#' @export
toHTML <- function(knitr,
                   pandoc,
                   keep_md = FALSE,
                   clean_supporting = TRUE,
                   df_print = NULL,
                   pre_knit = NULL,
                   post_knit = NULL,
                   pre_processor = NULL,
                   intermediates_generator = NULL,
                   post_processor = NULL,
                   on_exit = NULL,
                   base_format = NULL) {
  df_print <- "kable"
  keep_md <- TRUE
  template <- system.file("templates", "pandoc_template_default.html", package = "Rb3m")

  theme <- NULL
  highlight <- system.file("templates", "pandoc_highlight_haddock.theme", package = "Rb3m")
  pandoc_args <- c("--variable", "code_menu")
  mathjax <- NULL
  css <- c(
    system.file("includes", "style.css", package = "Rb3m"),
    system.file("includes", "style_navbar.css", package = "Rb3m"),
    system.file("includes", "style_highlight.css", package = "Rb3m"),
    system.file("includes", "style_code_btn.css", package = "Rb3m")
  )
  in_header <- c(
    system.file("includes", "header.html", package = "Rb3m"),
    system.file("includes", "header_navbar.js.html", package = "Rb3m"),
    system.file("includes", "header_codefolding.js.html", package = "Rb3m"),
    system.file("includes", "header_sourceembed.js.html", package = "Rb3m")
  )

  before_body <- c(
    system.file("includes", "body_prefix.html", package = "Rb3m"),
    system.file("includes", "body_prefix_navbar.html", package = "Rb3m")
  )

  after_body <- c(system.file("includes", "body_suffix.html", package = "Rb3m"))

  includes <- pandoc_include_args(
    in_header = in_header,
    before_body = before_body,
    after_body = after_body
  )

  pandoc_options <- rmarkdown::pandoc_options(
    to = "html5",
    from = from_rmarkdown(fig_caption, md_extensions),
    args = args
  )

  if (is.null(base_format)) {
    base_format <- html_document(
      toc = FALSE,
      toc_depth = 3,
      toc_float = FALSE,
      number_sections = FALSE,
      section_divs = TRUE,
      fig_width = 7,
      fig_height = 5,
      fig_retina = 2,
      fig_caption = TRUE,
      dev = "png",
      df_print = df_print,
      code_folding = c("none", "show", "hide"),
      code_download = FALSE,
      smart = TRUE,
      self_contained = TRUE,
      theme = theme,
      highlight = highlight,
      mathjax = mathjax,
      template = template,
      extra_dependencies = NULL,
      css = css,
      includes = includes,
      keep_md = keep_md,
      lib_dir = NULL,
      md_extensions = NULL,
      pandoc_args = pandoc_args,
      ...
    )
  }

  output_format(
    knitr = knitr,
    pandoc = pandoc,
    keep_md = keep_md,
    clean_supporting = clean_supporting,
    df_print = df_print,
    pre_knit = pre_knit,
    post_knit = post_knit,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    post_processor = post_processor,
    on_exit = on_exit,
    base_format = base_format
  )
}
