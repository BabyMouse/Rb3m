get_pathfile_from_res <- function(res_folder, res_file) {
  file.path(system.file(res_folder, package = "Rb3m"), res_file)
}

build_parg_from_res <- function(res_name, res_folder, res_file) {
  c(res_name, file.path(system.file(res_folder, package = "Rb3m"), res_file))
}
print_list <- function(indent_tring = "", list) {
  names <- names(list)
  for (name in names) {
    message(indent_tring, name, "(", typeof(name), ") = ", list[name])
  }
}
