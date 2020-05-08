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
                        # toc = FALSE,
                        # toc_depth = 3,
                        # toc_float = FALSE,
                        # number_sections = FALSE,
                        # section_divs = TRUE,
                        # fig_width = 7,
                        # fig_height = 5,
                        # fig_retina = 2,
                        # fig_caption = TRUE,
                        dev = "png",
                        df_print = "default",
                        # code_folding = c("none", "show", "hide"),
                        # code_download = FALSE,
                        smart = TRUE,
                        self_contained = TRUE,
                        # theme = "default",
                        # highlight = "default",
                        # mathjax = "default",
                        # template = "default",
                        # extra_dependencies = NULL,
                        # css = NULL,
                        # includes = NULL,
                        keep_md = FALSE,
                        # lib_dir = NULL,
                        # md_extensions = NULL,
                        # pandoc_args = NULL,
                        ...) {
  ops <- list(...)
  message("rmd_to_html:")
  print_list("  - ", list(`...` = ops))
  df_print <- "kable"
  keep_md <- TRUE
  theme <- NULL
  mathjax <- NULL
  fig_width <- 7
  fig_height <- 5
  fig_retina <- 2
  fig_caption <- TRUE
  md_extensions <- NULL

  k_options <- rmarkdown::knitr_options_html(
    fig_width = fig_width,
    fig_height = fig_height,
    fig_retina = fig_retina,
    keep_md = keep_md,
    dev = dev
  )

  template <- build_parg_from_res("--template", "templates/rmd_to_html", "pandoc_template_default.html5.html")
  highlight <- build_parg_from_res("--highlight-style", "templates/rmd_to_html", "pandoc_highlight_haddock.theme")
  pandoc_variable <- c("--variable", "code_menu")

  css_files <- c(
    get_pathfile_from_res("includes/rmd_to_html", "style.css"),
    get_pathfile_from_res("includes/rmd_to_html", "style_navbar.css"),
    get_pathfile_from_res("includes/rmd_to_html", "style_highlight.css"),
    get_pathfile_from_res("includes/rmd_to_html", "style_code_btn.css")
  )

  js_files <- c(
    get_pathfile_from_res("includes/rmd_to_html", "header_navbar.js"),
    get_pathfile_from_res("includes/rmd_to_html", "header_codefolding.js"),
    get_pathfile_from_res("includes/rmd_to_html", "header_sourceembed.js")
  )

  p_options <- c(
    template, highlight, pandoc_variable,
    merge_css_files_to_p_options(css_files),
    merge_js_files_to_p_options(js_files)
  )

  rmarkdown::output_format(
    knitr = k_options,
    pandoc = rmarkdown::pandoc_options(
      to = "html5",
      from = rmarkdown::from_rmarkdown(
        fig_caption,
        md_extensions
      ),
      args = c(
        "--standalone",
        p_options,
        build_parg_from_res("--include-in-header", "includes/rmd_to_html", "header.html"),
        # build_parg_from_res("--include-in-header", "includes/rmd_to_html", ""),
        # build_parg_from_res("--include-in-header", "includes/rmd_to_html", ""),
        # build_parg_from_res("--include-in-header", "includes/rmd_to_html", ""),
        build_parg_from_res("--include-before-body", "includes/rmd_to_html", "body_prefix.html"),
        build_parg_from_res("--include-before-body", "includes/rmd_to_html", "body_prefix_navbar.html"),
        build_parg_from_res("--include-after-body", "includes/rmd_to_html", "body_suffix.html")
      )
    ),
    keep_md = keep_md,
    clean_supporting = self_contained,
    df_print = df_print,
    pre_knit = pre_knit_event_handler(),
    post_knit = post_knit_event_handler(),
    pre_processor = pre_processor_event_handler(),
    intermediates_generator = intermediates_generator_event_handler(),
    post_processor = post_processor_event_handler(),
    on_exit = on_exit_event_handler(),
    base_format = rmarkdown::html_document_base(
      # smart = TRUE,
      theme = theme,
      mathjax = mathjax,
      pandoc_args = NULL,
      ...
    )
  )
}
