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

    original_error <- paste("Error message: ", cond, sep = "")

    # Dataset does not exist
    if ((grepl("404 Not Found", cond, fixed = TRUE) == TRUE) |
        (grepl("'There was a syntax error in your query: Encountered \" \".\" \". \"\""
               , cond
               , fixed = TRUE) == TRUE)) {
      stop("The dataset '"
              , dataset
              , "' does not exist.\nA full list of available datsets can be found by running 'ods_all_datasets()'.")

    # Spaces in dataset
    } else if ((grepl("HTTP status was '400 Bad Request'", cond, fixed = TRUE) == TRUE) |
               (grepl("'There was a syntax error in your query: Encountered \" \"<\" \"< \"\""
                      , cond
                      , fixed = TRUE) == TRUE)) {
      stop("The query generated from the dataset '"
              , dataset
              , "' produced a syntax error, possibly a result of spaces in the dataset name.\nA full list of available datsets can be found by running 'ods_all_datasets()'.")

    # Response too large
    } else if ((grepl("Response too large", cond, fixed = TRUE) == TRUE) |
               (grepl("HTTP status was '500 Internal Server Error'"
                      , cond
                      , fixed = TRUE) == TRUE) |
               (grepl("TimeoutException: reached elapsed time limit"
                      , cond
                      , fixed = TRUE) == TRUE) |
               (grepl("XML content does not seem to be XML: 'Request Timeout'"
                      , cond
                      , fixed = TRUE) == TRUE)) {
      stop("The dataset '"
              , dataset
              , "' is too large to be downloaded directly.\nTry adding filters to reduce size or contact statistics.enquiries@gov.scot if you require the full dataset.")
    # Handle other errors
    } else {
      stop("An unknown error has occurred. The original error message was: ", original_error)
      }
   }
}
