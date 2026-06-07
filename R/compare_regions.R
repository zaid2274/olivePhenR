#' Compare Regions
#'
#' @param data_list A named list of climate dataframes (one per region)
#' @param tbase Base temperature for GDD calculation (default: 10)
#' @param flowering_date_col Name of the flowering date column (default: "date")
#'
#' @return A dataframe comparing regions
#' @export
#'
#' @examples
#' regions <- list(Marrakech = df1, Fes = df2)
#' compare_regions(regions)
compare_regions <- function(data_list, tbase = 10, flowering_date_col = "date") {
  results <- lapply(names(data_list), function(region) {
    data <- data_list[[region]]
    data <- calculate_degree_days(data, tbase = tbase)
    data <- calculate_chilling_units(data)
    data <- detect_phenological_stage(data)
    flowering_date <- attr(data, "phenological_dates")$flowering
    frost_risk <- analyze_frost_risk(data, flowering_date = flowering_date)

    data.frame(
      region         = region,
      gdd_total      = max(data$gdd_cumul, na.rm = TRUE),
      chilling_total = max(data$chilling_cumul, na.rm = TRUE),
      flowering_date = as.character(flowering_date),
      frost_risk     = frost_risk$risk_class
    )
  })
  do.call(rbind, results)
}
