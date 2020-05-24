# Uninstall Rb3m package if exist
if (length(find.package("Rb3m", quiet = TRUE)) != 0) {
  devtools::uninstall(pkg = ".")
}
# Remove all document files to rebuild
do.call(file.remove, list(list.files("man", full.names = TRUE)))

devtools::load_all()
devtools::document()

# Build full options to remove unused file and folder
# devtools::install(pkg = ".")
devtools::install(pkg = ".", quick = TRUE)

# Restart R session
#' @seealso: https://stackoverflow.com/questions/15666810/restart-r-within-rstudio
# .rs.api.restartSession()
#
#' @seealso: https://www.rdocumentation.org/packages/startup/versions/0.14.0/topics/restart
# rstudioapi::restartSession()

message(format(Sys.time(), format = "%Y-%m-%d %H:%M:%S"))
