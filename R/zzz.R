# ref: https://r-pkgs.org/r.html

.onLoad <- function(libname, pkgname) {
  #packageStartupMessage(".onLoad: ...")
  #suppressPackageStartupMessages(Rb3m())
  #suppressMessages(Rb3m())
  message(".onLoad: libname = ",libname,"; pkgname = ",pkgname)
  #invisible()
}

.onAttach <- function(libname, pkgname) {
  #packageStartupMessage(".onAttach: ...")
  #suppressPackageStartupMessages(Rb3m())
  #suppressMessages(Rb3m())
  message(".onAttach: libname = ",libname,"; pkgname = ",pkgname)
  #invisible()
}

.onUnload <- function(libpath){
  message(".onUnload:",libpath)
}
.onDetach <- function(libpath){
  message(".onDetach:",libpath)
}
