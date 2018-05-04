#' Download data from statistics.gov.scot
#'
#' \code{scotgov_get} returns a tibble of data from statistics.gov.scot
#'
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param endpoint An API endpoint for statistics.gov.scot
#' @return A tibble of data from statistics.gov.scot
#'
#' @examples
#' scotgov_get("http://statistics.gov.scot/sparql")
scotgov_get <- function(endpoint = "http://statistics.gov.scot/sparql") {}
