# small function to transform sparql location to a simple name
# can be removed when dataset_structure and dataset_measures return clear labels
# internal function for ods_dataset
#' @noRd

ods_names <- function(dataset) {

  pattern <- "[/#][,&'%A-Za-z0-9()-]+$"

  regexpr_result <- regexpr(pattern, dataset)

  result <- substr(dataset,
                   regexpr_result + 1,
                   regexpr_result + attr(regexpr_result,
                                         "match.length") - 1)

  return(result)

}
