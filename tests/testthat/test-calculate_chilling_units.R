test_that("calculate_chilling_units fonctionne correctement", {
  data <- data.frame(
    date = seq(as.Date("2023-01-01"), as.Date("2023-01-10"), by = "day"),
    tmin = rep(2, 10),
    tmax = rep(6, 10)
  )
  result <- calculate_chilling_units(data)
  expect_true("chilling_units" %in% colnames(result))
  expect_true("chilling_cumul" %in% colnames(result))
  expect_true(all(result$chilling_units %in% c(0, 1)))
})
