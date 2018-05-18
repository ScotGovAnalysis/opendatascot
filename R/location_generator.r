# converts the dimensions from dataset_structure into correct locations for dataset query
# Internal function for scotgov_get

location_generator<-function(name) {

  if (name == 'refArea') {
    text<-'<http://purl.org/linked-data/sdmx/2009/dimension#refArea>'
  } else if (name == 'refPeriod') {
    text<-'<http://purl.org/linked-data/sdmx/2009/dimension#refPeriod>'
  } else if (name == 'measureType') {
    text<-'<http://purl.org/linked-data/cube#measureType>'
  } else {
    text<-paste0('<http://statistics.gov.scot/def/dimension/',name,'>')
  }
  
  return(text)
  
}
