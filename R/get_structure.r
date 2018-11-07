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
