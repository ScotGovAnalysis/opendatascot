#' View structure of data from statistics.gov.scot
#'
#' \code{ods_structure} returns a list of data about a dataset from statistics.gov.scot
#'
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param dataset An API endpoint for statistics.gov.scot that corresponds to a dataset
#' @return A list of data from statistics.gov.scot
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
