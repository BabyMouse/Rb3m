#' Get path and file name from resources
#'
#' @return String type.
#' @export
#'
get_pathfile_from_res <- function(res_folder, res_file) {
  file.path(system.file(res_folder, package = "Rb3m"), res_file)
}

#' Build Pandoc argument from resources
#'
#' @return String type.
#' @export
#'
build_parg_from_res <- function(res_name, res_folder, res_file) {
  c(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
}
#' Print tree member of list type
#'
#' @param lst List type. Default = NULL.
#' @param indent_string String type. Default = "".
#' @param list_title String type. Default = "".
#'
#' @return Nothing.
#' @export
#'
print_list <- function(lst = NULL, indent_string = NULL, list_title = NULL) {
  if (length(lst) > 0) {
    if (!is.null(list_title)) message(list_title)
    member_names <- names(lst)
    for (i in 1:length(lst)) {
      if (length(lst[[i]]) > 1 || typeof(lst[[i]]) == "list") {
        message(indent_string, member_names[i], " : ", typeof(lst[[i]]), " = ", length(lst[[i]]), " member(s)")
        print_list(lst[[i]], c("  ", indent_string))
      } else {
        message(indent_string, member_names[i], " : ", typeof(lst[[i]]), " = ", lst[[i]])
      }
    }
  }
}
