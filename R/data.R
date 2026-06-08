#' Données climatiques d'exemple
#'
#' Jeu de données climatiques journalières simulées pour l'année 2023,
#' utilisé pour illustrer les fonctions du package olivePhenR.
#'
#' @format Un dataframe avec 365 lignes et 3 variables :
#' \describe{
#'   \item{date}{Date au format Date}
#'   \item{tmin}{Température minimale journalière en degrés Celsius}
#'   \item{tmax}{Température maximale journalière en degrés Celsius}
#' }
#' @source Données simulées
"climate_sample"

#' Observations de floraison de l'olivier au Maroc
#'
#' Jeu de données contenant des observations de floraison de l'olivier
#' dans différentes villes du Maroc pour l'année 2023.
#'
#' @format Un dataframe avec 10 lignes et 5 variables :
#' \describe{
#'   \item{site}{Nom de la ville ou du site d'observation}
#'   \item{longitude}{Longitude du site en degrés décimaux}
#'   \item{latitude}{Latitude du site en degrés décimaux}
#'   \item{flowering_date}{Date de floraison observée}
#'   \item{gdd_at_flowering}{Degrés-jours cumulés à la date de floraison}
#' }
#' @source Données simulées représentatives du Maroc
"flowering_observations"
