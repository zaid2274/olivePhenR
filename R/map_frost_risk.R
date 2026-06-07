#' Map Frost Risk
#'
#' @param tmin_raster SpatRaster of minimum temperatures
#' @param flowering_raster SpatRaster of flowering dates (output of map_flowering_date)
#' @param frost_threshold Temperature threshold for frost (default: 0)
#'
#' @return A SpatRaster with frost risk index
#' @export
#'
#' @examples
#' risk_map <- map_frost_risk(r_tmin, flowering_map)
map_frost_risk <- function(tmin_raster, flowering_raster, frost_threshold = 0) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  frost_mask <- terra::app(tmin_raster, fun = function(x) {
    as.integer(x <= frost_threshold)
  })

  frost_risk <- frost_mask * (1 / (flowering_raster + 1))
  frost_risk <- terra::classify(frost_risk, matrix(c(
    0,   0.01, 1,
    0.01, 0.1, 2,
    0.1,  Inf, 3
  ), ncol = 3, byrow = TRUE))

  return(frost_risk)
}
