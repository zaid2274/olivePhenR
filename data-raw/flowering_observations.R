# Création des données d'observations de floraison de l'olivier
flowering_observations <- data.frame(
  site = c("Marrakech", "Fes", "Meknes", "Agadir", "Ouarzazate",
           "Rabat", "Tanger", "Beni Mellal", "Errachidia", "Safi"),
  longitude = c(-8.0, -5.0, -5.5, -9.6, -6.9,
                -6.8, -5.8, -6.3, -4.4, -9.2),
  latitude = c(31.6, 34.0, 33.9, 30.4, 30.9,
               34.0, 35.8, 32.3, 31.9, 32.3),
  flowering_date = as.Date(c(
    "2023-03-15", "2023-04-01", "2023-03-25",
    "2023-03-10", "2023-03-20", "2023-03-28",
    "2023-04-05", "2023-03-22", "2023-03-12", "2023-03-18"
  )),
  gdd_at_flowering = c(285, 310, 295, 270, 280,
                       300, 320, 290, 275, 288)
)

usethis::use_data(flowering_observations, overwrite = TRUE)
