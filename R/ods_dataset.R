#' Download a dataset
#'
#' \code{ods_dataset} returns a dataset from \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' \code{ods_dataset} returns either a complete or filtered dataset from \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}.
#' Other parameters can be used to filter the dataset.
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#' @param start_date \code{string}. Filter data points after this date.
#' @param end_date \code{string}. Filter data points before this date.
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
                        start_date = NULL,
                        end_date = NULL,
                        geography = NULL,
                        ...) {

    endpoint <- "http://statistics.gov.scot/sparql"
    query <- ods_print_query(dataset,
                             start_date = NULL,
                             end_date = NULL,
                             geography = NULL,
                             ...)

    query_data <- try(SPARQL::SPARQL(endpoint, query), silent = TRUE)
    if (query_data[1] ==  "Error :
       XML content does not seem to be XML: 'Response too large'\n"){
      stop(Error = "Dataset is too large to be downloaded like this.
         Try adding filters to reduce size")
    }


    result <- query_data$results

  return(result)

}
