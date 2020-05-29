#' @title Config some options for Knitr tranlate Rmd file to HTML file
#'
#' @description
#' This function inherit from \code{rmarkdown::html_document} function to config some options for Knitr tranlate Rmd file to HTML file.
#'
#' @export
#'
#' @usage
#'
#' rmd_to_html(df_print)
#' rmd_to_html(df_print, keep_md)
#'
#' @param toc Not config option.
#' @param toc_depth Not config option.
#'
#' @inheritParams rmarkdown::html_document
#'
#' @details
#'
#' Details for some things.
#'
#' @return
#'
#' Return HTML file in same folder of Rmd file.
#'
#' @section A Custom Section:
#'
#' Text accompanying the custom section.
#'
#' @note
#' \itemize{
#'   \item{Don't run directly.}
#'   \item{Passing value throught header of Rmd file.
#'     \describe{
#'       \item{Example}{}
#'       \item{}{\preformatted{
#' ---
#' output: Rb3m::rmd_to_html
#'   keep_md: yes
#' ---}
#'       }
#'     }
#'   }
#' }
#'
#' @author
#'   \describe{
#'     \item{}{Trát Quang Th<U+1EE5>y}
#'   }
#'
#' @source
#'   \itemize{
#'     \item \href{https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html}{https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html}
#'   }
#'
#' @references
#'   \describe{
#'     \item{label-1}{text-1}
#'     \item{label-2}{text-2}
#'   }
#'
#' @seealso
#'
#' \itemize{
#'   \item \href{https://github.com/BabyMouse/Rb3m}{GitHub: https://github.com/BabyMouse/Rb3m}
#'   \item \href{http://r-pkgs.had.co.nz/man.html}{http://r-pkgs.had.co.nz/man.html}
#' }
#'
#' @examples
#' add_numbers(1, 2) ## returns 3
#'
#' ## don't run this in calls to 'example(add_numbers)'
#' \dontrun{
#' add_numbers(2, 3)
#' }
#'
#' ## don't test this during 'R CMD check'
#' \donttest{
#' add_numbers(4, 5)
#' }
#'
rmd_to_html <- function(
                        # Rb3m options
                        code_folding = c("show", "hide", "none"),
                        #
                        # Knit options
                        fig_width = 7,
                        fig_height = 5,
                        fig_retina = 2,
                        keep_md = TRUE,
                        dev = "png",
                        #
                        # RMarkdown options
                        fig_caption = TRUE,
                        md_extensions = NULL,
                        self_contained = TRUE,
                        df_print = "kable",
                        #
                        # Pandoc options
                        # toc = FALSE,
                        # toc_depth = 3,
                        # toc_float = FALSE,
                        # number_sections = FALSE,
                        # theme = "default",
                        # mathjax = "default",
                        # extra_dependencies = NULL,
                        # css = NULL,
                        # includes = NULL,
                        # lib_dir = NULL,
                        # section_divs = TRUE,
                        smart = TRUE,
                        pandoc_variables = NULL,
                        ...) {
  dots_options <- list(...)
  dots_names <- names(dots_options)

  # Knit options
  k_options <- list(
    fig_width = fig_width,
    fig_height = fig_height,
    fig_retina = fig_retina,
    keep_md = keep_md,
    dev = dev
  )

  # RMarkdown options
  rmd_options <- list(
    from = list(
      fig_caption = fig_caption,
      md_extensions = md_extensions
    ),
    clean_supporting = self_contained,
    df_print = df_print,
    theme = NULL,
    mathjax = NULL
  )

  # Rb3m options
  # Standardized input information
  r_options <- list(
    code_folding = match.arg(code_folding),
    head_tempfile = tempfile(fileext = ".html"),
    body_prefix = tempfile(fileext = ".html"),
    body_suffix = tempfile(fileext = ".html")
  )
  if (!is.null(dots_names["nav"])) r_options$nav <- dots_options[["nav"]]
  if (!is.null(dots_names["template"])) r_options$template <- dots_options[["template"]]
  if (!is.null(dots_names["highlight"])) r_options$highlight <- dots_options[["highlight"]]

  # message(missing(nav$download_file_title))

  if (is.null(r_options$code_folding) || r_options$code_folding == "none") r_options$is_folding <- FALSE

  r_options <- list_merge(default_options, r_options)

  print_list(r_options, "  - ", "Rb3m options:")

  knitr::knit_engines$set(html = function(options) {
    knitr::engine_output(options, options$code, "")
  })
  knitr::knit_engines$set(yml = function(options) {
    knitr::engine_output(options, options$code, "")
  })

  pre_knit <- function(input, ...) {
    if (length(r_options$nav$download_file_name) == 0) {
      r_options$nav$download_file_name <<- basename(input)
    }
    if (length(r_options$nav$download_file_title) == 0) {
      r_options$nav$download_file_title <<- paste0("Download ", basename(input))
    }
    r_options$pre_knit <<- list(source_input = input, ...)

    pre_knit_event_handler(r_options)
  }
  post_knit <- function(metadata, input_file, runtime, encoding, ...) {
    r_options$post_knit <<- list(
      metadata = metadata, input_file = input_file,
      runtime = runtime, encoding = encoding,
      ...
    )
    post_knit_event_handler(r_options)
  }
  pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    r_options$pre_processor <<- list(
      metadata = metadata, input_file = input_file, runtime = runtime,
      knit_meta = knit_meta, files_dir = files_dir, output_dir = output_dir
    )
    pre_processor_event_handler(r_options)
  }
  intermediates_generator <- function(original_input, intermediates_dir) {
    r_options$intermediates_generator <<- list(
      original_input = original_input,
      intermediates_dir = intermediates_dir
    )
    intermediates_generator_event_handler(r_options)
  }
  post_processor <- function(metadata, input_file, output_file, clean, verbose) {
    r_options$post_processor <<- list(
      metadata = metadata,
      input_file = input_file, output_file = output_file,
      clean = clean, verbose = verbose
    )
    post_processor_event_handler(r_options)
    structure(output_file, post_process_original = TRUE)
  }
  on_exit <- function() {
    on_exit_event_handler(r_options)
  }

  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options_html(
      fig_width = k_options$fig_width,
      fig_height = k_options$fig_height,
      fig_retina = k_options$fig_retina,
      keep_md = k_options$keep_md,
      dev = k_options$dev
    ),
    pandoc = rmarkdown::pandoc_options(
      to = "html5",
      from = rmarkdown::from_rmarkdown(
        implicit_figures = rmd_options$from$fig_caption,
        extensions = rmd_options$from$md_extensions
      ) # ,
      # args = p_options
    ),
    keep_md = keep_md,
    clean_supporting = rmd_options$clean_supporting,
    df_print = rmd_options$df_print,
    pre_knit = pre_knit,
    post_knit = post_knit,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    post_processor = post_processor,
    on_exit = on_exit,
    base_format = rmarkdown::html_document_base(
      # smart = TRUE,
      theme = rmd_options$theme,
      mathjax = rmd_options$mathjax,
      # pandoc_args = NULL,
      # ...
    )
  )
}
