#' Plot Risk Maps
#'
#' @param raster A SpatRaster to plot
#' @param title Title of the map (default: "Carte phenologique")
#' @param export_path Optional path to export PNG/PDF (default: NULL)
#'
#' @return A plot
#' @export
#'
#' @examples
#' plot_risk_maps(flowering_map, title = "Date de floraison")
plot_risk_maps <- function(raster, title = "Carte phenologique", export_path = NULL) {
  if (!requireNamespace("terra", quietly = TRUE)) stop("Package 'terra' requis.")

  if (!is.null(export_path)) {
    ext <- tools::file_ext(export_path)
    if (ext == "pdf") pdf(export_path) else png(export_path)
  }

  terra::plot(raster, main = title, col = grDevices::hcl.colors(100, "YlOrRd"))

  if (!is.null(export_path)) dev.off()
}
