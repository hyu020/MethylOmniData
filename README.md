# MethylOmniData

`MethylOmniData` is the companion resource package for `MethylOmni`. It stores coefficient tables, complex-model resources, and reference matrices used by the core package. Install it before installing or using `MethylOmni`.

```r
install.packages("remotes")
remotes::install_github("hyu020/MethylOmniData")
remotes::install_github("hyu020/MethylOmni")
```

The package exposes resource accessors such as `clock_resource_path()`, `complex_resource_path()`, `omniage_resource_path()`, `reference_resource_path()`, and `methylomni_data_manifest()`. Users normally do not need to call these accessors directly.

All resources retain upstream provenance and license information in `inst/extdata/resource_manifest.csv`. Review that manifest before redistributing the package or publishing derived software.
