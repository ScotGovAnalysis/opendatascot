#' Return a list of the structure of a dataset
#'
#' \code{ods_structure} returns a list of data about a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}
#'
#' The \code{dataset} parameter must be passed a valid dataset name (a full list can be obtained by calling \code{ods_all_datasets}.
#'
#' @param dataset \code{string}. The identifying final part of a URI for a dataset on \href{https://statistics.gov.scot/}{statistics.gov.scot}.
#'
#' @return \code{list}. Returns all schemes and concepts within a dataset.
#'
#' @examples
#' ods_structure("average-household-size")
#'
#' @export

ods_structure <- function(dataset) {

  scheme_set <- ods_schemes(dataset)
  names(scheme_set) <- "schemes"

  categories <- list()

  for (i in 1:length(scheme_set[, ])) {

    categories[[i]] <- ods_concepts(dataset, scheme_set[i, ])


  }
  names(categories) <- gsub("[()%]", "", ods_names(scheme_set[, ]))

  result <- list(scheme_set, categories)
  names(result) <- list("schemes", "categories")

  return(result)
}
