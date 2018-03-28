#' Get array type
#'
#' Given an object containing annotation information, the function gets
#' array type which is used by other internal functions.
#'
#' @param x An object containing annotation information
#' @return A character scale of either "EPIC" or "450K"
get_array_type <- function(x) {
  anno_info <- annotation(x)
  if (anno_info["array"] == "IlluminaHumanMethylationEPIC") {
    return("EPIC")
  } else if (anno_info["array"] == "IlluminaHumanMethylation450k") {
    return("450K")
  } else {
    stop("fail to get array type")
  }
}
