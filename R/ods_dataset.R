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
#' @inheritParams ods_print_query
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
                        labelled = TRUE,
                        ...) {

    endpoint <- "http://statistics.gov.scot/sparql"

    #tryCatch({
     query <- ods_print_query(dataset, geography, labelled,
         ...)

    offset <- 0
    paginated_query <- paste(query, " LIMIT 10000 OFFSET", format(offset, scientific=FALSE))
    query_data <- ods_query_database(endpoint, paginated_query)

    if(nrow(query_data == 10000)) {
      print("large dataset, return may take a while")
      returned_data <- query_data
      while (nrow(returned_data) == 10000) {
          offset <- offset + 10000
          #print(paste("iter:", offset/10000))
          if (offset > 10000000) { break }# Exit the loop if suspected infinite
          paginated_query <- paste(query, " LIMIT 10000 OFFSET", format(offset, scientific=FALSE))
          returned_data <- ods_query_database(query = paginated_query)
          query_data <- rbind(query_data, returned_data)
        }
      }
     #   },
     #   error = function(err) {
     #     ods_error_message(err, dataset)
     #   },
     #   warning = function(warn) {
     #     ods_error_message(warn, dataset)
     #   })
     #
     #   },
     #   error = function(err) {
     #     ods_error_message(err, dataset)
     #   },
     #   warning = function(warn) {
     #     ods_error_message(warn, dataset)
     #   })
if(labelled){
 result <- ods_label_dataset(query_data)
} else {
 result <- pre_process_data(query_data)
}

  return(result)

}
