#' Calculate Chilling Units
#'
#' @param data A dataframe with climate data (output of import_climate_data)
#' @param tmin_col Name of the minimum temperature column (default: "tmin")
#' @param tmax_col Name of the maximum temperature column (default: "tmax")
#' @param tmin_chill Minimum temperature for chilling (default: 0)
#' @param tmax_chill Maximum temperature for chilling (default: 7.2)
#'
#' @return A dataframe with daily and cumulative chilling units
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
#' cu <- calculate_chilling_units(df)
calculate_chilling_units <- function(data, tmin_col = "tmin", tmax_col = "tmax",
                                     tmin_chill = 0, tmax_chill = 7.2) {
  tmean <- (data[[tmin_col]] + data[[tmax_col]]) / 2
  data$chilling_units <- ifelse(tmean >= tmin_chill & tmean <= tmax_chill, 1, 0)
  data$chilling_cumul <- cumsum(data$chilling_units)
  return(data)
}
