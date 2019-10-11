pre_process_data <- function(x) {
  # Keep only last elemnt of URI
  x[] <- lapply(
    X = x,
    FUN = function(x) {
      u <- str_extract(x,'[^/]+$')
      str_sub(u, 1, str_length(u)-1)
      }
    )
  return(x)
}
