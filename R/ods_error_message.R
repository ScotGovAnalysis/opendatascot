# Returns custom error message on failure
#'
#' \code{ods_error_message} is an internal function for \code{ods_dataset} that returns a custom error message depending on failure type
#'
#' @param dataset \code{cond}. The original error message produced by the failure in \code{ods_dataset}.
#' @param scheme \code{dataset}. The name of the dataset passed as a parameter to \code{ods_dataset}.
#'
#' @return \code{string} and \code{null}.
#'
#' @examples
#' ods_error_message(cond, dataset)
#'
#' @keywords internal
#'
#' @noRd

ods_error_message <- function(cond, dataset) {

  # Check internet connection is working
  if (is.null(curl::nslookup("r-project.org", error = FALSE))) {
    message("DNS lookup failed. Check internet connection.")

  } else {

    paste("Original error message: ", cond, ". ", dataset, sep = "")

    # original_error <- paste("Original error message: ", cond, sep = "")
    # unknown_error <- paste("There was an unknown error in the generated query; possibly an error in the dataset name provided.\nThe dataset name provided was: '",
    #                        dataset,
    #                        "'.\nCompare with existing datasets using 'ods_all_datasets()'.",
    #                        sep = "")
    #
    # if (grepl("Response too large", cond, fixed = TRUE) == TRUE) {
    #   message("Dataset '", dataset, "' is too large to be downloaded in its entirety.\nTry adding filters to reduce size.")
    # } else if (grepl("There was a syntax error in your query", cond, fixed = TRUE) == TRUE) {
    #   message(unknown_error)
    # } else if (grepl("cannot open the connection", cond, fixed = TRUE) == TRUE) {
    #   message(unknown_error)
    # } else {
    #   message(original_error)
    # }
  }
}
