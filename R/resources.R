#' Resolve a clock coefficient resource
#' @param clock Clock identifier.
#' @export
clock_resource_path <- function(clock) {
  manifest <- methylomni_data_manifest()
  hit <- match(clock, manifest$clock_id)
  if (is.na(hit)) return("")
  system.file("extdata", "weights", manifest$file[[hit]], package = "MethylOmniData")
}

#' Return the versioned data-resource manifest
#' @export
methylomni_data_manifest <- function() {
  path <- system.file("extdata", "resource_manifest.csv", package = "MethylOmniData")
  if (!nzchar(path)) return(data.frame())
  utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
}

#' Resolve a bundled complex model resource
#' @param name Resource file name.
#' @export
complex_resource_path <- function(name) {
  system.file("extdata", "complex", name, package = "MethylOmniData")
}

#' Resolve a bundled OmniAge-derived model resource
#' @param name Resource file name.
#' @export
omniage_resource_path <- function(name) {
  system.file("extdata", "omniage", name, package = "MethylOmniData")
}

#' Resolve a bundled cell-composition reference
#' @param reference_id Reference identifier.
#' @export
reference_resource_path <- function(reference_id) {
  system.file("extdata", "references", paste0(reference_id, ".rds"), package = "MethylOmniData")
}
