#' Load Sentinel-2 Data via Copernicus STAC
#'
#' @param start_date Start date for data search (format: "YYYY-MM-DD")
#' @param end_date End date for data search (format: "YYYY-MM-DD")
#' @param extent Vector c(xmin, ymin, xmax, ymax) for the study area
#' @param max_cloud Maximum cloud cover percentage (default: 20)
#'
#' @return A dataframe with available Sentinel-2 scenes information
#' @export
#'
#' @examples
#' \dontrun{
#' extent_maroc <- c(-13, 27, -1, 36)
#' scenes <- load_sentinel_data(
#'   start_date = "2023-03-01",
#'   end_date   = "2023-04-30",
#'   extent     = extent_maroc
#' )
#' }
load_sentinel_data <- function(start_date, end_date,
                               extent = c(-13, 27, -1, 36),
                               max_cloud = 20) {
  if (!requireNamespace("rstac", quietly = TRUE)) stop("Package 'rstac' requis.")

  # Connexion au catalogue Copernicus STAC
  stac_url <- "https://earth-search.aws.element84.com/v1"
  stac_obj <- rstac::stac(stac_url)

  # Recherche des scènes Sentinel-2
  items <- rstac::stac_search(
    q           = stac_obj,
    collections = "sentinel-2-l2a",
    bbox        = extent,
    datetime    = paste0(start_date, "/", end_date),
    limit       = 10
  ) |> rstac::get_request()

  # Filtrage par couverture nuageuse
  scenes <- rstac::items_filter(
    items,
    filter_fn = function(x) {
      x$properties$`eo:cloud_cover` <= max_cloud
    }
  )

  cat("Nombre de scènes disponibles :", rstac::items_length(scenes), "\n")

  # Extraction des informations des scènes
  scenes_info <- data.frame(
    id          = sapply(scenes$features, function(x) x$id),
    date        = sapply(scenes$features, function(x) x$properties$datetime),
    cloud_cover = sapply(scenes$features,
                         function(x) x$properties$`eo:cloud_cover`)
  )

  return(scenes_info)
}
