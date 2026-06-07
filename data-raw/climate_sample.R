## code to prepare `climate_sample` dataset goes here

usethis::use_data(climate_sample, overwrite = TRUE)
# Création du jeu de données d'exemple
set.seed(123)
dates <- seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day")

climate_sample <- data.frame(
  date = dates,
  tmin = round(rnorm(365, mean = 8, sd = 5), 1),
  tmax = round(rnorm(365, mean = 18, sd = 6), 1)
)

# S'assurer que tmax > tmin
climate_sample$tmax <- ifelse(
  climate_sample$tmax <= climate_sample$tmin,
  climate_sample$tmin + 2,
  climate_sample$tmax
)

usethis::use_data(climate_sample, overwrite = TRUE)
