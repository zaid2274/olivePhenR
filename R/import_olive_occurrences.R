#' Import Olive Tree Occurrences
#'
#' @param source Source of data: "gbif" or "csv" (default: "csv")
#' @param file Path to CSV file (required if source = "csv")
#' @param lon_col Name of longitude column (default: "longitude")
#' @param lat_col Name of latitude column (default: "latitude")
#'
#' @return An sf object with olive tree occurrences
#' @export
#'
#' @examples
#' occ <- import_olive_occurrences(source = "csv", file = "olives.csv")
import_olive_occurrences <- function(source = "csv", file = NULL,
                                     lon_col = "longitude", lat_col = "latitude") {
  if (!requireNamespace("sf", quietly = TRUE)) stop("Package 'sf' requis.")

  if (source == "csv") {
    if (is.null(file)) stop("Veuillez fournir un fichier CSV.")
    data <- read.csv(file, stringsAsFactors = FALSE)
  } else if (source == "gbif") {
    if (!requireNamespace("rgbif", quietly = TRUE)) stop("Package 'rgbif' requis.")
    raw <- rgbif::occ_search(scientificName = "Olea europaea", limit = 500)
    data <- raw$data[, c("decimalLongitude", "decimalLatitude")]
    colnames(data) <- c("longitude", "latitude")
    lon_col <- "longitude"
    lat_col <- "latitude"
  } else {
    stop("Source non supportée. Utilisez 'csv' ou 'gbif'.")
  }

  data <- data[!is.na(data[[lon_col]]) & !is.na(data[[lat_col]]), ]
  occ_sf <- sf::st_as_sf(data, coords = c(lon_col, lat_col), crs = 4326)
  return(occ_sf)
}
