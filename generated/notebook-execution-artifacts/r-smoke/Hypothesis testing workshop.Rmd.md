---
title: "Workshop Chapter 4: Hypothesis testing"
author: "Lucas Hoogduin"
date: "2026-08-02"
output:
  html_document:
    df_print: paged
---

<!-- GENERATED FILE: edit notebooks/support/hypothesis-testing/support.Rmd in the private ada repository. -->


## Hypothesis testing

### Exercise 4.1. Effect of the critical region on the sample size

The results on page 119 are obtained with the `FSaudit` package, first by creating an attribute object, filling it with the parameters of the test, and then applying the `size()` function.
The relevant parameters are the significance level `alpha`, the number of deviations in the population $M$ `popdev`, the population size $N$ `popn`, and the critical region `c`.


``` r
library(FSaudit)
mySample <- att_obj(alpha = .1, popdev = 60, popn = 1200, c = 0)
mySample <- size(mySample)
mySample$n
```

```
## [1] 45
```
The sample size increases as we increase the critical region to `c = 2`.

``` r
mySample <- size(mySample, c = 2)
mySample$n
```

```
## [1] 102
```

This result is obtained using the default Hypergeometric distribution. To obtain the sample size with the binomial approximation, as in Table 5.3, we specify the distribution when setting up the attribute object.


``` r
mySample2 <- att_obj(
  alpha = .1,
  tdr = .05,
  c = 2,
  dist = "binom"
)
mySample2 <- size(mySample2)
mySample2$n
```

```
## [1] 105
```

### Exercise 4.2. Significance levels

On page 120 we calculated significance levels for the occurrence of finding one or two errors. These probabilities are calculated in `R` with the following code:

``` r
phyper(q = 1, m = 60, n = 1140, k = 45)
```

```
## [1] 0.3294032
```

``` r
phyper(q = 2, m = 60, n = 1140, k = 102)
```

```
## [1] 0.09989878
```
Refer to Equation 2.1.
Remember that `R` uses `q` for the number of errors found $k$, `m` for the number of deviations in the population $M$, `n` for the number of correct items $N - M$, and `k` for the sample size $n$.

### Exercise 4.3. Type II error

On page 121 we also calculated the Type II error, for a scenario with no errors allowed in the sample and 24 errors in the population, or a population error rate of $24 / 200 = 0.02$.


``` r
phyper(0, m = 24, n = 1176, k = 45, lower.tail = FALSE)
```

```
## [1] 0.6040199
```

### Exercise 4.4. One-sided upper bounds

The one-sided upper bounds $p_U$ in Table 5.1 are obtained as follows:


``` r
upper(popn = 1200, n = 102, k = 0, alpha = 0.10) / 1200
```

```
## [1] 0.02083333
```

``` r
upper(popn = 1200, n = 102, k = 3, alpha = 0.10) / 1200
```

```
## [1] 0.0625
```

### Exercise 4.5. Case: European innovation subsidies
The sample size in the *Case: European innovation subsidies* depends on the critical region chosen. When the null hypothesis $H_0 : M \geq 120,000$ is rejected when the sample yields no errors, the critical region is $\{k | k = 0\}$. We first create an `mus_obj` object, and load it with the parameters.

``` r
subsidies <- mus_obj(
  cl = 0.95,
  popBv = 12000000,
  pm = 120000
)
subsidies <- size(subsidies,
  ee = 0
)
subsidies$n
```

```
## [1] 299
```
This result is exactly equal to that of the fixed-attribute sample:

``` r
myAttSample <- att_obj(alpha = 0.05, popn = 12000000, popdev = 120000)
myAttSample <- size(myAttSample, c = 0)
myAttSample$n
```

```
## [1] 299
```
To build a margin for one error, we may increase the critical region to $\{k | k \leq 1\}$, resulting in a sample size of $n =$ 473.


``` r
myAttSample <- size(myAttSample, c = 1)
myAttSample$n
```

```
## [1] 473
```

In MUS, we increase the critical region by anticipating on the expected error (in monetary terms) in the population. Thus, in applications where selected items are either completely correct or completely incorrect, it is easier to calculate the minimum required sample size using the `att_obj` than using the `mus_obj`.

### Exercise 4.6. Case: Accounts receivable circularization

We start by setting up the MUS object `ar` (for Accounts Receivable) in `R` with the `FSaudit` package and first verify that the number of sampling units `popn` and the total book value `popBv` of the sampling frame match those in the population. Notice that these statistics are calculated as soon as the object is loaded with the detail amounts.


``` r
ar <- mus_obj(
  bv = accounts_receivable$amount,
  id = accounts_receivable$invoice
)
ar$popn
```

```
## [1] 10000
```

``` r
ar$popBv
```

```
## [1] 13500000
```
Sample size calculation is invoked with the relevant values from the *Case: Accounts receivable circularization*.


``` r
ar <- size(ar,
  cl = 0.95, pm = 450000, ee = 100000,
  evalMeth = "Stringer"
)
ar$n
```

```
## [1] 145
```
Compare this with the sample size calculated using fixed-attribute sampling.


``` r
ar2 <- att_obj(alpha = 0.05, popn = 13500000, popdev = 450000)
ar2 <- size(ar2, c = 1)
ar2$n
```

```
## [1] 141
```

``` r
ar2 <- size(ar2, c = 2)
ar2$n
```

```
## [1] 187
```

We can therefore infer that with an expected error of `ee = 100000`, we can tolerate between one and two 100% errors.

### Exercise 4.7. Multiple hits with random selection

If we draw a sample of size $n = 1,100$ from the `accounts_receivable` population, the largest sampling units have an almost 100% inclusion probability and with a selection method such as `random` are likely to be hit more than once.

For example, the data file `accounts_receivable`, that comes with the `FSaudit` package, has the following six largest amounts:


``` r
accounts_receivable[order(-accounts_receivable$amount), ][1:6, 1:3]
```

```
## # A tibble: 6 × 3
##   debtor   invoice amount
##    <int>     <int>  <dbl>
## 1  47013 201719763 12050.
## 2  91415 201734940 11981.
## 3  33149 201706806 11586.
## 4  21704 201739548 10795.
## 5  39608 201726290 10520 
## 6  65215 201723585 10377.
```

We set up a new `mus_obj` and use a materiality of `pm = 36730` to arrive at a sample size of 1100.


``` r
multiple <- mus_obj(
  bv = accounts_receivable$amount,
  id = accounts_receivable$invoice,
  pm = 36730
)
multiple <- size(multiple)
multiple$n
```

```
## [1] 1100
```

We select the sample with the selection method `selMeth = "random"` and order it in decreasing order, displaying the six largest book values.


``` r
multiple <- select(multiple, selMeth = "random", seed = 1)
sample <- multiple$sample
head(sample[order(-sample$bv), ])
```

```
##           item       bv      cum     unit previous
## 938  201719763 12049.70  6248492 10416.59  6236442
## 1070 201719763 12049.70  6248492  5378.04  6236442
## 243  201734940 11981.19 12301198   782.72 12289216
## 543  201723585 10377.48  8822377  8218.39  8811999
## 501  201710344  9918.25  7486492  4816.81  7476574
## 822  201710344  9918.25  7486492  6251.71  7476574
```
This example demonstrates that invoices 201719763 and 201710344 were selected twice.

### Exercise 4.8. Stringer bound

We continue the case study sample, and select the sample, now with the "randomized fixed" selection method.


``` r
ar <- select(ar,
  selMeth = "randomized.fixed",
  seed = 345
)
head(ar$sample)
```

```
##        item      bv       cum    unit  previous
## 1 201718988 6789.87  25975.45  948.39  19185.58
## 2 201739677 3938.75 113653.76 3522.40 109715.01
## 3 201706137 1283.61 207433.52  190.95 206149.91
## 4 201705849  419.04 299741.99  121.36 299322.95
## 5 201732788 5821.45 398103.21  266.00 392281.76
## 6 201732288 1208.64 485658.19 1201.66 484449.55
```

Before we can evaluate the sample, we must first provide audit values. These should be provided in a list of the same order as the list of sample book values. We first copy the list of book values into a data frame.


``` r
myResults <- data.frame(item = ar$sample$item, av = ar$sample$bv)
```
Table 5.4. lists the three invoices (items 16, 52, and 124), that are assumed to be in error.

``` r
myResults[c(16, 52, 124), ]
```

```
##          item      av
## 16  201702532 5548.53
## 52  201720040  670.43
## 124 201724407 5761.85
```
We update the audit values of the erroneous items.

``` r
myResults[16, 2] <- 4438.82
myResults[52, 2] <- 0
myResults[124, 2] <- 5531.38
myResults[c(16, 52, 124), ]
```

```
##          item      av
## 16  201702532 4438.82
## 52  201720040    0.00
## 124 201724407 5531.38
```

The updated list of audit values is then submitted to the MUS object for evaluation.


``` r
ar <- evaluate(ar, av = myResults$av, evalMeth = "stringer")
```

The results of the Stringer bound evaluation as presented in Tables 5.6 and 5.7 are stored in the `Precision calculation` attribute.


``` r
ar$evalResults$Over$`Precision calculation`
```

```
##   m      taint projMis100 projMisst     mU mUincr   pgw100  precision
## 1 0         NA         NA        NA 276050     NA       NA 276050.000
## 2 1 1.00000000   93103.45 93103.448 436007 159957 66853.55  66853.552
## 3 2 0.20000072  186206.90 18620.757 577535 141528 48424.55   9684.945
## 4 3 0.03999931  279310.34  3724.073 710132 132597 39493.55   1579.715
```

The upper bounds $M_U$ in Table 5.5 are calculated with the `upper` function from the `FSaudit` package.


``` r
upper(k = 0, popn = 13500000, n = 145, alpha = .05)
```

```
## [1] 276050
```

``` r
upper(k = 1, popn = 13500000, n = 145, alpha = .05)
```

```
## [1] 436007
```

``` r
upper(k = 2, popn = 13500000, n = 145, alpha = .05)
```

```
## [1] 577535
```

``` r
upper(k = 3, popn = 13500000, n = 145, alpha = .05)
```

```
## [1] 710132
```

### Exercise 4.9. Cell evaluation

The results of the cell evaluation method, as presented in Table 5.8, can also be obtained, by changing the evaluation method.


``` r
options(width = 70)
ar <- evaluate(ar, av = myResults$av, evalMeth = "cell")
ar$evalResults$Over$`Precision calculation`
```

```
##   m    mum      taint projMisst     t_ave   mUPrev loadspread
## 1 0 276050         NA        NA        NA       NA   276050.0
## 2 1 436007 1.00000000 93103.448 1.0000000 276050.0   369153.4
## 3 2 577535 0.20000072 18620.757 0.6000004 436007.0   454627.8
## 4 3 710132 0.03999931  3724.073 0.4133333 454627.8   458351.8
##   simplespread stageUPL
## 1     276050.0 276050.0
## 2     436007.0 436007.0
## 3     346521.2 454627.8
## 4     293521.2 458351.8
```

### Exercise 4.10. PPS estimation

Finally, we present results from the `pps` evaluation method. For this purpose, we use audit values stored in the variable `av2`. The total error amount reflected in `av2` is 450,000.


``` r
ar <- evaluate(ar,
  av = myResults$av2,
  evalMeth = "pps"
)
ar$evalResults$`Error estimate`
```

```
## [1] 115448.3
```
A two-sided prediction interval around the PPS estimate is calculated according to Equations 5.6 and 5.7.


``` r
ar$evalResults$`pps estimate`
```

```
## [1] 13384552
```

``` r
ar$evalResults$`Lower bound`
```

```
## [1] 12976389
```

``` r
ar$evalResults$`Upper bound`
```

```
## [1] 13792714
```
