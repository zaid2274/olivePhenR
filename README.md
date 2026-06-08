
# olivePhenR

## Description

`olivePhenR` est un package R permettant de modéliser les stades
phénologiques de l’olivier et d’analyser les risques de gel tardif à
partir de données climatiques journalières.

## Installation

``` r
# installer depuis GitHub
devtools::install_github("zaid2274/olivePhenR")
```

## Fonctions principales

| Fonction                      | Description                              |
|-------------------------------|------------------------------------------|
| `import_climate_data()`       | Import des données climatiques CSV/Excel |
| `calculate_degree_days()`     | Calcul des degrés-jours cumulés          |
| `calculate_chilling_units()`  | Calcul des unités de froid               |
| `detect_phenological_stage()` | Détection des stades phénologiques       |
| `calibrate_model()`           | Calibration du modèle phénologique       |
| `analyze_frost_risk()`        | Analyse du risque de gel tardif          |
| `plot_phenology_curves()`     | Visualisation des courbes phénologiques  |
| `generate_report()`           | Génération de rapport HTML/PDF           |

## Exemple d’utilisation

``` r
library(olivePhenR)

# Charger les données d'exemple
data("climate_sample")

# Calculer les degrés-jours
gdd_data <- calculate_degree_days(climate_sample, tbase = 10)

# Calculer les chilling units
chill_data <- calculate_chilling_units(gdd_data)

# Détecter les stades phénologiques
stages <- detect_phenological_stage(chill_data)
attr(stages, "phenological_dates")

# Analyser le risque de gel
flowering_date <- attr(stages, "phenological_dates")$flowering
risk <- analyze_frost_risk(stages, flowering_date = flowering_date)
cat("Risque de gel :", risk$risk_class)

# Visualiser
plot_phenology_curves(chill_data)
```

## Stades phénologiques

- 🌱 **Dormance**
- 🌿 **Débourrement**
- 🌸 **Floraison**
- 🫒 **Fructification**
- ✅ **Maturité**

## Auteur

Zaid Baitar

## Sources des données

| Données | Source | Lien |
|----|----|----|
| Températures mondiales (Tmin/Tmax) | WorldClim v2.1 | [worldclim.org](https://worldclim.org) |
| Occurrences olivier | GBIF (Global Biodiversity Information Facility) | [gbif.org](https://gbif.org) |
| Données climatiques journalières | Simulées à partir de WorldClim | — |
| Observations de floraison | Données simulées représentatives du Maroc | — |

> Les données WorldClim sont téléchargées automatiquement via le package
> `geodata`. Les occurrences de l’olivier (*Olea europaea*) sont
> importées via le package `rgbif`.
