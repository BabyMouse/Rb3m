#' Knit to HTML file.
#' @encoding UTF-8
#'
#' @param toc T<U+u1ED9>i
#' &#9986; t&ocirc;i
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
  encoding <- NULL
  pre_knit <- function(input, ...) {
    message("pre_knit: ", input)
  }
  # post_knit <- function(metadata, input_file, runtime, ...) {
  #   message("post_knit: ")
  # }
  post_knit <- function(metadata, input_file, runtime, encoding, ...) {
    encoding <<- encoding
    message("post_knit: ")
  }
  pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    message("pre_processor: ")
  }
  intermediates_generator <- function(original_input, intermediates_dir) {
    message("intermediates_generator: ")
  }
  post_processor <- function(encoding) {
    function(metadata, input_file, output_file, clean, verbose) {
      message("post_processor: ")
    }
  }
  on_exit <- function() {
    message("on_exit: ")
  }
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
        build_parg_from_res("--template", "templates/toHTML", "pandoc_template_default.html5.html"),
        build_parg_from_res("--highlight-style", "templates/toHTML", "pandoc_highlight_haddock.theme"),
        build_parg_from_res("--css", "includes/toHTML", "style.css"),
        build_parg_from_res("--css", "includes/toHTML", "style_navbar.css"),
        build_parg_from_res("--css", "includes/toHTML", "style_highlight.css"),
        build_parg_from_res("--css", "includes/toHTML", "style_code_btn.css"),
        build_parg_from_res("--include-in-header", "includes/toHTML", "header.html"),
        build_parg_from_res("--include-in-header", "includes/toHTML", "header_navbar.js.html"),
        build_parg_from_res("--include-in-header", "includes/toHTML", "header_codefolding.js.html"),
        build_parg_from_res("--include-in-header", "includes/toHTML", "header_sourceembed.js.html"),
        build_parg_from_res("--include-before-body", "includes/toHTML", "body_prefix.html"),
        build_parg_from_res("--include-before-body", "includes/toHTML", "body_prefix_navbar.html"),
        build_parg_from_res("--include-after-body", "includes/toHTML", "body_suffix.html"),
        "--variable", "code_menu"
      )
    ),
    keep_md = keep_md,
    clean_supporting = self_contained,
    df_print = df_print,
    pre_knit = pre_knit,
    post_knit = post_knit,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    post_processor = NULL,#post_processor(function() encoding),
    on_exit = on_exit,
    base_format = rmarkdown::html_document_base(
      # smart = TRUE,
      theme = theme,
      mathjax = mathjax,
      pandoc_args = NULL,
      ...
    )
  )
}

build_parg_from_res <- function(res_name, res_folder, res_file) {
  # base::paste(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
  c(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
}
