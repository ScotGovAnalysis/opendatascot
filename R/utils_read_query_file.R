#' @title Read SPARQL Query File
#'
#' @description The function searches package content and selects \code{sparql}
#'   file matching \code{x}. The file name can be passed with or without
#'   \code{sparql} extension.
#'
#' @details The function is used internally and it's not exported. In addition
#'   to getting the file name the function does minor pre-processing on the file
#'   like removing the comments.
#'
#' @param x Name of SPARQL file to source.
#'
#' @rdname utilities
#'
#' @return A character scalar.
#'
#' @examples
#' read_query_file(x = "find_lower_geographies")
read_query_file <- function(x) {
  # Check that passed argument is scalar string
  checkmate::assert_string(x = x,
                na.ok = FALSE,
                null.ok = FALSE)

  if (!grepl(
    x = x,
    pattern = ".*sparql$",
    ignore.case = TRUE,
    perl = TRUE
  )) {
    x <- paste0(x, ".sparql")
  }

  query_file <-
    system.file("sparql", x, package = "opendatascot", mustWork = TRUE)
  qyery_text <- readLines(con = query_text, warn = FALSE, skipNul = TRUE)

  # Since you already have stringr
  # TODO:
  # - read collapse lines,
  # - clean commented lines
  # qyery_text <- str_replace_all(qyery_text, "[\r\n]" , "")


}
