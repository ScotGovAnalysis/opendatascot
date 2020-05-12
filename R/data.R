#' @title Geographic Lookup Data
#'
#' @description A simple lookup data set linking data zones to high-level
#'   geographies across Scotland. The included geographies account for 2001 and
#'   2011 data zones.
#'
#' @details Data zone geographies are periodically reviewed in order to
#'   accommodate for population flows. Usually, this is done following
#'   availability of new census data. In order to minimise size of the data set
#'   only the closest match of with the 2001 data zone was kept.
#'
#' @format A data frame with the following variables:
#' \itemize{
#'   \item{Datazones:}
#'      \itemize{
#'        \item{\code{datazone_2001}}{ - 2001 data zone code}
#'        \item{\code{datazone_2011}}{ - 2011 data zone code}
#'   }
#'   \item{Higher geographies:}
#'      \itemize{
#'        \item{\code{InterZone}}{ - Intermediate Geography Zone 2011}
#'        \item{\code{MMWard}}{ -  Multi-Member Ward}
#'        \item{\code{Council}}{ - Local Authority Code}
#'        \item{\code{SPConst}}{ - Scottish Parliament Constituency}
#'        \item{\code{CHP}{ - Community Health Partnership}
#'        \item{\code{HBCode}}{ - Health Board Area}
#'        \item{\code{la_name}}{ - Local Authority Name}
#'      }
#' }
#' @source
#' \emph{Scottish Government,} 2015. \href{https://www2.gov.scot/Topics/Statistics/sns/SNSRef/DZMatchingFile}{Data Zone Matching File (Area and Pop. based 2001 - 2011)}
#' \emph{Scottish Government,} 2014. \href{https://www2.gov.scot/Topics/Statistics/sns/SNSRef/DZ2011Lookups}{Data Zone and Intermediate Zone 2011 Lookups}
"geo_lookup"
