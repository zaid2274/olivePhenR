test_that("calculate_degree_days fonctionne correctement", {
  data <- data.frame(
    date = seq(as.Date("2023-01-01"), as.Date("2023-01-10"), by = "day"),
    tmin = rep(5, 10),
    tmax = rep(15, 10)
  )
  result <- calculate_degree_days(data, tbase = 10)
  expect_true("gdd" %in% colnames(result))
  expect_true("gdd_cumul" %in% colnames(result))
  expect_equal(result$gdd[1], 0)
  expect_true(all(result$gdd >= 0))
})
