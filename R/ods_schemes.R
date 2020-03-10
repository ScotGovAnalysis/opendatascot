#' Return the schemes used by a dataset
#'
#' \code{ods_schemes} returns all schemes used by a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets()}).
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#'
#' @return \code{data.frame}. All schemes used by the dataset named in the dataset argument.
#'
#' @examples
#' ods_schemes("average-household-size")
#'
#' @export

ods_schemes <- function(dataset) {

  if(grepl(" ", dataset)) {
    stop("Blanks space detected in requested dataset name, replace with a dash '-' for a valid dataset name")
  }

  endpoint <- "http://statistics.gov.scot/sparql"

  query_text <- read_query_file("schemes")
  query <- glue::glue(query_text, dataset = dataset, .open = "[", .close = "]")
  query_data <- ods_query_database(endpoint, query)
  query_filter <- query_data[query_data$componentProperty == "http://purl.org/linked-data/cube#dimension", ]
  result <- query_filter$componentReference

  if(length(result) == 0) {
    stop("No schemes detected for this dataset. Dataset may not be convertable to a dataframe, or the name may be spelled incorrectly")
  }

  return(result)
}
