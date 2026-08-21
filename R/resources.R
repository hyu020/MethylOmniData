#' Resolve a clock coefficient resource
#' @param clock Clock identifier.
#' @return A named character vector of installed resource paths, or `""`.
#' @export
clock_resource_path <- function(clock) {
  manifest <- methylomni_data_manifest()
  if (!nrow(manifest) || !"clock_ids" %in% names(manifest)) return("")
  ids <- strsplit(manifest$clock_ids, "|", fixed = TRUE)
  hit <- which(vapply(ids, function(x) clock %in% x, logical(1)))
  if (!length(hit)) return("")
  paths <- vapply(manifest$relative_path[hit], function(path) {
    system.file("extdata", path, package = "MethylOmniData")
  }, character(1))
  names(paths) <- manifest$resource_id[hit]
  paths
}

#' Resolve any bundled resource by manifest identifier
#' @param resource_id Unique `resource_id` from [methylomni_data_manifest()].
#' @return The installed resource path, or `""` when absent.
#' @export
methylomni_resource_path <- function(resource_id) {
  manifest <- methylomni_data_manifest()
  hit <- match(resource_id, manifest$resource_id)
  if (length(hit) != 1L || is.na(hit)) return("")
  system.file("extdata", manifest$relative_path[[hit]], package = "MethylOmniData")
}

#' Return the versioned data-resource manifest
#' @return A data frame with resource identity, provenance, licensing, and
#'   checksum fields.
#' @export
methylomni_data_manifest <- function() {
  path <- system.file("extdata", "resource_manifest.csv", package = "MethylOmniData")
  if (!nzchar(path)) return(data.frame())
  utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
}

#' Validate all installed MethylOmniData resources
#' @param check_md5 Recompute MD5 checksums in addition to path and size checks.
#' @return The resource manifest with installed path and validation columns.
#' @export
validate_resource_manifest <- function(check_md5 = TRUE) {
  manifest <- methylomni_data_manifest()
  if (!nrow(manifest)) return(manifest)
  paths <- vapply(manifest$resource_id, methylomni_resource_path, character(1))
  exists <- nzchar(paths) & file.exists(paths)
  observed_bytes <- rep(NA_real_, length(paths))
  observed_md5 <- rep(NA_character_, length(paths))
  for (i in which(exists)) {
    path <- paths[[i]]
    raw <- readBin(path, what = "raw", n = file.info(path)$size)
    if (grepl("\\.(csv|tsv|txt|json)$", path, ignore.case = TRUE)) {
      crlf <- which(raw[-length(raw)] == as.raw(13L) & raw[-1L] == as.raw(10L))
      if (length(crlf)) raw <- raw[-crlf]
    }
    observed_bytes[[i]] <- length(raw)
    if (isTRUE(check_md5)) {
      tmp <- tempfile("MethylOmniData-canonical-")
      writeBin(raw, tmp)
      observed_md5[[i]] <- unname(tools::md5sum(tmp))
      unlink(tmp)
    }
  }
  manifest$installed_path <- unname(paths)
  manifest$exists <- exists
  manifest$observed_canonical_bytes <- observed_bytes
  manifest$observed_canonical_md5 <- observed_md5
  manifest$bytes_match <- exists & observed_bytes == manifest$bytes
  manifest$md5_match <- if (isTRUE(check_md5)) {
    exists & tolower(observed_md5) == tolower(manifest$md5)
  } else NA
  manifest
}

#' Resolve a bundled complex model resource
#' @param name Resource file name.
#' @return The installed resource path, or `""` when absent.
#' @export
complex_resource_path <- function(name) {
  system.file("extdata", "complex", name, package = "MethylOmniData")
}

#' Resolve a bundled OmniAge-derived model resource
#' @param name Resource file name.
#' @return The installed resource path, or `""` when absent.
#' @export
omniage_resource_path <- function(name) {
  system.file("extdata", "omniage", name, package = "MethylOmniData")
}

#' Resolve a bundled cell-composition reference
#' @param reference_id Reference identifier.
#' @return The installed resource path, or `""` when absent.
#' @export
reference_resource_path <- function(reference_id) {
  system.file("extdata", "references", paste0(reference_id, ".rds"), package = "MethylOmniData")
}
