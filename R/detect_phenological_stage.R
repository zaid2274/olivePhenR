#' Detect Phenological Stages
#'
#' @param data A dataframe with cumulative GDD (output of calculate_degree_days)
#' @param gdd_col Name of the cumulative GDD column (default: "gdd_cumul")
#' @param threshold_budburst GDD threshold for budburst (default: 150)
#' @param threshold_flowering GDD threshold for flowering (default: 300)
#' @param threshold_fruiting GDD threshold for fruiting (default: 500)
#'
#' @return A dataframe with detected phenological stages and dates
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
#' gdd <- calculate_degree_days(df)
#' stages <- detect_phenological_stage(gdd)
detect_phenological_stage <- function(data, gdd_col = "gdd_cumul",
                                      threshold_budburst = 150,
                                      threshold_flowering = 300,
                                      threshold_fruiting = 500) {
  data$stage <- "dormance"
  data$stage[data[[gdd_col]] >= threshold_budburst] <- "debourrement"
  data$stage[data[[gdd_col]] >= threshold_flowering] <- "floraison"
  data$stage[data[[gdd_col]] >= threshold_fruiting] <- "fructification"

  dates <- list(
    budburst   = data$date[which(data[[gdd_col]] >= threshold_budburst)[1]],
    flowering  = data$date[which(data[[gdd_col]] >= threshold_flowering)[1]],
    fruiting   = data$date[which(data[[gdd_col]] >= threshold_fruiting)[1]]
  )

  attr(data, "phenological_dates") <- dates
  return(data)
}
