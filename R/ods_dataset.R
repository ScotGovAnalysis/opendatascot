#' Download a dataset
#'
#' \code{ods_dataset} returns a dataset from \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' \code{ods_dataset} returns either a complete or filtered dataset from \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}.
#' Other parameters can be used to filter the dataset.
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' @param geography \code{string}. A valid SG geography code, or portion thereof.
#' @param ... Arbitrary filters requiring valid scheme = value structure.
#'
#' @return \code{tibble}.
#' When invalid arguments are used returns \code{NULL} with \code{warning} (see \code{ods_error_message}).
#'
#' @examples
#' ods_dataset("average-household-size")
#'
#' @export

ods_dataset <- function(dataset,
                        geography = NULL,
                        ...) {

    endpoint <- "http://statistics.gov.scot/sparql"

    query <- tryCatch({
      ods_print_query(dataset,
        geography,
        ...)
      },
      error = function(err) {
        ods_error_message(err, dataset)
      },
      warning = function(warn) {
        ods_error_message(warn, dataset)
      })

    query_data <- tryCatch({
      SPARQL::SPARQL(endpoint, query)
      },
      error = function(err) {
        ods_error_message(err, dataset)
      },
      warning = function(warn) {
        ods_error_message(warn, dataset)
      })

    result <- pre_process_data(query_data$results)

  return(result)

}
