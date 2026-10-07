# MethylOmniData

MethylOmniData supplies coefficient tables, model files and reference matrices for MethylOmni. Version 0.4.0 adds the **GlobalClock160** and **GlobalClock12** coefficients, fixed training medians and model descriptions.

## Installation

```r
install.packages("remotes")
remotes::install_github("hyu020/MethylOmniData", ref = "v0.4.0")
remotes::install_github("hyu020/MethylOmni", ref = "v0.4.0")
```

Install the data package before calculating clocks. Omitting `ref` installs the current default-branch version.

## GlobalClock resources

| Model | CpGs | Intercept | Training age range, years | Training samples |
|---|---:|---:|---:|---:|
| GlobalClock160 | 160 | 23.0109946392448 | 18–101 | 5,236 |
| GlobalClock12 | 12 | -7.554587457206566 | 18.09–101 | 5,212 |

Both models use beta values on the original 0–1 scale and return age in years. GlobalClock12 has its own coefficients. The two models share five CpGs, giving a union of 167 probes.

Each coefficient table contains `probe`, `coefficient` and `training_median`. The intercept has its own row. Model descriptions include the input scale, output unit, training-age range and imputation requirements.

```r
library(MethylOmniData)
paths <- clock_resource_path("GlobalClock160")
weights_path <- paths[basename(paths) == "GlobalClock160.csv"]
weights <- read.csv(weights_path)
head(weights)

model_path <- methylomni_resource_path("GlobalClock_models")
models <- read.csv(model_path)
```

`clock_resource_path()` can return more than one named path because a clock may have both coefficients and a model description. `MethylOmni::load_clock_weights()` selects the coefficient table automatically.

## Resource information

`methylomni_data_manifest()` lists resource identities, file paths, source information and licences. Other accessors include `complex_resource_path()`, `omniage_resource_path()` and `reference_resource_path()`.

```r
manifest <- methylomni_data_manifest()
manifest[manifest$resource_id %in%
  c("GlobalClock160", "GlobalClock12", "GlobalClock_models"), ]
```

Resource integrity can be checked after installation with `validate_resource_manifest()`. Such checks need only be repeated when the installation or its files change.

## Use and citation

Calculate predictions and age acceleration through MethylOmni rather than editing the coefficient files. Refer to the [MethylOmni user guide](https://github.com/hyu020/MethylOmni/blob/main/docs/MethylOmni_User_Guide_zh-CN.md) for examples, interpretation and missing-data methods.

MethylOmniData retains its GPL-3 licence. Source and distribution information for individual resources are recorded in `inst/extdata/resource_manifest.csv`.
