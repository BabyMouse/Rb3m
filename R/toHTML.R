#' @export
toHTML <- function(toc = FALSE,
                   toc_depth = 3,
                   toc_float = FALSE,
                   number_sections = FALSE,
                   section_divs = TRUE,
                   fig_width = 7,
                   fig_height = 5,
                   fig_retina = 2,
                   fig_caption = TRUE,
                   dev = "png",
                   df_print = "default",
                   # code_folding = c("none", "show", "hide"),
                   # code_download = FALSE,
                   smart = TRUE,
                   self_contained = TRUE,
                   theme = "default",
                   highlight = "default",
                   mathjax = "default",
                   template = "default",
                   extra_dependencies = NULL,
                   css = NULL,
                   includes = NULL,
                   keep_md = FALSE,
                   lib_dir = NULL,
                   md_extensions = NULL,
                   pandoc_args = NULL,
                   ...) {
  df_print <- "kable"
  keep_md <- TRUE
  template <- "templates/pandoc_template_default.html"
  theme <- NULL
  highlight <- "templates/pandoc_highlight_haddock.theme"
  mathjax <- NULL
  css <- c(
    "includes/style.css",
    "includes/style_navbar.css",
    "includes/style_highlight.css",
    "includes/style_code_btn.css"
  )
  in_header <- c(
    "includes/header.html",
    "includes/header_navbar.js.html",
    "includes/header_codefolding.js.html",
    "includes/header_sourceembed.js.html"
  )
  before_body <- c(
    "includes/body_prefix.html",
    "includes/body_prefix_navbar.html"
  )
  after_body <- c("includes/body_suffix.html")
  includes <- rmarkdown::pandoc_include_args(
    in_header = in_header,
    before_body = before_body,
    after_body = after_body
  )

  knitr_options <- rmarkdown::knitr_options_html(
    fig_width = fig_width,
    fig_height = fig_height,
    fig_retina = fig_retina,
    keep_md = keep_md,
    dev = dev
  )
  knitr_options$opts_chunk$echo <- FALSE
  knitr_options$opts_chunk$warning <- FALSE
  knitr_options$opts_chunk$message <- FALSE
  knitr_options$opts_chunk$comment <- NA
  knitr_options$opts_chunk$R.options <- list(width = 70)
  knitr_options$opts_knit$bookdown.internal.label <- TRUE
  knitr_options$opts_hooks <- list()
  knitr_options$opts_hooks$preview <- NULL
  knitr_options$knit_hooks <- list()
  knitr_options$knit_hooks$chunk <- NULL
  rmarkdown::output_format(
    knitr = knitr_options,
    pandoc = rmarkdown::pandoc_options(
      to = "html5",
       from = rmarkdown::from_rmarkdown(fig_caption, md_extensions),
      args = "--standalone"
    ),
    keep_md = keep_md,
    clean_supporting = self_contained,
    df_print = df_print,
    pre_knit = NULL,
    post_knit = NULL,
    pre_processor = NULL,
    intermediates_generator = NULL,
    post_processor = NULL,
    on_exit = NULL,
    base_format = rmarkdown::html_document_base(
      smart = TRUE,
      theme = theme,
      highlight = highlight,
      mathjax = mathjax,
      template = template,
      css = css,
      includes = includes,
      pandoc_args = c("--variable", "code_menu"),
      ...
    )
  )
}
