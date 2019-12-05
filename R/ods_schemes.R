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
  endpoint <- "http://statistics.gov.scot/sparql"
  query <- paste0("PREFIX qb: <http://purl.org/linked-data/cube#>
    SELECT ?componentProperty ?componentReference
    WHERE {
      <http://statistics.gov.scot/data/", dataset,
                  "> qb:structure ?structure. #selects the structure of the dataset
      ?structure qb:component ?value.",
                  " #exposes the components of the dataset as value
      ?value ?componentProperty ?componentReference .
      }"
  )
  query_data <- ods_query_database(endpoint, query)

  query_filter <- query_data[query_data$componentProperty == "http://purl.org/linked-data/cube#dimension", ]

  result <- query_filter$componentReference

  return(data.frame(result))
}
