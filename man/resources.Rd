\name{methylomni_data_manifest}
\alias{methylomni_data_manifest}
\alias{clock_resource_path}
\alias{complex_resource_path}
\alias{reference_resource_path}
\alias{omniage_resource_path}
\alias{methylomni_resource_path}
\alias{validate_resource_manifest}
\title{Access Versioned MethylOmniData Resources}
\description{Resolve bundled coefficient, complex-model, and cell-reference
resources, or inspect their versioned manifest.}
\usage{
methylomni_data_manifest()
clock_resource_path(clock)
complex_resource_path(name)
omniage_resource_path(name)
reference_resource_path(reference_id)
methylomni_resource_path(resource_id)
validate_resource_manifest(check_md5 = TRUE)
}
\arguments{
  \item{clock}{Clock identifier.}
  \item{name}{Complex resource file name.}
  \item{reference_id}{Cell-composition reference identifier.}
  \item{resource_id}{Unique resource identifier from the manifest.}
  \item{check_md5}{Recompute MD5 checksums in addition to path and size checks.}
}
\value{The manifest and validation functions return data frames. Path functions
return one or more installed paths, or an empty string when unavailable.}
\examples{
manifest <- methylomni_data_manifest()
head(manifest)
clock_resource_path("Horvath2013")
validation <- validate_resource_manifest()
all(validation$exists & validation$bytes_match & validation$md5_match)
}
