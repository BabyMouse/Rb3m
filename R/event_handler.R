#' @export
pre_knit_event_handler <- function(r_options) {
  function(input, ...) {
    r_options$download_file_name <- ifelse(is.null(r_options$download_file_name),
      basename(input), r_options$download_file_name
    )
    r_options$download_file_title <- ifelse(is.null(r_options$download_file_title),
      paste0("Download ", basename(input)), r_options$download_file_title
    )
    html_content <- xfun::read_utf8(r_options$navbar_tempfile)
    html_content <- gsub("\\$\\{download_file_name\\}", r_options$download_file_name, html_content)
    html_content <- gsub(
      "\\$\\{download_file_data\\}",
      paste0("data:", mime::guess_type(input), ";base64,", base64enc::base64encode(input)),
      html_content
    )
    html_content <- gsub("\\$\\{download_file_title\\}", r_options$download_file_title, html_content)

    xfun::write_utf8(html_content, con = r_options$navbar_tempfile)
    message("pre_knit:")
    print_list("  - ", list(
      input = input, ... = list(...),
      r_options = r_options
    ))
  }
}
post_knit_event_handler <- function(r_options) {
  function(metadata, input_file, runtime, encoding, ...) {
    message("post_knit:")
    print_list("  - ", list(
      metadata = metadata,
      input_file = input_file, runtime = runtime, ... = list(...),
      r_options = r_options
    ))
  }
}
pre_processor_event_handler <- function() {
  function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    message("pre_processor:")
    print_list("  - ", list(
      metadata = metadata,
      input_file = input_file, runtime = runtime,
      knit_meta = knit_meta,
      files_dir = files_dir, output_dir = output_dir
    ))
  }
}
intermediates_generator_event_handler <- function() {
  function(original_input, intermediates_dir) {
    message("intermediates_generator:")
    print_list("  - ", list(original_input = original_input, intermediates_dir = intermediates_dir))
  }
}
post_processor_event_handler <- function() {
  function(metadata, input_file, output_file, clean, verbose) {
    message("post_processor:")
    print_list(" - ", list(
      metadata = metadata,
      input_file = input_file, output_file = output_file,
      clean = clean, verbose = verbose
    ))
    structure(output_file, post_process_original = TRUE)
  }
}
on_exit_event_handler <- function(r_options) {
  function() {
    message("on_exit:")
    print_list("  - ", list(r_options = r_options))
  }
}
