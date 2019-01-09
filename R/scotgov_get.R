#' Download data from statistics.gov.scot
#'
#' \code{scotgov_get} returns a tibble of data from statistics.gov.scot
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param dataset The last part of the URI for a dataset on statistics.gov.scot
#' @param start_date Filter data points on or after this date
#' @param end_date Filter data points after this date
#' @param geography An S code - filter data points within this geography
#' @param ... arbitrary filters requiring valid dimension = value structure
#' @return A \code{data.frame} of data from statistics.gov.scot
#'
#' @examples
#' scotgov_get("average-household-size")
#'
#' @export
scotgov_get <- function(dataset,
                        start_date = NULL,
                        end_date = NULL,
                        geography = NULL,
                       ...) {

  if (is.null(start_date) &
      is.null(end_date) &
      is.null(geography)  &
      length(list(...)) == 0) {

  if ("readr" %in% rownames(utils::installed.packages())) {
    #download with readr if available
    result <- tryCatch(
      {readr::read_csv(paste0("https://statistics.gov.scot/downloads/",
                               "cube-table?uri=http%3A%2F%2F",
                               "statistics.gov.scot%2Fdata%2F",
                               dataset))},
      error = function(cond) { ods_error_message(cond, dataset) })


  } else {
    result <- tryCatch(
      {utils::read.csv(paste0("https://statistics.gov.scot/downloads/",
                               "cube-table?uri=http%3A%2F%2F",
                               "statistics.gov.scot%2Fdata%2F",
                               dataset))},
      error = function(cond) { ods_error_message(cond, dataset) })}

  } else {

  endpoint <- "http://statistics.gov.scot/sparql"

  query <- tryCatch({
    get_dataset_query(dataset)},
    error = function(cond) { ods_error_message(cond, dataset) })

  query_data <- tryCatch(
    {SPARQL::SPARQL(endpoint,query)},
    error = function(cond) { ods_error_message(cond, dataset) })

  result <- query_data$results

  }

  return(result)

}
