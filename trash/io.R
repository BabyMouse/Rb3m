#' @export
read_to_string <- function(pathfile) {
  paste(xfun::read_utf8(pathfile), sep = "", collapse = "\n")
}
