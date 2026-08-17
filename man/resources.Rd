\name{methylomni_data_manifest}
\alias{methylomni_data_manifest}
\alias{clock_resource_path}
\alias{complex_resource_path}
\alias{reference_resource_path}
\alias{omniage_resource_path}
\title{Access Versioned MethylOmniData Resources}
\description{Resolve bundled coefficient, complex-model, and cell-reference
resources, or inspect their versioned manifest.}
\usage{
methylomni_data_manifest()
clock_resource_path(clock)
complex_resource_path(name)
omniage_resource_path(name)
reference_resource_path(reference_id)
}
\arguments{
  \item{clock}{Clock identifier.}
  \item{name}{Complex resource file name.}
  \item{reference_id}{Cell-composition reference identifier.}
}
\value{The manifest function returns a data frame; path functions return a local path.}
