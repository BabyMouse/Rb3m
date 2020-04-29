#xfun::pkg_load2("knitr", "rmarkdown")
#' @import knitr

# ref: https://github.com/yihui/knitr/blob/master/R/engine.R
knitr::knit_engines$set(html = function(options) {
  knitr::engine_output(options, options$code, "")
})

#source(system.file("R", "source_embed.R", package = "Rb3m"))
# knitr::spin('source_embed.R')

# after_body<-c("_includes/body_suffix.html")
# rmarkdown::pandoc_include_args(after_body = after_body)
