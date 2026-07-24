# Simulation Artifacts

Some book figures are based on simulations that are too slow for ordinary
notebook and manuscript renders. These simulations should be stored as
versioned artifacts and loaded by default.

## Auxiliary Sampling Distributions

The sampling-distribution simulation for the auxiliary variables and
stratification chapter is externalized from:

`notebooks/support/auxiliary-variables-and-stratification/support.Rmd`

The default render path loads:

- `generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.rds`
- `generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.csv.gz`

The RDS file is the canonical artifact used by the notebook. The CSV.GZ file is
provided as a student-friendly download for readers who want to inspect the
simulation results outside R.

Download URLs for the companion site:

- RDS: `https://github.com/LuHoo/ada/raw/main/generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.rds`
- CSV.GZ: `https://github.com/LuHoo/ada/raw/main/generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.csv.gz`

## Recomputing

Recompute only when the simulation inputs or estimator behavior change. The
full default run uses 50,000 iterations and can take a long time.

```sh
Rscript scripts/recompute-auxiliary-sampling-simulation.R
```

For a quick smoke test, use a smaller simulation:

```sh
Rscript scripts/recompute-auxiliary-sampling-simulation.R --sim-size 10 --output-rds /tmp/aux-sim-smoke.rds --output-csv /tmp/aux-sim-smoke.csv.gz
```

To force the support notebook to recompute during rendering:

```sh
ADA_RECOMPUTE_AUXILIARY_SAMPLING_SIMULATION=true Rscript scripts/render-notebooks.R --slug auxiliary-variables-and-stratification
```

After recomputing the full artifact, rerender the affected notebook/manuscript
outputs and commit the updated artifacts together.
