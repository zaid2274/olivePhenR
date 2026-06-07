#' Plot Phenology Curves
#'
#' @param data A dataframe with GDD and chilling units
#' @param gdd_col Name of cumulative GDD column (default: "gdd_cumul")
#' @param chilling_col Name of cumulative chilling units column (default: "chilling_cumul")
#' @param date_col Name of date column (default: "date")
#'
#' @return A ggplot object
#' @export
#'
#' @examples
#' df <- calculate_degree_days(import_climate_data("climate.csv"))
#' plot_phenology_curves(df)
plot_phenology_curves <- function(data, gdd_col = "gdd_cumul",
                                  chilling_col = "chilling_cumul",
                                  date_col = "date") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) stop("Package 'ggplot2' requis.")

  p <- ggplot2::ggplot(data, ggplot2::aes(x = .data[[date_col]])) +
    ggplot2::geom_line(ggplot2::aes(y = .data[[gdd_col]], color = "Degres-jours")) +
    ggplot2::geom_line(ggplot2::aes(y = .data[[chilling_col]], color = "Chilling units")) +
    ggplot2::labs(title = "Courbes phenologiques de l'olivier",
                  x = "Date", y = "Cumul", color = "Variable") +
    ggplot2::theme_minimal()
  return(p)
}
