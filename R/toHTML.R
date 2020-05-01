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
  theme <- NULL
  mathjax <- NULL
  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options_html(
      fig_width = fig_width,
      fig_height = fig_height,
      fig_retina = fig_retina,
      keep_md = keep_md,
      dev = dev
    ),
    pandoc = rmarkdown::pandoc_options(
      to = "html5",
      from = rmarkdown::from_rmarkdown(
        fig_caption,
        md_extensions
      ),
      args = c(
        "--standalone",
        "--template", file.path(system.file("templates/toHTML", package = "Rb3m"), "pandoc_template_default.html5.html"),
        "--highlight-style", file.path(system.file("templates/toHTML", package = "Rb3m"), "pandoc_highlight_haddock.theme"),
        "--css", file.path(system.file("includes/toHTML", package = "Rb3m"), "style.css"),
        "--css", file.path(system.file("includes/toHTML", package = "Rb3m"), "style_navbar.css"),
        "--css", file.path(system.file("includes/toHTML", package = "Rb3m"), "style_highlight.css"),
        "--css", file.path(system.file("includes/toHTML", package = "Rb3m"), "style_code_btn.css"),
        "--include-in-header", file.path(system.file("includes/toHTML", package = "Rb3m"), "header.html"),
        "--include-in-header", file.path(system.file("includes/toHTML", package = "Rb3m"), "header_navbar.js.html"),
        "--include-in-header", file.path(system.file("includes/toHTML", package = "Rb3m"), "header_sourceembed.js.html"),
        "--include-before-body", file.path(system.file("includes/toHTML", package = "Rb3m"), "body_prefix.html"),
        "--include-before-body", file.path(system.file("includes/toHTML", package = "Rb3m"), "body_prefix_navbar.html"),
        "--include-after-body", file.path(system.file("includes/toHTML", package = "Rb3m"), "body_suffix.html"),
        "--variable", "code_menu"
      )
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
      # smart = TRUE,
      theme = theme,
      mathjax = mathjax,
      pandoc_args = NULL,
      ...
    )
  )
}
