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
#' @param file_name Name of SPARQL file to source.
#'
#' @rdname utilities
#'
#' @return A character scalar.

read_query_file <- function(file_name) {
  # Check that passed argument is scalar string
  checkmate::assert_string(x = file_name,
                           na.ok = FALSE,
                           null.ok = FALSE)

  if (!grepl(
    x = file_name,
    pattern = ".*sparql$",
    ignore.case = TRUE,
    perl = TRUE
  )) {
    x <- paste0(file_name, ".sparql")
  }

  query_file <-
    system.file("SPARQL", x, package = "opendatascot", mustWork = TRUE)
  query_text <-
    readLines(con = query_file,
              warn = FALSE,
              skipNul = TRUE)
  # Remove comments
  query_text <-
    query_text[grep(
      pattern = "^(\\s*|)#",
      x = query_text,
      perl = TRUE,
      invert = TRUE
    )]

  # Collapse lines
  query_text <- paste(query_text, collapse = " ")

  # Return completed file
  return(query_text)
}
