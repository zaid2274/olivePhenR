#' Map Flowering Date
#'
#' @param tmin_raster SpatRaster of minimum temperatures (12 layers = 12 months)
#' @param tmax_raster SpatRaster of maximum temperatures (12 layers = 12 months)
#' @param tbase Base temperature for GDD calculation (default: 10)
#' @param threshold_flowering GDD threshold for flowering (default: 300)
#'
#' @return A SpatRaster with estimated flowering month
#' @export
#'
#' @examples
#' \dontrun{
#' r_tmin <- load_climate_rasters(source = "worldclim", var = "tmin")
#' r_tmax <- load_climate_rasters(source = "worldclim", var = "tmax")
#' flowering_map <- map_flowering_date(r_tmin, r_tmax)
#' }
map_flowering_date <- function(tmin_raster, tmax_raster,
                               tbase = 10, threshold_flowering = 300) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  # Calcul tmean pour chaque mois
  tmean_raster <- (tmin_raster + tmax_raster) / 2

  # GDD mensuel (approximation 30 jours par mois)
  gdd_monthly <- terra::app(tmean_raster, fun = function(x) {
    pmax(0, x - tbase) * 30
  })

  # Cumul des GDD mois par mois
  nlayers <- terra::nlyr(gdd_monthly)
  gdd_cumul <- gdd_monthly

  for (i in 2:nlayers) {
    gdd_cumul[[i]] <- gdd_cumul[[i-1]] + gdd_monthly[[i]]
  }

  # Mois de floraison = premier mois où GDD cumulé dépasse le seuil
  flowering_month <- terra::app(gdd_cumul, fun = function(x) {
    idx <- which(x >= threshold_flowering)[1]
    if (is.na(idx)) return(NA) else return(idx)
  })

  names(flowering_month) <- "flowering_month"
  return(flowering_month)
}
