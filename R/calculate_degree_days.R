#' Calculate Growing Degree Days (GDD)
#'
#' @param data A dataframe with climate data (output of import_climate_data)
#' @param tbase Base temperature for GDD calculation (default: 10)
#' @param tmin_col Name of the minimum temperature column (default: "tmin")
#' @param tmax_col Name of the maximum temperature column (default: "tmax")
#'
#' @return A dataframe with daily and cumulative GDD
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
#' gdd <- calculate_degree_days(df)
calculate_degree_days <- function(data, tbase = 10, tmin_col = "tmin", tmax_col = "tmax") {
  data$gdd <- pmax(0, (data[[tmax_col]] + data[[tmin_col]]) / 2 - tbase)
  data$gdd_cumul <- cumsum(data$gdd)
  return(data)
}
