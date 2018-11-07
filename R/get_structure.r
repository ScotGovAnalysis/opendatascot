#' View structure of data from statistics.gov.scot
#'
#' \code{get_structure} returns a list of data about a dataset from statistics.gov.scot
#'
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param endpoint An API endpoint for statistics.gov.scot
#' @return A list of data from statistics.gov.scot
#'
#' @examples
#' get_structure("average-household-size")
#'
#' @export

get_structure <- function(dataset) {

  dimension_set <- dataset_dimensions(dataset)
  names(dimension_set) <- "dimensions"

  categories <- list()

  for(i in 1:length(dimension_set[,])) {

    categories[[i]] <- get_categories(dataset, dimension_set[i,])


  }
  names(categories) <- get_names(dimension_set[,])

  result <- list(dimension_set,categories)
  names(result) <- list("dimensions","categories")

  return(result)
}
