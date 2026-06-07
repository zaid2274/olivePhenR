test_that("analyze_frost_risk fonctionne correctement", {
  data <- data.frame(
    date = seq(as.Date("2023-04-01"), as.Date("2023-05-15"), by = "day"),
    tmin = rep(5, 45),
    tmax = rep(15, 45)
  )
  result <- analyze_frost_risk(data, flowering_date = as.Date("2023-04-15"))
  expect_true(!is.null(result$frost_days))
  expect_true(!is.null(result$risk_class))
  expect_true(result$risk_class %in% c("faible", "moyen", "eleve"))
})
