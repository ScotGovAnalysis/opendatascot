# small function to transform sparql location to a simple name
# can be removed when dataset_structure and dataset_measures return clear labels
# internal function for scotgov_get

get_names<- function(dataset) {
  pattern<-'[/#][%A-Za-z0-9()-]+>'
  regexpr_result<-regexpr(pattern,dataset)
  result<-substr(dataset,regexpr_result+1,regexpr_result+attr(regexpr_result,"match.length")-2)
  
  return(result)
  
}  
