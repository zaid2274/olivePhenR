#' Analyze Frost Risk
#'
#' @param data A dataframe with climate data (output of import_climate_data)
#' @param flowering_date Estimated flowering date (as.Date)
#' @param tmin_col Name of the minimum temperature column (default: "tmin")
#' @param frost_threshold Temperature threshold for frost (default: 0)
#' @param window_days Number of days after flowering to check (default: 30)
#'
#' @return A list with frost risk index and class
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
#' risk <- analyze_frost_risk(df, flowering_date = as.Date("2023-04-15"))
analyze_frost_risk <- function(data, flowering_date, tmin_col = "tmin",
                               frost_threshold = 0, window_days = 30) {
  end_date <- flowering_date + window_days
  window_data <- data[data$date >= flowering_date & data$date <= end_date, ]

  frost_days <- sum(window_data[[tmin_col]] <= frost_threshold, na.rm = TRUE)
  frost_freq <- frost_days / window_days

  risk_class <- dplyr::case_when(
    frost_freq == 0              ~ "faible",
    frost_freq <= 0.2            ~ "moyen",
    TRUE                         ~ "eleve"
  )

  return(list(
    frost_days  = frost_days,
    frost_freq  = frost_freq,
    risk_class  = risk_class,
    window_data = window_data
  ))
}
