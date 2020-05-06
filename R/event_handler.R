#' @export
pre_knit_event_handler <- function() {
  function(input, ...) {
    message("pre_knit:\n", " - input: ", input)
    print_list(" - ", list(...))
    message(" - ...:",...)
  }
}
post_knit_event_handler <- function() {
  function(metadata, input_file, runtime, encoding, ...) {
    message("post_knit:\n", " - metadata: ")
    print_list("   $ ", (metadata))
    print_list(" - ", c(input_file = input_file, runtime = runtime, encoding = encoding))
    print_list(" - ", list(...))
    message(" - ...:",...)
  }
}
pre_processor_event_handler <- function() {
  function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    message("pre_processor:\n", " - metadata: ")
    print_list("   $ ", as.list(metadata))
    message(" - knit_meta: ")
    print_list("   ", as.list(knit_meta))
    print_list(" - ", c(input_file = input_file, runtime = runtime, files_dir = files_dir, output_dir = output_dir))
  }
}
intermediates_generator_event_handler <- function() {
  function(original_input, intermediates_dir) {
    message("intermediates_generator:")
    print_list(" - ", c(original_input = original_input, intermediates_dir = intermediates_dir))
  }
}
post_processor_event_handler <- function() {
  function(metadata, input_file, output_file, clean, verbose) {
    message("post_processor:\n", " - metadata: ")
    print_list("   $ ", as.list(metadata))
    print_list(" - ", c(input_file = input_file, output_file = output_file, clean = clean, verbose = verbose))
    structure(output_file, post_process_original = TRUE)
  }
}
on_exit_event_handler <- function() {
  function() {
    message("on_exit:")
  }
}
