#' Load Climate Rasters
#'
#' @param path Path to the folder containing raster files
#' @param variable Climate variable to load: "tmin" or "tmax" (default: "tmin")
#' @param extent Optional extent to crop the raster (default: NULL)
#'
#' @return A SpatRaster object
#' @export
#'
#' @examples
#' r <- load_climate_rasters(path = "data/rasters", variable = "tmin")
load_climate_rasters <- function(path, variable = "tmin", extent = NULL) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  files <- list.files(path, pattern = paste0(variable, ".*\\.tif$"),
                      full.names = TRUE)
  if (length(files) == 0) stop("Aucun fichier raster trouvé.")

  raster <- terra::rast(files)

  if (!is.null(extent)) {
    ext_obj <- terra::ext(extent)
    raster <- terra::crop(raster, ext_obj)
  }

  return(raster)
}
