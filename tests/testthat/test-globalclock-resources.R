test_that("GlobalClock coefficient tables and model information resolve together", {
  for (id in c("GlobalClock160", "GlobalClock12")) {
    paths <- clock_resource_path(id)
    expect_equal(length(paths), 2L)
    expect_true(all(file.exists(paths)))
    w <- utils::read.csv(paths[basename(paths) == paste0(id, ".csv")])
    expect_equal(nrow(w) - 1L, if (id == "GlobalClock160") 160L else 12L)
    expect_true(all(is.finite(w$training_median[-1])))
  }
})
