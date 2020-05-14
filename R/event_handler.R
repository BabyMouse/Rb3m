#' @export
pre_knit_event_handler <- function(r_options) {
  html_content <- xfun::read_utf8(r_options$navbar_tempfile)
  html_content <- gsub("\\$\\{download_file_name\\}", r_options$download_file_name, html_content)
  html_content <- gsub(
    "\\$\\{download_file_data\\}",
    paste0(
      "data:", mime::guess_type(r_options$pre_knit$source_input), ";base64,",
      base64enc::base64encode(r_options$pre_knit$source_input)
    ),
    html_content
  )
  html_content <- gsub("\\$\\{download_file_title\\}", r_options$download_file_title, html_content)

  xfun::write_utf8(html_content, con = r_options$navbar_tempfile)
  print_list(r_options, "  - ", "pre_knit:")
}
post_knit_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "post_knit:")
}
pre_processor_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "pre_processor:")
}
intermediates_generator_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "intermediates_generator:")
}
post_processor_event_handler <- function() {
  function(metadata, input_file, output_file, clean, verbose) {
    print_list(list(
      metadata = metadata,
      input_file = input_file, output_file = output_file,
      clean = clean, verbose = verbose
    ), " - ", "post_processor:")
    structure(output_file, post_process_original = TRUE)
  }
}
on_exit_event_handler <- function(r_options) {
  print_list(r_options, "  - ", "on_exit:")
}
