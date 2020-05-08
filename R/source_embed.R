#' Embed a file to HTML throght a tag
#'
#' @param file
#' @param name
#' @param text
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
embed_file_a <- function(file,
                         name = basename(file),
                         text = paste("Download", name),
                         ...) {
  # Source: https://github.com/yihui/xfun/blob/master/R/markdown.R
  # xfun::embed_file('ddrIntroduction.Rmd')

  # xfun::pkg_load2(c("base64enc", "htmltools", "mime"))

  message('star... paste0')

  h <- paste0(
    "data:",
    mime::guess_type(file),
    ";base64,",
    base64enc::base64encode(file)
  )
  htmltools::a(
    id = "embed-rmd-file",
    href = h,
    download = name,
    hidden = NA,
    text,
    ...
  )
}
