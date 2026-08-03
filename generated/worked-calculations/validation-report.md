# Manuscript Calculation Validation Report

- Status: passed
- Checked calculations: 22

## Checked Calculations

| ID | Source notebook | Target snippet | Status |
| --- | --- | --- | --- |
| aux.difference.estimator | notebooks/support/auxiliary-variables-and-stratification/support.Rmd | generated/worked-calculations/aux-difference-estimator.tex | passed |
| aux.mpu.estimator | notebooks/support/auxiliary-variables-and-stratification/support.Rmd | generated/worked-calculations/aux-mpu-estimator.tex | passed |
| aux.ratio.estimator | notebooks/support/auxiliary-variables-and-stratification/support.Rmd | generated/worked-calculations/aux-ratio-estimator.tex | passed |
| aux.regression.estimator | notebooks/support/auxiliary-variables-and-stratification/support.Rmd | generated/worked-calculations/aux-regression-estimator.tex | passed |
| est.mean.minimum_sample_size_finite | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-minimum-sample-size-finite.tex | passed |
| est.mean.minimum_sample_size_infinite | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-minimum-sample-size-infinite.tex | passed |
| est.mean.one_sided_upper_95 | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-one-sided-upper-95.tex | passed |
| est.mean.point_estimate | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-point-estimate.tex | passed |
| est.mean.stein_interval | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-stein-interval.tex | passed |
| est.mean.two_sided_finite_95 | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-two-sided-finite-95.tex | passed |
| est.mean.two_sided_interval_95 | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-two-sided-interval-95.tex | passed |
| est.mean.two_sided_interval_99 | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-mean-two-sided-interval-99.tex | passed |
| est.prop.binomial_interval_95 | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-prop-binomial-interval-95.tex | passed |
| est.prop.binomial_interval_extended | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-prop-binomial-interval-extended.tex | passed |
| est.prop.minimum_sample_size_normal | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-prop-minimum-sample-size-normal.tex | passed |
| est.prop.point_estimate | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-prop-point-estimate.tex | passed |
| est.prop.total_point_estimate | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-prop-total-point-estimate.tex | passed |
| est.total.point_estimate | notebooks/support/population-estimation/support.Rmd | generated/worked-calculations/est-total-point-estimate.tex | passed |
| hyp.mus.sample_size | notebooks/support/hypothesis-testing/support.Rmd | generated/worked-calculations/hyp-mus-sample-size.tex | passed |
| reg.annual.assurance | notebooks/support/regression-analysis/support.Rmd | generated/worked-calculations/reg-annual-assurance.tex | passed |
| reg.annual.decision_bounds | notebooks/support/regression-analysis/support.Rmd | generated/worked-calculations/reg-annual-decision-bounds.tex | passed |
| reg.annual.expectation_interval | notebooks/support/regression-analysis/support.Rmd | generated/worked-calculations/reg-annual-expectation-interval.tex | passed |

## R/Python Shared Value Comparisons

| ID | R raw | Python raw | Difference | Tolerance | Status |
| --- | ---: | ---: | ---: | ---: | --- |
| aux.mpu.population_size | 3500 | 3500 | 0 | 1e-08 | passed |
| aux.mpu.sample_size | 400 | 400 | 0 | 1e-08 | passed |
| aux.mpu.total_audit_value | 864212.48 | 864212.48 | 3.49245965480804e-10 | 1e-08 | passed |
| aux.mpu.mean_audit_value | 2160.5312 | 2160.5312 | 0 | 1e-08 | passed |
| aux.mpu.sum_squared_audit_values | 3649977984.2608 | 3649977984.2608 | 9.5367431640625e-07 | 3.6499779842608e-06 | passed |
| aux.mpu.audit_value_variance | 4468220.4456 | 4468220.44559254 | 7.45803117752075e-06 | 1e-05 | passed |
| aux.mpu.estimated_population_value | 7561859.2 | 7561859.2 | 9.31322574615479e-10 | 1e-08 | passed |
