#' Map Frost Risk
#'
#' @param tmin_raster SpatRaster of minimum temperatures (12 layers = 12 months)
#' @param flowering_raster SpatRaster of flowering months (output of map_flowering_date)
#' @param frost_threshold Temperature threshold for frost (default: 0)
#'
#' @return A SpatRaster with frost risk class (1=faible, 2=moyen, 3=eleve)
#' @export
#'
#' @examples
#' \dontrun{
#' r_tmin <- load_climate_rasters(source = "worldclim", var = "tmin")
#' r_tmax <- load_climate_rasters(source = "worldclim", var = "tmax")
#' flowering_map <- map_flowering_date(r_tmin, r_tmax)
#' risk_map <- map_frost_risk(r_tmin, flowering_map)
#' }
map_frost_risk <- function(tmin_raster, flowering_raster, frost_threshold = 0) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  # Pour chaque pixel, récupérer le mois de floraison
  # et vérifier si la tmin de ce mois est sous le seuil de gel
  frost_risk <- terra::app(
    c(tmin_raster, flowering_raster),
    fun = function(x) {
      n_months <- length(x) - 1
      tmin_vals <- x[1:n_months]
      flowering_month <- x[n_months + 1]

      if (is.na(flowering_month)) return(NA)

      month_idx <- round(flowering_month)
      if (month_idx < 1 || month_idx > n_months) return(NA)

      tmin_flowering <- tmin_vals[month_idx]

      if (is.na(tmin_flowering)) return(NA)
      if (tmin_flowering > 2)    return(1)  # faible
      if (tmin_flowering >= 0)   return(2)  # moyen
      return(3)                              # eleve
    }
  )

  names(frost_risk) <- "frost_risk"
  return(frost_risk)
}
