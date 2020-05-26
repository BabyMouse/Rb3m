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
#' @title Merge 2 lists
#' @description
#' Merge 2 lists into 1 list.
#'
#' @param a List type, can \code{unnamed}.
#' @param b List type, will ignore \code{unnamed}.
#'
#' @return Output list type was merged.
#' @export
#'
#' @seealso
#' \itemize{
#'   \item \href{https://github.com/tidyverse/purrr/blob/master/R/list-modify.R}{https://github.com/tidyverse/purrr/blob/master/R/list-modify.R}
#' }
#'
#' @examples
#' l1 <- list(a = T, b = F, d = list(g = 3))
#' l2 <- list(b = T, c = T, d = list(e = 1, f = 2))
#' Rb3m::list_merge(l1, l2)
list_merge <- function(a, b) {
  if (length(a) == 0) {
    return(b)
  }
  if (length(b) == 0) {
    return(a)
  }
  b_names <- names(b)
  for (i in 1:length(b_names)) {
    if (typeof(b[[b_names[i]]]) == "list") {
      a[[b_names[i]]] <- list_merge(a[[b_names[i]]], b[[b_names[i]]])
    } else {
      a[[b_names[i]]] <- b[[b_names[i]]]
    }
  }
  return(a)
}
