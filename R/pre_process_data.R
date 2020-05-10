#' Strips all api cruft form returned values
#'
#' \code{pre_process_data} is an internal function for \code{ods_dataset} that returns all unique values of a dataset scheme
#'
#' @param x \code{data.frame}. Dataframe produced by the sparql query.
#'
#' @return \code{data.frame}.
#'
#' @examples
#' pre_process_data(my_query_results)
#'
#' @keywords internal
#'
#' @noRd

pre_process_data <- function(x) {
  # Keep only last elemnt of URI
  x[] <- lapply(
    X = x,
    FUN = function(x) {
      u <- stringr::str_extract(x,'[^/]+$')
      stringr::str_remove(u,'[>]')

      }
    )
  return(x)
}
