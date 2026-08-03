# Manuscript Calculation Validation Report

- Status: passed
- Checked calculations: 1

## Checked Calculations

| ID | Source notebook | Target snippet | Status |
| --- | --- | --- | --- |
| aux.mpu.estimator | notebooks/support/auxiliary-variables-and-stratification/support.Rmd | generated/worked-calculations/aux-mpu-estimator.tex | passed |

## R/Python Shared Value Comparisons

| ID | R raw | Python raw | Difference | Tolerance | Status |
| --- | ---: | ---: | ---: | ---: | --- |
| aux.mpu.population_size | 3500 | 3500 | 0 | 1e-08 | passed |
| aux.mpu.sample_size | 400 | 400 | 0 | 1e-08 | passed |
| aux.mpu.total_audit_value | 864212.48 | 864212.48 | 0 | 1e-08 | passed |
| aux.mpu.mean_audit_value | 2160.5312 | 2160.5312 | 0 | 1e-08 | passed |
| aux.mpu.sum_squared_audit_values | 3649977984.2608 | 3649977984.2608 | 0 | 3.6499779842608e-06 | passed |
| aux.mpu.audit_value_variance | 4468220.44559254 | 4468220.44559254 | 0 | 1e-08 | passed |
| aux.mpu.estimated_population_value | 7561859.2 | 7561859.2 | 0 | 1e-08 | passed |
