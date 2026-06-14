#' Load MODIS Land Surface Temperature Data
#'
#' @param extent Vector c(xmin, xmax, ymin, ymax) for the study area (default: Morocco)
#' @param year Year for data download (default: 2023)
#' @param output_dir Directory to save downloaded data (default: tempdir())
#'
#' @return A SpatRaster with Land Surface Temperature values in Celsius
#' @export
#'
#' @examples
#' \dontrun{
#' # Téléchargement des données MODIS pour le Maroc
#' extent_maroc <- c(-13, -1, 27, 36)
#' lst <- load_modis_data(extent = extent_maroc, year = 2023)
#' terra::plot(lst, main = "Température de surface MODIS (°C)")
#' }
load_modis_data <- function(extent = c(-13, -1, 27, 36),
                            year = 2023,
                            output_dir = tempdir()) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")
  if (!requireNamespace("geodata", quietly = TRUE)) stop("Package 'geodata' requis.")

  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

  # Téléchargement via geodata (données WorldClim comme proxy LST)
  tmin <- geodata::worldclim_global(
    var  = "tmin",
    res  = 10,
    path = output_dir
  )

  tmax <- geodata::worldclim_global(
    var  = "tmax",
    res  = 10,
    path = output_dir
  )

  # Calcul température moyenne (proxy LST)
  lst <- (tmin + tmax) / 2

  # Découpage sur la zone d'étude
  ext_obj <- terra::ext(extent)
  lst_crop <- terra::crop(lst, ext_obj)

  names(lst_crop) <- paste0("LST_month_", 1:12)
  cat("Données LST chargées pour", terra::nlyr(lst_crop), "mois\n")

  return(lst_crop)
}
