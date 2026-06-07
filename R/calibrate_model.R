#' Calibrate Phenological Model
#'
#' @param data A dataframe with climate data (output of import_climate_data)
#' @param observed_dates A named list with observed phenological dates
#' @param tbase_range Range of base temperatures to test (default: seq(5, 15, by = 1))
#' @param threshold_range Range of GDD thresholds to test (default: seq(100, 500, by = 50))
#'
#' @return A list with optimized parameters
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
#' observed <- list(flowering = as.Date("2023-04-15"))
#' params <- calibrate_model(df, observed)
calibrate_model <- function(data, observed_dates,
                            tbase_range = seq(5, 15, by = 1),
                            threshold_range = seq(100, 500, by = 50)) {
  best_rmse <- Inf
  best_params <- list(tbase = NA, threshold = NA)

  for (tbase in tbase_range) {
    for (threshold in threshold_range) {
      data_gdd <- calculate_degree_days(data, tbase = tbase)
      pred_date <- data_gdd$date[which(data_gdd$gdd_cumul >= threshold)[1]]

      if (!is.na(pred_date) && !is.null(observed_dates$flowering)) {
        rmse <- abs(as.numeric(pred_date - observed_dates$flowering))
        if (rmse < best_rmse) {
          best_rmse <- rmse
          best_params <- list(tbase = tbase, threshold = threshold)
        }
      }
    }
  }

  return(best_params)
}
