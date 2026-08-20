test_that("manifest covers and validates every installed resource", {
  manifest <- methylomni_data_manifest()
  expect_gt(nrow(manifest), 0L)
  expect_true(all(c("resource_id", "clock_ids", "relative_path", "sha256",
                    "source_url", "redistribution_status") %in% names(manifest)))
  expect_equal(anyDuplicated(manifest$resource_id), 0L)
  expect_equal(anyDuplicated(manifest$relative_path), 0L)

  audit <- validate_resource_manifest(check_md5 = TRUE)
  expect_true(all(audit$exists))
  expect_true(all(audit$bytes_match))
  expect_true(all(audit$md5_match))

  extdata <- system.file("extdata", package = "MethylOmniData")
  installed <- list.files(extdata, recursive = TRUE, full.names = FALSE)
  installed <- setdiff(gsub("\\\\", "/", installed), "resource_manifest.csv")
  expect_setequal(installed, manifest$relative_path)
})

test_that("clock and generic accessors resolve real files", {
  expect_true(all(file.exists(clock_resource_path("GPAge10"))))
  expect_true(all(file.exists(clock_resource_path("PCHorvath1"))))
  manifest <- methylomni_data_manifest()
  paths <- vapply(manifest$resource_id, methylomni_resource_path, character(1))
  expect_true(all(file.exists(paths)))
})
