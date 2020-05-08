#' Get path and file name from resources
#'
#' @param res_folder
#' @param res_file
#'
#' @return String type.
#' @export
#'
#' @examples
get_pathfile_from_res <- function(res_folder, res_file) {
  file.path(system.file(res_folder, package = "Rb3m"), res_file)
}

#' Build Pandoc argument from resources
#'
#' @param res_name
#' @param res_folder
#' @param res_file
#'
#' @return String type.
#' @export
#'
#' @examples
build_parg_from_res <- function(res_name, res_folder, res_file) {
  c(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
}
#' Print tree member of list type
#'
#' @param indent_string String type.
#' @param lst List type.
#'
#' @return Nothing.
#' @export
#'
#' @examples
print_list <- function(indent_string = "", lst = NULL) {
  if (length(lst) > 0) {
    member_names <- names(lst)
    for (i in 1:length(lst)) {
      if (length(lst[[i]]) > 1) {
        message(indent_string, member_names[i], " : ", typeof(lst[[i]]), " = ")
        print_list(c("  ", indent_string), lst[[i]])
      } else {
        message(indent_string, member_names[i], " : ", typeof(lst[[i]]), " = ", lst[[i]])
      }
    }
  }
}
