#' Import climate data
#'
#' @param file Path to a CSV or Excel file containing climate data
#' @param date_col Name of the date column (default: "date")
#' @param tmin_col Name of the minimum temperature column (default: "tmin")
#' @param tmax_col Name of the maximum temperature column (default: "tmax")
#'
#' @return A dataframe with daily climate data
#' @export
#'
#' @examples
#' df <- import_climate_data("climate.csv")
import_climate_data <- function(file, date_col = "date", tmin_col = "tmin", tmax_col = "tmax") {
  ext <- tools::file_ext(file)
  if (ext == "csv") {
    data <- read.csv(file, stringsAsFactors = FALSE)
  } else if (ext %in% c("xlsx", "xls")) {
    if (!requireNamespace("readxl", quietly = TRUE)) stop("Package 'readxl' requis.")
    data <- readxl::read_excel(file)
  } else {
    stop("Format non supporté. Utilisez CSV ou Excel.")
  }
  data[[date_col]] <- as.Date(data[[date_col]])
  data$tmean <- (data[[tmin_col]] + data[[tmax_col]]) / 2
  data <- data[!is.na(data[[tmin_col]]) & !is.na(data[[tmax_col]]), ]
  return(data)
}
