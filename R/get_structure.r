get_structure <- function(dataset) {
  
  dimension_set <- dataset_dimensions(dataset)
  
  categories <- list()
  
  for(i in 1:length(dimensions_set)) {
    
    categories[i] <- get_categories(dataset, dimension_set[i])
    
  }
  
  result <- list(dimension_set,categories)
  
  return(result)
}
