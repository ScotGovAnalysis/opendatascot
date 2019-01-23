#' Download data from statistics.gov.scot
#'
#' \code{ods_dataset} returns a tibble of data from statistics.gov.scot
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
#' @param ... arbitrary filters requiring valid scheme = value structure
#' @return A \code{data.frame} of data from statistics.gov.scot
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

  if (is.null(start_date) &
      is.null(end_date) &
      is.null(geography)  &
      length(list(...)) == 0) {

    if ("readr" %in% rownames(utils::installed.packages())) {
      #download with readr if available
      result <- readr::read_csv(paste0("https://statistics.gov.scot/downloads/",
                                       "cube-table?uri=http%3A%2F%2F",
                                       "statistics.gov.scot%2Fdata%2F",
                                       dataset))
    } else {
      result <- utils::read.csv(paste0("https://statistics.gov.scot/downloads/",
                                       "cube-table?uri=http%3A%2F%2F",
                                       "statistics.gov.scot%2Fdata%2F",
                                       dataset))
    }

  } else {

    endpoint <- "http://statistics.gov.scot/sparql"
    query <- ods_print_query(dataset,
                             start_date = NULL,
                             end_date = NULL,
                             geography = NULL,
                             ...)

    query_data <- try(SPARQL::SPARQL(endpoint, query), silent = TRUE)
    if ( query_data[1] ==  "Error :
       XML content does not seem to be XML: 'Response too large'\n"){
      stop(Error = "Dataset is too large to be downloaded like this.
         Try adding filters to reduce size")
    }


    result <- query_data$results

  }

  return(result)

}
