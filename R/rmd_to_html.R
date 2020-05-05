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
rmd_to_html <- function(toc = FALSE,
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
  pre_knit <- function(input, ...) {
    message("pre_knit:")
    message(" - input: ", input)
  }
  post_knit <- function(metadata, input_file, runtime, encoding, ...) {
    message("post_knit:")
    message(" - metadata: ", metadata)
    message(" - input_file: ", input_file)
    message(" - runtime: ", runtime)
    message(" - encoding: ", encoding)
  }
  pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    message("pre_processor:")
    message(" - metadata: ", metadata)
    message(" - input_file: ", input_file)
    message(" - runtime: ", runtime)
    message(" - knit_meta: ", knit_meta)
    message(" - files_dir: ", files_dir)
    message(" - output_dir: ", output_dir)
  }
  intermediates_generator <- function(original_input, intermediates_dir) {
    message("intermediates_generator:")
    message(" - original_input: ", original_input)
    message(" - intermediates_dir: ", intermediates_dir)
  }
  post_processor <- function(metadata, input_file, output_file, clean, verbose) {
    message("post_processor:")
    message(" - metadata: ", metadata)
    message(" - input_file: ", input_file)
    message(" - output_file: ", output_file)
    message(" - clean: ", clean)
    message(" - verbose: ", verbose)
    structure(output_file, post_process_original = TRUE)
  }
  on_exit <- function() {
    message("on_exit:")
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
    post_processor = post_processor,#post_processor(function() encoding),
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

get_pathfile_from_res <- function(res_folder, res_file) {
  file.path(system.file(res_folder, package = "Rb3m"), res_file)
}

build_parg_from_res <- function(res_name, res_folder, res_file) {
  c(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
}
