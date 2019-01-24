# Returns custom error message on failure for ods_dataset()
# internal function for ods_dataset()
#' @noRd

ods_error_message <- function(cond, dataset) {

  # Check internet connection is working
  if (is.null(curl::nslookup("r-project.org", error = FALSE))) {
    message("DNS lookup failed. Check internet connection.")

  } else {

    original_error <- paste("Original error message: ", cond, sep = "")
    unknown_error <- paste("There was an unknown error in the generated query; possibly an error in the dataset name provided.\nThe dataset name provided was: '",
                           dataset,
                           "'.\nCompare with existing datasets using 'ods_all_datasets()'.",
                           sep = "")

    # Errors if using readr
    if (grepl("HTTP error 400", cond, fixed = TRUE) == TRUE) {
      message(unknown_error)
      message(original_error)
    } else if (grepl("404", cond, fixed = TRUE) == TRUE) {
      message(paste("The dataset '",
                    dataset,
                    "' does not exist.\nCompare with existing datasets using 'ods_all_datasets()'.",
                    sep = ""))
      message(original_error)
    } else if (grepl("HTTP error 406", cond, fixed = TRUE) == TRUE) {
      message(unknown_error)
      message(original_error)
    } else if (grepl("HTTP error 500", cond, fixed = TRUE) == TRUE) {
      message(unknown_error)
      message(original_error)
    } else if (grepl("HTTP error 503", cond, fixed = TRUE) == TRUE) {
      message("The query has timed out.")
      message(original_error)
    }

    # Errors if using utils::readcsv or filters
    else if (grepl("Response too large", cond, fixed = TRUE) == TRUE) {
      message("Dataset '", dataset, "' is too large to be downloaded in its entirety.\nTry adding filters to reduce size.")
    } else if (grepl("There was a syntax error in your query", cond, fixed = TRUE) == TRUE) {
      message(unknown_error)
    } else if (grepl("cannot open the connection", cond, fixed = TRUE) == TRUE) {
      message(unknown_error)
    } else {
      message(original_error)
    }
  }
}
