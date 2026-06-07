#' Map Flowering Date
#'
#' @param tmin_raster SpatRaster of minimum temperatures
#' @param tmax_raster SpatRaster of maximum temperatures
#' @param tbase Base temperature for GDD calculation (default: 10)
#' @param threshold_flowering GDD threshold for flowering (default: 300)
#'
#' @return A SpatRaster with estimated flowering dates (day of year)
#' @export
#'
#' @examples
#' r_tmin <- load_climate_rasters(path = "data/rasters", variable = "tmin")
#' r_tmax <- load_climate_rasters(path = "data/rasters", variable = "tmax")
#' flowering_map <- map_flowering_date(r_tmin, r_tmax)
map_flowering_date <- function(tmin_raster, tmax_raster,
                               tbase = 10, threshold_flowering = 300) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  tmean_raster <- (tmin_raster + tmax_raster) / 2
  gdd_raster   <- terra::app(tmean_raster, fun = function(x) pmax(0, x - tbase))
  gdd_cumul    <- terra::app(gdd_raster, fun = cumsum)

  flowering_doy <- terra::app(gdd_cumul, fun = function(x) {
    idx <- which(x >= threshold_flowering)[1]
    if (is.na(idx)) return(NA) else return(idx)
  })

  return(flowering_doy)
}
