# Volume 1 Traceability Audit Report

Date: 2026-08-04

Source inventory: `generated/traceability/vol1-manuscript-calculation-inventory.csv`

This report is generated from a complete line-by-line inventory pass over all Volume 1 manuscript chapters and mapped support notebooks.

## Probability Distributions (pro)

### Files Reviewed

- Manuscript: `probability-distributions.tex`
- Support notebook/output: `notebooks/support/probability-distributions/support.html`

### Audit Totals

- Total hard-coded numeric values found: 138
- Total values linked dynamically: 1
- Values intentionally left hard-coded: 137

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| 9 | `probability-distributions.tex` |  | `\input{generated/worked-calculations/prob-inline-linked-values}` |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 84 | `probability-distributions.tex` | 17, 60, 331 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 87 | `probability-distributions.tex` | 0, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 102 | `probability-distributions.tex` | 1, 60, 59 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 111 | `probability-distributions.tex` | 313, 330, 330 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 148 | `probability-distributions.tex` | 60, 331, 2, 2 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 151 | `probability-distributions.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 154 | `probability-distributions.tex` | 331, 60 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 155 | `probability-distributions.tex` | 17, 0, 17, 314, 60, 254, 331, 60, 271 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 157 | `probability-distributions.tex` | 17, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 160 | `probability-distributions.tex` | 314, 60, 254, 331, 60, 271, 314, 60, 254, 60, 271, 331 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 164 | `probability-distributions.tex` | 314, 271, 331, 254, 314, 271, 270, 255, 254, 331, 330, 315, 314, 254 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 168 | `probability-distributions.tex` | 271, 270, 255, 331, 330, 315 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 171 | `probability-distributions.tex` | 60 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 184 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 186 | `probability-distributions.tex` | 2, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 190 | `probability-distributions.tex` | 60, 17, 331, 3.0816, 1, 1, 60, 17, 331, 1, 17, 331, 331, 60, 331, 1, 2.4007 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 217 | `probability-distributions.tex` | 17, 331, 0.0514 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 225 | `probability-distributions.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 234 | `probability-distributions.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 238 | `probability-distributions.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 243 | `probability-distributions.tex` | 1, 60, 1, 0.0514, 1, 1, 0.0514, 60, 1, 0.1373 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 246 | `probability-distributions.tex` | 60, 0.0514, 3.0816, 2, 60, 0.0514, 1, 0.0514, 2.9233 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 250 | `probability-distributions.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 273 | `probability-distributions.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 281 | `probability-distributions.tex` | 60, 17, 331, 3.0816 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 283 | `probability-distributions.tex` | 3, 3.0816, 3, 3, 3.08, 0.2238 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 295 | `probability-distributions.tex` | 60 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 312 | `probability-distributions.tex` | 0, 0.0304, 0.0423, 0.0459 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 313 | `probability-distributions.tex` | 1, 0.1215, 0.1373, 0.1414 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 314 | `probability-distributions.tex` | 2, 0.2239, 0.2193, 0.2179 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 332 | `probability-distributions.tex` | 3, 3.0816, 2.4007 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 333 | `probability-distributions.tex` | 2, 3.0816, 2.9233 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 334 | `probability-distributions.tex` | 1, 3.0816, 3.0816 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 352 | `probability-distributions.tex` | 1030 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 356 | `probability-distributions.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 359 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 360 | `probability-distributions.tex` | 200 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 363 | `probability-distributions.tex` | 2, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 368 | `probability-distributions.tex` | 1, 930, 1035, 1073, 994, 910, 1033, 947, 1102, 1095, 921 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 371 | `probability-distributions.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 374 | `probability-distributions.tex` | 1030 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 386 | `probability-distributions.tex` | 1, 10 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 387 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 394 | `probability-distributions.tex` | 1, 100% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 405 | `probability-distributions.tex` | 1, 2, 2 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 436 | `probability-distributions.tex` | 1, 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 440 | `probability-distributions.tex` | 2, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 443 | `probability-distributions.tex` | 1, 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 447 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 454 | `probability-distributions.tex` | 2, 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 457 | `probability-distributions.tex` | 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 464 | `probability-distributions.tex` | 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 469 | `probability-distributions.tex` | 2, 2, 200, 1012, 115.26, 200 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 474 | `probability-distributions.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 477 | `probability-distributions.tex` | 0, 68.3%, 1, 1, 95.4%, 2, 2, 99.7%, 3, 3, 99.7%, 3, 3, 1, 2, 2, 95%, 1.96, 1.96, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 480 | `probability-distributions.tex` | 1030, 2, 1012 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 482 | `probability-distributions.tex` | 1012, 1030, 115.26, 200, 2.2086 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 485 | `probability-distributions.tex` | 2.21, 1.36%, 2 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 496 | `probability-distributions.tex` | 0, 2, 1, 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 498 | `probability-distributions.tex` | 1, 10, 1, 9, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 500 | `probability-distributions.tex` | 1, 3, 9, 100 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 535 | `probability-distributions.tex` | 1004, 73.78, 1030 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 537 | `probability-distributions.tex` | 1004, 1030, 73.78, 10, 1.11 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 540 | `probability-distributions.tex` | 2, 2, 14.7% | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 549 | `probability-distributions.tex` | 1004, 10, 1.11, 14.7%, 1030 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 556 | `probability-distributions.tex` | 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 558 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 560 | `probability-distributions.tex` | 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 563 | `probability-distributions.tex` | 1, 2, 2, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 573 | `probability-distributions.tex` | 2, 1, 95%, 2, 10, 1, 16.92 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 575 | `probability-distributions.tex` | 2, 1, 2, 2, 10, 1, 73.78, 2, 16.92, 2896 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 577 | `probability-distributions.tex` | 95% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 579 | `probability-distributions.tex` | 2, 2, 3.33 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 582 | `probability-distributions.tex` | 2, 1, 2, 2, 10, 1, 73.78, 2, 3.33, 14736 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 586 | `probability-distributions.tex` | 2, 2896, 95%, 90%, 2896, 14736 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 598 | `probability-distributions.tex` | 1, 2, 2, 1, 2, 1, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 607 | `probability-distributions.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 609 | `probability-distributions.tex` | 1, 25, 2, 23, 0.05, 1, 2 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 637 | `probability-distributions.tex` | 1, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 640 | `probability-distributions.tex` | 1, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 642 | `probability-distributions.tex` | 1, 1, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 653 | `probability-distributions.tex` | 1, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 663 | `probability-distributions.tex` | 1, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 665 | `probability-distributions.tex` | 1, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 676 | `probability-distributions.tex` | 1, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 678 | `probability-distributions.tex` | 1, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 689 | `probability-distributions.tex` | 1, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 700 | `probability-distributions.tex` | 1, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 702 | `probability-distributions.tex` | 1, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 713 | `probability-distributions.tex` | 1, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 715 | `probability-distributions.tex` | 1, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 729 | `probability-distributions.tex` | 1, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 730 | `probability-distributions.tex` | 1, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 731 | `probability-distributions.tex` | 1, 1, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 740 | `probability-distributions.tex` | 1, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 749 | `probability-distributions.tex` | 1, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 750 | `probability-distributions.tex` | 1, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 759 | `probability-distributions.tex` | 1, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 760 | `probability-distributions.tex` | 1, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 769 | `probability-distributions.tex` | 1, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 778 | `probability-distributions.tex` | 1, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 779 | `probability-distributions.tex` | 1, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 788 | `probability-distributions.tex` | 1, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 789 | `probability-distributions.tex` | 1, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 797 | `probability-distributions.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 801 | `probability-distributions.tex` | 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 815 | `probability-distributions.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 816 | `probability-distributions.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 817 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 818 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 848 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 849 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 850 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 851 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 873 | `probability-distributions.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 885 | `probability-distributions.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 893 | `probability-distributions.tex` | 0.10 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 897 | `probability-distributions.tex` | 1, 1, 1, 10% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 906 | `probability-distributions.tex` | 1000, 0.05 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 910 | `probability-distributions.tex` | 100, 10% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 922 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 923 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 924 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 925 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 957 | `probability-distributions.tex` | 1, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 959 | `probability-distributions.tex` | 0.1, 1, 0.9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 965 | `probability-distributions.tex` | 60 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 986 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 987 | `probability-distributions.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 988 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 989 | `probability-distributions.tex` | 1.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1000 | `probability-distributions.tex` | 1, 200 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1002 | `probability-distributions.tex` | 50, 100, 200 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1020 | `probability-distributions.tex` | 1%, 2.405, 2.365, 2.345, 2.326 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1021 | `probability-distributions.tex` | 5%, 1.677, 1.660, 1.653, 1.645 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1022 | `probability-distributions.tex` | 10%, 1.299, 1.290, 1.286, 1.282 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1040 | `probability-distributions.tex` | 0.10 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |

## Estimation (est)

### Files Reviewed

- Manuscript: `estimation.tex`
- Support notebook/output: `notebooks/support/population-estimation/support.html`

### Audit Totals

- Total hard-coded numeric values found: 106
- Total values linked dynamically: 24
- Values intentionally left hard-coded: 82

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| 124 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-point-estimate}` |
| 125 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-point-estimate-inline-value}` |
| 136 | `estimation.tex` |  | `\input{generated/worked-calculations/est-total-point-estimate}` |
| 241 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-two-sided-interval-95}` |
| 245 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-two-sided-interval-99}` |
| 263 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-one-sided-upper-95}` |
| 286 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-two-sided-finite-95}` |
| 319 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-minimum-sample-size-infinite}` |
| 337 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-stein-interval}` |
| 366 | `estimation.tex` |  | `\input{generated/worked-calculations/est-mean-minimum-sample-size-finite}` |
| 387 | `estimation.tex` |  | `\input{generated/worked-calculations/est-prop-point-estimate}` |
| 396 | `estimation.tex` |  | `\input{generated/worked-calculations/est-prop-total-point-estimate}` |
| 440 | `estimation.tex` |  | `\input{generated/worked-calculations/est-prop-binomial-interval-95}` |
| 469 | `estimation.tex` |  | `\input{generated/worked-calculations/est-prop-minimum-sample-size-normal}` |
| 470 | `estimation.tex` |  | `\input{generated/worked-calculations/est-prop-binomial-interval-extended}` |
| 239 | `estimation.tex` | 5%, 95%, 1 | `We use the $t$ distribution with an $\alpha$ value of 5\% to obtain a confidence level of 95\%, and we use $n - 1 = \EstMeanDf$ degrees of freedom.` |
| 241 | `estimation.tex` | 95 | `\input{generated/worked-calculations/est-mean-two-sided-interval-95}` |
| 245 | `estimation.tex` | 99 | `\input{generated/worked-calculations/est-mean-two-sided-interval-99}` |
| 263 | `estimation.tex` | 95 | `\input{generated/worked-calculations/est-mean-one-sided-upper-95}` |
| 286 | `estimation.tex` | 95 | `\input{generated/worked-calculations/est-mean-two-sided-finite-95}` |
| 364 | `estimation.tex` | 2, 1, 2, 2, 2, 2, 2, 2, 2, 2 | `\gamma = \frac{E^2 (N-1)}{N^2 t_{\alpha/2}^2 s^2} \approx \frac{E^2}{N t_{\alpha/2}^2 s^2}` |
| 385 | `estimation.tex` | 1 | `where $k$ denotes the number of women in the sample. Note that when conveniently coding a nominal variable that consists of only two possible values, we can simply sum the observations to obtain a count of the class t...` |
| 440 | `estimation.tex` | 95 | `\input{generated/worked-calculations/est-prop-binomial-interval-95}` |
| 442 | `estimation.tex` | 2 | `To obtain a one-sided confidence interval for a proportion, we can use Equations \ref{eq:lower_bound_binomial} or \ref{eq:upper_bound_binomial}, again using $\alpha$ rather than $\alpha/2$.` |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 74 | `estimation.tex` | 2222, 12 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 76 | `estimation.tex` | 50, 20, 0, 150708, 31 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 79 | `estimation.tex` | 95%, 20 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 96 | `estimation.tex` | 1602, 6, 1, 1612, 910046, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 97 | `estimation.tex` | 1946, 13, 8, 4818, 536825, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 98 | `estimation.tex` | 1690, 4, 0, 1399, 468652, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 99 | `estimation.tex` | 1967, 10, 4, 2845, 890951, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 100 | `estimation.tex` | 1013, 8, 6, 2486, 688734, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 101 | `estimation.tex` | 369, 15, 7, 5585, 798493, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 169 | `estimation.tex` | 3200.00 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 172 | `estimation.tex` | 5, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 173 | `estimation.tex` | 5, 5 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 179 | `estimation.tex` | 5, 5, 5, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 186 | `estimation.tex` | 1, 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 189 | `estimation.tex` | 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 198 | `estimation.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 201 | `estimation.tex` | 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 216 | `estimation.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 220 | `estimation.tex` | 2, 2, 100 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 224 | `estimation.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 252 | `estimation.tex` | 95%, 5, 0.5, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 270 | `estimation.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 273 | `estimation.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 283 | `estimation.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 295 | `estimation.tex` | 95%, 5, 5, 5, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 303 | `estimation.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 306 | `estimation.tex` | 5, 95%, 5, 5, 600000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 309 | `estimation.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 316 | `estimation.tex` | 2, 2, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 327 | `estimation.tex` | 1945, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 330 | `estimation.tex` | 2, 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 344 | `estimation.tex` | 10%, 300000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 349 | `estimation.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 355 | `estimation.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 360 | `estimation.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 377 | `estimation.tex` | 0, 0, 1 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 407 | `estimation.tex` | 0.1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 409 | `estimation.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 412 | `estimation.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 415 | `estimation.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 418 | `estimation.tex` | 0, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 425 | `estimation.tex` | 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 429 | `estimation.tex` | 1, 2, 2, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 434 | `estimation.tex` | 1, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 437 | `estimation.tex` | 1, 2, 2, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 451 | `estimation.tex` | 20, 5, 1, 5, 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 454 | `estimation.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 460 | `estimation.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 465 | `estimation.tex` | 2, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 477 | `estimation.tex` | 1, 100%, 0, 1, 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 502 | `estimation.tex` | 2, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 503 | `estimation.tex` | 2, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 512 | `estimation.tex` | 2, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 513 | `estimation.tex` | 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 522 | `estimation.tex` | 2, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 523 | `estimation.tex` | 2, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 524 | `estimation.tex` | 2, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 525 | `estimation.tex` | 2, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 526 | `estimation.tex` | 2, 3, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 527 | `estimation.tex` | 2, 3, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 536 | `estimation.tex` | 2, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 537 | `estimation.tex` | 2, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 546 | `estimation.tex` | 2, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 547 | `estimation.tex` | 2, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 556 | `estimation.tex` | 2, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 557 | `estimation.tex` | 2, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 571 | `estimation.tex` | 2, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 572 | `estimation.tex` | 2, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 581 | `estimation.tex` | 2, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 582 | `estimation.tex` | 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 591 | `estimation.tex` | 2, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 592 | `estimation.tex` | 2, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 593 | `estimation.tex` | 2, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 594 | `estimation.tex` | 2, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 595 | `estimation.tex` | 2, 3, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 596 | `estimation.tex` | 2, 3, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 605 | `estimation.tex` | 2, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 606 | `estimation.tex` | 2, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 615 | `estimation.tex` | 2, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 616 | `estimation.tex` | 2, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 625 | `estimation.tex` | 2, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 626 | `estimation.tex` | 2, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |

## Estimation with Auxiliary Variables and Stratification (aux)

### Files Reviewed

- Manuscript: `auxiliary.tex`
- Support notebook/output: `notebooks/support/auxiliary-variables-and-stratification/support.html`

### Audit Totals

- Total hard-coded numeric values found: 294
- Total values linked dynamically: 8
- Values intentionally left hard-coded: 286

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| 4 | `auxiliary.tex` |  | `\input{generated/worked-calculations/aux-inline-linked-values}` |
| 123 | `auxiliary.tex` |  | `\input{generated/worked-calculations/aux-mpu-estimator}` |
| 253 | `auxiliary.tex` |  | `\input{generated/worked-calculations/aux-regression-estimator}` |
| 285 | `auxiliary.tex` |  | `\input{generated/worked-calculations/aux-difference-estimator}` |
| 319 | `auxiliary.tex` |  | `\input{generated/worked-calculations/aux-ratio-estimator}` |
| 121 | `auxiliary.tex` | 400 | `We start addressing the problem in the \emph{Case: Valuation of inventories} with the estimator introduced in the previous chapter. An estimate of the correct value of the population is obtained by extrapolating the a...` |
| 125 | `auxiliary.tex` | 95% | `A 95\% two-sided prediction interval on the correct population value is then calculated by applying Equation \ref{eq:two-sided_finite}, multiplied by $N$` |
| 255 | `auxiliary.tex` | 200000 | `We can also conclude that using the correlation between book and audit values reduces the precision of the estimate of the correct population value to below the desired precision of 200,000. Therefore, by using the re...` |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 12 | `auxiliary.tex` | 100 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 14 | `auxiliary.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 71 | `auxiliary.tex` | 3500, 7360816 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 77 | `auxiliary.tex` | 3550437464 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 78 | `auxiliary.tex` | 2, 3586086982 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 79 | `auxiliary.tex` | 2, 3649977984 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 80 | `auxiliary.tex` | 2, 135190038 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 84 | `auxiliary.tex` | 95%, 200000 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 88 | `auxiliary.tex` | 95% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 102 | `auxiliary.tex` | 2524, 728.40, 842.99, 114.59 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 103 | `auxiliary.tex` | 3065, 2199.37, 1999.96, 199.41 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 104 | `auxiliary.tex` | 2662, 1452.48, 1589.65, 137.17 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 105 | `auxiliary.tex` | 3099, 68.61, 36.39, 32.22 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 106 | `auxiliary.tex` | 1596, 5292.84, 5273.66, 19.18 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 107 | `auxiliary.tex` | 582, 910.03, 969.29, 59.26 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 110 | `auxiliary.tex` | 863201.37, 864212.48, 1011.11 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 128 | `auxiliary.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 137 | `auxiliary.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 142 | `auxiliary.tex` | 3500, 3500, 400, 400, 164.6967 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 145 | `auxiliary.tex` | 7561859, 164.6967, 1.966, 4468220 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 148 | `auxiliary.tex` | 7561859, 684415 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 150 | `auxiliary.tex` | 6877444, 8246274 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 152 | `auxiliary.tex` | 684415, 200000, 2107 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 174 | `auxiliary.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 178 | `auxiliary.tex` | 0, 1, 0 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 180 | `auxiliary.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 185 | `auxiliary.tex` | 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 186 | `auxiliary.tex` | 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 191 | `auxiliary.tex` | 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 196 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 197 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 214 | `auxiliary.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 217 | `auxiliary.tex` | 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 219 | `auxiliary.tex` | 2, 1, 2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 224 | `auxiliary.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 234 | `auxiliary.tex` | 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 238 | `auxiliary.tex` | 1, 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 240 | `auxiliary.tex` | 2, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 242 | `auxiliary.tex` | 1, 1, 0, 2, 1, 1, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 244 | `auxiliary.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 262 | `auxiliary.tex` | 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 275 | `auxiliary.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 277 | `auxiliary.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 280 | `auxiliary.tex` | 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 294 | `auxiliary.tex` | 0, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 302 | `auxiliary.tex` | 864212.48, 863201.37, 1.00117 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 308 | `auxiliary.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 311 | `auxiliary.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 314 | `auxiliary.tex` | 2, 2, 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 335 | `auxiliary.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 341 | `auxiliary.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 347 | `auxiliary.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 351 | `auxiliary.tex` | 1, 1, 1, 1, 0, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 356 | `auxiliary.tex` | 0, 1, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 362 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 365 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 368 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 374 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 401 | `auxiliary.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 430 | `auxiliary.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 434 | `auxiliary.tex` | 260000, 82, 200, 3.7%, 0, 200, 96, 10, 0, 200, 116, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 444 | `auxiliary.tex` | 100 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 472 | `auxiliary.tex` | 260061, 259469, 258983, 261954 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 473 | `auxiliary.tex` | 262571, 259493, 255750, 262293 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 474 | `auxiliary.tex` | 260227, 260002, 259453, 262544 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 496 | `auxiliary.tex` | 66480, 72079, 90768, 189442 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 497 | `auxiliary.tex` | 71356, 67540, 77348, 187828 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 498 | `auxiliary.tex` | 66827, 67194, 67731, 192016 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 509 | `auxiliary.tex` | 260000, 95%, 95%, 95% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 522 | `auxiliary.tex` | 94.94%, 94.85%, 94.94%, 78.41% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 523 | `auxiliary.tex` | 94.87%, 95.14%, 94.51%, 79.08% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 524 | `auxiliary.tex` | 94.78%, 94.88%, 94.65%, 78.07% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 533 | `auxiliary.tex` | 95%, 80%, 116, 3500, 100, 35% | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 555 | `auxiliary.tex` | 1978 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 557 | `auxiliary.tex` | 19, 1, 1, 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 559 | `auxiliary.tex` | 10000, 13500000, 122, 100000, 100, 1%, 20 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 567 | `auxiliary.tex` | 1937.98, 6, 322.9967 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 573 | `auxiliary.tex` | 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 577 | `auxiliary.tex` | 2, 2059679, 1937.98, 2, 6, 6, 1, 286744 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 581 | `auxiliary.tex` | 2, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 586 | `auxiliary.tex` | 2, 0.1147, 286744, 0.1147, 1, 0.1147, 322.9967, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 587 | `auxiliary.tex` | 43483.25 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 589 | `auxiliary.tex` | 0.1147 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 590 | `auxiliary.tex` | 6 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 593 | `auxiliary.tex` | 10000, 10000, 100, 100, 994.9874 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 595 | `auxiliary.tex` | 2.571, 0.05, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 597 | `auxiliary.tex` | 994.9874, 2.571, 43483.25, 533347.23 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 603 | `auxiliary.tex` | 2, 2, 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 608 | `auxiliary.tex` | 2, 230244509, 2, 0.9825, 231280871, 0.9825, 2, 234376912, 6, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 613 | `auxiliary.tex` | 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 616 | `auxiliary.tex` | 0.1147, 46410.33 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 623 | `auxiliary.tex` | 994.9874, 2.571, 46410.33, 551006 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 631 | `auxiliary.tex` | 2, 2, 2, 1, 1, 2, 1, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 634 | `auxiliary.tex` | 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 637 | `auxiliary.tex` | 2, 43483.25, 2, 0.9915, 1, 1120631, 1130239 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 638 | `auxiliary.tex` | 0.9915, 1, 2, 1130239 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 639 | `auxiliary.tex` | 43401.57 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 646 | `auxiliary.tex` | 994.9874, 2.571, 43401.57, 532846 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 667 | `auxiliary.tex` | 100%, 100%, 100% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 691 | `auxiliary.tex` | 5, 20 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 715 | `auxiliary.tex` | 7360816, 3, 2453605 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 726 | `auxiliary.tex` | 1, 2431, 1.57, 2478.93, 2452927.31 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 727 | `auxiliary.tex` | 2, 710, 2480.29, 4833.28, 2453454.96 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 728 | `auxiliary.tex` | 3, 359, 4839.62, 18496.21, 2454433.73 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 747 | `auxiliary.tex` | 1849.46, 1851.03, 3700.50, 5549.96 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 763 | `auxiliary.tex` | 1, 1.57, 1848.60, 2030, 45.06, 45.06 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 764 | `auxiliary.tex` | 2, 1851.65, 3694.56, 857, 29.27, 74.33 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 765 | `auxiliary.tex` | 3, 3700.70, 5547.71, 360, 18.97, 93.30 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 766 | `auxiliary.tex` | 4, 5556.67, 7398.87, 154, 12.41, 105.71 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 767 | `auxiliary.tex` | 5, 7406.10, 9238.08, 63, 7.94, 113.65 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 768 | `auxiliary.tex` | 6, 9273.30, 11077.31, 24, 4.90, 118.55 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 769 | `auxiliary.tex` | 7, 11299.53, 12723.03, 7, 2.65, 121.20 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 770 | `auxiliary.tex` | 8, 13131.76, 14125.05, 4, 2.00, 123.20 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 771 | `auxiliary.tex` | 9, 0, 0.00, 123.20 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 772 | `auxiliary.tex` | 10, 18496.21, 1, 1.00, 124.20 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 782 | `auxiliary.tex` | 124.20, 3, 41.40 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 784 | `auxiliary.tex` | 1, 1, 45.05, 41.40, 1, 0, 45.05, 41.40, 0, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 786 | `auxiliary.tex` | 2, 3, 48.24, 41.40, 29.27, 2, 2, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 804 | `auxiliary.tex` | 1, 1.57, 1848.60, 2030, 45.06 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 805 | `auxiliary.tex` | 2, 1851.65, 5547.71, 1217, 48.25 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 806 | `auxiliary.tex` | 3, 5556.67, 18496.21, 253, 30.89 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 831 | `auxiliary.tex` | 50 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 836 | `auxiliary.tex` | 2, 2, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 854 | `auxiliary.tex` | 1, 2030, 524.12, 1063964, 557644952 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 855 | `auxiliary.tex` | 2, 1217, 1001.24, 1218515, 1220031365 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 856 | `auxiliary.tex` | 3, 253, 1828.32, 462564, 845712351 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 860 | `auxiliary.tex` | 3500, 2745042, 2623388667 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 869 | `auxiliary.tex` | 200, 200 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 871 | `auxiliary.tex` | 1.972, 2, 2745042, 2, 200000, 2, 1.972, 2, 2623388667, 584 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 879 | `auxiliary.tex` | 584, 195 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 900 | `auxiliary.tex` | 1, 2030, 524.12, 1063964, 226 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 901 | `auxiliary.tex` | 2, 1217, 1001.24, 1218515, 259 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 902 | `auxiliary.tex` | 3, 253, 1828.32, 462564, 98 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 906 | `auxiliary.tex` | 3500, 2745042, 583 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 917 | `auxiliary.tex` | 1, 584, 1063964, 2745042, 226 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 945 | `auxiliary.tex` | 1, 2030, 226, 183746.92, 545.26 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 946 | `auxiliary.tex` | 2, 1217, 259, 853049.17, 1302.54 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 947 | `auxiliary.tex` | 3, 253, 98, 779308.12, 2824.72 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 971 | `auxiliary.tex` | 1, 2030, 813.04, 1650470.12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 972 | `auxiliary.tex` | 2, 1217, 3293.63, 4008343.01 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 973 | `auxiliary.tex` | 3, 253, 7952.12, 2011887.29 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 991 | `auxiliary.tex` | 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1013 | `auxiliary.tex` | 1, 2030, 226, 16204.07, 297308, 4817605606 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1014 | `auxiliary.tex` | 2, 1217, 259, 4501.49, 1696612, 7637282583 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1015 | `auxiliary.tex` | 3, 253, 98, 400.15, 7979066, 3192847772 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1023 | `auxiliary.tex` | 15647735961, 125090.91 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1033 | `auxiliary.tex` | 2, 2, 2, 2, 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1040 | `auxiliary.tex` | 15647735961, 2, 4817605606, 2, 225, 7637282583, 2, 258, 3192847772, 2, 97, 564 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1043 | `auxiliary.tex` | 564, 1.9642 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1046 | `auxiliary.tex` | 7670700, 245704 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1048 | `auxiliary.tex` | 7424999, 0.5, 7916401, 200000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1057 | `auxiliary.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1065 | `auxiliary.tex` | 1, 212652334, 226, 827.20, 813.04, 269587 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1066 | `auxiliary.tex` | 2, 3067091255, 259, 3268.20, 3293.63, 1082008 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1067 | `auxiliary.tex` | 3, 6492159030, 98, 7731.59, 7952.12, 4813063 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1078 | `auxiliary.tex` | 1, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1082 | `auxiliary.tex` | 1, 11165022188, 10881902823, 1.026 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1092 | `auxiliary.tex` | 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1094 | `auxiliary.tex` | 1, 16204.07, 269587, 528.93, 4368411054, 4533333210 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1095 | `auxiliary.tex` | 2, 4501.49, 1082008, 1027.37, 4870649168, 4751253947 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1096 | `auxiliary.tex` | 3, 400.15, 4813063, 1997.94, 1925961966, 1597315666 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1108 | `auxiliary.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1122 | `auxiliary.tex` | 1, 2030, 827.20, 1679213.22 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1123 | `auxiliary.tex` | 2, 1217, 3268.20, 3977396.35 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1124 | `auxiliary.tex` | 3, 253, 7731.59, 1956092.61 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1139 | `auxiliary.tex` | 1.026, 7360816.00, 7612702.17, 7412261 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1145 | `auxiliary.tex` | 1, 2, 2, 2, 1, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1163 | `auxiliary.tex` | 1, 226, 297308, 269587, 279765, 38790 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1164 | `auxiliary.tex` | 2, 259, 1696612, 1082008, 1055485, 589700 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1165 | `auxiliary.tex` | 3, 98, 7979066, 4813063, 3991762, 2328674 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1177 | `auxiliary.tex` | 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1195 | `auxiliary.tex` | 1, 2030, 226, 16204.07, 38790, 628560668 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1196 | `auxiliary.tex` | 2, 1217, 259, 4501, 49, 589700, 2654530513 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1197 | `auxiliary.tex` | 3, 253, 98, 400.15, 2328674, 931826118 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1210 | `auxiliary.tex` | 4214917300, 64922.39 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1220 | `auxiliary.tex` | 4214917300, 2, 628560668, 2, 225, 2654530513, 2, 258, 931826118, 2, 97, 467 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1224 | `auxiliary.tex` | 467, 1.9651 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1227 | `auxiliary.tex` | 7412261, 1.9651, 64922.39, 7412261, 127.576 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1229 | `auxiliary.tex` | 7284685, 0.5, 7539837, 200000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1253 | `auxiliary.tex` | 1, 2030, 226, 3199.97, 194.68 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1254 | `auxiliary.tex` | 2, 1217, 259, 6586.02, 766.86 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1255 | `auxiliary.tex` | 3, 253, 98, 21612.17, 1531.24 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1279 | `auxiliary.tex` | 1, 2030, 14.16, 28743.09 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1280 | `auxiliary.tex` | 2, 1217, 25.43, 30946.67 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1281 | `auxiliary.tex` | 3, 253, 220.53, 55794.68 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1293 | `auxiliary.tex` | 7360816, 57998.26, 7418814 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1299 | `auxiliary.tex` | 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1318 | `auxiliary.tex` | 1, 2030, 226, 16204.07, 37898.92, 614116709 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1319 | `auxiliary.tex` | 2, 1217, 259, 4501.49, 588080.39, 2647238193 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1320 | `auxiliary.tex` | 3, 253, 98, 400.15, 2344701.56, 938239506 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1332 | `auxiliary.tex` | 4199594408, 64804.28 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1342 | `auxiliary.tex` | 4199594408, 2, 614116709, 2, 225, 2647238193, 2, 258, 938239506, 2, 97, 465 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1345 | `auxiliary.tex` | 465, 1.9651 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1348 | `auxiliary.tex` | 7418814, 1.9651, 64804, 7418814, 127346 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1350 | `auxiliary.tex` | 7291468, 0.5, 7546160, 200000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1370 | `auxiliary.tex` | 1, 2030, 827.20, 813.04, 1679213.22, 1650470.12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1371 | `auxiliary.tex` | 2, 1217, 3268.20, 3293.63, 3977396.35, 4008343.01 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1372 | `auxiliary.tex` | 3, 253, 7731.59, 7952.12, 1956092.61, 2011887.29 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1387 | `auxiliary.tex` | 7612702.17, 1.0076 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1393 | `auxiliary.tex` | 7360816, 1.0076, 7416895.23 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1402 | `auxiliary.tex` | 2, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1405 | `auxiliary.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1420 | `auxiliary.tex` | 1, 16204.07, 38070.24, 616892795 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1421 | `auxiliary.tex` | 2, 4501, 49, 587737.51, 2645694719 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1422 | `auxiliary.tex` | 3, 400.15, 2332418.89, 933324559 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1434 | `auxiliary.tex` | 4195912074, 64775.86 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1444 | `auxiliary.tex` | 4195912074, 2, 616892795, 2, 225, 2645694719, 2, 258, 933324559, 2, 97, 465 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1447 | `auxiliary.tex` | 465, 1.9651 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1450 | `auxiliary.tex` | 7416895, 1.9651, 64776, 7416895, 127290 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1452 | `auxiliary.tex` | 7289605, 0.5, 7544185, 200000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1466 | `auxiliary.tex` | 3, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1477 | `auxiliary.tex` | 3, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1478 | `auxiliary.tex` | 3, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1479 | `auxiliary.tex` | 3, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1480 | `auxiliary.tex` | 3, 2, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1481 | `auxiliary.tex` | 3, 2, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1482 | `auxiliary.tex` | 3, 2, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1483 | `auxiliary.tex` | 3, 2, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1492 | `auxiliary.tex` | 3, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1493 | `auxiliary.tex` | 3, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1494 | `auxiliary.tex` | 3, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1495 | `auxiliary.tex` | 3, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1506 | `auxiliary.tex` | 3, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1507 | `auxiliary.tex` | 3, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1508 | `auxiliary.tex` | 3, 4, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1519 | `auxiliary.tex` | 3, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1520 | `auxiliary.tex` | 3, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1521 | `auxiliary.tex` | 3, 5, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1532 | `auxiliary.tex` | 3, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1533 | `auxiliary.tex` | 3, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1534 | `auxiliary.tex` | 3, 6, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1535 | `auxiliary.tex` | 3, 6, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1546 | `auxiliary.tex` | 3, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1547 | `auxiliary.tex` | 3, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1548 | `auxiliary.tex` | 3, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1549 | `auxiliary.tex` | 3, 7, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1550 | `auxiliary.tex` | 3, 7, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1551 | `auxiliary.tex` | 3, 7, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1552 | `auxiliary.tex` | 3, 7, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1563 | `auxiliary.tex` | 3, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1564 | `auxiliary.tex` | 3, 8, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1573 | `auxiliary.tex` | 3, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1574 | `auxiliary.tex` | 3, 9, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1575 | `auxiliary.tex` | 3, 9, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1576 | `auxiliary.tex` | 3, 9, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1577 | `auxiliary.tex` | 3, 9, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1578 | `auxiliary.tex` | 3, 9, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1579 | `auxiliary.tex` | 3, 9, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1593 | `auxiliary.tex` | 3, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1602 | `auxiliary.tex` | 3, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1603 | `auxiliary.tex` | 3, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1604 | `auxiliary.tex` | 3, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1605 | `auxiliary.tex` | 3, 2, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1606 | `auxiliary.tex` | 3, 2, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1607 | `auxiliary.tex` | 3, 2, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1608 | `auxiliary.tex` | 3, 2, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1617 | `auxiliary.tex` | 3, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1618 | `auxiliary.tex` | 3, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1619 | `auxiliary.tex` | 3, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1620 | `auxiliary.tex` | 3, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1629 | `auxiliary.tex` | 3, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1630 | `auxiliary.tex` | 3, 4, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1631 | `auxiliary.tex` | 3, 4, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1640 | `auxiliary.tex` | 3, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1641 | `auxiliary.tex` | 3, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1642 | `auxiliary.tex` | 3, 5, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1651 | `auxiliary.tex` | 3, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1652 | `auxiliary.tex` | 3, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1653 | `auxiliary.tex` | 3, 6, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1654 | `auxiliary.tex` | 3, 6, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1663 | `auxiliary.tex` | 3, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1664 | `auxiliary.tex` | 3, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1665 | `auxiliary.tex` | 3, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1666 | `auxiliary.tex` | 3, 7, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1667 | `auxiliary.tex` | 3, 7, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1668 | `auxiliary.tex` | 3, 7, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1669 | `auxiliary.tex` | 3, 7, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1678 | `auxiliary.tex` | 3, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1679 | `auxiliary.tex` | 3, 8, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1688 | `auxiliary.tex` | 3, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1689 | `auxiliary.tex` | 3, 9, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1690 | `auxiliary.tex` | 3, 9, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1691 | `auxiliary.tex` | 3, 9, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1692 | `auxiliary.tex` | 3, 9, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1693 | `auxiliary.tex` | 3, 9, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1694 | `auxiliary.tex` | 3, 9, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |

## Hypothesis Testing (hyp)

### Files Reviewed

- Manuscript: `hypothesis-testing.tex`
- Support notebook/output: `notebooks/support/hypothesis-testing/support.html`

### Audit Totals

- Total hard-coded numeric values found: 172
- Total values linked dynamically: 3
- Values intentionally left hard-coded: 169

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| 668 | `hypothesis-testing.tex` |  | `\input{generated/worked-calculations/hyp-cell-evaluation-steps}` |
| 721 | `hypothesis-testing.tex` |  | `\input{generated/worked-calculations/hyp-mus-attribute-sample-sizes-rows}` |
| 737 | `hypothesis-testing.tex` |  | `\input{generated/worked-calculations/hyp-mus-sample-size}` |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 84 | `hypothesis-testing.tex` | 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 99 | `hypothesis-testing.tex` | 1, 5%, 5% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 101 | `hypothesis-testing.tex` | 2, 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 117 | `hypothesis-testing.tex` | 4 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 119 | `hypothesis-testing.tex` | 5 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 121 | `hypothesis-testing.tex` | 0.05, 1200, 1200, 0.05, 60 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 123 | `hypothesis-testing.tex` | 6, 90%, 10% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 125 | `hypothesis-testing.tex` | 0.05, 0.05, 10%, 5%, 10%, 5% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 127 | `hypothesis-testing.tex` | 7, 0, 0, 0, 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 129 | `hypothesis-testing.tex` | 0, 2 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 132 | `hypothesis-testing.tex` | 0.05, 10% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 134 | `hypothesis-testing.tex` | 0.05 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 138 | `hypothesis-testing.tex` | 45, 2, 102 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 147 | `hypothesis-testing.tex` | 8 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 149 | `hypothesis-testing.tex` | 9, 0, 45, 1 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 151 | `hypothesis-testing.tex` | 2, 102, 2, 90% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 154 | `hypothesis-testing.tex` | 1, 45, 1200, 60, 0.3294, 10%, 2, 102, 1200, 60, 0.0999 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 161 | `hypothesis-testing.tex` | 2%, 2%, 1, 45, 1200, 0, 02, 1200, 24, 0.6040 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 174 | `hypothesis-testing.tex` | 10%, 5%, 2, 102, 90% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 187 | `hypothesis-testing.tex` | 0, 0.00%, 0.0, 25, 2.08% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 188 | `hypothesis-testing.tex` | 1, 0.98%, 11.8, 43, 3.58% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 189 | `hypothesis-testing.tex` | 2, 1.96%, 23.5, 59, 4.92% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 190 | `hypothesis-testing.tex` | 3, 2.94%, 35.3, 75, 6.25% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 198 | `hypothesis-testing.tex` | 5%, 60, 5%, 1200, 0, 0.05, 0, 60, 5% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 207 | `hypothesis-testing.tex` | 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 209 | `hypothesis-testing.tex` | 5, 0, 5%, 10%, 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 215 | `hypothesis-testing.tex` | 1% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 216 | `hypothesis-testing.tex` | 5% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 217 | `hypothesis-testing.tex` | 10% | Intentionally hard-coded (manual/theoretical) | Table header threshold value is contextual and intentionally manual. |
| 218 | `hypothesis-testing.tex` | 15% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 219 | `hypothesis-testing.tex` | 20% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 223 | `hypothesis-testing.tex` | 0, 299, 59, 29, 19, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 224 | `hypothesis-testing.tex` | 1, 473, 93, 46, 30, 22 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 225 | `hypothesis-testing.tex` | 2, 628, 124, 61, 40, 30 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 226 | `hypothesis-testing.tex` | 3, 773, 153, 76, 50, 37 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 238 | `hypothesis-testing.tex` | 1% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 239 | `hypothesis-testing.tex` | 5% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 240 | `hypothesis-testing.tex` | 10% | Intentionally hard-coded (manual/theoretical) | Table header threshold value is contextual and intentionally manual. |
| 241 | `hypothesis-testing.tex` | 15% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 242 | `hypothesis-testing.tex` | 20% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 246 | `hypothesis-testing.tex` | 0, 230, 45, 22, 15, 11 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 247 | `hypothesis-testing.tex` | 1, 388, 77, 38, 25, 18 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 248 | `hypothesis-testing.tex` | 2, 531, 105, 52, 34, 25 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 249 | `hypothesis-testing.tex` | 3, 667, 132, 65, 43, 32 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 266 | `hypothesis-testing.tex` | 0, 0.05, 10%, 5%, 10% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 268 | `hypothesis-testing.tex` | 45, 0.02, 1, 1, 1, 0.02, 45, 0.40 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 270 | `hypothesis-testing.tex` | 45, 77, 105 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 284 | `hypothesis-testing.tex` | 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 297 | `hypothesis-testing.tex` | 2.8, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 298 | `hypothesis-testing.tex` | 1.8, 2.7, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 299 | `hypothesis-testing.tex` | 0.8, 2.7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 300 | `hypothesis-testing.tex` | 0.8, 2.7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 301 | `hypothesis-testing.tex` | 3.2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 302 | `hypothesis-testing.tex` | 0.4, 2.7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 303 | `hypothesis-testing.tex` | 0.4, 2.7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 305 | `hypothesis-testing.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 306 | `hypothesis-testing.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 308 | `hypothesis-testing.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 324 | `hypothesis-testing.tex` | 0, 0, 0, 1, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 325 | `hypothesis-testing.tex` | 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 331 | `hypothesis-testing.tex` | 1, 0, 1, 0, 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 335 | `hypothesis-testing.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 338 | `hypothesis-testing.tex` | 1, 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 341 | `hypothesis-testing.tex` | 1, 1, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 345 | `hypothesis-testing.tex` | 10%, 5%, 0, 1, 49 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 390 | `hypothesis-testing.tex` | 2 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 392 | `hypothesis-testing.tex` | 0, 120000, 0.01 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 403 | `hypothesis-testing.tex` | 4 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 405 | `hypothesis-testing.tex` | 5, 12000000, 0, 0, 01, 12000000, 120000 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 407 | `hypothesis-testing.tex` | 6, 95%, 5% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 409 | `hypothesis-testing.tex` | 7, 299, 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 411 | `hypothesis-testing.tex` | 8 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 413 | `hypothesis-testing.tex` | 9, 95%, 120000 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 433 | `hypothesis-testing.tex` | 10000, 13500000, 450000, 100000 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 436 | `hypothesis-testing.tex` | 5%, 450000, 100000, 95% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 440 | `hypothesis-testing.tex` | 0, 1, 299, 473 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 442 | `hypothesis-testing.tex` | 145, 450000, 100000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 444 | `hypothesis-testing.tex` | 141, 1, 187, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 448 | `hypothesis-testing.tex` | 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 463 | `hypothesis-testing.tex` | 7, 5, 2, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 473 | `hypothesis-testing.tex` | 0.1, 0, 0, 1.6, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 475 | `hypothesis-testing.tex` | 0.6, 1.6, 0, 3.2, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 477 | `hypothesis-testing.tex` | 0.1, 3.2, 0, 4.8, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 479 | `hypothesis-testing.tex` | 0.1, 4.8, 0, 6.4, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 481 | `hypothesis-testing.tex` | 0.1, 6.4, 0, 8, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 483 | `hypothesis-testing.tex` | 0.1, 8, 0, 9.6, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 485 | `hypothesis-testing.tex` | 0.6, 9.6, 0, 11.2, 0.8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 519 | `hypothesis-testing.tex` | 201702532, 5548.53, 4438.82, 1109.71, 20.00% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 520 | `hypothesis-testing.tex` | 201720040, 670.43, 0.00, 670.43, 100.00% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 521 | `hypothesis-testing.tex` | 201724407, 5761.85, 5531.38, 230.47, 4.00% | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 549 | `hypothesis-testing.tex` | 0, 0.00, 276050.00, 276050.00, 0.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 550 | `hypothesis-testing.tex` | 1, 93103.45, 436007.00, 159957.00, 66853.55 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 551 | `hypothesis-testing.tex` | 2, 186206.90, 577535.00, 141528.00, 48424.55 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 552 | `hypothesis-testing.tex` | 3, 279310.34, 710132.00, 132597.00, 39493.55 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 560 | `hypothesis-testing.tex` | 13500000, 145, 93103.45 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 568 | `hypothesis-testing.tex` | 159957.00, 93103.45, 1, 159957.00, 93103.45, 66853.55 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 585 | `hypothesis-testing.tex` | 1, 100.00%, 93103.45, 93103.45 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 586 | `hypothesis-testing.tex` | 2, 20.00%, 93103.45, 18620.76 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 587 | `hypothesis-testing.tex` | 3, 4.00%, 93103.45, 3724.07 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 612 | `hypothesis-testing.tex` | 1, 100.00%, 66853.55, 66853.55 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 613 | `hypothesis-testing.tex` | 2, 20.00%, 48424.55, 9684.95 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 614 | `hypothesis-testing.tex` | 3, 4.00%, 39493.55, 1579.71 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 626 | `hypothesis-testing.tex` | 115448.28, 354168.21, 469616.49, 95%, 469616.49 | Intentionally hard-coded (checked in support output) | Stringer-bound worked-example result checked against support notebook output. |
| 628 | `hypothesis-testing.tex` | 3 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 631 | `hypothesis-testing.tex` | 100%, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 653 | `hypothesis-testing.tex` | 0, 276050, 276050.00, 276050.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 654 | `hypothesis-testing.tex` | 1, 436007, 100.00%, 93103.45, 100.00%, 276050.00, 369153.45, 436007.00, 436007.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 655 | `hypothesis-testing.tex` | 2, 577535, 20.00%, 18620.69, 60.00%, 436007.00, 454627.69, 346521.00, 454627.69 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 656 | `hypothesis-testing.tex` | 3, 710132, 4.00%, 3724.14, 41.33%, 454627.69, 458351.83, 293497.56, 458351.83 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 680 | `hypothesis-testing.tex` | 20, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 685 | `hypothesis-testing.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 693 | `hypothesis-testing.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 699 | `hypothesis-testing.tex` | 2, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 704 | `hypothesis-testing.tex` | 100% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 707 | `hypothesis-testing.tex` | 13500000, 450000, 100000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 709 | `hypothesis-testing.tex` | 100% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 733 | `hypothesis-testing.tex` | 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 744 | `hypothesis-testing.tex` | 2, 1 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 746 | `hypothesis-testing.tex` | 2, 100000, 300000, 145, 746 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 762 | `hypothesis-testing.tex` | 4, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 763 | `hypothesis-testing.tex` | 4, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 764 | `hypothesis-testing.tex` | 4, 1, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 775 | `hypothesis-testing.tex` | 4, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 784 | `hypothesis-testing.tex` | 4, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 793 | `hypothesis-testing.tex` | 4, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 805 | `hypothesis-testing.tex` | 4, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 806 | `hypothesis-testing.tex` | 4, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 807 | `hypothesis-testing.tex` | 4, 5, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 821 | `hypothesis-testing.tex` | 4, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 822 | `hypothesis-testing.tex` | 4, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 823 | `hypothesis-testing.tex` | 4, 6, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 835 | `hypothesis-testing.tex` | 4, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 836 | `hypothesis-testing.tex` | 4, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 837 | `hypothesis-testing.tex` | 4, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 846 | `hypothesis-testing.tex` | 4, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 847 | `hypothesis-testing.tex` | 4, 8, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 848 | `hypothesis-testing.tex` | 4, 8, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 849 | `hypothesis-testing.tex` | 4, 8, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 850 | `hypothesis-testing.tex` | 4, 8, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 851 | `hypothesis-testing.tex` | 4, 8, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 852 | `hypothesis-testing.tex` | 4, 8, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 864 | `hypothesis-testing.tex` | 4, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 873 | `hypothesis-testing.tex` | 4, 10, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 874 | `hypothesis-testing.tex` | 4, 10, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 889 | `hypothesis-testing.tex` | 4, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 890 | `hypothesis-testing.tex` | 4, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 891 | `hypothesis-testing.tex` | 4, 1, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 900 | `hypothesis-testing.tex` | 4, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 909 | `hypothesis-testing.tex` | 4, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 918 | `hypothesis-testing.tex` | 4, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 927 | `hypothesis-testing.tex` | 4, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 928 | `hypothesis-testing.tex` | 4, 5, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 929 | `hypothesis-testing.tex` | 4, 5, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 938 | `hypothesis-testing.tex` | 4, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 939 | `hypothesis-testing.tex` | 4, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 940 | `hypothesis-testing.tex` | 4, 6, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 949 | `hypothesis-testing.tex` | 4, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 950 | `hypothesis-testing.tex` | 4, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 951 | `hypothesis-testing.tex` | 4, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 960 | `hypothesis-testing.tex` | 4, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 961 | `hypothesis-testing.tex` | 4, 8, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 962 | `hypothesis-testing.tex` | 4, 8, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 963 | `hypothesis-testing.tex` | 4, 8, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 964 | `hypothesis-testing.tex` | 4, 8, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 965 | `hypothesis-testing.tex` | 4, 8, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 966 | `hypothesis-testing.tex` | 4, 8, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 975 | `hypothesis-testing.tex` | 4, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 984 | `hypothesis-testing.tex` | 4, 10, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 985 | `hypothesis-testing.tex` | 4, 10, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |

## Regression Analysis (reg)

### Files Reviewed

- Manuscript: `regression-analysis.tex`
- Support notebook/output: `notebooks/support/regression-analysis/support.html`

### Audit Totals

- Total hard-coded numeric values found: 456
- Total values linked dynamically: 8
- Values intentionally left hard-coded: 448

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| 1799 | `regression-analysis.tex` |  | `\input{generated/worked-calculations/reg-inline-linked-values}` |
| 2450 | `regression-analysis.tex` |  | `\input{generated/worked-calculations/reg-annual-expectation-interval}` |
| 2527 | `regression-analysis.tex` |  | `\input{generated/worked-calculations/reg-annual-assurance}` |
| 2558 | `regression-analysis.tex` |  | `\input{generated/worked-calculations/reg-annual-decision-bounds}` |
| 1801 | `regression-analysis.tex` | 3 | `\paragraph{Value of test statistic} We use the Shapiro--Wilk test to obtain the value of the $W$ statistic and its associated $p$ value. For \ttblue{mod.3}, the value of the $W$ statistic is \RegModThreeW, with a $p$ ...` |
| 2529 | `regression-analysis.tex` | 5 | `\paragraph{Step 5. Derive the distribution of the test statistic under the hypotheses}` |
| 2556 | `regression-analysis.tex` | 99% | `The Acceptable Difference Range is defined by the 99\% prediction interval around the expected difference between the expected and recorded revenue:` |
| 2560 | `regression-analysis.tex` | 0 | `A test statistic that falls between these bounds provides sufficient evidence to reject the audit null hypothesis of material misstatement. Test statistics below the lower bound or above the upper bound do not provide...` |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 58 | `regression-analysis.tex` | 2014 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 64 | `regression-analysis.tex` | 2011, 2013, 2014 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 151 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 156 | `regression-analysis.tex` | 1, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 336 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 352 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 377 | `regression-analysis.tex` | 0, 1, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 382 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 549 | `regression-analysis.tex` | 2011, 2013, 2014 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 553 | `regression-analysis.tex` | 90, 60, 30 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 615 | `regression-analysis.tex` | 2, 1, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 643 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 655 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 661 | `regression-analysis.tex` | 1.2, 0.4, 0.2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 678 | `regression-analysis.tex` | 1, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 680 | `regression-analysis.tex` | 0, 0 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 686 | `regression-analysis.tex` | 1, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 693 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 712 | `regression-analysis.tex` | 0, 4897663, 1, 18.99 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 715 | `regression-analysis.tex` | 4897663, 18.99 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 719 | `regression-analysis.tex` | 18.99, 2, 2, 0.397, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 724 | `regression-analysis.tex` | 2, 2, 1.5, 1.5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 732 | `regression-analysis.tex` | 4897663, 2014855, 2.431, 0.0205 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 733 | `regression-analysis.tex` | 18.99, 4.02, 4.728, 0.0000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 751 | `regression-analysis.tex` | 0, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 757 | `regression-analysis.tex` | 10, 20, 30, 36 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 786 | `regression-analysis.tex` | 1.0000, 0.6298, 0.1304, 0.6541 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 787 | `regression-analysis.tex` | 0.6298, 1.0000, 0.5788, 0.0487 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 788 | `regression-analysis.tex` | 0.1304, 0.5788, 1.0000, 0.7248 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 789 | `regression-analysis.tex` | 0.6541, 0.0487, 0.7248, 1.0000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 811 | `regression-analysis.tex` | 1, 4112487, 0, 1980698, 1, 2, 0.397, 0.868, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 824 | `regression-analysis.tex` | 702547, 1046713, 0.6712, 0.5069 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 825 | `regression-analysis.tex` | 21.55, 3.158, 6.8224, 0.0000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 826 | `regression-analysis.tex` | 2965, 4789, 0.6192, 0.5402 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 827 | `regression-analysis.tex` | 9478, 1893, 5.0079, 0.0000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 840 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 861 | `regression-analysis.tex` | 467201, 1471889, 0.3174, 0.75328 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 862 | `regression-analysis.tex` | 34.26, 4.379, 7.8240, 0.00000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 863 | `regression-analysis.tex` | 4923031, 3227574, 1.5253, 0.13840 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 864 | `regression-analysis.tex` | 120941, 43614, 2.7730, 0.00977 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 865 | `regression-analysis.tex` | 1495, 3047, 0.4906, 0.62754 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 866 | `regression-analysis.tex` | 23.63, 6.858, 3.4460, 0.00181 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 867 | `regression-analysis.tex` | 124446, 43928, 2.8329, 0.00846 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 868 | `regression-analysis.tex` | 13340, 21899, 0.6091, 0.54734 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 876 | `regression-analysis.tex` | 0, 1, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 879 | `regression-analysis.tex` | 0, 1, 2, 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 885 | `regression-analysis.tex` | 467201, 34.26, 120941, 1495 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 888 | `regression-analysis.tex` | 1, 467201, 4923031, 5390232, 34.26, 23.63, 10.63, 120941, 124446, 3505, 1495, 13340, 11845 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 891 | `regression-analysis.tex` | 5390232, 10.63, 3505, 11845 | Intentionally hard-coded (Epic 214 scope) | Model equation output is within structured model/test output verification scope (Epic #214). |
| 894 | `regression-analysis.tex` | 1680711, 2, 0.917 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 930 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 940 | `regression-analysis.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 944 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 954 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 958 | `regression-analysis.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 963 | `regression-analysis.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 967 | `regression-analysis.tex` | 2, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 972 | `regression-analysis.tex` | 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 981 | `regression-analysis.tex` | 0.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 985 | `regression-analysis.tex` | 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 990 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 994 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 999 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1003 | `regression-analysis.tex` | 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1030 | `regression-analysis.tex` | 0, 1, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1031 | `regression-analysis.tex` | 0, 1, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1032 | `regression-analysis.tex` | 0, 1, 0, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1033 | `regression-analysis.tex` | 1, 1, 0, 1, 1, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1034 | `regression-analysis.tex` | 0, 1, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1035 | `regression-analysis.tex` | 0, 1, 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1182 | `regression-analysis.tex` | 1, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1186 | `regression-analysis.tex` | 1, 1, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1197 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1213 | `regression-analysis.tex` | 2, 2, 5%, 20, 5%, 1, 0.95, 20, 0.64, 36 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1228 | `regression-analysis.tex` | 36, 22 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1235 | `regression-analysis.tex` | 2, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1250 | `regression-analysis.tex` | 4, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1252 | `regression-analysis.tex` | 1, 0.5, 1, 0.5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1254 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1273 | `regression-analysis.tex` | 22, 2012, 10, 4.1680952, 0.2463804, 0.448000286 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1274 | `regression-analysis.tex` | 29, 2013, 05, 0.2155177, 0.5187665, 0.006479471 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1275 | `regression-analysis.tex` | 30, 2013, 06, 1.3124479, 0.4899321, 0.201612590 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1276 | `regression-analysis.tex` | 34, 2013, 10, 2.3990931, 0.6194744, 1.001187652 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1277 | `regression-analysis.tex` | 36, 2013, 12, 2.2533566, 0.1021413, 0.063025927 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1286 | `regression-analysis.tex` | 22, 34, 36, 34, 29, 30, 34, 22, 30 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1312 | `regression-analysis.tex` | 2012, 5, 2012, 5 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1319 | `regression-analysis.tex` | 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1320 | `regression-analysis.tex` | 6 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1323 | `regression-analysis.tex` | 5000000, 2500000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1324 | `regression-analysis.tex` | 1, 6, 36 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1328 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1330 | `regression-analysis.tex` | 45 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1331 | `regression-analysis.tex` | 22, 2012 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1332 | `regression-analysis.tex` | 5000000, 2500000, 0250, 0000 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1333 | `regression-analysis.tex` | 0.1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1337 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1338 | `regression-analysis.tex` | 1, 1288215, 2, 608990, 3, 1002086, 4, 725783, 5477, 35 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1339 | `regression-analysis.tex` | 6, 894259, 7, 1005443, 8180, 658, 9206, 435, 10618, 143 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1340 | `regression-analysis.tex` | 11394, 919, 12134, 1802, 13133, 4097, 14338, 355, 15, 600937 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1341 | `regression-analysis.tex` | 16127, 5732, 17, 657053, 18, 1038038, 19, 748714, 20176, 320 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1342 | `regression-analysis.tex` | 21, 390729, 22, 4830879, 23, 490111, 24212, 9685, 25991, 66 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1343 | `regression-analysis.tex` | 26185, 1338, 27148, 1242, 28215, 7458, 29255, 669, 30155, 5452 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1344 | `regression-analysis.tex` | 31911, 119, 32899, 648, 33501, 201, 34229, 9683, 35, 2421841 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1349 | `regression-analysis.tex` | 3, 22, 4830879 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1350 | `regression-analysis.tex` | 22, 4830879 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1353 | `regression-analysis.tex` | 3, 22, 2421841 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1354 | `regression-analysis.tex` | 22, 2421841 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1357 | `regression-analysis.tex` | 22, 4830879, 22, 2421841 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1365 | `regression-analysis.tex` | 3, 3, 63, 3, 2.0 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1378 | `regression-analysis.tex` | 580713, 1299338, 0.4469, 0.65836 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1379 | `regression-analysis.tex` | 34.87, 3.87, 9.0211, 0.00000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1380 | `regression-analysis.tex` | 4809519, 2849202, 1.6880, 0.10252 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1381 | `regression-analysis.tex` | 111458, 38501, 2.8950, 0.00727 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1382 | `regression-analysis.tex` | 933, 2690, 0.3467, 0.73142 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1383 | `regression-analysis.tex` | 24.24, 6.05, 4.0046, 0.00042 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1384 | `regression-analysis.tex` | 114963, 38779, 2.9646, 0.00613 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1385 | `regression-analysis.tex` | 12777, 19331, 0.6610, 0.51404 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1403 | `regression-analysis.tex` | 1, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1407 | `regression-analysis.tex` | 10, 10, 2, 0.9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1429 | `regression-analysis.tex` | 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1435 | `regression-analysis.tex` | 10, 3.16 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1438 | `regression-analysis.tex` | 3.16 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1439 | `regression-analysis.tex` | 1, 5.60, 3, 2.47 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1452 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1459 | `regression-analysis.tex` | 0, 0, 10, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1460 | `regression-analysis.tex` | 0, 0, 0, 5.5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1462 | `regression-analysis.tex` | 0, 1, 10, 4.6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1464 | `regression-analysis.tex` | 0, 2.89, 10, 2.89 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1466 | `regression-analysis.tex` | 1.0, 2.91, 1.0, 1.4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1467 | `regression-analysis.tex` | 1.2, 1.4, 1.2, 0.9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1469 | `regression-analysis.tex` | 1, 2.89, 1, 0.9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1470 | `regression-analysis.tex` | 2, 2.89, 2, 1.8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1471 | `regression-analysis.tex` | 3, 2.89, 3, 1.8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1472 | `regression-analysis.tex` | 3.5, 2.89, 3.5, 2.2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1473 | `regression-analysis.tex` | 3.8, 2.89, 3.8, 2.6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1474 | `regression-analysis.tex` | 4.5, 2.89, 4.5, 2.5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1475 | `regression-analysis.tex` | 4.9, 2.89, 4.9, 3.4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1476 | `regression-analysis.tex` | 5.9, 2.89, 5.9, 3.4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1477 | `regression-analysis.tex` | 6.0, 2.89, 6.0, 3.2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1478 | `regression-analysis.tex` | 7.1, 2.89, 7.1, 4.2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1479 | `regression-analysis.tex` | 7.3, 2.89, 7.3, 3.6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1480 | `regression-analysis.tex` | 8.2, 2.89, 8.2, 4.8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1481 | `regression-analysis.tex` | 9.5, 2.89, 9.5, 4.2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1484 | `regression-analysis.tex` | 5.23, 0, 5.23, 2.89 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1486 | `regression-analysis.tex` | 0, 2.89, 5.23, 2.89 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1515 | `regression-analysis.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1516 | `regression-analysis.tex` | 2, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1520 | `regression-analysis.tex` | 2, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1530 | `regression-analysis.tex` | 2, 1, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1535 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1544 | `regression-analysis.tex` | 1, 1, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1551 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1558 | `regression-analysis.tex` | 2, 9.5307, 10, 14 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1574 | `regression-analysis.tex` | 3.7804, 14, 1, 3.7804, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1575 | `regression-analysis.tex` | 5.7503, 14, 34, 1.6913, 13 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1579 | `regression-analysis.tex` | 9.5307, 14, 35 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1590 | `regression-analysis.tex` | 3.7804, 10, 14, 5.7503, 10, 14, 3.7804, 10, 14, 5.7503, 10, 14, 9.5307, 10, 14 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1598 | `regression-analysis.tex` | 3.7804, 10, 14, 1, 3.7804, 10, 14, 5.7503, 10, 14, 34, 1.6913, 10, 13 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1603 | `regression-analysis.tex` | 2, 3.7804, 10, 14, 9.5307, 10, 14, 0.3967 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1606 | `regression-analysis.tex` | 0, 39.7%, 4112487 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1609 | `regression-analysis.tex` | 1, 5.7503, 10, 14, 34, 4112487 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1612 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1627 | `regression-analysis.tex` | 3.7804, 14, 1, 3.7804, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1628 | `regression-analysis.tex` | 3.5110, 14, 1, 3.5110, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1629 | `regression-analysis.tex` | 9.8390, 13, 1, 9.8390, 13 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1630 | `regression-analysis.tex` | 1.2554, 14, 32, 3.9232, 12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1634 | `regression-analysis.tex` | 9.5307, 14, 35 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1644 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1647 | `regression-analysis.tex` | 2, 3.7804, 10, 14, 3.5110, 10, 14, 9.8390, 10, 13, 9.5307, 10, 14, 0.8683 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1650 | `regression-analysis.tex` | 39.67%, 0, 86.83%, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1652 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1657 | `regression-analysis.tex` | 0, 2, 2, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1662 | `regression-analysis.tex` | 2, 2, 1, 2, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1664 | `regression-analysis.tex` | 2, 0, 36, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1666 | `regression-analysis.tex` | 2, 0.3967, 1, 0.3967, 34, 0.3789 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1668 | `regression-analysis.tex` | 1, 1, 2, 0.8683, 0.8667, 1, 2, 0.8559, 1, 0.8586 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1675 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1690 | `regression-analysis.tex` | 0, 1, 2 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1694 | `regression-analysis.tex` | 0, 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1705 | `regression-analysis.tex` | 0, 0.3967, 0.3789, 1202.633, 1207.383 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1706 | `regression-analysis.tex` | 0.8667, 0.8586, 1150.277, 1156.611 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1707 | `regression-analysis.tex` | 1, 0.8683, 0.8559, 1151.848, 1159.766 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1708 | `regression-analysis.tex` | 2, 0.9170, 0.8963, 1143.217, 1157.468 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1715 | `regression-analysis.tex` | 2, 2, 62, 04, 0, 2, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1717 | `regression-analysis.tex` | 0, 2, 0.3789, 1207.383, 1, 2, 0.85, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1719 | `regression-analysis.tex` | 2, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1721 | `regression-analysis.tex` | 22, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1729 | `regression-analysis.tex` | 64, 75% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1765 | `regression-analysis.tex` | 2, 3, 22 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 1793 | `regression-analysis.tex` | 0, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1805 | `regression-analysis.tex` | 5%, 1% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 1831 | `regression-analysis.tex` | 0 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1837 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1845 | `regression-analysis.tex` | 2, 0, 1, 1, 2, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1847 | `regression-analysis.tex` | 2, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1849 | `regression-analysis.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 1853 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1865 | `regression-analysis.tex` | 5%, 1% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 1894 | `regression-analysis.tex` | 1, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1925 | `regression-analysis.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1937 | `regression-analysis.tex` | 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1938 | `regression-analysis.tex` | 1, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1939 | `regression-analysis.tex` | 3 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 1942 | `regression-analysis.tex` | 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1946 | `regression-analysis.tex` | 2, 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1948 | `regression-analysis.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1952 | `regression-analysis.tex` | 5%, 1%, 10% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 1972 | `regression-analysis.tex` | 1, 1, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1996 | `regression-analysis.tex` | 1, 4, 4 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2010 | `regression-analysis.tex` | 14959, 741231, 0.020, 0.984046 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2011 | `regression-analysis.tex` | 34.07, 3.209, 10.615, 0.000000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2012 | `regression-analysis.tex` | 5633141, 2324882, 2.423, 0.022375 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2013 | `regression-analysis.tex` | 82554, 32693, 2.525, 0.017747 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2014 | `regression-analysis.tex` | 2155, 2326, 0.927, 0.362397 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2015 | `regression-analysis.tex` | 22.83, 5.31, 4.303, 0.000198 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2016 | `regression-analysis.tex` | 84539, 33751, 2.505, 0.018590 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2017 | `regression-analysis.tex` | 20135, 13897, 1.449, 0.158894 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2025 | `regression-analysis.tex` | 1, 4, 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2052 | `regression-analysis.tex` | 752767, 1170485, 0.643, 0.525029 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2053 | `regression-analysis.tex` | 35.87, 2.50, 14.327, 0.000000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2054 | `regression-analysis.tex` | 3219526, 1577708, 2.040, 0.050173 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2055 | `regression-analysis.tex` | 121381, 25102, 4.835, 0.000037 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2056 | `regression-analysis.tex` | 23.23, 4.10, 5.661, 0.000004 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2057 | `regression-analysis.tex` | 125064, 25504, 4.904, 0.000031 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2068 | `regression-analysis.tex` | 752767, 35.87, 121381 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2074 | `regression-analysis.tex` | 3972293, 12.64, 3683 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2076 | `regression-analysis.tex` | 752767, 3219526, 3972293, 35.87, 23.23, 12.64, 121381, 125064, 3683 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2078 | `regression-analysis.tex` | 5, 3, 5% | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2100 | `regression-analysis.tex` | 0, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2128 | `regression-analysis.tex` | 5 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2133 | `regression-analysis.tex` | 0.525 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2134 | `regression-analysis.tex` | 5%, 0.050173 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2149 | `regression-analysis.tex` | 0, 1, 2, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2172 | `regression-analysis.tex` | 81.8, 5, 30, 2.2, 16 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2186 | `regression-analysis.tex` | 2014, 606400, 0 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2199 | `regression-analysis.tex` | 752767, 1, 752767 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2200 | `regression-analysis.tex` | 35.87, 606400, 21752892 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2201 | `regression-analysis.tex` | 3219526, 0, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2202 | `regression-analysis.tex` | 121381, 0, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2203 | `regression-analysis.tex` | 23.23, 0, 606400, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2204 | `regression-analysis.tex` | 125064, 0, 0, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2216 | `regression-analysis.tex` | 2014, 22505659, 19228840, 3276819 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2225 | `regression-analysis.tex` | 2, 1, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2231 | `regression-analysis.tex` | 0, 0, 0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2235 | `regression-analysis.tex` | 99% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2237 | `regression-analysis.tex` | 9, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2240 | `regression-analysis.tex` | 9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2246 | `regression-analysis.tex` | 2, 1, 1, 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2254 | `regression-analysis.tex` | 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2268 | `regression-analysis.tex` | 5 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2282 | `regression-analysis.tex` | 2014, 19228840, 18270762, 22505659, 26740557, 3276819 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2283 | `regression-analysis.tex` | 2014, 26792280, 21884851, 26370098, 30855345, 422182 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2284 | `regression-analysis.tex` | 2014, 19935840, 24872800, 29651399, 34429998, 9715559 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2285 | `regression-analysis.tex` | 2014, 13468000, 10117297, 14235543, 18353788, 767543 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2286 | `regression-analysis.tex` | 2014, 7344128, 3275961, 7683165, 12090370, 339037 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2287 | `regression-analysis.tex` | 2014, 11196216, 7225223, 11362096, 15498968, 165880 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2288 | `regression-analysis.tex` | 2014, 13929472, 10572555, 14845538, 19118521, 916066 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2289 | `regression-analysis.tex` | 2014, 12352176, 9357740, 13544329, 17730918, 1192153 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2290 | `regression-analysis.tex` | 2014, 12628944, 8613794, 13497081, 18380369, 868137 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2291 | `regression-analysis.tex` | 2014, 9361000, 8358271, 12609214, 16860157, 3248214 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2292 | `regression-analysis.tex` | 2014, 10164048, 7059618, 11282544, 15505471, 1118496 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2293 | `regression-analysis.tex` | 2014, 18377456, 16921330, 21094017, 25266704, 2716561 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2297 | `regression-analysis.tex` | 174778400, 198680683, 23902283 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2311 | `regression-analysis.tex` | 2014, 99%, 99%, 2, 2014, 500 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2323 | `regression-analysis.tex` | 8, 000, 000 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2326 | `regression-analysis.tex` | 99%, 12 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2342 | `regression-analysis.tex` | 99%, 2014, 2014 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 2355 | `regression-analysis.tex` | 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2366 | `regression-analysis.tex` | 0, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2373 | `regression-analysis.tex` | 12, 0, 1, 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2377 | `regression-analysis.tex` | 12 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2379 | `regression-analysis.tex` | 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2389 | `regression-analysis.tex` | 12, 2, 0 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2392 | `regression-analysis.tex` | 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2396 | `regression-analysis.tex` | 2, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2398 | `regression-analysis.tex` | 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2405 | `regression-analysis.tex` | 12, 2, 12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2459 | `regression-analysis.tex` | 12, 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2461 | `regression-analysis.tex` | 12 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2464 | `regression-analysis.tex` | 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2466 | `regression-analysis.tex` | 1, 12 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2471 | `regression-analysis.tex` | 12, 2 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2511 | `regression-analysis.tex` | 4 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2520 | `regression-analysis.tex` | 1.2, 1.4, 0.2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 2530 | `regression-analysis.tex` | 1, 1 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2532 | `regression-analysis.tex` | 0 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2551 | `regression-analysis.tex` | 99%, 0.01, 1 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2562 | `regression-analysis.tex` | 8 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2593 | `regression-analysis.tex` | 1 | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 2631 | `regression-analysis.tex` | 1 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 2651 | `regression-analysis.tex` | 5, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2662 | `regression-analysis.tex` | 5, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2677 | `regression-analysis.tex` | 5, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2678 | `regression-analysis.tex` | 5, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2679 | `regression-analysis.tex` | 5, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2680 | `regression-analysis.tex` | 5, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2681 | `regression-analysis.tex` | 5, 3, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2682 | `regression-analysis.tex` | 5, 3, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2683 | `regression-analysis.tex` | 5, 3, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2684 | `regression-analysis.tex` | 5, 3, 8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2695 | `regression-analysis.tex` | 5, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2704 | `regression-analysis.tex` | 5, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2714 | `regression-analysis.tex` | 5, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2715 | `regression-analysis.tex` | 5, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2724 | `regression-analysis.tex` | 5, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2725 | `regression-analysis.tex` | 5, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2726 | `regression-analysis.tex` | 5, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2727 | `regression-analysis.tex` | 5, 7, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2736 | `regression-analysis.tex` | 5, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2745 | `regression-analysis.tex` | 5, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2746 | `regression-analysis.tex` | 5, 9, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2747 | `regression-analysis.tex` | 5, 9, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2756 | `regression-analysis.tex` | 5, 10, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2767 | `regression-analysis.tex` | 5, 11, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2776 | `regression-analysis.tex` | 5, 12, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2785 | `regression-analysis.tex` | 5, 13, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2786 | `regression-analysis.tex` | 5, 13, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2787 | `regression-analysis.tex` | 5, 13, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2796 | `regression-analysis.tex` | 5, 14, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2805 | `regression-analysis.tex` | 5, 15, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2806 | `regression-analysis.tex` | 5, 15, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2815 | `regression-analysis.tex` | 5, 16, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2824 | `regression-analysis.tex` | 5, 17, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2825 | `regression-analysis.tex` | 5, 17, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2834 | `regression-analysis.tex` | 5, 18, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2835 | `regression-analysis.tex` | 5, 18, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2846 | `regression-analysis.tex` | 5, 19, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2847 | `regression-analysis.tex` | 5, 19, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2848 | `regression-analysis.tex` | 5, 19, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2849 | `regression-analysis.tex` | 5, 19, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2850 | `regression-analysis.tex` | 5, 19, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2859 | `regression-analysis.tex` | 5, 20, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2860 | `regression-analysis.tex` | 5, 20, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2861 | `regression-analysis.tex` | 5, 20, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2870 | `regression-analysis.tex` | 5, 21, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2879 | `regression-analysis.tex` | 5, 22, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2880 | `regression-analysis.tex` | 5, 22, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2891 | `regression-analysis.tex` | 5, 23, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2892 | `regression-analysis.tex` | 5, 23, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2893 | `regression-analysis.tex` | 5, 23, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2902 | `regression-analysis.tex` | 5, 24, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2903 | `regression-analysis.tex` | 5, 24, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2912 | `regression-analysis.tex` | 5, 25, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2913 | `regression-analysis.tex` | 5, 25, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2922 | `regression-analysis.tex` | 5, 26, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2923 | `regression-analysis.tex` | 5, 26, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2924 | `regression-analysis.tex` | 5, 26, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2925 | `regression-analysis.tex` | 5, 26, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2934 | `regression-analysis.tex` | 5, 27, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2943 | `regression-analysis.tex` | 5, 28, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2952 | `regression-analysis.tex` | 5, 29, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2963 | `regression-analysis.tex` | 5, 30, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2972 | `regression-analysis.tex` | 5, 31, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2973 | `regression-analysis.tex` | 5, 31, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2974 | `regression-analysis.tex` | 5, 31, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2975 | `regression-analysis.tex` | 5, 31, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2986 | `regression-analysis.tex` | 5, 32, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2995 | `regression-analysis.tex` | 5, 33, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 2996 | `regression-analysis.tex` | 5, 33, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3005 | `regression-analysis.tex` | 5, 34, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3016 | `regression-analysis.tex` | 5, 35, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3017 | `regression-analysis.tex` | 5, 35, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3018 | `regression-analysis.tex` | 5, 35, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3028 | `regression-analysis.tex` | 5, 36, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3029 | `regression-analysis.tex` | 5, 36, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3030 | `regression-analysis.tex` | 5, 36, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3031 | `regression-analysis.tex` | 5, 36, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3032 | `regression-analysis.tex` | 5, 36, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3033 | `regression-analysis.tex` | 5, 36, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3048 | `regression-analysis.tex` | 5, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3057 | `regression-analysis.tex` | 5, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3066 | `regression-analysis.tex` | 5, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3067 | `regression-analysis.tex` | 5, 3, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3068 | `regression-analysis.tex` | 5, 3, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3069 | `regression-analysis.tex` | 5, 3, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3070 | `regression-analysis.tex` | 5, 3, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3071 | `regression-analysis.tex` | 5, 3, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3072 | `regression-analysis.tex` | 5, 3, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3073 | `regression-analysis.tex` | 5, 3, 8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3082 | `regression-analysis.tex` | 5, 4, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3091 | `regression-analysis.tex` | 5, 5, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3100 | `regression-analysis.tex` | 5, 6, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3101 | `regression-analysis.tex` | 5, 6, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3110 | `regression-analysis.tex` | 5, 7, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3111 | `regression-analysis.tex` | 5, 7, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3112 | `regression-analysis.tex` | 5, 7, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3113 | `regression-analysis.tex` | 5, 7, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3122 | `regression-analysis.tex` | 5, 8, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3131 | `regression-analysis.tex` | 5, 9, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3132 | `regression-analysis.tex` | 5, 9, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3133 | `regression-analysis.tex` | 5, 9, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3142 | `regression-analysis.tex` | 5, 10, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3151 | `regression-analysis.tex` | 5, 11, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3160 | `regression-analysis.tex` | 5, 12, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3169 | `regression-analysis.tex` | 5, 13, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3170 | `regression-analysis.tex` | 5, 13, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3171 | `regression-analysis.tex` | 5, 13, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3180 | `regression-analysis.tex` | 5, 14, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3189 | `regression-analysis.tex` | 5, 15, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3190 | `regression-analysis.tex` | 5, 15, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3199 | `regression-analysis.tex` | 5, 16, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3208 | `regression-analysis.tex` | 5, 17, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3209 | `regression-analysis.tex` | 5, 17, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3218 | `regression-analysis.tex` | 5, 18, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3219 | `regression-analysis.tex` | 5, 18, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3228 | `regression-analysis.tex` | 5, 19, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3229 | `regression-analysis.tex` | 5, 19, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3230 | `regression-analysis.tex` | 5, 19, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3231 | `regression-analysis.tex` | 5, 19, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3232 | `regression-analysis.tex` | 5, 19, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3241 | `regression-analysis.tex` | 5, 20, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3242 | `regression-analysis.tex` | 5, 20, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3243 | `regression-analysis.tex` | 5, 20, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3252 | `regression-analysis.tex` | 5, 21, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3261 | `regression-analysis.tex` | 5, 22, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3262 | `regression-analysis.tex` | 5, 22, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3271 | `regression-analysis.tex` | 5, 23, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3272 | `regression-analysis.tex` | 5, 23, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3273 | `regression-analysis.tex` | 5, 23, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3282 | `regression-analysis.tex` | 5, 24, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3283 | `regression-analysis.tex` | 5, 24, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3292 | `regression-analysis.tex` | 5, 25, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3293 | `regression-analysis.tex` | 5, 25, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3302 | `regression-analysis.tex` | 5, 26, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3303 | `regression-analysis.tex` | 5, 26, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3304 | `regression-analysis.tex` | 5, 26, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3305 | `regression-analysis.tex` | 5, 26, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3314 | `regression-analysis.tex` | 5, 27, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3323 | `regression-analysis.tex` | 5, 28, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3332 | `regression-analysis.tex` | 5, 29, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3341 | `regression-analysis.tex` | 5, 30, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3350 | `regression-analysis.tex` | 5, 31, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3351 | `regression-analysis.tex` | 5, 31, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3352 | `regression-analysis.tex` | 5, 31, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3353 | `regression-analysis.tex` | 5, 31, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3362 | `regression-analysis.tex` | 5, 32, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3371 | `regression-analysis.tex` | 5, 33, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3372 | `regression-analysis.tex` | 5, 33, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3381 | `regression-analysis.tex` | 5, 34, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3390 | `regression-analysis.tex` | 5, 35, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3391 | `regression-analysis.tex` | 5, 35, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3392 | `regression-analysis.tex` | 5, 35, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3401 | `regression-analysis.tex` | 5, 36, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3402 | `regression-analysis.tex` | 5, 36, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3403 | `regression-analysis.tex` | 5, 36, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3404 | `regression-analysis.tex` | 5, 36, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3405 | `regression-analysis.tex` | 5, 36, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 3406 | `regression-analysis.tex` | 5, 36, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |

## Goodness of Fit (gof)

### Files Reviewed

- Manuscript: `goodness-of-fit.tex`
- Support notebook/output: `notebooks/support/goodness-of-fit/support.html`

### Audit Totals

- Total hard-coded numeric values found: 175
- Total values linked dynamically: 0
- Values intentionally left hard-coded: 175

### Values Linked Dynamically

| Line | File | Value(s) | Dynamic object/reference used |
|---:|---|---|---|
| - | - | - | No dynamic linkage rows in this chapter inventory |

### Remaining Hard-coded Values and Justification

| Line | File | Value(s) | Status | Justification |
|---:|---|---|---|---|
| 71 | `goodness-of-fit.tex` | 1835, 1909, 1881, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 73 | `goodness-of-fit.tex` | 1883, 1948, 20000, 30%, 1, 5%, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 92 | `goodness-of-fit.tex` | 1857, 1936, 1900 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 104 | `goodness-of-fit.tex` | 30 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 112 | `goodness-of-fit.tex` | 9, 41, 15, 4, 69 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 138 | `goodness-of-fit.tex` | 1, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 139 | `goodness-of-fit.tex` | 1, 2, 3, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 164 | `goodness-of-fit.tex` | 250, 100, 275, 625 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 165 | `goodness-of-fit.tex` | 0.40, 0.16, 0.44, 1.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 174 | `goodness-of-fit.tex` | 625 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 178 | `goodness-of-fit.tex` | 0, 1, 0.40, 2, 0.16, 3, 0.44 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 187 | `goodness-of-fit.tex` | 40, 15, 12, 13 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 199 | `goodness-of-fit.tex` | 15, 12, 13, 40 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 209 | `goodness-of-fit.tex` | 1, 0.40, 2, 0.16, 3, 0.44 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 212 | `goodness-of-fit.tex` | 40 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 215 | `goodness-of-fit.tex` | 1, 40, 0.40, 16.0 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 216 | `goodness-of-fit.tex` | 2, 40, 0.16, 6.4 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 217 | `goodness-of-fit.tex` | 3, 40, 0.44, 17.6 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 231 | `goodness-of-fit.tex` | 15, 12, 13 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 232 | `goodness-of-fit.tex` | 16.0, 6.4, 17.6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 250 | `goodness-of-fit.tex` | 2, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 251 | `goodness-of-fit.tex` | 15, 16, 2, 16, 12, 6.4, 2, 6.4, 13, 17.6, 2, 17.6 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 252 | `goodness-of-fit.tex` | 0.063, 4.900, 1.202 | Intentionally hard-coded (checked in support output) | Chi-squared component sum checked against support notebook output. |
| 253 | `goodness-of-fit.tex` | 6.165 | Intentionally hard-coded (checked in support output) | Chi-squared statistic result checked against support notebook output. |
| 255 | `goodness-of-fit.tex` | 3 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 258 | `goodness-of-fit.tex` | 1, 3, 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 260 | `goodness-of-fit.tex` | 0.05, 2, 0.05, 2, 5.991 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 263 | `goodness-of-fit.tex` | 2, 6.165, 2, 0.05, 2, 5.991 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 271 | `goodness-of-fit.tex` | 2, 2, 6.165, 0.046 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 275 | `goodness-of-fit.tex` | 0.05 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 288 | `goodness-of-fit.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 299 | `goodness-of-fit.tex` | 1, 2, 1, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 318 | `goodness-of-fit.tex` | 1, 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 323 | `goodness-of-fit.tex` | 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 367 | `goodness-of-fit.tex` | 1.5, 1, 2, 3, 4, 5, 6, 7, 8, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 370 | `goodness-of-fit.tex` | 86, 48, 23, 32, 24, 36, 19, 18, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 381 | `goodness-of-fit.tex` | 10, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 383 | `goodness-of-fit.tex` | 10, 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 387 | `goodness-of-fit.tex` | 1, 2, 9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 402 | `goodness-of-fit.tex` | 0.95, 1, 2, 3, 4, 5, 6, 7, 8, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 404 | `goodness-of-fit.tex` | 31.0, 16.4, 10.7, 11.3, 7.2, 8.6, 5.5, 4.2, 5.1, 335 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 405 | `goodness-of-fit.tex` | 32.7, 17.6, 12.6, 9.8, 7.4, 6.4, 4.9, 5.6, 3.0, 1458 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 406 | `goodness-of-fit.tex` | 32.4, 18.8, 10.1, 10.1, 9.8, 5.5, 4.7, 5.5, 3.1, 741 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 407 | `goodness-of-fit.tex` | 33.4, 18.5, 12.4, 7.5, 7.1, 6.5, 5.5, 4.9, 4.2, 308 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 408 | `goodness-of-fit.tex` | 26.7, 25.2, 15.4, 10.8, 6.7, 5.1, 4.1, 2.8, 3.2, 1800 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 410 | `goodness-of-fit.tex` | 31.2, 19.3, 12.2, 9.9, 7.6, 6.4, 4.9, 4.6, 3.7, 4643 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 452 | `goodness-of-fit.tex` | 6000, 9500, 6, 7, 8, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 492 | `goodness-of-fit.tex` | 300 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 505 | `goodness-of-fit.tex` | 1, 2, 9, 0.3010, 0.1761, 0.1249, 0.0969, 0.0792, 0.0669, 0.0580 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 512 | `goodness-of-fit.tex` | 0, 1, 2, 9, 0.3010, 0.1761, 0.1249, 0.0969, 0.0792 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 513 | `goodness-of-fit.tex` | 0.0669, 0.0580, 0.0512, 0.0458 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 519 | `goodness-of-fit.tex` | 0, 1, 2, 9, 0.3010, 0.1761, 0.1249, 0.0969, 0.0792 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 520 | `goodness-of-fit.tex` | 0.0669, 0.0580, 0.0512, 0.0458 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 543 | `goodness-of-fit.tex` | 1, 1, 2, 3, 4, 5, 6, 7, 8, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 545 | `goodness-of-fit.tex` | 86, 48, 23, 32, 24, 36, 19, 18, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 546 | `goodness-of-fit.tex` | 90.3, 52.8, 37.5, 29.1, 23.8, 20.1, 17.4, 15.3, 13.7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 567 | `goodness-of-fit.tex` | 2, 1, 9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 568 | `goodness-of-fit.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 575 | `goodness-of-fit.tex` | 2, 8 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 587 | `goodness-of-fit.tex` | 1, 9, 1, 8, 0.05, 2, 0.05, 8, 15.51 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 590 | `goodness-of-fit.tex` | 8 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 613 | `goodness-of-fit.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 615 | `goodness-of-fit.tex` | 1, 86, 90.31, 18.57, 0.21 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 616 | `goodness-of-fit.tex` | 2, 48, 52.83, 23.30, 0.44 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 617 | `goodness-of-fit.tex` | 3, 23, 37.48, 209.72, 5.60 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 618 | `goodness-of-fit.tex` | 4, 32, 29.07, 8.57, 0.29 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 619 | `goodness-of-fit.tex` | 5, 24, 23.75, 0.06, 0.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 620 | `goodness-of-fit.tex` | 6, 36, 20.08, 253.32, 12.61 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 621 | `goodness-of-fit.tex` | 7, 19, 17.40, 2.57, 0.15 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 622 | `goodness-of-fit.tex` | 8, 18, 15.35, 7.05, 0.46 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 623 | `goodness-of-fit.tex` | 9, 14, 13.73, 0.07, 0.01 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 625 | `goodness-of-fit.tex` | 300, 300.00, 2, 19.77 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 632 | `goodness-of-fit.tex` | 2, 19.77 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 636 | `goodness-of-fit.tex` | 2, 19.77, 15.51, 5% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 648 | `goodness-of-fit.tex` | 2 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 653 | `goodness-of-fit.tex` | 90% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 667 | `goodness-of-fit.tex` | 10, 11, 12, 99 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 677 | `goodness-of-fit.tex` | 1, 1 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 679 | `goodness-of-fit.tex` | 10, 11, 99 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 709 | `goodness-of-fit.tex` | 39, 69, 60, 72, 70, 58, 65, 55, 59, 53 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 711 | `goodness-of-fit.tex` | 0, 1, 2, 9 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 715 | `goodness-of-fit.tex` | 0, 1, 9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 718 | `goodness-of-fit.tex` | 0, 1, 9, 0.10 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 738 | `goodness-of-fit.tex` | 1.3, 0, 1, 2, 3, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 740 | `goodness-of-fit.tex` | 39, 69, 60, 72, 53, 600 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 741 | `goodness-of-fit.tex` | 60, 60, 60, 60, 60, 600 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 742 | `goodness-of-fit.tex` | 2, 441, 81, 0, 144, 49 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 743 | `goodness-of-fit.tex` | 2, 7.35, 1.35, 0.00, 2.40, 0.82, 14.50 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 751 | `goodness-of-fit.tex` | 5, 0.1, 5 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 754 | `goodness-of-fit.tex` | 5, 0.1, 50 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 762 | `goodness-of-fit.tex` | 2, 14.50 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 767 | `goodness-of-fit.tex` | 10, 1, 9 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 769 | `goodness-of-fit.tex` | 5% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 772 | `goodness-of-fit.tex` | 2, 0.05, 9, 16.92 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 777 | `goodness-of-fit.tex` | 0.106 | Intentionally hard-coded (Epic 214 scope) | p-value output is handled under Epic #214 structured verification scope. |
| 785 | `goodness-of-fit.tex` | 2, 14.50, 16.92 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 787 | `goodness-of-fit.tex` | 5% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 821 | `goodness-of-fit.tex` | 36, 6 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 826 | `goodness-of-fit.tex` | 1.613923, 2.51122, 4.125143 | Intentionally hard-coded (checked in support output) | Difference computation checked against support notebook output. |
| 831 | `goodness-of-fit.tex` | 4.125143, 6, 0.6891742 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 842 | `goodness-of-fit.tex` | 2.55, 1.85, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 843 | `goodness-of-fit.tex` | 1.85, 1.15, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 844 | `goodness-of-fit.tex` | 1.15, 0.45, 10 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 845 | `goodness-of-fit.tex` | 0.45, 0.25, 10 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 846 | `goodness-of-fit.tex` | 0.25, 0.95, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 847 | `goodness-of-fit.tex` | 0.95, 1.65, 8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 901 | `goodness-of-fit.tex` | 36 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 909 | `goodness-of-fit.tex` | 2.55, 0.0054, 0, 0.19 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 910 | `goodness-of-fit.tex` | 2.55, 1.85, 0.0268, 2, 0.96 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 911 | `goodness-of-fit.tex` | 1.85, 1.15, 0.0929, 1, 3.34 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 912 | `goodness-of-fit.tex` | 1.15, 0.45, 0.2013, 10, 7.25 | Intentionally hard-coded (manual/theoretical) | Context appears referential/illustrative without explicit computation operator. |
| 913 | `goodness-of-fit.tex` | 0.45, 0.25, 0.2724, 10, 9.80 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 914 | `goodness-of-fit.tex` | 0.25, 0.95, 0.2302, 5, 8.29 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 915 | `goodness-of-fit.tex` | 0.95, 1.65, 0.1216, 8, 4.38 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 916 | `goodness-of-fit.tex` | 1.65, 0.0495, 0, 1.78 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 918 | `goodness-of-fit.tex` | 1.0000, 36, 36.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 932 | `goodness-of-fit.tex` | 1, 8 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 933 | `goodness-of-fit.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 945 | `goodness-of-fit.tex` | 2 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 947 | `goodness-of-fit.tex` | 2.55, 0, 0.19, 0.04, 0.19 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 948 | `goodness-of-fit.tex` | 2.55, 1.85, 2, 0.96, 1.07, 1.11 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 949 | `goodness-of-fit.tex` | 1.85, 1.15, 1, 3.34, 5.50, 1.64 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 950 | `goodness-of-fit.tex` | 1.15, 0.45, 10, 7.25, 7.58, 1.05 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 951 | `goodness-of-fit.tex` | 0.45, 0.25, 10, 9.80, 0.04, 0.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 952 | `goodness-of-fit.tex` | 0.25, 0.95, 5, 8.29, 10.82, 1.30 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 953 | `goodness-of-fit.tex` | 0.95, 1.65, 8, 4.38, 13.13, 3.00 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 954 | `goodness-of-fit.tex` | 1.65, 0, 1.78, 3.17, 1.78 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 956 | `goodness-of-fit.tex` | 36, 36.00, 2, 10.09 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 965 | `goodness-of-fit.tex` | 2, 10.09 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 973 | `goodness-of-fit.tex` | 0.05 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 981 | `goodness-of-fit.tex` | 1, 8, 1, 7 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 986 | `goodness-of-fit.tex` | 5% | Intentionally hard-coded (manual/theoretical) | Numeric reference appears contextual rather than a computed manuscript result. |
| 989 | `goodness-of-fit.tex` | 2, 0.05, 7, 14.07 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 992 | `goodness-of-fit.tex` | 14.07 | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 999 | `goodness-of-fit.tex` | 2, 10.09, 14.07 | Intentionally hard-coded (checked in support output) | Numeric token(s) found in chapter support notebook output. |
| 1001 | `goodness-of-fit.tex` | 5% | Intentionally hard-coded (Epic 214 scope) | Model/test-statistic style output belongs to Epic #214 verification track. |
| 1009 | `goodness-of-fit.tex` | 0.184 | Intentionally hard-coded (Epic 214 scope) | p-value output is handled under Epic #214 structured verification scope. |
| 1048 | `goodness-of-fit.tex` | 6, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1057 | `goodness-of-fit.tex` | 6, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1058 | `goodness-of-fit.tex` | 6, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1059 | `goodness-of-fit.tex` | 6, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1060 | `goodness-of-fit.tex` | 6, 2, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1061 | `goodness-of-fit.tex` | 6, 2, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1062 | `goodness-of-fit.tex` | 6, 2, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1063 | `goodness-of-fit.tex` | 6, 2, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1072 | `goodness-of-fit.tex` | 6, 2, 8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1081 | `goodness-of-fit.tex` | 6, 2, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1090 | `goodness-of-fit.tex` | 6, 2, 10 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1099 | `goodness-of-fit.tex` | 6, 2, 11 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1100 | `goodness-of-fit.tex` | 6, 2, 12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1101 | `goodness-of-fit.tex` | 6, 2, 13 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1102 | `goodness-of-fit.tex` | 6, 2, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1103 | `goodness-of-fit.tex` | 6, 2, 15 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1104 | `goodness-of-fit.tex` | 6, 2, 16 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1113 | `goodness-of-fit.tex` | 6, 2, 17 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1114 | `goodness-of-fit.tex` | 6, 2, 18 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1125 | `goodness-of-fit.tex` | 6, 1, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1134 | `goodness-of-fit.tex` | 6, 2, 1 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1135 | `goodness-of-fit.tex` | 6, 2, 2 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1136 | `goodness-of-fit.tex` | 6, 2, 3 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1137 | `goodness-of-fit.tex` | 6, 2, 4 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1138 | `goodness-of-fit.tex` | 6, 2, 5 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1139 | `goodness-of-fit.tex` | 6, 2, 6 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1140 | `goodness-of-fit.tex` | 6, 2, 7 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1149 | `goodness-of-fit.tex` | 6, 2, 8 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1158 | `goodness-of-fit.tex` | 6, 2, 9 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1167 | `goodness-of-fit.tex` | 6, 2, 10 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1176 | `goodness-of-fit.tex` | 6, 2, 11 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1177 | `goodness-of-fit.tex` | 6, 2, 12 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1178 | `goodness-of-fit.tex` | 6, 2, 13 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1179 | `goodness-of-fit.tex` | 6, 2, 14 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1180 | `goodness-of-fit.tex` | 6, 2, 15 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1181 | `goodness-of-fit.tex` | 6, 2, 16 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1190 | `goodness-of-fit.tex` | 6, 2, 17 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |
| 1191 | `goodness-of-fit.tex` | 6, 2, 18 | Intentionally hard-coded (manual/theoretical) | Line contains numeric content but no compute-signal pattern. |

