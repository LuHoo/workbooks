# Volume 1 Manuscript Calculation Inventory

Status: draft rollout inventory

## Summary

- Total classified calculation candidates: 1309
- must_be_generated_from_support_notebook: 335
- must_be_checked_against_support_notebook: 383
- static_theoretical_or_illustrative: 534
- handled_by_epic_214_model_test_output: 57
- unclassified: 0

## Classification Policy

- must_be_generated_from_support_notebook: calculation line requires snippet migration or explicit support-output linkage.
- must_be_checked_against_support_notebook: line has notebook-driven values that are present in chapter support output.
- static_theoretical_or_illustrative: intentionally manual/formulaic/reference values.
- handled_by_epic_214_model_test_output: model/test-statistic outputs tracked under Epic #214.

## Probability Distributions

- Support notebook: notebooks/support/probability-distributions/support.html
- Classified calculation candidates: 138

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.pro.0001 | probability-distributions.tex:9 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/prob-inline-linked-values} |
| calc.pro.0002 | probability-distributions.tex:84 | static_theoretical_or_illustrative | intentional_manual | For the following calculations, we assume that the number of erroneously reported PhD degrees is 17. The auditor selects a sample of 60 from the group of 331 PhD degrees. |
| calc.pro.0003 | probability-distributions.tex:87 | static_theoretical_or_illustrative | intentional_manual | What is the probability of finding 0, 1, or 2 errors in each sample? |
| calc.pro.0004 | probability-distributions.tex:102 | static_theoretical_or_illustrative | intentional_manual | In \emph{Case: Number of students}, the attribute is dichotomous: students on the list are either correctly or incorrectly reported. There is no in-between. For example, if government regulations state that a student ... |
| calc.pro.0005 | probability-distributions.tex:111 | static_theoretical_or_illustrative | intentional_manual | In this section, we assume that we sample without replacement. We sample \ProbSampleSize items from the list of \ProbPopulationSize PhDs in the \emph{Case: Number of students}, and we assume that \ProbErrorCount of th... |
| calc.pro.0006 | probability-distributions.tex:148 | static_theoretical_or_illustrative | intentional_manual | We can use Equation \ref{eq:hypergeometric} to calculate the probability of finding no errors in the sample of 60 elements from the list of 331 Ph.D.s.\footnote{See Section \ref{sec:workshop02r} and \ref{sec:workshop0... |
| calc.pro.0007 | probability-distributions.tex:151 | must_be_checked_against_support_notebook | checked_in_support_output | P(\stoch{k} = 0) = \frac{ |
| calc.pro.0008 | probability-distributions.tex:154 | must_be_checked_against_support_notebook | checked_in_support_output | {\left( \begin{array}{c}331\\60\end{array} \right)} = |
| calc.pro.0009 | probability-distributions.tex:155 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{\frac{17!}{0!17!} \frac{314!}{60!254!}}{\frac{331!}{60!271!}} = |
| calc.pro.0010 | probability-distributions.tex:157 | must_be_checked_against_support_notebook | checked_in_support_output | Note that $\left( \begin{array}{c}17\\0\end{array} \right) = 1$. |
| calc.pro.0011 | probability-distributions.tex:160 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{\frac{314!}{60!254!}}{\frac{331!}{60!271!}} = \frac{314!}{60!254!} \frac{60!271!}{331!} = |
| calc.pro.0012 | probability-distributions.tex:164 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{314! 271!}{331! 254!} = \frac{314! 271 \cdot 270 \cdot ... \cdot 255 \cdot 254!}{331 \cdot 330 \cdot ... \cdot 315 \cdot 314! 254!} = |
| calc.pro.0013 | probability-distributions.tex:168 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{271 \cdot 270 \cdot ... \cdot 255 }{331 \cdot 330 \cdot ... \cdot 315} \approx \ProbZeroErrorProbability |
| calc.pro.0014 | probability-distributions.tex:171 | must_be_checked_against_support_notebook | checked_in_support_output | The results are shown in Figure \ref{fig:H2hypergeometric}, where the fourth panel shows the results for a sample size of $n = 60$. We also show the results for different sample sizes to provide an impression of the s... |
| calc.pro.0015 | probability-distributions.tex:184 | static_theoretical_or_illustrative | intentional_manual | The variance is:\nomenclature{$\sigma^2$}{variance, square of the standard deviation $\sigma$} |
| calc.pro.0016 | probability-distributions.tex:186 | must_be_checked_against_support_notebook | checked_in_support_output | \sigma^2 = n \pi (1 - \pi) \frac{N - n}{N - 1} |
| calc.pro.0017 | probability-distributions.tex:190 | must_be_generated_from_support_notebook | migration_required | For \emph{Case: Number of students}, the mean number of errors in the sample is $n M / N =$ 60 $\cdot$ 17 / 331 $\approx 3.0816$. The variance is $n \pi (1 - \pi) \frac{N - n}{N - 1} = 60 \cdot \frac{17}{331} \cdot (1... |
| calc.pro.0018 | probability-distributions.tex:217 | must_be_checked_against_support_notebook | checked_in_support_output | \pi = \frac{M}{N} = \frac{17}{331} = 0.0514 |
| calc.pro.0019 | probability-distributions.tex:225 | must_be_checked_against_support_notebook | checked_in_support_output | P(\stoch{k} = k) = \left(\begin{array}{c}n\\k\end{array}\right)\pi^{k} (1-\pi)^{n-k} |
| calc.pro.0020 | probability-distributions.tex:234 | must_be_checked_against_support_notebook | checked_in_support_output | \sigma^2 = n\pi(1-\pi) |
| calc.pro.0021 | probability-distributions.tex:238 | must_be_checked_against_support_notebook | checked_in_support_output | Comparing Equations \ref{eq:variance_hyper} and \ref{eq:variance_binom}, the difference is the factor $\frac{N - n}{N - 1}$. |
| calc.pro.0022 | probability-distributions.tex:243 | must_be_checked_against_support_notebook | checked_in_support_output | P(\stoch{k} = 1) = \left(\begin{array}{c}60\\1\end{array}\right)0.0514^{1} (1-0.0514)^{60-1} = 0.1373 |
| calc.pro.0023 | probability-distributions.tex:246 | must_be_generated_from_support_notebook | migration_required | The mean number of errors is $\mu =$ 60 $\cdot$ 0.0514 $\approx 3.0816$, and the variance is $\sigma^2 =$ 60 $\cdot$ 0.0514 $\cdot$ (1 - 0.0514) $\approx$ 2.9233. |
| calc.pro.0024 | probability-distributions.tex:250 | must_be_checked_against_support_notebook | checked_in_support_output | The mean of both distributions is the same, and the variance is practically the same if $\frac{N - n}{N - 1} \approx 1$, that is, if $n$ is much smaller than $N$. This implies that both distributions return approximat... |
| calc.pro.0025 | probability-distributions.tex:273 | must_be_checked_against_support_notebook | checked_in_support_output | \sigma^2 = n\pi |
| calc.pro.0026 | probability-distributions.tex:281 | must_be_checked_against_support_notebook | checked_in_support_output | First, we calculate the value of parameter $\mu = n \pi = 60 \cdot 17 / 331 \approx 3.0816$. We then get |
| calc.pro.0027 | probability-distributions.tex:283 | must_be_checked_against_support_notebook | checked_in_support_output | P(\stoch{k} = 3) = \frac{3.0816^3}{3!}e^{-3.08} \approx 0.2238 |
| calc.pro.0028 | probability-distributions.tex:295 | must_be_checked_against_support_notebook | checked_in_support_output | To appreciate the differences between the calculations using three different distributions, we summarize the probabilities for the sample of $n = 60$ items in Table \ref{tab:summaryProbabilities} and Figure \ref{fig:H... |
| calc.pro.0029 | probability-distributions.tex:312 | must_be_generated_from_support_notebook | migration_required | 0     & 0.0304 & 0.0423 & 0.0459 \\ |
| calc.pro.0030 | probability-distributions.tex:313 | must_be_generated_from_support_notebook | migration_required | 1     & 0.1215 & 0.1373 & 0.1414 \\ |
| calc.pro.0031 | probability-distributions.tex:314 | must_be_generated_from_support_notebook | migration_required | 2     & 0.2239 & 0.2193 & 0.2179 \\ |
| calc.pro.0032 | probability-distributions.tex:332 | must_be_generated_from_support_notebook | migration_required | Hypergeometric & 3 & 3.0816 & 2.4007 \\ |
| calc.pro.0033 | probability-distributions.tex:333 | must_be_generated_from_support_notebook | migration_required | Binomial       & 2 & 3.0816 & 2.9233 \\ |
| calc.pro.0034 | probability-distributions.tex:334 | must_be_generated_from_support_notebook | migration_required | Poisson        & 1 & 3.0816 & 3.0816 \\ |
| calc.pro.0035 | probability-distributions.tex:352 | static_theoretical_or_illustrative | intentional_manual | You obtained a large data file with a large number of social security payments. According to the agent, payments were increased from the previous year to adjust for inflation. The mean payment value is 1,030. |
| calc.pro.0036 | probability-distributions.tex:356 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Objective sample 1:} obtain an indication of the variance of the payments. |
| calc.pro.0037 | probability-distributions.tex:359 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Objective sample 2:} obtain an indication of the mean payment. |
| calc.pro.0038 | probability-distributions.tex:360 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Action:} select 200 payments, record their values and calculate their mean and variance. |
| calc.pro.0039 | probability-distributions.tex:363 | static_theoretical_or_illustrative | intentional_manual | The first sample is prepared for the second sample. In Chapter \ref{cha:estimation} we discuss how the sample size of sample 2 can be determined in order to obtain an estimate of the mean value with a certain desired ... |
| calc.pro.0040 | probability-distributions.tex:368 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Sample 1:}  The values of the payments are 930, 1,035, 1,073, 994, 910, 1,033, 947, 1,102, 1,095, 921. |
| calc.pro.0041 | probability-distributions.tex:371 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{Sample 2:} The mean of the $N = \ProbSocSecSampleTwoN$ payments $\bar{x} = \ProbSocSecSampleTwoMean,$ their standard deviation $s = \ProbSocSecSampleTwoSd$. |
| calc.pro.0042 | probability-distributions.tex:374 | static_theoretical_or_illustrative | intentional_manual | Given the sample results, determine whether it is probable that the mean payment value in the population equals 1,030. |
| calc.pro.0043 | probability-distributions.tex:386 | must_be_generated_from_support_notebook | migration_required | 1 & variance & 10  & \ProbSocSecSampleOneMean &  \ProbSocSecSampleOneSd \\ |
| calc.pro.0044 | probability-distributions.tex:387 | static_theoretical_or_illustrative | intentional_manual | 2 & mean     & \ProbSocSecSampleTwoN & \ProbSocSecSampleTwoMean & \ProbSocSecSampleTwoSd \\ |
| calc.pro.0045 | probability-distributions.tex:394 | static_theoretical_or_illustrative | intentional_manual | In Sections \ref{sec:hypergeometric_distribution} - \ref{sec:poisson_distribution} we have seen that with discrete probability distributions we have a mathematical function that assigns the probability of occurrence f... |
| calc.pro.0046 | probability-distributions.tex:405 | static_theoretical_or_illustrative | intentional_manual | The evaluation of sample 1 is executed with the $\chi^2$ distribution in Section \ref{sec:chi_squared_distribution}, and that of sample 2 with the normal distribution in Section \ref{sec:normal_distribution}. We discu... |
| calc.pro.0047 | probability-distributions.tex:436 | must_be_checked_against_support_notebook | checked_in_support_output | f(x) = \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{1}{2}\left( \frac{x-\mu}{\sigma} \right)^2} |
| calc.pro.0048 | probability-distributions.tex:440 | must_be_checked_against_support_notebook | checked_in_support_output | From Equation \ref{eq:normal_distribution} it shows that the probability density function requires two parameters ($\mu$ and $\sigma$). To perform any calculations, we need to \emph{standardize}\index{standardization}... |
| calc.pro.0049 | probability-distributions.tex:443 | must_be_checked_against_support_notebook | checked_in_support_output | f(x) = \frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}\left( z \right)^2} |
| calc.pro.0050 | probability-distributions.tex:447 | static_theoretical_or_illustrative | intentional_manual | Because the population mean $\mu$ and population variance $\sigma^2$ are usually unknown, we use the following estimators: the mean $\mu$ is estimated by the \hlblue{sample mean}\index{sample mean} $\overline{x}$, |
| calc.pro.0051 | probability-distributions.tex:454 | static_theoretical_or_illustrative | intentional_manual | The population variance $\sigma^2$ is estimated using the estimator $s^2$, |
| calc.pro.0052 | probability-distributions.tex:457 | must_be_checked_against_support_notebook | checked_in_support_output | s^2 = \frac{\sum{(x_i - \overline{x})^2}}{n - 1} |
| calc.pro.0053 | probability-distributions.tex:464 | must_be_checked_against_support_notebook | checked_in_support_output | s^2 = \frac{\sum{x^2 - (\sum{x})^2 / n}}{n - 1} |
| calc.pro.0054 | probability-distributions.tex:469 | must_be_generated_from_support_notebook | migration_required | Let us consider the results of Sample 2 from \emph{Case: Social security payments}. The sample size for Sample 2 is $n = 200$. The results for this sample are $\overline{x} =$ 1,012 and $s =  $ 115.26. The sample mean... |
| calc.pro.0055 | probability-distributions.tex:474 | must_be_checked_against_support_notebook | checked_in_support_output | has a standard normal distribution. Note the effect of sample size $n$ on the distribution of the sample mean: when $n = 1$ the sample mean has the same variance as the population, but as the sample size increases, th... |
| calc.pro.0056 | probability-distributions.tex:477 | must_be_generated_from_support_notebook | migration_required | The standard normal distribution has known probabilities between fixed multiples of $s$ around the mean $\mu = 0$, for example, 68.3\% between $z = -1$ and $z = 1$, 95.4\% between $z = -2$ and $z = 2$, and 99.7\% betw... |
| calc.pro.0057 | probability-distributions.tex:480 | must_be_checked_against_support_notebook | checked_in_support_output | Assuming that the population mean is 1,030, we can now calculate the probability of obtaining the result of Sample 2 in the \emph{Case: Social security payments}: a sample mean of 1,012 or less by applying Equation \r... |
| calc.pro.0058 | probability-distributions.tex:482 | must_be_checked_against_support_notebook | checked_in_support_output | z = \frac{1,012 - 1,030}{115.26 / \sqrt{200}} = -2.2086 |
| calc.pro.0059 | probability-distributions.tex:485 | static_theoretical_or_illustrative | intentional_manual | The probabilities for $z$ are tabulated; without statistical software, this is the most efficient way to obtain them. When we look up the rounded value of -2.21 in such a table, the probability of 1.36\% is found.\foo... |
| calc.pro.0060 | probability-distributions.tex:496 | must_be_generated_from_support_notebook | migration_required | Similar to the standard normal distribution, the Student's $t$ distribution has a symmetrical probability density function, with mean $\mu = 0$ and variance $\sigma^2 = \frac{n - 1}{n - 3}$. The variance is greater th... |
| calc.pro.0061 | probability-distributions.tex:498 | must_be_generated_from_support_notebook | migration_required | In the \emph{Case: Social security payments}, the social security agency is principally concerned with the mean value of the payments, not the value of each individual payment. The mean payment of Sample 1 with $n = 1... |
| calc.pro.0062 | probability-distributions.tex:500 | static_theoretical_or_illustrative | intentional_manual | Figure \ref{fig:H2tverdelingen} shows $t$ distributions with 1, 3, 9, and 100 degrees of freedom. |
| calc.pro.0063 | probability-distributions.tex:535 | must_be_checked_against_support_notebook | checked_in_support_output | The mean payment in the sample is $\bar{x}$ = 1,004. The standard deviation of the sample payments is $s$ = 73.78. To calculate the probability of our sample result given the population mean 1,030, we fill out Equatio... |
| calc.pro.0064 | probability-distributions.tex:537 | must_be_checked_against_support_notebook | checked_in_support_output | t = \frac{1,004 - 1,030}{73.78 / \sqrt{10}} = -1.11 |
| calc.pro.0065 | probability-distributions.tex:540 | static_theoretical_or_illustrative | intentional_manual | Similar to the normal distribution, there are tables for the $t$ distribution. In Exercise \ref{ex:student} in Section \ref{sec:workshop02r} and Exercise \ref{ex:student_p} in Section \ref{sec:workshop02p}, the probab... |
| calc.pro.0066 | probability-distributions.tex:549 | must_be_generated_from_support_notebook | migration_required | Therefore, the probability of obtaining a sample mean of 1,004 or less in a sample of 10 items is equal to the probability of $t <$ -1.11. This probability is shown in Figure \ref{fig:H2KansInT} and is approximately e... |
| calc.pro.0067 | probability-distributions.tex:556 | must_be_checked_against_support_notebook | checked_in_support_output | The $\chi^2$ (\emph{chi-squared}) \emph{distribution}\index{$\chi^2$ distribution}\index{chi-squared distribution}\index{distribution!$\chi^2$}\index{distribution!chi-squared} arises naturally when we add the squares ... |
| calc.pro.0068 | probability-distributions.tex:558 | static_theoretical_or_illustrative | intentional_manual | An estimator of population variance $\sigma^2$ is the sample variance given by Equation \ref{eq:sample_variance}: |
| calc.pro.0069 | probability-distributions.tex:560 | must_be_checked_against_support_notebook | checked_in_support_output | s^2 = \frac{\sum \left( x_{i}-\overline{x} \right)^2}{n-1} |
| calc.pro.0070 | probability-distributions.tex:563 | must_be_generated_from_support_notebook | migration_required | The quantity $(n-1)s^2/\sigma^2$ can be used to draw inferences on the population variance, because it has a $\chi^2$ distribution with $n-1$ degrees of freedom if the sample is drawn from a normal distribution. Figur... |
| calc.pro.0071 | probability-distributions.tex:573 | must_be_generated_from_support_notebook | migration_required | The $\chi^2$ distribution can be used to construct a confidence interval of the population variance, for example, for the results of Sample 1 of \emph{Case: Social security payments}. The 95\% upper bound on a $\chi^2... |
| calc.pro.0072 | probability-distributions.tex:575 | must_be_checked_against_support_notebook | checked_in_support_output | \sigma^2 \geq \frac{(n - 1)s^2}{\chi^2} = \frac{(10 - 1) \cdot 73.78^2}{16.92} \approx 2,896 |
| calc.pro.0073 | probability-distributions.tex:577 | static_theoretical_or_illustrative | intentional_manual | is the 95\% lower bound for the population variance. |
| calc.pro.0074 | probability-distributions.tex:579 | must_be_checked_against_support_notebook | checked_in_support_output | Similarly, to calculate the upper bound for $\sigma^2$, we begin with the lower bound of a $\chi^2$ distributed variable of 3.33. |
| calc.pro.0075 | probability-distributions.tex:582 | must_be_checked_against_support_notebook | checked_in_support_output | \sigma^2 \leq \frac{(n - 1)s^2}{\chi^2} = \frac{(10 - 1) \cdot 73.78^2}{3.33} \approx 14,736 |
| calc.pro.0076 | probability-distributions.tex:586 | must_be_generated_from_support_notebook | migration_required | We find that $\sigma^2 \geq$ 2,896. The two one-sided 95\% confidence intervals are combined into a single two-sided 90\% confidence interval of [2,896; 14,736] for the population variance. |
| calc.pro.0077 | probability-distributions.tex:598 | must_be_checked_against_support_notebook | checked_in_support_output | If we divide two independent random variables $X_1$ and $X_2$ each of which has a $\chi^2$ distribution with $k_1$ and $k_2$ degrees of freedom, the resulting random variable $F = X_1 / X_2$ has an $F$ distribution wi... |
| calc.pro.0078 | probability-distributions.tex:607 | static_theoretical_or_illustrative | intentional_manual | Figure \ref{fig:H2Fverdelingen} shows $F$ distributions for different combinations of degrees of freedom. This clearly shows that the distribution is not symmetrical. Negative values for $F$ cannot be observed because... |
| calc.pro.0079 | probability-distributions.tex:609 | handled_by_epic_214_model_test_output | epic_214_scope | A classic example we discuss when introducing hypothesis testing is to compare the outcome of an $F$-distributed test statistic with a critical value at a given significance level. For example, if we know that the tes... |
| calc.pro.0080 | probability-distributions.tex:637 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-1-1} |
| calc.pro.0081 | probability-distributions.tex:640 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-1-2} |
| calc.pro.0082 | probability-distributions.tex:642 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-1-3} |
| calc.pro.0083 | probability-distributions.tex:653 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-2-1} |
| calc.pro.0084 | probability-distributions.tex:663 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-3-1} |
| calc.pro.0085 | probability-distributions.tex:665 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-3-2} |
| calc.pro.0086 | probability-distributions.tex:676 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-4-1} |
| calc.pro.0087 | probability-distributions.tex:678 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-4-2} |
| calc.pro.0088 | probability-distributions.tex:689 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-5-1} |
| calc.pro.0089 | probability-distributions.tex:700 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-6-1} |
| calc.pro.0090 | probability-distributions.tex:702 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-6-2} |
| calc.pro.0091 | probability-distributions.tex:713 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-7-1} |
| calc.pro.0092 | probability-distributions.tex:715 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-1-7-2} |
| calc.pro.0093 | probability-distributions.tex:729 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-1-1} |
| calc.pro.0094 | probability-distributions.tex:730 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-1-2} |
| calc.pro.0095 | probability-distributions.tex:731 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-1-3} |
| calc.pro.0096 | probability-distributions.tex:740 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-2-1} |
| calc.pro.0097 | probability-distributions.tex:749 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-3-1} |
| calc.pro.0098 | probability-distributions.tex:750 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-3-2} |
| calc.pro.0099 | probability-distributions.tex:759 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-4-1} |
| calc.pro.0100 | probability-distributions.tex:760 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-4-2} |
| calc.pro.0101 | probability-distributions.tex:769 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-5-1} |
| calc.pro.0102 | probability-distributions.tex:778 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-6-1} |
| calc.pro.0103 | probability-distributions.tex:779 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-6-2} |
| calc.pro.0104 | probability-distributions.tex:788 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-7-1} |
| calc.pro.0105 | probability-distributions.tex:789 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-1-7-2} |
| calc.pro.0106 | probability-distributions.tex:797 | must_be_checked_against_support_notebook | checked_in_support_output | Several relationships exist among the probability distributions introduced in the preceding sections. We have already seen that some distributions are \hlblue{special cases} of others. For example, the standard normal... |
| calc.pro.0107 | probability-distributions.tex:801 | static_theoretical_or_illustrative | intentional_manual | We have also seen examples of \hlblue{combinations} of random variables; when we introduced the $\chi^2$ distribution, we said that if $X$ follows a normal distribution, $X^2$ follows a $\chi^2$ distribution. |
| calc.pro.0108 | probability-distributions.tex:815 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below= 1 cm of hype] (bino) {binomial}; |
| calc.pro.0109 | probability-distributions.tex:816 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below= 1 cm of bino] (pois) {Poisson}; |
| calc.pro.0110 | probability-distributions.tex:817 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of bino] (stud) {Student's $t$}; |
| calc.pro.0111 | probability-distributions.tex:818 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of pois] (norm) {normal}; |
| calc.pro.0112 | probability-distributions.tex:848 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, below= 0.5 cm of hype] (bino) {binomial}; |
| calc.pro.0113 | probability-distributions.tex:849 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below= 0.5 cm of bino] (pois) {Poisson}; |
| calc.pro.0114 | probability-distributions.tex:850 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of bino] (stud) {Student's $t$}; |
| calc.pro.0115 | probability-distributions.tex:851 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of pois] (norm) {normal}; |
| calc.pro.0116 | probability-distributions.tex:873 | must_be_generated_from_support_notebook | migration_required | Hypergeometric & $n\pi$ & $n\pi (1-\pi) \frac{N - n}{N - 1}$ \\ |
| calc.pro.0117 | probability-distributions.tex:885 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{N - n}{N - 1} \approx \frac{N - n}{N} = 1 - \frac{n}{N} |
| calc.pro.0118 | probability-distributions.tex:893 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{n}{N} < 0.10 |
| calc.pro.0119 | probability-distributions.tex:897 | must_be_generated_from_support_notebook | migration_required | The correction factor $(N - n) / (N - 1)$ is equal to 1 if the sample size $n = 1$ and gradually decreases to zero as the sample size increases to $N$. Consequently, the variance decreases and the probability mass bec... |
| calc.pro.0120 | probability-distributions.tex:906 | must_be_checked_against_support_notebook | checked_in_support_output | Figure \ref{fig:H2_hyp_appr_bin.png} shows a comparison of the probability mass functions for samples of different sizes from a population of $N =$ 1000 elements. The population error rate $\pi = 0.05$. |
| calc.pro.0121 | probability-distributions.tex:910 | must_be_checked_against_support_notebook | checked_in_support_output | The third panel is borderline because $n = 100 = 10\% \cdot N$. The last two panels show a much larger sample size, and the approximation is not very close: the binomial distribution has fatter tails than the hypergeo... |
| calc.pro.0122 | probability-distributions.tex:922 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, below= 0.5 cm of hype] (bino) {binomial}; |
| calc.pro.0123 | probability-distributions.tex:923 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, below= 0.5 cm of bino] (pois) {Poisson}; |
| calc.pro.0124 | probability-distributions.tex:924 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of bino] (stud) {Student's $t$}; |
| calc.pro.0125 | probability-distributions.tex:925 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, right= 1.5 cm of pois] (norm) {normal}; |
| calc.pro.0126 | probability-distributions.tex:957 | must_be_checked_against_support_notebook | checked_in_support_output | Similar to what we discussed in \ref{sub:hypergeometric_approximated_by_binomial}, the difference between the two distributions lies in their variance. As $n$ tends to infinity and $n\pi$ remains constant, the differe... |
| calc.pro.0127 | probability-distributions.tex:959 | must_be_checked_against_support_notebook | checked_in_support_output | We observe that the variance of the Poisson distribution is always greater than that of the binomial distribution, and the difference is smaller for lower values of $\pi$. If $\pi < 0.1$ the adjustment factor $1 - \pi... |
| calc.pro.0128 | probability-distributions.tex:965 | must_be_checked_against_support_notebook | checked_in_support_output | Figure \ref{fig:H2_hyp_appr_poiss.png} shows a comparison of the probability mass functions for a sample of $n = 60$ elements from populations with different error rates. |
| calc.pro.0129 | probability-distributions.tex:986 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below= 0.5 cm of hype] (bino) {binomial}; |
| calc.pro.0130 | probability-distributions.tex:987 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below= 0.5 cm of bino] (pois) {Poisson}; |
| calc.pro.0131 | probability-distributions.tex:988 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, right= 1.5 cm of bino] (stud) {Student's $t$}; |
| calc.pro.0132 | probability-distributions.tex:989 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, right= 1.5 cm of pois] (norm) {normal}; |
| calc.pro.0133 | probability-distributions.tex:1000 | must_be_checked_against_support_notebook | checked_in_support_output | The advantage of approximating the Student's $t$ distribution with the normal distribution lies in the fact that we do not need to consider the number of degrees of freedom ($df = n - 1$). Generally, we assume that th... |
| calc.pro.0134 | probability-distributions.tex:1002 | must_be_checked_against_support_notebook | checked_in_support_output | Table \ref{tab:vergPoissNorm} compares $t$-values for samples of size $n = 50, 100$, and $200$ with the $z$-value from the normal distribution at different significance levels\footnote{Significance levels are explaine... |
| calc.pro.0135 | probability-distributions.tex:1020 | must_be_generated_from_support_notebook | migration_required | 1\%  & 2.405 & 2.365 & 2.345 & 2.326 \\ |
| calc.pro.0136 | probability-distributions.tex:1021 | must_be_generated_from_support_notebook | migration_required | 5\%  & 1.677 & 1.660 & 1.653 & 1.645 \\ |
| calc.pro.0137 | probability-distributions.tex:1022 | must_be_generated_from_support_notebook | migration_required | 10\% & 1.299 & 1.290 & 1.286 & 1.282 \\ |
| calc.pro.0138 | probability-distributions.tex:1040 | must_be_checked_against_support_notebook | checked_in_support_output | Hypergeometric & Binomial & $\frac{n}{N} < 0.10$ \\ |

## Estimation

- Support notebook: notebooks/support/population-estimation/support.html
- Classified calculation candidates: 106

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.est.0139 | estimation.tex:124 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-point-estimate} |
| calc.est.0140 | estimation.tex:125 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-point-estimate-inline-value} |
| calc.est.0141 | estimation.tex:136 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-total-point-estimate} |
| calc.est.0142 | estimation.tex:241 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-interval-95} |
| calc.est.0143 | estimation.tex:245 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-interval-99} |
| calc.est.0144 | estimation.tex:263 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-one-sided-upper-95} |
| calc.est.0145 | estimation.tex:286 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-finite-95} |
| calc.est.0146 | estimation.tex:319 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-minimum-sample-size-infinite} |
| calc.est.0147 | estimation.tex:337 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-stein-interval} |
| calc.est.0148 | estimation.tex:366 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-minimum-sample-size-finite} |
| calc.est.0149 | estimation.tex:387 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-point-estimate} |
| calc.est.0150 | estimation.tex:396 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-total-point-estimate} |
| calc.est.0151 | estimation.tex:440 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-binomial-interval-95} |
| calc.est.0152 | estimation.tex:469 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-minimum-sample-size-normal} |
| calc.est.0153 | estimation.tex:470 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-binomial-interval-extended} |
| calc.est.0154 | estimation.tex:74 | static_theoretical_or_illustrative | intentional_manual | Winesburg (OH) employs 2,222 civil servants. A full list of employee IDs is available. To perform a substantive analysis of the monthly personnel expenses, you want to make a substantive test of the charge for one mon... |
| calc.est.0155 | estimation.tex:76 | static_theoretical_or_illustrative | intentional_manual | To do this, you obtain a random sample of 50 employees employed in January 20XX and determine their gross salaries and genders. The sample results have been partially reproduced in Table \ref{tab:sample50}. The total ... |
| calc.est.0156 | estimation.tex:79 | static_theoretical_or_illustrative | intentional_manual | Estimate, with 95\% confidence, the total monthly payroll for January 20XX, and the proportions of men and women employed by the town. |
| calc.est.0157 | estimation.tex:96 | must_be_generated_from_support_notebook | migration_required | 1602  & 6  & 1 & 1,612 & 910046 & 0 \\ |
| calc.est.0158 | estimation.tex:97 | must_be_generated_from_support_notebook | migration_required | 1946  & 13 & 8 & 4,818 & 536825 & 1 \\ |
| calc.est.0159 | estimation.tex:98 | must_be_generated_from_support_notebook | migration_required | 1690  & 4  & 0 & 1,399 & 468652 & 0 \\ |
| calc.est.0160 | estimation.tex:99 | must_be_generated_from_support_notebook | migration_required | 1967  & 10 & 4 & 2,845 & 890951 & 0 \\ |
| calc.est.0161 | estimation.tex:100 | must_be_generated_from_support_notebook | migration_required | 1013  & 8  & 6 & 2,486 & 688734 & 0 \\ |
| calc.est.0162 | estimation.tex:101 | must_be_generated_from_support_notebook | migration_required | 369   & 15 & 7 & 5,585 & 798493 & 0 \\ |
| calc.est.0163 | estimation.tex:169 | static_theoretical_or_illustrative | intentional_manual | If the true population mean is 3,200.00, as in Figure \ref{fig:H3low_estimate}, the sample mean found to be \EstMeanPointEstimate (marked with an `x') is still close to the true value. This is not as good an estimate ... |
| calc.est.0164 | estimation.tex:172 | must_be_checked_against_support_notebook | checked_in_support_output | We see two borderline sampling distributions, one for samples from a population with a low population mean ($\mu$ = \EstMeanLower95) and one for samples from a population with a high population mean ($\mu$ = \EstMeanU... |
| calc.est.0165 | estimation.tex:173 | static_theoretical_or_illustrative | intentional_manual | ~is just acceptable. If the true population mean is less than \EstMeanLower95, the observed sample mean ends up in the right tail and is distrusted as being exceptionally high, whereas if the true population mean is g... |
| calc.est.0166 | estimation.tex:179 | must_be_generated_from_support_notebook | migration_required | For all values of the population mean between \EstMeanLower95 and \EstMeanUpper95, the sample mean is consistent with the assumption that the sample is obtained from a population with this mean. Hence, we infer that t... |
| calc.est.0167 | estimation.tex:186 | static_theoretical_or_illustrative | intentional_manual | Under certain conditions (we validate these conditions in Chapter \ref{cha:stratified_sampling}), we know that the sample mean has a $t$ distribution with $n-1$ degrees of freedom. To calculate the lower and upper bou... |
| calc.est.0168 | estimation.tex:189 | must_be_checked_against_support_notebook | checked_in_support_output | s^2_{\bar{y}} = \frac{s^2}{n} |
| calc.est.0169 | estimation.tex:198 | static_theoretical_or_illustrative | intentional_manual | In this equation, $s^2$ is the estimated population \emph{variance}\index{variance} from Equation \ref{eq:sample_variance}: |
| calc.est.0170 | estimation.tex:201 | must_be_checked_against_support_notebook | checked_in_support_output | s^2 = \frac{\sum (y_i - \bar{y})^2}{n-1} |
| calc.est.0171 | estimation.tex:216 | must_be_checked_against_support_notebook | checked_in_support_output | \bar{y} \pm t_{\alpha/2} \frac{s}{\sqrt{n}} |
| calc.est.0172 | estimation.tex:220 | must_be_checked_against_support_notebook | checked_in_support_output | The quantity $t_{\alpha/2} {s}/{\sqrt{n}}$\nomenclature{$t_{\alpha/2}$}{two-tailed $t$ value} is referred to as \hlblue{precision achieved}\index{precision!achieved}. The interval around the mean value of an element o... |
| calc.est.0173 | estimation.tex:224 | must_be_checked_against_support_notebook | checked_in_support_output | N \bar{y} \pm N t_{\alpha/2} \frac{s}{\sqrt{n}} |
| calc.est.0174 | estimation.tex:239 | must_be_generated_from_support_notebook | generated_snippet_linked | We use the $t$ distribution with an $\alpha$ value of 5\% to obtain a confidence level of 95\%, and we use $n - 1 = \EstMeanDf$ degrees of freedom. |
| calc.est.0175 | estimation.tex:241 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-interval-95} |
| calc.est.0176 | estimation.tex:245 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-interval-99} |
| calc.est.0177 | estimation.tex:252 | must_be_generated_from_support_notebook | migration_required | In the previous section, we found a 95\% confidence interval for the mean monthly payroll of [\EstMeanLower95,\hspace{0.5em} \EstMeanUpper95]. We can make similar statements about the minimum or maximum mean monthly p... |
| calc.est.0178 | estimation.tex:263 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-one-sided-upper-95} |
| calc.est.0179 | estimation.tex:270 | must_be_checked_against_support_notebook | checked_in_support_output | So far, we have worked with a sample from a large population and have ignored the fact that the population is finite. To consider this effect, we require the \hlblue{finite-population correction factor}\index{finite-p... |
| calc.est.0180 | estimation.tex:273 | must_be_checked_against_support_notebook | checked_in_support_output | \bar{y} \pm t_{\alpha/2} \frac{s}{\sqrt{n}}\sqrt{\frac{N-n}{N-1}} |
| calc.est.0181 | estimation.tex:283 | must_be_checked_against_support_notebook | checked_in_support_output | Figure \ref{fig:fpcf} shows the effects of the finite-population correction factor. The $x$-axis represents the sample size $n$ as a fraction of the population size $N$. The $y$-axis shows the value of $\sqrt{(N - n)/... |
| calc.est.0182 | estimation.tex:286 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-mean-two-sided-finite-95} |
| calc.est.0183 | estimation.tex:295 | must_be_generated_from_support_notebook | migration_required | When we presented the results of the sample, a sample size of $n =$ \EstMeanSampleSize was  determined. The resulting 95\% confidence intervals for the mean monthly payroll of [\EstMeanLower95, \EstMeanUpper95], and f... |
| calc.est.0184 | estimation.tex:303 | must_be_checked_against_support_notebook | checked_in_support_output | N \bar{y} \pm N t_{\alpha/2} \frac{s}{\sqrt{n}} |
| calc.est.0185 | estimation.tex:306 | must_be_checked_against_support_notebook | checked_in_support_output | Suppose we are not satisfied with the precision achieved of \EstMeanTotalPrecision95, which leads to a 95\% two-sided confidence interval of [\EstMeanTotalLower95, \EstMeanTotalUpper95]. Instead, let us assume that we... |
| calc.est.0186 | estimation.tex:309 | must_be_checked_against_support_notebook | checked_in_support_output | N t_{\alpha/2} \frac{s}{\sqrt{n}} \leq E |
| calc.est.0187 | estimation.tex:316 | must_be_checked_against_support_notebook | checked_in_support_output | n \geq \frac{N^2 t_{\alpha/2}^2 s^2}{E^2} |
| calc.est.0188 | estimation.tex:327 | static_theoretical_or_illustrative | intentional_manual | To address these problems, Stein (1945) developed a two-step procedure\footnote{Note that, in this procedure, Stein uses $s_1$ from the initial sample and $\bar{y}$ based on both the initial and additional samples.} g... |
| calc.est.0189 | estimation.tex:330 | must_be_checked_against_support_notebook | checked_in_support_output | N \bar{y}_{tot} \pm N t_{\alpha/2}[n_1-1] \frac{s_1}{\sqrt{n_{tot}}} |
| calc.est.0190 | estimation.tex:344 | must_be_checked_against_support_notebook | checked_in_support_output | We saw in Section \ref{sub:the_effect_of_finiteness} that the finiteness of the population from which we sample has a noticeable effect when the sample size is greater than 10\% of the population size. In the example ... |
| calc.est.0191 | estimation.tex:349 | must_be_checked_against_support_notebook | checked_in_support_output | N \bar{y} \pm N t_{\alpha/2} \frac{s}{\sqrt{n}}\sqrt{\frac{N-n}{N-1}} |
| calc.est.0192 | estimation.tex:355 | must_be_checked_against_support_notebook | checked_in_support_output | N t_{\alpha/2} \frac{s}{\sqrt{n}} \sqrt{\frac{N - n}{N-1}} \leq E |
| calc.est.0193 | estimation.tex:360 | must_be_checked_against_support_notebook | checked_in_support_output | n \geq \frac{N}{1 + \gamma} |
| calc.est.0194 | estimation.tex:364 | must_be_generated_from_support_notebook | generated_snippet_linked | \gamma = \frac{E^2 (N-1)}{N^2 t_{\alpha/2}^2 s^2} \approx \frac{E^2}{N t_{\alpha/2}^2 s^2} |
| calc.est.0195 | estimation.tex:377 | static_theoretical_or_illustrative | intentional_manual | The sample data presented in Table \ref{tab:sample50} also shows the number of men and women. Men were coded with 0, and women were coded with 1. This is an example of a \hlblue{nominal variable}\index{nominal variabl... |
| calc.est.0196 | estimation.tex:385 | must_be_generated_from_support_notebook | generated_snippet_linked | where $k$ denotes the number of women in the sample. Note that when conveniently coding a nominal variable that consists of only two possible values, we can simply sum the observations to obtain a count of the class t... |
| calc.est.0197 | estimation.tex:407 | static_theoretical_or_illustrative | intentional_manual | To calculate a confidence interval\index{confidence interval!proportion}\index{interval!confidence!proportion} for a proportion in a finite population, we should employ the hypergeometric distribution.\footnote{Only i... |
| calc.est.0198 | estimation.tex:409 | static_theoretical_or_illustrative | intentional_manual | The \hlblue{hypergeometric lower bound}\index{hypergeometric lower bound}\index{lower bound!hypergeometric} is defined as the smallest value of $M$ such that the probability of finding this sample result or worse exce... |
| calc.est.0199 | estimation.tex:412 | must_be_checked_against_support_notebook | checked_in_support_output | M_L(k) = min{\sum_{i=k}^n hyp(N, M, n, i) > \alpha /2} |
| calc.est.0200 | estimation.tex:415 | static_theoretical_or_illustrative | intentional_manual | The \hlblue{hypergeometric upper bound}\index{hypergeometric upper bound}\index{upper bound!hypergeometric} is defined as the largest value of $M$ such that the probability of finding this sample result or better exce... |
| calc.est.0201 | estimation.tex:418 | must_be_checked_against_support_notebook | checked_in_support_output | M_U(k) = max{\sum_{i=0}^k hyp(N, M, n, i) > \alpha /2} |
| calc.est.0202 | estimation.tex:425 | must_be_checked_against_support_notebook | checked_in_support_output | p_l(k) = \frac{k}{k + (n - k + 1) F_{\alpha/2}} |
| calc.est.0203 | estimation.tex:429 | must_be_checked_against_support_notebook | checked_in_support_output | with the number of degrees of freedom of $F$ given by $\nu_1 = 2n - 2k + 2$ and $\nu_2 = 2k$.\nomenclature{$p_l$}{lower bound on the proportion of successes in the population $p$, based on the sample result $k$} |
| calc.est.0204 | estimation.tex:434 | must_be_checked_against_support_notebook | checked_in_support_output | p_u(k) = \frac{k + 1}{k + 1 + (n - k)/F_{\alpha/2}} |
| calc.est.0205 | estimation.tex:437 | must_be_checked_against_support_notebook | checked_in_support_output | with the number of degrees of freedom of $F$ given by $\nu_1 = 2k + 2$ and $\nu_2 = 2n - 2k$.\nomenclature{$p_u$}{upper bound on the proportion of successes in the population $p$, based on the sample result $k$} |
| calc.est.0206 | estimation.tex:440 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/est-prop-binomial-interval-95} |
| calc.est.0207 | estimation.tex:442 | must_be_generated_from_support_notebook | generated_snippet_linked | To obtain a one-sided confidence interval for a proportion, we can use Equations \ref{eq:lower_bound_binomial} or \ref{eq:upper_bound_binomial}, again using $\alpha$ rather than $\alpha/2$. |
| calc.est.0208 | estimation.tex:451 | must_be_checked_against_support_notebook | checked_in_support_output | Therefore, we use the normal approximation\footnote{We approve of this approximation if $n \geq 20$, $n\pi \geq 5$ and $n(1-\pi) \geq 5$} for the binomial distribution, using the following equation for a confidence in... |
| calc.est.0209 | estimation.tex:454 | must_be_checked_against_support_notebook | checked_in_support_output | p \pm z_{\alpha/2} \sqrt{p(1-p)/n} |
| calc.est.0210 | estimation.tex:460 | must_be_checked_against_support_notebook | checked_in_support_output | z_{\alpha/2} \sqrt{p(1-p)/n} \leq E |
| calc.est.0211 | estimation.tex:465 | must_be_checked_against_support_notebook | checked_in_support_output | n \geq \frac{(z_{\alpha/2})^2 p(1-p)}{E^2} |
| calc.est.0212 | estimation.tex:477 | must_be_generated_from_support_notebook | migration_required | We notice that  $p-p_l$ is slightly above the target $E = \EstPropTargetPrecision$; this is due to the fact that the normal approximation is \hlblue{anti-conservative}\index{anti-conservative}\footnote{anti-conservati... |
| calc.est.0213 | estimation.tex:502 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-1-1} |
| calc.est.0214 | estimation.tex:503 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-1-2} |
| calc.est.0215 | estimation.tex:512 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-2-1} |
| calc.est.0216 | estimation.tex:513 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-2-2} |
| calc.est.0217 | estimation.tex:522 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-1} |
| calc.est.0218 | estimation.tex:523 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-2} |
| calc.est.0219 | estimation.tex:524 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-3} |
| calc.est.0220 | estimation.tex:525 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-4} |
| calc.est.0221 | estimation.tex:526 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-5} |
| calc.est.0222 | estimation.tex:527 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-3-6} |
| calc.est.0223 | estimation.tex:536 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-4-1} |
| calc.est.0224 | estimation.tex:537 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-4-2} |
| calc.est.0225 | estimation.tex:546 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-5-1} |
| calc.est.0226 | estimation.tex:547 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-5-2} |
| calc.est.0227 | estimation.tex:556 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-6-1} |
| calc.est.0228 | estimation.tex:557 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-2-6-2} |
| calc.est.0229 | estimation.tex:571 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-1-1} |
| calc.est.0230 | estimation.tex:572 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-1-2} |
| calc.est.0231 | estimation.tex:581 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-2-1} |
| calc.est.0232 | estimation.tex:582 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-2-2} |
| calc.est.0233 | estimation.tex:591 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-1} |
| calc.est.0234 | estimation.tex:592 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-2} |
| calc.est.0235 | estimation.tex:593 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-3} |
| calc.est.0236 | estimation.tex:594 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-4} |
| calc.est.0237 | estimation.tex:595 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-5} |
| calc.est.0238 | estimation.tex:596 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-3-6} |
| calc.est.0239 | estimation.tex:605 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-4-1} |
| calc.est.0240 | estimation.tex:606 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-4-2} |
| calc.est.0241 | estimation.tex:615 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-5-1} |
| calc.est.0242 | estimation.tex:616 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-5-2} |
| calc.est.0243 | estimation.tex:625 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-6-1} |
| calc.est.0244 | estimation.tex:626 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-2-6-2} |

## Estimation with Auxiliary Variables and Stratification

- Support notebook: notebooks/support/auxiliary-variables-and-stratification/support.html
- Classified calculation candidates: 294

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.aux.0245 | auxiliary.tex:4 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/aux-inline-linked-values} |
| calc.aux.0246 | auxiliary.tex:123 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/aux-mpu-estimator} |
| calc.aux.0247 | auxiliary.tex:253 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/aux-regression-estimator} |
| calc.aux.0248 | auxiliary.tex:285 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/aux-difference-estimator} |
| calc.aux.0249 | auxiliary.tex:319 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/aux-ratio-estimator} |
| calc.aux.0250 | auxiliary.tex:12 | static_theoretical_or_illustrative | intentional_manual | In Chapter \ref{cha:probability_distributions} we see that the distribution of the sample mean depends on both the distribution from which we sample and the sample size. In Chapter \ref{cha:estimation} we assume that ... |
| calc.aux.0251 | auxiliary.tex:14 | static_theoretical_or_illustrative | intentional_manual | This chapter addresses these issues. The use of an auxiliary variable and/or stratification reduces the imprecision of the estimate and promotes normal distribution of the sample mean. The estimators discussed in this... |
| calc.aux.0252 | auxiliary.tex:71 | must_be_checked_against_support_notebook | checked_in_support_output | As part of the financial statement audit, you perform procedures for the valuation of inventories. There are 3,500 elements, with a total value of $B = 7,360,816$\nomenclature{$B$}{total book value of the population}. |
| calc.aux.0253 | auxiliary.tex:77 | must_be_checked_against_support_notebook | checked_in_support_output | \item the cross-product of book value ($x$) and audit value ($y$)\nomenclature{$y$}{audit value}\\ $\sum x y = $ 3,550,437,464; |
| calc.aux.0254 | auxiliary.tex:78 | must_be_checked_against_support_notebook | checked_in_support_output | \item the squared book values $\sum x^2 = $3,586,086,982; |
| calc.aux.0255 | auxiliary.tex:79 | must_be_checked_against_support_notebook | checked_in_support_output | \item the squared audit values $\sum y^2 = $3,649,977,984; |
| calc.aux.0256 | auxiliary.tex:80 | must_be_checked_against_support_notebook | checked_in_support_output | \item the squared differences $\sum d^2\nomenclature{$d$}{difference $x - y$ between the book value $x$ and audit value $y$} = $135,190,038. |
| calc.aux.0257 | auxiliary.tex:84 | static_theoretical_or_illustrative | intentional_manual | The audited values are then extrapolated to obtain a 95\% two-sided prediction interval for the true value of inventories. The target precision for this estimate is 200,000. |
| calc.aux.0258 | auxiliary.tex:88 | static_theoretical_or_illustrative | intentional_manual | Obtain a 95\% prediction interval for the true value of inventories. |
| calc.aux.0259 | auxiliary.tex:102 | must_be_generated_from_support_notebook | migration_required | 2524 &   728.40 &   842.99 & -114.59 \\ |
| calc.aux.0260 | auxiliary.tex:103 | must_be_generated_from_support_notebook | migration_required | 3065 & 2,199.37 & 1,999.96 &  199.41 \\ |
| calc.aux.0261 | auxiliary.tex:104 | must_be_generated_from_support_notebook | migration_required | 2662 & 1,452.48 & 1,589.65 & -137.17 \\ |
| calc.aux.0262 | auxiliary.tex:105 | must_be_generated_from_support_notebook | migration_required | 3099 &    68.61 &    36.39 &   32.22 \\ |
| calc.aux.0263 | auxiliary.tex:106 | must_be_generated_from_support_notebook | migration_required | 1596 & 5,292.84 & 5,273.66 &   19.18 \\ |
| calc.aux.0264 | auxiliary.tex:107 | must_be_generated_from_support_notebook | migration_required | 582 &   910.03 &   969.29 &  -59.26 \\ |
| calc.aux.0265 | auxiliary.tex:110 | must_be_generated_from_support_notebook | migration_required | Total & 863,201.37 & 864,212.48 & -1,011.11 \\ |
| calc.aux.0266 | auxiliary.tex:121 | must_be_generated_from_support_notebook | generated_snippet_linked | We start addressing the problem in the \emph{Case: Valuation of inventories} with the estimator introduced in the previous chapter. An estimate of the correct value of the population is obtained by extrapolating the a... |
| calc.aux.0267 | auxiliary.tex:125 | must_be_generated_from_support_notebook | generated_snippet_linked | A 95\% two-sided prediction interval on the correct population value is then calculated by applying Equation \ref{eq:two-sided_finite}, multiplied by $N$ |
| calc.aux.0268 | auxiliary.tex:128 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_{MPU} \pm N t_{\alpha/2} \frac{s_{y}}{\sqrt{n}}\sqrt{\frac{N-n}{N}} |
| calc.aux.0269 | auxiliary.tex:137 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_{MPU} \pm g t_{\alpha/2} s_{y} |
| calc.aux.0270 | auxiliary.tex:142 | must_be_checked_against_support_notebook | checked_in_support_output | g = \sqrt{\frac{3,500(3,500 - 400)}{400}} = 164.6967 |
| calc.aux.0271 | auxiliary.tex:145 | must_be_checked_against_support_notebook | checked_in_support_output | 7,561,859 \pm  164.6967 \cdot 1.966 \cdot \sqrt{4,468,220} = |
| calc.aux.0272 | auxiliary.tex:148 | must_be_checked_against_support_notebook | checked_in_support_output | 7,561,859 \pm 684,415 |
| calc.aux.0273 | auxiliary.tex:150 | static_theoretical_or_illustrative | intentional_manual | which then yields the prediction interval [6,877,444; 8,246,274]. |
| calc.aux.0274 | auxiliary.tex:152 | static_theoretical_or_illustrative | intentional_manual | We can see that the precision achieved is 684,415, exceeding the desired precision of 200,000. To achieve this precision by just extending the sample, the sample size should be 2,107,\footnote{Use equation \ref{eq:min... |
| calc.aux.0275 | auxiliary.tex:174 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y} = b_0 + b_1 x |
| calc.aux.0276 | auxiliary.tex:178 | static_theoretical_or_illustrative | intentional_manual | Coefficients $b_0$ and $b_1$ are estimated using a technique called \hlblue{least squares estimation}\index{least squares estimation}\index{estimation!least squares}. This minimizes the vertical distances between each... |
| calc.aux.0277 | auxiliary.tex:180 | must_be_checked_against_support_notebook | checked_in_support_output | b_0 = \bar{y} - b_1 \bar{x} |
| calc.aux.0278 | auxiliary.tex:185 | must_be_checked_against_support_notebook | checked_in_support_output | b_1 = \frac{\sum{xy - n \bar{x} \bar{y}}}{\sum{x^2} - n \bar{x}^2} |
| calc.aux.0279 | auxiliary.tex:186 | must_be_checked_against_support_notebook | checked_in_support_output | = \frac{\sum{x y} - \frac{\sum{x}\sum{y}}{n}}{\sum{x^2} - \frac{(\sum{x})^2}{n}} |
| calc.aux.0280 | auxiliary.tex:191 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y} = \bar{y} - b_1 \bar{x} + b_1 x = \bar{y} + b_1(x - \bar{x}) |
| calc.aux.0281 | auxiliary.tex:196 | must_be_checked_against_support_notebook | checked_in_support_output | N \hat{y} &= N \bar{y} + N b_1(x - \bar{x}) \\ |
| calc.aux.0282 | auxiliary.tex:197 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R &= N \overline{y} + b_1 (X - N \overline{x}) |
| calc.aux.0283 | auxiliary.tex:214 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \pm g t_{\alpha/2} s_{y, R} |
| calc.aux.0284 | auxiliary.tex:217 | must_be_checked_against_support_notebook | checked_in_support_output | The regression variance is calculated as\footnote{Both versions of the formula are valid. Recall that $b_1 = \frac{c_{xy}}{s_x^2}$, and use $r = \frac{c_{xy}}{s_x s_y}$ from Equation \ref{eq:correlation}.} |
| calc.aux.0285 | auxiliary.tex:219 | must_be_checked_against_support_notebook | checked_in_support_output | s_{y, R}^2 = \frac{n - 1}{n - 2}(s_y^2 - 2 b_1 c_{xy} + b_1^2 s_x^2) = s_y^2 \frac{n - 1}{n - 2} (1 - r^2) |
| calc.aux.0286 | auxiliary.tex:224 | must_be_checked_against_support_notebook | checked_in_support_output | c_{xy} = \frac{\sum{x y} - n \bar{x} \bar{y}}{n - 1}= \frac{\sum{xy} - \frac{\sum{x}\sum{y}}{n}}{(n - 1)} |
| calc.aux.0287 | auxiliary.tex:234 | must_be_checked_against_support_notebook | checked_in_support_output | r^2_{xy} = \left( \frac{c_{xy}}{s_{x} s_{y}} \right)^2 |
| calc.aux.0288 | auxiliary.tex:238 | static_theoretical_or_illustrative | intentional_manual | If we approximate the regression variance using a factor $n - 1$ in the denominator rather than $n - 2$, we obtain the following equality relationship: |
| calc.aux.0289 | auxiliary.tex:240 | must_be_checked_against_support_notebook | checked_in_support_output | s_{y, R}^2 = s_y^2 (1 - r_{xy}^2) |
| calc.aux.0290 | auxiliary.tex:242 | static_theoretical_or_illustrative | intentional_manual | This implies that the precision of the regression estimator is always smaller than that of the MPU estimator because $-1 \leq r_{xy} \leq 1$, and therefore, $0 \leq r_{xy}^2 \leq 1$. Consequently, the factor $1 - r^2$... |
| calc.aux.0291 | auxiliary.tex:244 | must_be_checked_against_support_notebook | checked_in_support_output | If there is a strong correlation between the book and audit values, the effect on precision achieved could be considerable. If there is perfect correlation and $r^2 = 1$, the precision achieved is reduced to zero. Thi... |
| calc.aux.0292 | auxiliary.tex:255 | must_be_generated_from_support_notebook | generated_snippet_linked | We can also conclude that using the correlation between book and audit values reduces the precision of the estimate of the correct population value to below the desired precision of 200,000. Therefore, by using the re... |
| calc.aux.0293 | auxiliary.tex:262 | must_be_checked_against_support_notebook | checked_in_support_output | An alternative estimation technique uses the \hlblue{difference estimator}\index{difference estimator}\index{estimator!difference}. It has been very popular with auditors because the calculation of the estimate is not... |
| calc.aux.0294 | auxiliary.tex:275 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_D \pm g t_{\alpha/2} s_d |
| calc.aux.0295 | auxiliary.tex:277 | static_theoretical_or_illustrative | intentional_manual | where $s_d^2$ is the variance of the differences $d$ |
| calc.aux.0296 | auxiliary.tex:280 | must_be_checked_against_support_notebook | checked_in_support_output | s_d^2 = \frac{\sum{d^2} - (\sum{d})^2/n}{n - 1} |
| calc.aux.0297 | auxiliary.tex:294 | must_be_checked_against_support_notebook | checked_in_support_output | Another estimation technique popular among auditors is the \hlblue{ratio estimator}\index{ratio estimator}. Similar to the difference estimator, the point estimate calculation is straightforward and can be performed m... |
| calc.aux.0298 | auxiliary.tex:302 | must_be_checked_against_support_notebook | checked_in_support_output | where $q = \frac{\sum{y}}{\sum{x}}$ is the ratio of the average audit and book values\nomenclature{$q$}{ratio of the average audit and book values}. In \emph{Case: Valuation of inventories}, using the values from Tabl... |
| calc.aux.0299 | auxiliary.tex:308 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_Q \pm g t_{\alpha/2} s_q |
| calc.aux.0300 | auxiliary.tex:311 | static_theoretical_or_illustrative | intentional_manual | where $s_q^2$ is the variance of the ratio estimator |
| calc.aux.0301 | auxiliary.tex:314 | must_be_checked_against_support_notebook | checked_in_support_output | s_q^2 = \frac{\sum{y^2} - 2q\sum{xy} + q^2\sum{x^2}}{n - 1} |
| calc.aux.0302 | auxiliary.tex:335 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \underset{b_1 = 1}{=} N \overline{y} + (X - N \overline{x}) |
| calc.aux.0303 | auxiliary.tex:341 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \underset{b_1 = 1}{=} X - N \frac{\sum{x} - \sum{y}}{n} |
| calc.aux.0304 | auxiliary.tex:347 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \underset{b_1 = 1}{=} X - N \frac{\sum{d}}{n} = \hat{Y}_D |
| calc.aux.0305 | auxiliary.tex:351 | must_be_generated_from_support_notebook | migration_required | Therefore, if we set the slope parameter $b_1$ to equal 1,\footnote{If $b_1 = 1$, then $y = b_0 + x$, or $y - x = b_0$ is constant.} the regression estimator degenerates into the difference estimator. This implies tha... |
| calc.aux.0306 | auxiliary.tex:356 | must_be_checked_against_support_notebook | checked_in_support_output | b_0 = \overline{y} - b_1 \overline{x} \equiv 0 |
| calc.aux.0307 | auxiliary.tex:362 | must_be_checked_against_support_notebook | checked_in_support_output | b_1 = \frac{\overline{y}}{\overline{x}} = \frac{\sum{y}/n}{\sum{x}/n} =\frac{\sum{y}}{\sum{x}} = q |
| calc.aux.0308 | auxiliary.tex:365 | must_be_checked_against_support_notebook | checked_in_support_output | If we use $b_1 = q$ in the formula for the regression estimator, we obtain |
| calc.aux.0309 | auxiliary.tex:368 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \underset{b_1 = q}{=} N \overline{y} + q(X - N \overline{x}) |
| calc.aux.0310 | auxiliary.tex:374 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R \underset{b_1 = q}{=} qB + N \frac{\sum{y}}{n} - N \frac{\sum{y}}{\sum{x}} \frac{\sum{x}}{n} = qB = \hat{Y}_Q |
| calc.aux.0311 | auxiliary.tex:401 | must_be_checked_against_support_notebook | checked_in_support_output | Subtract $X$ from both sides of the equation and then divide the result by $-\overline{d}$\footnote{If $\overline{d} = $ 0, then the two estimators also yield the same result.} |
| calc.aux.0312 | auxiliary.tex:430 | static_theoretical_or_illustrative | intentional_manual | \item provides good \hlblue{coverage}\index{coverage} -- the estimator yields a precision interval that contains the population parameter with a probability of at least $(1 - \alpha)$. Estimators with bad coverage are... |
| calc.aux.0313 | auxiliary.tex:434 | must_be_generated_from_support_notebook | migration_required | To further clarify these criteria, we seeded the \emph{Inventories} population with different error patterns, with a total error of 260,000. The \emph{constant difference} pattern differences are normally distributed,... |
| calc.aux.0314 | auxiliary.tex:444 | must_be_checked_against_support_notebook | checked_in_support_output | We then repeatedly obtained samples of size $n = 100$ and collected the results. The precomputed simulation results are available as a downloadable artifact from the project repository.\footnote{\url{https://github.co... |
| calc.aux.0315 | auxiliary.tex:472 | must_be_generated_from_support_notebook | migration_required | Difference & 260,061 & 259,469 & 258,983 & 261,954 \\ |
| calc.aux.0316 | auxiliary.tex:473 | must_be_generated_from_support_notebook | migration_required | Ratio      & 262,571 & 259,493 & 255,750 & 262,293 \\ |
| calc.aux.0317 | auxiliary.tex:474 | must_be_generated_from_support_notebook | migration_required | Regression & 260,227 & 260,002 & 259,453 & 262,544 \\ |
| calc.aux.0318 | auxiliary.tex:496 | must_be_generated_from_support_notebook | migration_required | Difference & 66,480 & 72,079 & 90,768 & 189,442 \\ |
| calc.aux.0319 | auxiliary.tex:497 | must_be_generated_from_support_notebook | migration_required | Ratio & 71,356 & 67,540 & 77,348 & 187,828 \\ |
| calc.aux.0320 | auxiliary.tex:498 | must_be_generated_from_support_notebook | migration_required | Regression & 66,827 & 67,194 & 67,731 & 192,016 \\ |
| calc.aux.0321 | auxiliary.tex:509 | must_be_checked_against_support_notebook | checked_in_support_output | Finally, we counted the fraction of samples that yielded a confidence interval that contained the true seeded error of 260,000. Because the confidence level used was 95\%, an ideal estimator would cover the correct va... |
| calc.aux.0322 | auxiliary.tex:522 | must_be_generated_from_support_notebook | migration_required | Difference & 94.94\% & 94.85\% & 94.94\% & 78.41\% \\ |
| calc.aux.0323 | auxiliary.tex:523 | must_be_generated_from_support_notebook | migration_required | Ratio & 94.87\% & 95.14\% & 94.51\% & 79.08\% \\ |
| calc.aux.0324 | auxiliary.tex:524 | must_be_generated_from_support_notebook | migration_required | Regression & 94.78\% & 94.88\% & 94.65\% & 78.07\% \\ |
| calc.aux.0325 | auxiliary.tex:533 | must_be_generated_from_support_notebook | migration_required | The results in Table \ref{tab:coverage_of_estimators} illustrate two important aspects of the application of the Central Limit Theorem: convergence to a normal distribution is from below\footnote{Convergence from belo... |
| calc.aux.0326 | auxiliary.tex:555 | static_theoretical_or_illustrative | intentional_manual | Roberts (1978) proposed a modification to the calculation of the standard error. If the number of differences $m$\nomenclature{$m$}{number of (non-zero) differences in the sample} is less than three, the standard erro... |
| calc.aux.0327 | auxiliary.tex:557 | must_be_checked_against_support_notebook | checked_in_support_output | If the number of differences is between three and 19, the standard error is calculated as follows: all three estimators require the upper bound on the percentage of differences, $M_U(k)$, as defined in Equation \ref{e... |
| calc.aux.0328 | auxiliary.tex:559 | must_be_checked_against_support_notebook | checked_in_support_output | We use an example\footnote{See Exercise \ref{ex:sporadic}} from a file that will be used in the next Chapter. The \ttblue{accounts\_receivable} data file contains 10,000 invoices, and the total value of the \ttblue{am... |
| calc.aux.0329 | auxiliary.tex:567 | must_be_checked_against_support_notebook | checked_in_support_output | \bar{d}_m = \frac{\sum{d_m}}{m} = \frac{1,937.98}{6} = 322.9967 |
| calc.aux.0330 | auxiliary.tex:573 | must_be_checked_against_support_notebook | checked_in_support_output | s_{d, m}^2 = \frac{\sum{d_m^2} - \frac{(\sum{d_m})^2}{m}}{m - 1} |
| calc.aux.0331 | auxiliary.tex:577 | must_be_checked_against_support_notebook | checked_in_support_output | s_{d, m}^2 = \frac{2,059,679 - \frac{1,937.98^2}{6}}{6 - 1} = 286,744 |
| calc.aux.0332 | auxiliary.tex:581 | must_be_checked_against_support_notebook | checked_in_support_output | {s'_d}^2 = M_U(m) s_{d, m}^2 + M_U(m)(1 - M_U(m))(\bar{d}_m)^2 |
| calc.aux.0333 | auxiliary.tex:586 | must_be_generated_from_support_notebook | migration_required | {s'_d}^2 &= 0.1147 \cdot 286,744 + 0.1147 \cdot (1 - 0.1147) \cdot 322.9967^2 \\ |
| calc.aux.0334 | auxiliary.tex:587 | must_be_checked_against_support_notebook | checked_in_support_output | &= 43,483.25 |
| calc.aux.0335 | auxiliary.tex:589 | must_be_checked_against_support_notebook | checked_in_support_output | where we have used $M_U(m) = 0.1147$. |
| calc.aux.0336 | auxiliary.tex:590 | must_be_checked_against_support_notebook | checked_in_support_output | Note that $M_U(m)$ is the upper bound on the proportion of errors, given $m = 6$.\footnote{See Equation \ref{eq:upper_bound}} |
| calc.aux.0337 | auxiliary.tex:593 | must_be_checked_against_support_notebook | checked_in_support_output | g = \sqrt{\frac{N(N - n)}{n}} = \sqrt{\frac{10,000 \cdot (10,000 - 100)}{100}} = 994.9874 |
| calc.aux.0338 | auxiliary.tex:595 | must_be_checked_against_support_notebook | checked_in_support_output | such that the result is\footnote{The $t$ value of 2.571 is for a two-sided interval with $\alpha = 0.05$ and df = 5.} |
| calc.aux.0339 | auxiliary.tex:597 | must_be_checked_against_support_notebook | checked_in_support_output | 994.9874 \cdot 2.571 \cdot \sqrt{43,483.25} = 533,347.23 |
| calc.aux.0340 | auxiliary.tex:603 | must_be_checked_against_support_notebook | checked_in_support_output | s_{q, m}^2 = \frac{\sum{y^2} - 2q\sum{xy} + q^2\sum{x^2}}{m - 1} |
| calc.aux.0341 | auxiliary.tex:608 | must_be_generated_from_support_notebook | migration_required | s_{q, m}^2 &= \frac{230,244,509 - 2 \cdot 0.9825 \cdot 231,280,871 + 0.9825^2 \cdot 234,376,912}{6 - 1} \\ |
| calc.aux.0342 | auxiliary.tex:613 | must_be_checked_against_support_notebook | checked_in_support_output | {s'_Q}^2 = M_U(m) s_{Q, m}^2 |
| calc.aux.0343 | auxiliary.tex:616 | must_be_checked_against_support_notebook | checked_in_support_output | = 0.1147 \cdot \AuxSporadicRatioVariance = 46,410.33 |
| calc.aux.0344 | auxiliary.tex:623 | must_be_checked_against_support_notebook | checked_in_support_output | 994.9874 \cdot 2.571 \cdot \sqrt{46,410.33} = 551,006 |
| calc.aux.0345 | auxiliary.tex:631 | must_be_checked_against_support_notebook | checked_in_support_output | {s'_{r}}^2 = {s'_{d}}^2 - 2(b_1 - 1)(c_{xy} - s_x^2) + (b_1 - 1)^2 s_x^2 |
| calc.aux.0346 | auxiliary.tex:634 | must_be_checked_against_support_notebook | checked_in_support_output | where ${s'_{d}}^2$ is the result obtained for the difference estimator in Equation \ref{eq:sd_diff_sporadic} $b_1$ is the slope coefficient, as defined in Equation \ref{eq:regression_slope}, and $s_x^2$ is the varianc... |
| calc.aux.0347 | auxiliary.tex:637 | must_be_generated_from_support_notebook | migration_required | {s'_{r}}^2 &= 43,483.25 - 2(0.9915 - 1)(1,120,631 - 1,130,239) \\ |
| calc.aux.0348 | auxiliary.tex:638 | must_be_generated_from_support_notebook | migration_required | &+ (0.9915 - 1)^2 \cdot 1,130,239 \\ |
| calc.aux.0349 | auxiliary.tex:639 | must_be_checked_against_support_notebook | checked_in_support_output | &= 43,401.57 |
| calc.aux.0350 | auxiliary.tex:646 | must_be_checked_against_support_notebook | checked_in_support_output | 994.9874 \cdot 2.571 \cdot \sqrt{43,401.57} = 532,846 |
| calc.aux.0351 | auxiliary.tex:667 | static_theoretical_or_illustrative | intentional_manual | In some cases, we test all items in a stratum. This stratum is called the \hlblue{census stratum}\index{census stratum}\index{stratum!census} or \hlblue{100\% stratum}\index{100\% stratum}\index{stratum!100\%}. |
| calc.aux.0352 | auxiliary.tex:691 | static_theoretical_or_illustrative | intentional_manual | Apart from an unfortunate distribution of audit differences across strata, as the number of strata increases, we lose degrees of freedom as we make separate estimates of the mean and standard deviation in each stratum... |
| calc.aux.0353 | auxiliary.tex:715 | must_be_checked_against_support_notebook | checked_in_support_output | The desired total book value per stratum is therefore 7,360,816 / 3 = 2,453,605. |
| calc.aux.0354 | auxiliary.tex:726 | must_be_generated_from_support_notebook | migration_required | 1 & 2,431 & 1.57 -- 2,478.93 & 2,452,927.31 \\ |
| calc.aux.0355 | auxiliary.tex:727 | must_be_generated_from_support_notebook | migration_required | 2 & 710   & 2,480.29 -- 4,833.28 & 2,453,454.96 \\ |
| calc.aux.0356 | auxiliary.tex:728 | must_be_generated_from_support_notebook | migration_required | 3 & 359   & 4,839.62 -- 18,496.21 & 2,454,433.73 \\ |
| calc.aux.0357 | auxiliary.tex:747 | static_theoretical_or_illustrative | intentional_manual | The range between the values is thus divided into ten equal parts, each with a width of 1849.46.\footnote{It is also possible to use cells of unequal length. In that case, the square root of the frequency is multiplie... |
| calc.aux.0358 | auxiliary.tex:763 | must_be_generated_from_support_notebook | migration_required | 1 & 1.57 - 1,848.60 & 2,030 & 45.06 & 45.06\\ |
| calc.aux.0359 | auxiliary.tex:764 | must_be_generated_from_support_notebook | migration_required | 2 & 1,851.65 - 3,694.56 & 857 & 29.27 & 74.33 \\ |
| calc.aux.0360 | auxiliary.tex:765 | must_be_generated_from_support_notebook | migration_required | 3 & 3,700.70 - 5,547.71 & 360 & 18.97 & 93.30 \\ |
| calc.aux.0361 | auxiliary.tex:766 | must_be_generated_from_support_notebook | migration_required | 4 & 5,556.67 - 7,398.87 & 154 & 12.41 & 105.71 \\ |
| calc.aux.0362 | auxiliary.tex:767 | must_be_generated_from_support_notebook | migration_required | 5 & 7,406.10 - 9,238.08 & 63 & 7.94 & 113.65 \\ |
| calc.aux.0363 | auxiliary.tex:768 | must_be_generated_from_support_notebook | migration_required | 6 & 9,273.30 - 11,077.31 & 24 & 4.90 & 118.55 \\ |
| calc.aux.0364 | auxiliary.tex:769 | must_be_generated_from_support_notebook | migration_required | 7 & 11,299.53 - 12,723.03 & 7 & 2.65 & 121.20 \\ |
| calc.aux.0365 | auxiliary.tex:770 | must_be_generated_from_support_notebook | migration_required | 8 & 13,131.76 - 14,125.05 & 4 & 2.00 & 123.20 \\ |
| calc.aux.0366 | auxiliary.tex:771 | must_be_generated_from_support_notebook | migration_required | 9 & - & 0 & 0.00 & 123.20 \\ |
| calc.aux.0367 | auxiliary.tex:772 | must_be_generated_from_support_notebook | migration_required | 10 & 18,496.21 & 1 & 1.00 & 124.20 \\ |
| calc.aux.0368 | auxiliary.tex:782 | must_be_checked_against_support_notebook | checked_in_support_output | The total sum of square roots of frequencies of 124.20 is divided by the desired number of strata 3, resulting in a target sum of 41.40. |
| calc.aux.0369 | auxiliary.tex:784 | must_be_checked_against_support_notebook | checked_in_support_output | In the example in Table \ref{tab:class_inventories} the first stratum is formed by class 1. The cumulative sum for class 1 is 45.05, which is greater than 41.40. The sum without class 1 is 0. Since 45.05 is closer to ... |
| calc.aux.0370 | auxiliary.tex:786 | static_theoretical_or_illustrative | intentional_manual | For the second stratum, we add classes 2 and 3 for a subtotal of 48.24, which is closer to 41.40 than the subtotal of 29.27 for class 2 only. Hence, stratum 2 contains classes 2 and 3. |
| calc.aux.0371 | auxiliary.tex:804 | must_be_generated_from_support_notebook | migration_required | 1 & 1.57 - 1,848.60 & 2,030 & 45.06 \\ |
| calc.aux.0372 | auxiliary.tex:805 | must_be_generated_from_support_notebook | migration_required | 2 & 1,851.65 - 5,547.71 & 1,217 & 48.25 \\ |
| calc.aux.0373 | auxiliary.tex:806 | must_be_generated_from_support_notebook | migration_required | 3 & 5,556.67 - 18,496.21 & 253 & 30.89 \\ |
| calc.aux.0374 | auxiliary.tex:831 | static_theoretical_or_illustrative | intentional_manual | Therefore, it is recommended to first obtain a pilot sample of sufficient size (at least 50) to estimate reasonable approximations of these input variables. However, in practice this may not always be possible. |
| calc.aux.0375 | auxiliary.tex:836 | must_be_checked_against_support_notebook | checked_in_support_output | n = \frac{t^2(\sum{N_h s_{y,h}})^2}{E^2 + t^2\sum{N_h s_{y,h}^2}} |
| calc.aux.0376 | auxiliary.tex:854 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 524.12 & 1,063,964 & 557,644,952 \\ |
| calc.aux.0377 | auxiliary.tex:855 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 1,001.24 & 1,218,515 & 1,220,031,365 \\ |
| calc.aux.0378 | auxiliary.tex:856 | must_be_generated_from_support_notebook | migration_required | 3 & 253 & 1,828.32 & 462,564 & 845,712,351 \\ |
| calc.aux.0379 | auxiliary.tex:860 | must_be_generated_from_support_notebook | migration_required | Total & 3,500 & & 2,745,042 & 2,623,388,667 \\ |
| calc.aux.0380 | auxiliary.tex:869 | static_theoretical_or_illustrative | intentional_manual | \footnote{At this stage, the determination of the mean-per-unit $t$ value is arbitrary. We presume that the calculated sample size is greater than 200, and therefore use a mean-per-unit $t$ value with 200 degrees of f... |
| calc.aux.0381 | auxiliary.tex:871 | must_be_checked_against_support_notebook | checked_in_support_output | n = \frac{1.972^2 \cdot 2,745,042^2} {200,000^2 + 1.972^2 \cdot 2,623,388,667} = 584 |
| calc.aux.0382 | auxiliary.tex:879 | must_be_checked_against_support_notebook | checked_in_support_output | Sample allocation is different for the two stratification methods. When we stratify the population by equal recorded value boundaries, the sample is evenly distributed over the strata. With a sample size of $n = 584$,... |
| calc.aux.0383 | auxiliary.tex:900 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 524.12 & 1,063,964 & 226 \\ |
| calc.aux.0384 | auxiliary.tex:901 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 1,001.24 & 1,218,515 & 259 \\ |
| calc.aux.0385 | auxiliary.tex:902 | must_be_generated_from_support_notebook | migration_required | 3 & 253 & 1,828.32 & 462,564 & 98 \\ |
| calc.aux.0386 | auxiliary.tex:906 | must_be_generated_from_support_notebook | migration_required | Total & 3,500 & & 2,745,042 & 583 \\ |
| calc.aux.0387 | auxiliary.tex:917 | must_be_checked_against_support_notebook | checked_in_support_output | n_1 = 584 \cdot \frac{1,063,964}{2,745,042}= 226 |
| calc.aux.0388 | auxiliary.tex:945 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 226 & 183,746.92 &   545.26 \\ |
| calc.aux.0389 | auxiliary.tex:946 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 259 & 853,049.17 & 1,302.54 \\ |
| calc.aux.0390 | auxiliary.tex:947 | must_be_generated_from_support_notebook | migration_required | 3 &   253 &  98 & 779,308.12 & 2,824.72 \\ |
| calc.aux.0391 | auxiliary.tex:971 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030  &   813.04 & 1,650,470.12 \\ |
| calc.aux.0392 | auxiliary.tex:972 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217  & 3,293.63 & 4,008,343.01 \\ |
| calc.aux.0393 | auxiliary.tex:973 | must_be_generated_from_support_notebook | migration_required | 3 &   253  & 7,952.12 & 2,011,887.29 \\ |
| calc.aux.0394 | auxiliary.tex:991 | must_be_checked_against_support_notebook | checked_in_support_output | s^2_{MPU} = \sum_{h = 1}^{L}g_h^2 s_{y,h}^2 |
| calc.aux.0395 | auxiliary.tex:1013 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 226 & 16,204.07 &   297,308 &  4,817,605,606 \\ |
| calc.aux.0396 | auxiliary.tex:1014 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 259 &  4,501.49 & 1,696,612 &  7,637,282,583 \\ |
| calc.aux.0397 | auxiliary.tex:1015 | must_be_generated_from_support_notebook | migration_required | 3 &   253 &  98 &    400.15 & 7,979,066 &  3,192,847,772 \\ |
| calc.aux.0398 | auxiliary.tex:1023 | must_be_checked_against_support_notebook | checked_in_support_output | The standard error of the MPU estimate is the square root of its variance $s_{MPU} = \sqrt{15,647,735,961} = 125,090.91.$ This standard error $s_{MPU}$ is then used to obtain the lower and upper bounds of the predicti... |
| calc.aux.0399 | auxiliary.tex:1033 | must_be_checked_against_support_notebook | checked_in_support_output | df_e = \frac{(\sum g_h^2 s_{y,h}^2)^2}{\sum \frac{(g_h^2 s_{y,h}^2)^2}{n_h - 1}} |
| calc.aux.0400 | auxiliary.tex:1040 | must_be_checked_against_support_notebook | checked_in_support_output | df_{e, MPU} = \frac{15,647,735,961^2}{\frac{4,817,605,606^2}{225} + \frac{7,637,282,583^2}{258} + \frac{3,192,847,772^2}{97}} = 564 |
| calc.aux.0401 | auxiliary.tex:1043 | must_be_checked_against_support_notebook | checked_in_support_output | In this case, the effective number of degrees of freedom $df_e = 564$ and the corresponding $t$ value equals $1.9642$. Therefore, using Equation \ref{eq:pred_interval_strat_MPU} |
| calc.aux.0402 | auxiliary.tex:1046 | must_be_checked_against_support_notebook | checked_in_support_output | 7,670,700 \pm 245,704 |
| calc.aux.0403 | auxiliary.tex:1048 | must_be_checked_against_support_notebook | checked_in_support_output | leads to a prediction interval of [7,424,999,\hspace{0.5em} 7,916,401]. This result is more precise than that for unstratified sampling but is not sufficiently precise for the target precision of 200,000. |
| calc.aux.0404 | auxiliary.tex:1057 | static_theoretical_or_illustrative | intentional_manual | \parbox[t]{2cm}{\raggedleft $\sum{x y}$} & |
| calc.aux.0405 | auxiliary.tex:1065 | must_be_generated_from_support_notebook | migration_required | 1 &   212,652,334 & 226 &   827.20 &   813.04 &   269,587 \\ |
| calc.aux.0406 | auxiliary.tex:1066 | must_be_generated_from_support_notebook | migration_required | 2 & 3,067,091,255 & 259 & 3,268.20 & 3,293.63 & 1,082,008 \\ |
| calc.aux.0407 | auxiliary.tex:1067 | must_be_generated_from_support_notebook | migration_required | 3 & 6,492,159,030 &  98 & 7,731.59 & 7,952.12 & 4,813,063 \\ |
| calc.aux.0408 | auxiliary.tex:1078 | must_be_checked_against_support_notebook | checked_in_support_output | b_1 = \frac{\sum{g_h^2 c_{xy, h}}}{\sum{g_h^2 s_{x, h}^2}} |
| calc.aux.0409 | auxiliary.tex:1082 | must_be_generated_from_support_notebook | migration_required | Table \ref{tab:calculation_slope} shows the intermediate results that lead to the calculation of coefficient $b_1 = \frac{11,165,022,188}{10,881,902,823} = 1.026$. |
| calc.aux.0410 | auxiliary.tex:1092 | static_theoretical_or_illustrative | intentional_manual | \parbox[t]{2cm}{\raggedleft $g^2 s_{x}^2$} \\ |
| calc.aux.0411 | auxiliary.tex:1094 | must_be_generated_from_support_notebook | migration_required | 1 & 16,204.07 &   269,587 &   528.93 & 4,368,411,054 & 4,533,333,210 \\ |
| calc.aux.0412 | auxiliary.tex:1095 | must_be_generated_from_support_notebook | migration_required | 2 &  4,501.49 & 1,082,008 & 1,027.37 & 4,870,649,168 & 4,751,253,947 \\ |
| calc.aux.0413 | auxiliary.tex:1096 | must_be_generated_from_support_notebook | migration_required | 3 &    400.15 & 4,813,063 & 1,997.94 & 1,925,961,966 & 1,597,315,666 \\ |
| calc.aux.0414 | auxiliary.tex:1108 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R = \sum{N \overline{y}} + b_1 (X - \sum{N \overline{x}}) |
| calc.aux.0415 | auxiliary.tex:1122 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 &   827.20 & 1,679,213.22 \\ |
| calc.aux.0416 | auxiliary.tex:1123 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 3,268.20 & 3,977,396.35 \\ |
| calc.aux.0417 | auxiliary.tex:1124 | must_be_generated_from_support_notebook | migration_required | 3 &   253 & 7,731.59 & 1,956,092.61 \\ |
| calc.aux.0418 | auxiliary.tex:1139 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_R = \AuxStratifiedMpuEstimate + 1.026 \cdot (7,360,816.00 - 7,612,702.17) = 7,412,261 |
| calc.aux.0419 | auxiliary.tex:1145 | must_be_checked_against_support_notebook | checked_in_support_output | s_{y_{r, h}} = \sqrt{\frac{n_h - 1}{n_h - 2}(s_{y, h}^2 - 2 b_1 c_{xy, h} + b_1^2 s_{x, h}^2)} |
| calc.aux.0420 | auxiliary.tex:1163 | must_be_generated_from_support_notebook | migration_required | 1 & 226 &   297,308 &   269,587 &   279,765 &    38,790 \\ |
| calc.aux.0421 | auxiliary.tex:1164 | must_be_generated_from_support_notebook | migration_required | 2 & 259 & 1,696,612 & 1,082,008 & 1,055,485 &   589,700 \\ |
| calc.aux.0422 | auxiliary.tex:1165 | must_be_generated_from_support_notebook | migration_required | 3 &  98 & 7,979,066 & 4,813,063 & 3,991,762 & 2,328,674 \\ |
| calc.aux.0423 | auxiliary.tex:1177 | must_be_checked_against_support_notebook | checked_in_support_output | s^2_{R} = \sum_{h = 1}^{L}g_h^2 s_{y_r,h}^2 |
| calc.aux.0424 | auxiliary.tex:1195 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 226 & 16,204.07 &    38,790 &   628,560,668 \\ |
| calc.aux.0425 | auxiliary.tex:1196 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 259 &  4,501,49 &   589,700 & 2,654,530,513 \\ |
| calc.aux.0426 | auxiliary.tex:1197 | must_be_generated_from_support_notebook | migration_required | 3 &   253 &  98 &    400.15 & 2,328,674 &   931,826,118 \\ |
| calc.aux.0427 | auxiliary.tex:1210 | must_be_checked_against_support_notebook | checked_in_support_output | The standard error of the regression estimate is the square root of the variance $s_{R} = \sqrt{4,214,917,300} = 64,922.39.$ This standard error $s_{R}$ is then used to obtain the lower and upper bounds of the predict... |
| calc.aux.0428 | auxiliary.tex:1220 | must_be_checked_against_support_notebook | checked_in_support_output | df_{e, R} = \frac{4,214,917,300^2}{\frac{628,560,668^2}{225} + \frac{2,654,530,513^2}{258} + \frac{931,826,118^2}{97}} = 467 |
| calc.aux.0429 | auxiliary.tex:1224 | must_be_checked_against_support_notebook | checked_in_support_output | In this case, the effective number of degrees of freedom $df_e = 467$, and the corresponding mean-per-unit$t$ value equals $1.9651$. Therefore, using Equation \ref{eq:pred_interval_strat_reg} |
| calc.aux.0430 | auxiliary.tex:1227 | must_be_checked_against_support_notebook | checked_in_support_output | 7,412,261 \pm 1.9651 \cdot 64,922.39 = 7,412,261 \pm 127.576 |
| calc.aux.0431 | auxiliary.tex:1229 | must_be_checked_against_support_notebook | checked_in_support_output | leads to a prediction interval of [7,284,685,\hspace{0.5em} 7,539,837]. The regression estimator yielded an estimate that is sufficiently precise, given the target precision of 200,000. |
| calc.aux.0432 | auxiliary.tex:1253 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 226 &   3,199.97 &   194.68 \\ |
| calc.aux.0433 | auxiliary.tex:1254 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 259 &  -6,586.02 &   766.86 \\ |
| calc.aux.0434 | auxiliary.tex:1255 | must_be_generated_from_support_notebook | migration_required | 3 &   253 &  98 & -21,612.17 & 1,531.24 \\ |
| calc.aux.0435 | auxiliary.tex:1279 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 &   14.16 &  28,743.09 \\ |
| calc.aux.0436 | auxiliary.tex:1280 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 &  -25.43 & -30,946.67 \\ |
| calc.aux.0437 | auxiliary.tex:1281 | must_be_generated_from_support_notebook | migration_required | 3 &   253 & -220.53 & -55,794.68 \\ |
| calc.aux.0438 | auxiliary.tex:1293 | must_be_checked_against_support_notebook | checked_in_support_output | The difference estimate of the population audit value is $7,360,816 - (-57,998.26) = 7,418,814$. |
| calc.aux.0439 | auxiliary.tex:1299 | must_be_checked_against_support_notebook | checked_in_support_output | s^2_{D} = \sum_{h = 1}^{L}g_h^2 s_{d,h}^2 |
| calc.aux.0440 | auxiliary.tex:1318 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 & 226 & 16,204.07 &    37,898.92 &   614,116,709 \\ |
| calc.aux.0441 | auxiliary.tex:1319 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 259 &  4,501.49 &   588,080.39 & 2,647,238,193 \\ |
| calc.aux.0442 | auxiliary.tex:1320 | must_be_generated_from_support_notebook | migration_required | 3 &   253 &  98 &    400.15 & 2,344,701.56 &   938,239,506 \\ |
| calc.aux.0443 | auxiliary.tex:1332 | must_be_checked_against_support_notebook | checked_in_support_output | The standard error of the difference estimate is the square root of its variance $s_D = \sqrt{4,199,594,408} = 64,804.28.$ This standard error $s_D$ is then used to obtain the lower and upper bounds of the prediction ... |
| calc.aux.0444 | auxiliary.tex:1342 | must_be_checked_against_support_notebook | checked_in_support_output | df_{e, D} = \frac{4,199,594,408^2}{\frac{614,116,709^2}{225} + \frac{2,647,238,193^2}{258} + \frac{938,239,506^2}{97}} = 465 |
| calc.aux.0445 | auxiliary.tex:1345 | must_be_checked_against_support_notebook | checked_in_support_output | For the difference estimator, the effective number of degrees of freedom $df_{e, d} = 465$, and the corresponding mean-per-unit$t$ value equals $1.9651$. Therefore, using Equation \ref{eq:pred_interval_strat_diff} |
| calc.aux.0446 | auxiliary.tex:1348 | must_be_checked_against_support_notebook | checked_in_support_output | 7,418,814 \pm 1.9651 \cdot 64,804 = 7,418,814 \pm 127,346 |
| calc.aux.0447 | auxiliary.tex:1350 | must_be_checked_against_support_notebook | checked_in_support_output | leads to a prediction interval of [7,291,468,\hspace{0.5em} 7,546,160]. This result is more precise than that for unstratified sampling, and sufficiently precise, given the target precision of 200,000. |
| calc.aux.0448 | auxiliary.tex:1370 | must_be_generated_from_support_notebook | migration_required | 1 & 2,030 &   827.20 &   813.04 & 1,679,213.22 & 1,650,470.12 \\ |
| calc.aux.0449 | auxiliary.tex:1371 | must_be_generated_from_support_notebook | migration_required | 2 & 1,217 & 3,268.20 & 3,293.63 & 3,977,396.35 & 4,008,343.01 \\ |
| calc.aux.0450 | auxiliary.tex:1372 | must_be_generated_from_support_notebook | migration_required | 3 &   253 & 7,731.59 & 7,952.12 & 1,956,092.61 & 2,011,887.29\\ |
| calc.aux.0451 | auxiliary.tex:1387 | must_be_checked_against_support_notebook | checked_in_support_output | q = \frac{\AuxStratifiedMpuEstimate}{7,612,702.17} = 1.0076 |
| calc.aux.0452 | auxiliary.tex:1393 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_Q = X q = 7,360,816 \cdot 1.0076 =  7,416,895.23 |
| calc.aux.0453 | auxiliary.tex:1402 | must_be_checked_against_support_notebook | checked_in_support_output | s_Q^2 = \sum_{h = 1}^{L}g_h^2 s_{q,h}^2 |
| calc.aux.0454 | auxiliary.tex:1405 | static_theoretical_or_illustrative | intentional_manual | where $s_{q,h}^2$ is the stratum variance, the square of the stratum standard deviation calculated using Equation \ref{eq:sd_ratios}. |
| calc.aux.0455 | auxiliary.tex:1420 | must_be_generated_from_support_notebook | migration_required | 1 & 16,204.07 &    38,070.24 &   616,892,795 \\ |
| calc.aux.0456 | auxiliary.tex:1421 | must_be_generated_from_support_notebook | migration_required | 2 &  4,501,49 &   587,737.51 & 2,645,694,719 \\ |
| calc.aux.0457 | auxiliary.tex:1422 | must_be_generated_from_support_notebook | migration_required | 3 &    400.15 & 2,332,418.89 &   933,324,559 \\ |
| calc.aux.0458 | auxiliary.tex:1434 | must_be_checked_against_support_notebook | checked_in_support_output | The standard error of the ratio estimate is the square root of its variance $s_Q = \sqrt{4,195,912,074} = 64,775.86.$ This standard error $s_{\hat{Y}_d}$ is then used to obtain the lower and upper bounds of the predic... |
| calc.aux.0459 | auxiliary.tex:1444 | must_be_checked_against_support_notebook | checked_in_support_output | df_{e, Q} = \frac{4,195,912,074^2}{\frac{616,892,795^2}{225} + \frac{2,645,694,719^2}{258} + \frac{933,324,559^2}{97}} = 465 |
| calc.aux.0460 | auxiliary.tex:1447 | must_be_checked_against_support_notebook | checked_in_support_output | The effective number of degrees of freedom $df_{e, Q} = 465$, and the corresponding mean-per-unit $t$ value equals $1.9651$. Therefore, using Equation \ref{eq:pred_interval_ratio} |
| calc.aux.0461 | auxiliary.tex:1450 | must_be_checked_against_support_notebook | checked_in_support_output | 7,416,895 \pm 1.9651 \cdot 64,776 = 7,416,895 \pm 127,290 |
| calc.aux.0462 | auxiliary.tex:1452 | must_be_checked_against_support_notebook | checked_in_support_output | leads to a prediction interval of [7,289,605,\hspace{0.5em} 7,544,185]. This result is more precise than that for unstratified sampling and is sufficiently precise, given the target precision of 200,000. |
| calc.aux.0463 | auxiliary.tex:1466 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-1-1} |
| calc.aux.0464 | auxiliary.tex:1477 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-1} |
| calc.aux.0465 | auxiliary.tex:1478 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-2} |
| calc.aux.0466 | auxiliary.tex:1479 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-3} |
| calc.aux.0467 | auxiliary.tex:1480 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-4} |
| calc.aux.0468 | auxiliary.tex:1481 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-5} |
| calc.aux.0469 | auxiliary.tex:1482 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-6} |
| calc.aux.0470 | auxiliary.tex:1483 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-2-7} |
| calc.aux.0471 | auxiliary.tex:1492 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-3-1} |
| calc.aux.0472 | auxiliary.tex:1493 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-3-2} |
| calc.aux.0473 | auxiliary.tex:1494 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-3-3} |
| calc.aux.0474 | auxiliary.tex:1495 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-3-4} |
| calc.aux.0475 | auxiliary.tex:1506 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-4-1} |
| calc.aux.0476 | auxiliary.tex:1507 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-4-2} |
| calc.aux.0477 | auxiliary.tex:1508 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-4-3} |
| calc.aux.0478 | auxiliary.tex:1519 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-5-1} |
| calc.aux.0479 | auxiliary.tex:1520 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-5-2} |
| calc.aux.0480 | auxiliary.tex:1521 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-5-3} |
| calc.aux.0481 | auxiliary.tex:1532 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-6-1} |
| calc.aux.0482 | auxiliary.tex:1533 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-6-2} |
| calc.aux.0483 | auxiliary.tex:1534 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-6-3} |
| calc.aux.0484 | auxiliary.tex:1535 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-6-4} |
| calc.aux.0485 | auxiliary.tex:1546 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-1} |
| calc.aux.0486 | auxiliary.tex:1547 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-2} |
| calc.aux.0487 | auxiliary.tex:1548 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-3} |
| calc.aux.0488 | auxiliary.tex:1549 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-4} |
| calc.aux.0489 | auxiliary.tex:1550 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-5} |
| calc.aux.0490 | auxiliary.tex:1551 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-6} |
| calc.aux.0491 | auxiliary.tex:1552 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-7-7} |
| calc.aux.0492 | auxiliary.tex:1563 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-8-1} |
| calc.aux.0493 | auxiliary.tex:1564 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-8-2} |
| calc.aux.0494 | auxiliary.tex:1573 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-1} |
| calc.aux.0495 | auxiliary.tex:1574 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-2} |
| calc.aux.0496 | auxiliary.tex:1575 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-3} |
| calc.aux.0497 | auxiliary.tex:1576 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-4} |
| calc.aux.0498 | auxiliary.tex:1577 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-5} |
| calc.aux.0499 | auxiliary.tex:1578 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-6} |
| calc.aux.0500 | auxiliary.tex:1579 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-3-9-7} |
| calc.aux.0501 | auxiliary.tex:1593 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-1-1} |
| calc.aux.0502 | auxiliary.tex:1602 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-1} |
| calc.aux.0503 | auxiliary.tex:1603 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-2} |
| calc.aux.0504 | auxiliary.tex:1604 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-3} |
| calc.aux.0505 | auxiliary.tex:1605 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-4} |
| calc.aux.0506 | auxiliary.tex:1606 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-5} |
| calc.aux.0507 | auxiliary.tex:1607 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-6} |
| calc.aux.0508 | auxiliary.tex:1608 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-2-7} |
| calc.aux.0509 | auxiliary.tex:1617 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-3-1} |
| calc.aux.0510 | auxiliary.tex:1618 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-3-2} |
| calc.aux.0511 | auxiliary.tex:1619 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-3-3} |
| calc.aux.0512 | auxiliary.tex:1620 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-3-4} |
| calc.aux.0513 | auxiliary.tex:1629 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-4-1} |
| calc.aux.0514 | auxiliary.tex:1630 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-4-2} |
| calc.aux.0515 | auxiliary.tex:1631 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-4-3} |
| calc.aux.0516 | auxiliary.tex:1640 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-5-1} |
| calc.aux.0517 | auxiliary.tex:1641 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-5-2} |
| calc.aux.0518 | auxiliary.tex:1642 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-5-3} |
| calc.aux.0519 | auxiliary.tex:1651 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-6-1} |
| calc.aux.0520 | auxiliary.tex:1652 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-6-2} |
| calc.aux.0521 | auxiliary.tex:1653 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-6-3} |
| calc.aux.0522 | auxiliary.tex:1654 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-6-4} |
| calc.aux.0523 | auxiliary.tex:1663 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-1} |
| calc.aux.0524 | auxiliary.tex:1664 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-2} |
| calc.aux.0525 | auxiliary.tex:1665 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-3} |
| calc.aux.0526 | auxiliary.tex:1666 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-4} |
| calc.aux.0527 | auxiliary.tex:1667 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-5} |
| calc.aux.0528 | auxiliary.tex:1668 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-6} |
| calc.aux.0529 | auxiliary.tex:1669 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-7-7} |
| calc.aux.0530 | auxiliary.tex:1678 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-8-1} |
| calc.aux.0531 | auxiliary.tex:1679 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-8-2} |
| calc.aux.0532 | auxiliary.tex:1688 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-1} |
| calc.aux.0533 | auxiliary.tex:1689 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-2} |
| calc.aux.0534 | auxiliary.tex:1690 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-3} |
| calc.aux.0535 | auxiliary.tex:1691 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-4} |
| calc.aux.0536 | auxiliary.tex:1692 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-5} |
| calc.aux.0537 | auxiliary.tex:1693 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-6} |
| calc.aux.0538 | auxiliary.tex:1694 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-3-9-7} |

## Hypothesis Testing

- Support notebook: notebooks/support/hypothesis-testing/support.html
- Classified calculation candidates: 172

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.hyp.0539 | hypothesis-testing.tex:668 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/hyp-cell-evaluation-steps} |
| calc.hyp.0540 | hypothesis-testing.tex:721 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/hyp-mus-attribute-sample-sizes-rows} |
| calc.hyp.0541 | hypothesis-testing.tex:737 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/hyp-mus-sample-size} |
| calc.hyp.0542 | hypothesis-testing.tex:84 | must_be_checked_against_support_notebook | checked_in_support_output | \begin{enumerate}[leftmargin=*,labelsep=.5em] |
| calc.hyp.0543 | hypothesis-testing.tex:99 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Step 1. Develop the research question.} The research question introduced above in \emph{Case: Information provided by the entity} is: are more than 5\% of the data points incorrect? In this example, the mat... |
| calc.hyp.0544 | hypothesis-testing.tex:101 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 2. State the null and alternative hypotheses.} It is a general practice for auditors to define the \hlblue{null hypothesis}\index{null hypothesis}\index{hypothesis!null} or default position, as the pop... |
| calc.hyp.0545 | hypothesis-testing.tex:117 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 4. Choose an appropriate test and its test statistic.} The test statistic is related to the null hypothesis $\pi$ by calculating $p$, which is the fraction of errors in the sample with $p = k / n$. Thu... |
| calc.hyp.0546 | hypothesis-testing.tex:119 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 5. Derive the distribution of the test statistic under the null hypothesis.} In general, we know the distribution of the test statistic, or approximate it. |
| calc.hyp.0547 | hypothesis-testing.tex:121 | handled_by_epic_214_model_test_output | epic_214_scope | If the null hypothesis $\pi \geq$ 0.05 is true, then $k$ has a hypergeometric distribution, with parameter population size $N =$ 1,200, number of errors in the population $M = N * \pi = $ 1,200 $\cdot$ 0.05 = 60, and ... |
| calc.hyp.0548 | hypothesis-testing.tex:123 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 6. Select a significance level.} The significance level is the level of probability at which the null hypothesis is rejected. The significance level is given in the \emph{Objective} paragraph of \emph{... |
| calc.hyp.0549 | hypothesis-testing.tex:125 | handled_by_epic_214_model_test_output | epic_214_scope | Calculations are performed with a single value for $\pi$ rather than the range of values of $\pi \geq$ 0.05. Choosing $\pi =$ 0.05, the border value of the null hypothesis, is appropriate, because, at this value, the ... |
| calc.hyp.0550 | hypothesis-testing.tex:127 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 7. Determine the critical region.} The auditor also determines the \hlblue{critical region}\index{critical region}. It contains the values for the test statistic $k$ for which the null hypothesis is re... |
| calc.hyp.0551 | hypothesis-testing.tex:129 | handled_by_epic_214_model_test_output | epic_214_scope | Alternatively, one may want to allow for a small number of errors in the test. For example, we can choose to reject $H_0$ only if no more than two errors are found in the sample. In this case, the critical region is d... |
| calc.hyp.0552 | hypothesis-testing.tex:132 | handled_by_epic_214_model_test_output | epic_214_scope | The critical region affects the minimum required sample size. We determine the sample size $n$ such that if the null hypothesis is true, that is, the population contains a material misstatement ($\pi \geq 0.05$), the ... |
| calc.hyp.0553 | hypothesis-testing.tex:134 | must_be_checked_against_support_notebook | checked_in_support_output | P(\stoch{k} \leq k_{cr} \| \pi = 0.05) \leq \alpha |
| calc.hyp.0554 | hypothesis-testing.tex:138 | handled_by_epic_214_model_test_output | epic_214_scope | This leads to a sample size of $n =$ 45, if we do not allow for any errors in the sample. If we determine the critical region to be $\{\stoch{k} \| k \leq 2\}$, allowing for up to two errors in the sample, the minimum ... |
| calc.hyp.0555 | hypothesis-testing.tex:147 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 8. Compute the value of the test statistic from the sample.} In our case, the computation is simple: only the number of errors in the sample is counted. Alternatively, we can calculate a one-sided conf... |
| calc.hyp.0556 | hypothesis-testing.tex:149 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 9. Conclude on the test, by using the critical region, the $p$-value of the test statistic or the confidence interval.} Let us assume a test with a critical region $\{k \| k = 0\}$, and one error was fo... |
| calc.hyp.0557 | hypothesis-testing.tex:151 | handled_by_epic_214_model_test_output | epic_214_scope | Alternatively, if a test is carried out with a critical region $\{k \| k \leq 2\}$, two errors are found in the sample with $n =$ 102. This time, $k = 2$ is an element of the critical region, and therefore, the null hy... |
| calc.hyp.0558 | hypothesis-testing.tex:154 | handled_by_epic_214_model_test_output | epic_214_scope | The construction of a critical region is a tradition when calculations are difficult to perform manually. The critical regions were derived from extensive tables of the results. A modern alternative is to calculate th... |
| calc.hyp.0559 | hypothesis-testing.tex:161 | must_be_checked_against_support_notebook | checked_in_support_output | 2\%. The Type II error at a population error rate of 2\% is $P(\stoch{k} \geq 1, n = 45, N = 1,200, M = 0,02 \cdot 1200 = 24) = 0.6040$.\label{type_two_error} |
| calc.hyp.0560 | hypothesis-testing.tex:174 | handled_by_epic_214_model_test_output | epic_214_scope | The hypothesis test can also be performed using a confidence interval. In \emph{Case: Information provided by the entity} we used a significance level of 10\%, and materiality was set at 5\%. Tolerating up to two erro... |
| calc.hyp.0561 | hypothesis-testing.tex:187 | must_be_generated_from_support_notebook | migration_required | 0 & 0.00\% & 0.0 & 25 & 2.08\%  \\ |
| calc.hyp.0562 | hypothesis-testing.tex:188 | must_be_generated_from_support_notebook | migration_required | 1 & 0.98\% & 11.8 & 43 & 3.58\%  \\ |
| calc.hyp.0563 | hypothesis-testing.tex:189 | must_be_generated_from_support_notebook | migration_required | 2 & 1.96\% & 23.5 & 59 & 4.92\%  \\ |
| calc.hyp.0564 | hypothesis-testing.tex:190 | must_be_generated_from_support_notebook | migration_required | 3 & 2.94\% & 35.3 & 75 & 6.25\% \\ |
| calc.hyp.0565 | hypothesis-testing.tex:198 | handled_by_epic_214_model_test_output | epic_214_scope | Rather than determining whether the number of errors $k$ is an element of the critical region, we now compare the upper bound of the confidence interval with the materiality set. Materiality is 5\% in this example or ... |
| calc.hyp.0566 | hypothesis-testing.tex:207 | handled_by_epic_214_model_test_output | epic_214_scope | If the critical region is $\{k \| k = 0\}$, then the sample is referred to as a \hlblue{discovery sample}\index{discovery sample}\index{sample!discovery}. |
| calc.hyp.0567 | hypothesis-testing.tex:209 | handled_by_epic_214_model_test_output | epic_214_scope | We observed that the sample size is mainly driven by three parameters: the significance level $\alpha$, critical region $k_{cr}$, and tolerable deviation rate $\pi$.\footnote{The fourth parameter, the population size ... |
| calc.hyp.0568 | hypothesis-testing.tex:215 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 1\%$ & |
| calc.hyp.0569 | hypothesis-testing.tex:216 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 5\%$ & |
| calc.hyp.0570 | hypothesis-testing.tex:217 | static_theoretical_or_illustrative | intentional_manual | $\pi = 10\%$ & |
| calc.hyp.0571 | hypothesis-testing.tex:218 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 15\%$ & |
| calc.hyp.0572 | hypothesis-testing.tex:219 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 20\%$ \\ |
| calc.hyp.0573 | hypothesis-testing.tex:223 | must_be_generated_from_support_notebook | migration_required | 0 & 299 & 59 & 29 & 19 & 14 \\ |
| calc.hyp.0574 | hypothesis-testing.tex:224 | must_be_generated_from_support_notebook | migration_required | 1 & 473 & 93 & 46 & 30 & 22 \\ |
| calc.hyp.0575 | hypothesis-testing.tex:225 | must_be_generated_from_support_notebook | migration_required | 2 & 628 & 124 & 61 & 40 & 30 \\ |
| calc.hyp.0576 | hypothesis-testing.tex:226 | must_be_generated_from_support_notebook | migration_required | 3 & 773 & 153 & 76 & 50 & 37 \\ |
| calc.hyp.0577 | hypothesis-testing.tex:238 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 1\%$ & |
| calc.hyp.0578 | hypothesis-testing.tex:239 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 5\%$ & |
| calc.hyp.0579 | hypothesis-testing.tex:240 | static_theoretical_or_illustrative | intentional_manual | $\pi = 10\%$ & |
| calc.hyp.0580 | hypothesis-testing.tex:241 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 15\%$ & |
| calc.hyp.0581 | hypothesis-testing.tex:242 | must_be_checked_against_support_notebook | checked_in_support_output | $\pi = 20\%$ \\ |
| calc.hyp.0582 | hypothesis-testing.tex:246 | must_be_generated_from_support_notebook | migration_required | 0 & 230 & 45 & 22 & 15 & 11 \\ |
| calc.hyp.0583 | hypothesis-testing.tex:247 | must_be_generated_from_support_notebook | migration_required | 1 & 388 & 77 & 38 & 25 & 18 \\ |
| calc.hyp.0584 | hypothesis-testing.tex:248 | must_be_generated_from_support_notebook | migration_required | 2 & 531 & 105 & 52 & 34 & 25 \\ |
| calc.hyp.0585 | hypothesis-testing.tex:249 | must_be_generated_from_support_notebook | migration_required | 3 & 667 & 132 & 65 & 43 & 32 \\ |
| calc.hyp.0586 | hypothesis-testing.tex:266 | static_theoretical_or_illustrative | intentional_manual | The OCC in Fig. \ref{fig:three_attribute_occ}, reflecting a test with $H_0: \pi \geq 0.05$ shows that populations with a low deviation rate have a high chance of being accepted, whereas the probability of acceptance d... |
| calc.hyp.0587 | hypothesis-testing.tex:268 | must_be_checked_against_support_notebook | checked_in_support_output | The $y$-axis reflects the \hlblue{power}\index{power} of the test. For example, when $n = 45$ and the true population error rate $\pi = 0.02$ we find the power  $(1 - \beta) = (1 - \pi)^n = (1 - 0.02)^{45} = 0.40$. |
| calc.hyp.0588 | hypothesis-testing.tex:270 | handled_by_epic_214_model_test_output | epic_214_scope | As we have seen in the previous section, the choice of the critical region affected the sample size. Without allowing for errors, the sample size was 45, but allowing for one or two errors, the sample size increased t... |
| calc.hyp.0589 | hypothesis-testing.tex:284 | must_be_checked_against_support_notebook | checked_in_support_output | \begin{enumerate}[leftmargin=*,labelsep=.5em] |
| calc.hyp.0590 | hypothesis-testing.tex:297 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, text width=2.8cm, align=center] (first) {Initial sample $n_0$}; |
| calc.hyp.0591 | hypothesis-testing.tex:298 | must_be_checked_against_support_notebook | checked_in_support_output | \node[blueblock, right = 1.8cm of first, text width=2.7cm, align=center] (seco) {Extension $n_1$}; |
| calc.hyp.0592 | hypothesis-testing.tex:299 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, above = 0.8cm of seco, text width=2.7cm, align=center] (acc1) {Accept the population}; |
| calc.hyp.0593 | hypothesis-testing.tex:300 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below = 0.8cm of seco, text width=2.7cm, align=center] (rej1) {Reject the population}; |
| calc.hyp.0594 | hypothesis-testing.tex:301 | must_be_checked_against_support_notebook | checked_in_support_output | \node[right = 3.2cm of seco] (dummy) {}; |
| calc.hyp.0595 | hypothesis-testing.tex:302 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, above = 0.4cm of dummy, text width=2.7cm, align=center] (acc2)  {Accept the population}; |
| calc.hyp.0596 | hypothesis-testing.tex:303 | must_be_checked_against_support_notebook | checked_in_support_output | \node[whiteblock, below = 0.4cm of dummy, text width=2.7cm, align=center] (rej2)  {Reject the population}; |
| calc.hyp.0597 | hypothesis-testing.tex:305 | must_be_checked_against_support_notebook | checked_in_support_output | \path [line] (first) -- node {k = 0} (acc1); |
| calc.hyp.0598 | hypothesis-testing.tex:306 | must_be_checked_against_support_notebook | checked_in_support_output | \path [line] (first) -- node {k = 1} (seco); |
| calc.hyp.0599 | hypothesis-testing.tex:308 | must_be_checked_against_support_notebook | checked_in_support_output | \path [line] (seco) -- node {k = 0} (acc2); |
| calc.hyp.0600 | hypothesis-testing.tex:324 | must_be_checked_against_support_notebook | checked_in_support_output | \item The probability of finding no deviations in the initial sample of size $n_0$\footnote{$P(k = 0 \| n_0) = (1 - \pi)^{n_0}$}; plus |
| calc.hyp.0601 | hypothesis-testing.tex:325 | must_be_checked_against_support_notebook | checked_in_support_output | \item The probability of finding one deviation in the initial sample of size $n_0$ and then finding one deviation in the extension of size $n_1$.\footnote{$P(k = 1 \| n_0) \cdot P(k = 0 \| n_1) = n \pi (1 - \pi)^{n_0 - ... |
| calc.hyp.0602 | hypothesis-testing.tex:331 | must_be_checked_against_support_notebook | checked_in_support_output | P(\text{Accept}) = (1 - \pi)^{n_0} + n \pi (1 - \pi)^{n_0 - 1} (1 - \pi)^{n_1} |
| calc.hyp.0603 | hypothesis-testing.tex:335 | must_be_checked_against_support_notebook | checked_in_support_output | If we choose the size of the extension equal to that of the initial sample, $n = n_0 = n_1$, the probability to accept is |
| calc.hyp.0604 | hypothesis-testing.tex:338 | must_be_checked_against_support_notebook | checked_in_support_output | P(\text{Accept}) = (1 - \pi)^{n} + n \pi (1 - \pi)^{n - 1} (1 - \pi)^{n} = |
| calc.hyp.0605 | hypothesis-testing.tex:341 | static_theoretical_or_illustrative | intentional_manual | (1 - \pi)^{n} (1 + n \pi (1 - \pi)^{n - 1}) \leq \alpha |
| calc.hyp.0606 | hypothesis-testing.tex:345 | must_be_checked_against_support_notebook | checked_in_support_output | The probability of accepting a population with a certain population deviation rate, $\pi$, can be calculated using Equation \ref{eq:p_accept_n0_equal_to_n1}. For example, if we apply double sampling to \emph{Case: Inf... |
| calc.hyp.0607 | hypothesis-testing.tex:390 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 2. State the null and alternative hypotheses.} If we define $M$ as the total amount of inappropriate cost items, then we define the null hypothesis as follows: |
| calc.hyp.0608 | hypothesis-testing.tex:392 | static_theoretical_or_illustrative | intentional_manual | H_0 : M \geq 120,000 \text{ or } \pi \geq 0.01 |
| calc.hyp.0609 | hypothesis-testing.tex:403 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 4. Choose an appropriate test and its test statistic.} The test statistic is the number of errors, $k$, in the sample. A cost item is deemed incorrect if one or more of the inclusion conditions are not... |
| calc.hyp.0610 | hypothesis-testing.tex:405 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 5. Derive the distribution of the test statistic under the null hypothesis.} Under the null hypothesis, $k$ follows a hypergeometric distribution with parameters $N = 12,000,000$ and $M_0 = 0,01 \cdot ... |
| calc.hyp.0611 | hypothesis-testing.tex:407 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Step 6. Select a significance level.} Given the required confidence level of 95\%, the significance level of the test is its complement of 5\%. |
| calc.hyp.0612 | hypothesis-testing.tex:409 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 7. Determine the critical region.} As in the previous \emph{Case: Information provided by the entity} we have to decide on the critical region. The minimum sample size $n = $ 299 is obtained for the sm... |
| calc.hyp.0613 | hypothesis-testing.tex:411 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 8. Compute the value of the test statistic from the sample.} The remainder of the test is similar to that of the previous \emph{Case: Information produced by the entity}. Select the number of items in ... |
| calc.hyp.0614 | hypothesis-testing.tex:413 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 9. Conclude on the test, by using the critical region, the $p$-value of the test statistic or the confidence interval.} If $k$ is within the critical region, the null hypothesis is rejected. We may con... |
| calc.hyp.0615 | hypothesis-testing.tex:433 | static_theoretical_or_illustrative | intentional_manual | There are 10,000 trade account receivable invoices outstanding at year-end, their total amount is 13,500,000. Performance materiality for this account is 450,000. Based on the findings from previous years, you expect ... |
| calc.hyp.0616 | hypothesis-testing.tex:436 | must_be_checked_against_support_notebook | checked_in_support_output | Calculate the minimum required sample size that allows you, at a significance level of 5\%, to reject the hypothesis that the population is overstated by more than 450,000 if the extrapolated error from the sample doe... |
| calc.hyp.0617 | hypothesis-testing.tex:440 | handled_by_epic_214_model_test_output | epic_214_scope | In the previous case study, the \emph{Case: European innovation subsidies}, we observed that the choice of the critical region had a dramatic effect on the sample size; increasing the critical region from $\{k \| k = 0... |
| calc.hyp.0618 | hypothesis-testing.tex:442 | must_be_checked_against_support_notebook | checked_in_support_output | A sample size of $n = 145$ is then calculated using a \hlblue{performance materiality}\index{performance materiality}\index{materiality!performance} ($M$)\nomenclature{$M$}{(performance) materiality} of 450,000, and t... |
| calc.hyp.0619 | hypothesis-testing.tex:444 | must_be_checked_against_support_notebook | checked_in_support_output | The MUS sample size lies between the fixed attribute sample sizes of 141 (for $k = 1$) and 187 (for $k = 2$).\footnote{The calculation of the sample size is explained on page~\pageref{par:sample_size_calculation}} Bef... |
| calc.hyp.0620 | hypothesis-testing.tex:448 | must_be_checked_against_support_notebook | checked_in_support_output | \begin{enumerate}[leftmargin=*,labelsep=.5em] |
| calc.hyp.0621 | hypothesis-testing.tex:463 | static_theoretical_or_illustrative | intentional_manual | What happens if the logical unit is partially correct and partially incorrect? For example, if its book value is 7 and its audit value is 5, then we can regard the first five monetary units to be correct and the last ... |
| calc.hyp.0622 | hypothesis-testing.tex:473 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_blue, fill opacity=0.1, draw=black] (0,0) rectangle (1.6,0.8); |
| calc.hyp.0623 | hypothesis-testing.tex:475 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_blue, fill opacity=0.6, draw=black] (1.6,0) rectangle (3.2,0.8); |
| calc.hyp.0624 | hypothesis-testing.tex:477 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_blue, fill opacity=0.1, draw=black] (3.2,0) rectangle (4.8,0.8); |
| calc.hyp.0625 | hypothesis-testing.tex:479 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_blue, fill opacity=0.1, draw=black] (4.8,0) rectangle (6.4,0.8); |
| calc.hyp.0626 | hypothesis-testing.tex:481 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_blue, fill opacity=0.1, draw=black] (6.4,0) rectangle (8,0.8); |
| calc.hyp.0627 | hypothesis-testing.tex:483 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_light_pink, fill opacity=0.1, draw=black] (8,0) rectangle (9.6,0.8); |
| calc.hyp.0628 | hypothesis-testing.tex:485 | must_be_checked_against_support_notebook | checked_in_support_output | \filldraw[fill=KPMG_light_pink, fill opacity=0.6, draw=black] (9.6,0) rectangle (11.2,0.8); |
| calc.hyp.0629 | hypothesis-testing.tex:519 | must_be_generated_from_support_notebook | migration_required | 201702532 & 5,548.53 & 4,438.82 & 1,109.71 & 20.00\% \\ |
| calc.hyp.0630 | hypothesis-testing.tex:520 | must_be_generated_from_support_notebook | migration_required | 201720040 & 670.43 & 0.00 & 670.43 & 100.00\% \\ |
| calc.hyp.0631 | hypothesis-testing.tex:521 | must_be_generated_from_support_notebook | migration_required | 201724407 & 5,761.85 & 5,531.38 & 230.47 & 4.00\% \\ |
| calc.hyp.0632 | hypothesis-testing.tex:549 | must_be_generated_from_support_notebook | migration_required | 0 & 0.00 & 276,050.00 & 276,050.00 & 0.00 \\ |
| calc.hyp.0633 | hypothesis-testing.tex:550 | must_be_generated_from_support_notebook | migration_required | 1 & 93,103.45 & 436,007.00 & 159,957.00 & 66,853.55 \\ |
| calc.hyp.0634 | hypothesis-testing.tex:551 | must_be_generated_from_support_notebook | migration_required | 2 & 186,206.90 & 577,535.00 & 141,528.00 & 48,424.55 \\ |
| calc.hyp.0635 | hypothesis-testing.tex:552 | must_be_generated_from_support_notebook | migration_required | 3 & 279,310.34 & 710,132.00 & 132,597.00 & 39,493.55 \\ |
| calc.hyp.0636 | hypothesis-testing.tex:560 | must_be_checked_against_support_notebook | checked_in_support_output | Table \ref{tab:confidence_intervals_MUS} shows that the point estimate increases with $X / n = $ 13,500,000 / 145 = 93,103.45 for each error found. |
| calc.hyp.0637 | hypothesis-testing.tex:568 | must_be_checked_against_support_notebook | checked_in_support_output | For example, $PGW$ for the first error is calculated from the increase in $M_U$ (159,957.00) not attributed to the increase in point estimate (93,103.45), therefore $PGW_1 =$ 159,957.00 - 93,103.45 = 66,853.55. |
| calc.hyp.0638 | hypothesis-testing.tex:585 | must_be_generated_from_support_notebook | migration_required | 1 & 100.00\% & 93,103.45 & 93,103.45 \\ |
| calc.hyp.0639 | hypothesis-testing.tex:586 | must_be_generated_from_support_notebook | migration_required | 2 & 20.00\% & 93,103.45 & 18,620.76 \\ |
| calc.hyp.0640 | hypothesis-testing.tex:587 | must_be_generated_from_support_notebook | migration_required | 3 & 4.00\% & 93,103.45 & 3,724.07 \\ |
| calc.hyp.0641 | hypothesis-testing.tex:612 | must_be_generated_from_support_notebook | migration_required | 1 & 100.00\% & 66,853.55 & 66,853.55 \\ |
| calc.hyp.0642 | hypothesis-testing.tex:613 | must_be_generated_from_support_notebook | migration_required | 2 & 20.00\% & 48,424.55 & 9,684.95 \\ |
| calc.hyp.0643 | hypothesis-testing.tex:614 | must_be_generated_from_support_notebook | migration_required | 3 & 4.00\% & 39,493.55 & 1,579.71 \\ |
| calc.hyp.0644 | hypothesis-testing.tex:626 | must_be_checked_against_support_notebook | checked_in_support_output | The \emph{upper confidence bound}\index{confidence bound}\index{bound!confidence} on errors according to the Stringer bound method is the sum of the point estimate of 115,448.28, and the precision achieved is 354,168.... |
| calc.hyp.0645 | hypothesis-testing.tex:628 | static_theoretical_or_illustrative | intentional_manual | \paragraph{Method 3: Cell Bounds} The \hlblue{cell bounds}\index{cell bounds} evaluation method is a further refinement of the Stringer bound method. |
| calc.hyp.0646 | hypothesis-testing.tex:631 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{Load and Spread} In addition to the partial error, all other errors in the population are 100\% errors. As a result, the upper bound $M_U[k]$ for error $k$ is the sum of the previous upper bound $M_U[k-1]$ ... |
| calc.hyp.0647 | hypothesis-testing.tex:653 | must_be_generated_from_support_notebook | migration_required | 0 & 276,050 & & & & & & 276,050.00 & 276,050.00 \\ |
| calc.hyp.0648 | hypothesis-testing.tex:654 | must_be_generated_from_support_notebook | migration_required | 1 & 436,007 & 100.00\% & 93,103.45 & 100.00\% & 276,050.00 & 369,153.45 & 436,007.00 & 436,007.00 \\ |
| calc.hyp.0649 | hypothesis-testing.tex:655 | must_be_generated_from_support_notebook | migration_required | 2 & 577,535 & 20.00\% & 18,620.69 & 60.00\% & 436,007.00 & 454,627.69 & 346,521.00 & 454,627.69 \\ |
| calc.hyp.0650 | hypothesis-testing.tex:656 | must_be_generated_from_support_notebook | migration_required | 3 & 710,132 & 4.00\% & 3,724.14 & 41.33\% & 454,627.69 & 458,351.83 & 293,497.56 & 458,351.83 \\ |
| calc.hyp.0651 | hypothesis-testing.tex:680 | static_theoretical_or_illustrative | intentional_manual | It has been suggested for situations where more than 20 differences have been found in a sample that was selected with probabilities proportional to size.\footnote{We suggest to use a $t$-value with $m - 1$ degrees of... |
| calc.hyp.0652 | hypothesis-testing.tex:685 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_{pps} = X (1 - \bar{t}) |
| calc.hyp.0653 | hypothesis-testing.tex:693 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{Y}_{pps} \pm t_{\alpha/2} s_t \frac{X}{\sqrt{n}} |
| calc.hyp.0654 | hypothesis-testing.tex:699 | must_be_checked_against_support_notebook | checked_in_support_output | s_{t} = \sqrt{\frac{\sum{t_j^2} - (\sum{t_j})^2/n}{n - 1}} |
| calc.hyp.0655 | hypothesis-testing.tex:704 | handled_by_epic_214_model_test_output | epic_214_scope | Now that we know how an MUS sample is evaluated, we can calculate the required sample size given a certain expected error. Previously, in attribute sampling, we chose a certain critical region and the sample size was ... |
| calc.hyp.0656 | hypothesis-testing.tex:707 | must_be_checked_against_support_notebook | checked_in_support_output | We turn to the parameters from the \emph{Case: Accounts receivable circularization}. The total book value of the population $X =$ 13,500,000, performance materiality $M = 450,000$, and we expect a total misstatement i... |
| calc.hyp.0657 | hypothesis-testing.tex:709 | must_be_checked_against_support_notebook | checked_in_support_output | With only 100\% errors, Table \ref{tab:attribute_sample_sizes} shows the sample sizes $n_k$, sampling intervals $SI_k$ and expected errors $k \cdot SI_k$ for the various critical regions. Sample size $n_k$ is calculat... |
| calc.hyp.0658 | hypothesis-testing.tex:733 | must_be_checked_against_support_notebook | checked_in_support_output | n^* = \frac{k - \frac{n_k}{n_{k + 1} - n_k}}{\frac{EE}{X} - \frac{1}{n_{k + 1} - n_{k}}} |
| calc.hyp.0659 | hypothesis-testing.tex:744 | handled_by_epic_214_model_test_output | epic_214_scope | As explained in Volume 2, Section \ref{sec:nature_and_cause_of_deviations_and_misstatements}, before extrapolating the differences, the auditor should first evaluate their nature and causes. For statistical evaluation... |
| calc.hyp.0660 | hypothesis-testing.tex:746 | handled_by_epic_214_model_test_output | epic_214_scope | If $M_U$ is not within the critical region, the null hypothesis cannot be rejected; however, this does not automatically mean that the alternative hypothesis is true. In this case, it is usually best to first discuss ... |
| calc.hyp.0661 | hypothesis-testing.tex:762 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-1-1} |
| calc.hyp.0662 | hypothesis-testing.tex:763 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-1-2} |
| calc.hyp.0663 | hypothesis-testing.tex:764 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-1-3} |
| calc.hyp.0664 | hypothesis-testing.tex:775 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-2-1} |
| calc.hyp.0665 | hypothesis-testing.tex:784 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-3-1} |
| calc.hyp.0666 | hypothesis-testing.tex:793 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-4-1} |
| calc.hyp.0667 | hypothesis-testing.tex:805 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-5-1} |
| calc.hyp.0668 | hypothesis-testing.tex:806 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-5-2} |
| calc.hyp.0669 | hypothesis-testing.tex:807 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-5-3} |
| calc.hyp.0670 | hypothesis-testing.tex:821 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-6-1} |
| calc.hyp.0671 | hypothesis-testing.tex:822 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-6-2} |
| calc.hyp.0672 | hypothesis-testing.tex:823 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-6-3} |
| calc.hyp.0673 | hypothesis-testing.tex:835 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-7-1} |
| calc.hyp.0674 | hypothesis-testing.tex:836 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-7-2} |
| calc.hyp.0675 | hypothesis-testing.tex:837 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-7-3} |
| calc.hyp.0676 | hypothesis-testing.tex:846 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-1} |
| calc.hyp.0677 | hypothesis-testing.tex:847 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-2} |
| calc.hyp.0678 | hypothesis-testing.tex:848 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-3} |
| calc.hyp.0679 | hypothesis-testing.tex:849 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-4} |
| calc.hyp.0680 | hypothesis-testing.tex:850 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-5} |
| calc.hyp.0681 | hypothesis-testing.tex:851 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-6} |
| calc.hyp.0682 | hypothesis-testing.tex:852 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-8-7} |
| calc.hyp.0683 | hypothesis-testing.tex:864 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-9-1} |
| calc.hyp.0684 | hypothesis-testing.tex:873 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-10-1} |
| calc.hyp.0685 | hypothesis-testing.tex:874 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-4-10-2} |
| calc.hyp.0686 | hypothesis-testing.tex:889 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-1-1} |
| calc.hyp.0687 | hypothesis-testing.tex:890 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-1-2} |
| calc.hyp.0688 | hypothesis-testing.tex:891 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-1-3} |
| calc.hyp.0689 | hypothesis-testing.tex:900 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-2-1} |
| calc.hyp.0690 | hypothesis-testing.tex:909 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-3-1} |
| calc.hyp.0691 | hypothesis-testing.tex:918 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-4-1} |
| calc.hyp.0692 | hypothesis-testing.tex:927 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-5-1} |
| calc.hyp.0693 | hypothesis-testing.tex:928 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-5-2} |
| calc.hyp.0694 | hypothesis-testing.tex:929 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-5-3} |
| calc.hyp.0695 | hypothesis-testing.tex:938 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-6-1} |
| calc.hyp.0696 | hypothesis-testing.tex:939 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-6-2} |
| calc.hyp.0697 | hypothesis-testing.tex:940 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-6-3} |
| calc.hyp.0698 | hypothesis-testing.tex:949 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-7-1} |
| calc.hyp.0699 | hypothesis-testing.tex:950 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-7-2} |
| calc.hyp.0700 | hypothesis-testing.tex:951 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-7-3} |
| calc.hyp.0701 | hypothesis-testing.tex:960 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-1} |
| calc.hyp.0702 | hypothesis-testing.tex:961 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-2} |
| calc.hyp.0703 | hypothesis-testing.tex:962 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-3} |
| calc.hyp.0704 | hypothesis-testing.tex:963 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-4} |
| calc.hyp.0705 | hypothesis-testing.tex:964 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-5} |
| calc.hyp.0706 | hypothesis-testing.tex:965 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-6} |
| calc.hyp.0707 | hypothesis-testing.tex:966 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-8-7} |
| calc.hyp.0708 | hypothesis-testing.tex:975 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-9-1} |
| calc.hyp.0709 | hypothesis-testing.tex:984 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-10-1} |
| calc.hyp.0710 | hypothesis-testing.tex:985 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-4-10-2} |

## Regression Analysis

- Support notebook: notebooks/support/regression-analysis/support.html
- Classified calculation candidates: 424

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.reg.0711 | regression-analysis.tex:732 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod0-rows} |
| calc.reg.0712 | regression-analysis.tex:822 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod1-rows} |
| calc.reg.0713 | regression-analysis.tex:855 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod2-rows} |
| calc.reg.0714 | regression-analysis.tex:1364 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod3-rows} |
| calc.reg.0715 | regression-analysis.tex:1778 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-inline-linked-values} |
| calc.reg.0716 | regression-analysis.tex:1989 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod4-rows} |
| calc.reg.0717 | regression-analysis.tex:2024 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-summary-mod5-rows} |
| calc.reg.0718 | regression-analysis.tex:2417 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-annual-expectation-interval} |
| calc.reg.0719 | regression-analysis.tex:2494 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-annual-assurance} |
| calc.reg.0720 | regression-analysis.tex:2525 | must_be_generated_from_support_notebook | generated_snippet_linked | \input{generated/worked-calculations/reg-annual-decision-bounds} |
| calc.reg.0721 | regression-analysis.tex:58 | static_theoretical_or_illustrative | intentional_manual | \item Evaluating whether recorded 2014 revenue is consistent with expectations and within acceptable variance. |
| calc.reg.0722 | regression-analysis.tex:64 | static_theoretical_or_illustrative | intentional_manual | Figure \ref{fig:H7_ussteamco_estimation_holdout} shows the monthly revenue and production data used in the case. The observations from 2011 to 2013 form the estimation period; the observations from 2014 form the hold-... |
| calc.reg.0723 | regression-analysis.tex:151 | must_be_checked_against_support_notebook | checked_in_support_output | y = \beta_0 + \beta_1x + \epsilon |
| calc.reg.0724 | regression-analysis.tex:156 | static_theoretical_or_illustrative | intentional_manual | Variable $y$ on the left-hand side of the equation is the conditional mean of the variable under analysis, or the dependent variable. Variable $x$ on the right side represents the independent variable. The relationshi... |
| calc.reg.0725 | regression-analysis.tex:336 | must_be_checked_against_support_notebook | checked_in_support_output | y = \beta_0 + \beta_1x + \epsilon |
| calc.reg.0726 | regression-analysis.tex:352 | static_theoretical_or_illustrative | intentional_manual | A requirement that is often overlooked is that the observations of $y$ and $x$ used to estimate the coefficients $\beta_0$ and $\beta_1$ are randomly obtained. Particularly in time-series analysis, it may be difficult... |
| calc.reg.0727 | regression-analysis.tex:377 | must_be_checked_against_support_notebook | checked_in_support_output | This requirement is quite technical, and we usually do not have to worry about it. First, it is needed to ensure that the estimators of $\beta_0$ and $\beta_1$ are unbiased. The requirement that the errors $\epsilon$ ... |
| calc.reg.0728 | regression-analysis.tex:382 | must_be_checked_against_support_notebook | checked_in_support_output | E(y \| x) = \beta_0 + \beta_1x |
| calc.reg.0729 | regression-analysis.tex:549 | static_theoretical_or_illustrative | intentional_manual | For time-series data, this split is straightforward: we use prior year(s) data for the estimation set to develop the model. The model is then used to make expectations for the current year, where the current-year data... |
| calc.reg.0730 | regression-analysis.tex:553 | must_be_checked_against_support_notebook | checked_in_support_output | When we analyze cross-sectional data from similar entities, such as retail outlets or stores, the data can be split into an estimation set and a hold-out set based on random sampling or structural characteristics. In ... |
| calc.reg.0731 | regression-analysis.tex:615 | must_be_generated_from_support_notebook | migration_required | \ttblue{mod.2} & Extension of \ttblue{mod.1} that includes interaction terms to capture differential effects in summer and non-summer periods. & \ref{sub:disaggregation_ch07}\\ |
| calc.reg.0732 | regression-analysis.tex:643 | must_be_checked_against_support_notebook | checked_in_support_output | y = \beta_0 + \beta_1x + \epsilon |
| calc.reg.0733 | regression-analysis.tex:655 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y} = b_0 + b_1 x |
| calc.reg.0734 | regression-analysis.tex:661 | must_be_checked_against_support_notebook | checked_in_support_output | \hspace*{1.2cm}\=\hspace*{0.4cm}\=\hspace*{0.2cm}\= \kill |
| calc.reg.0735 | regression-analysis.tex:678 | static_theoretical_or_illustrative | intentional_manual | Hence, the slope coefficient $b_1$ is a sample statistic and estimate of the slope coefficient $\beta_1$ of the (unknown) population. |
| calc.reg.0736 | regression-analysis.tex:680 | static_theoretical_or_illustrative | intentional_manual | Similarly, the constant term $b_0$ in the equation represents a sample statistic that is an estimate of the population constant $\beta_0$. |
| calc.reg.0737 | regression-analysis.tex:686 | must_be_checked_against_support_notebook | checked_in_support_output | b_1 = \frac{\sum{xy} - n \bar{x} \bar{y}}{(n - 1) s^2_x} |
| calc.reg.0738 | regression-analysis.tex:693 | must_be_checked_against_support_notebook | checked_in_support_output | b_0 = \bar{y} - b_1 \bar{x} |
| calc.reg.0739 | regression-analysis.tex:712 | must_be_checked_against_support_notebook | checked_in_support_output | The estimated values are $b_0 = \RegModZeroIntercept$ for the intercept and $b_1 = \RegModZeroSlope$ for the slope.\footnote{The calculation of the coefficients is shown in Exercise \ref{ex:modelling_mod0}.} Replacing... |
| calc.reg.0740 | regression-analysis.tex:719 | static_theoretical_or_illustrative | intentional_manual | This shows that the company earns \$\RegModZeroSlope in revenue for every additional thousand pounds of steam produced. We also observe that the \hlblue{coefficient of determination}\index{coefficient of determination... |
| calc.reg.0741 | regression-analysis.tex:724 | static_theoretical_or_illustrative | intentional_manual | \begin{tabularx}{\textwidth}{X Z{2cm} Z{2cm} Z{1.5cm} Z{1.5cm}} |
| calc.reg.0742 | regression-analysis.tex:750 | must_be_checked_against_support_notebook | checked_in_support_output | y = \beta_0 + \beta_1x_1+ \ldots + \beta_kx_k+ \epsilon |
| calc.reg.0743 | regression-analysis.tex:756 | must_be_checked_against_support_notebook | checked_in_support_output | In practice, it is not always easy to determine which variables should be considered for inclusion in a model or to obtain their data. When we are fortunate enough to have data for all potentially relevant independent... |
| calc.reg.0744 | regression-analysis.tex:785 | must_be_generated_from_support_notebook | migration_required | revenue    &  1.0000 &  0.6298 & -0.1304 &  0.6541 \\ |
| calc.reg.0745 | regression-analysis.tex:786 | must_be_generated_from_support_notebook | migration_required | production &  0.6298 &  1.0000 &  0.5788 & -0.0487 \\ |
| calc.reg.0746 | regression-analysis.tex:787 | must_be_generated_from_support_notebook | migration_required | coolDD     & -0.1304 &  0.5788 &  1.0000 & -0.7248 \\ |
| calc.reg.0747 | regression-analysis.tex:788 | must_be_generated_from_support_notebook | migration_required | heatDD     &  0.6541 & -0.0487 & -0.7248 &  1.0000 \\ |
| calc.reg.0748 | regression-analysis.tex:810 | must_be_generated_from_support_notebook | migration_required | Adding the additional variables \texttt{coolDD} and \texttt{heatDD} has improved the fit of the model. The residual standard deviation decreased from \footnote{See Exercises \ref{ex:modelling_mod0} and \ref{ex:modelli... |
| calc.reg.0749 | regression-analysis.tex:835 | must_be_checked_against_support_notebook | checked_in_support_output | Closer inspection of the data reveals two distinct groups, identified by the \ttblue{summer} variable. Figure \ref{fig:H7_scat_rev2} shows a scatter plot of production and revenue, with two separate regression lines. ... |
| calc.reg.0750 | regression-analysis.tex:863 | must_be_checked_against_support_notebook | checked_in_support_output | Remember that the interaction variable \ttblue{summer} takes on values of 0 or 1. In winter months, \ttblue{summer = 0}, and the regression model reduces to: |
| calc.reg.0751 | regression-analysis.tex:866 | must_be_checked_against_support_notebook | checked_in_support_output | \text{revenue} = \beta_0 + \beta_1 \cdot \text{production} + \beta_2 \cdot \text{coolDD} + \beta_3 \cdot \text{heatDD} + \epsilon |
| calc.reg.0752 | regression-analysis.tex:872 | must_be_generated_from_support_notebook | migration_required | \text{revenue} = 467,201 + 34.26 \cdot \text{production} -120,941 \cdot \text{coolDD} + 1,495 \cdot \text{heatDD} |
| calc.reg.0753 | regression-analysis.tex:875 | must_be_generated_from_support_notebook | migration_required | For the summer months, when \ttblue{summer = 1}, the interaction terms apply, and they adjust the intercept and the predictors. The \ttblue{intercept} of 467,201 is adjusted upward by 4,923,031 to 5,390,232, the produ... |
| calc.reg.0754 | regression-analysis.tex:878 | must_be_generated_from_support_notebook | migration_required | \text{revenue} = 5,390,232 + 10.63 \cdot \text{production} + 3,505 \cdot \text{coolDD} -11,845 \cdot \text{heatDD} |
| calc.reg.0755 | regression-analysis.tex:917 | static_theoretical_or_illustrative | intentional_manual | Both the dependent variable \(y\) and the independent variables \(x_1,\ldots,x_k\) can be transformed. Transformations are commonly used to improve the suitability of a regression model. Depending on the circumstances... |
| calc.reg.0756 | regression-analysis.tex:927 | must_be_checked_against_support_notebook | checked_in_support_output | \ln(y) & \text{if } \lambda = 0 |
| calc.reg.0757 | regression-analysis.tex:931 | must_be_checked_against_support_notebook | checked_in_support_output | In this formula, \(y\) represents the original observation and \(\lambda\) is the transformation parameter. The transformed value is denoted by \(y(\lambda)\). As \(\lambda\) approaches zero, the transformation conver... |
| calc.reg.0758 | regression-analysis.tex:941 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{\(\lambda = -1\):} |
| calc.reg.0759 | regression-analysis.tex:945 | must_be_checked_against_support_notebook | checked_in_support_output | y(\lambda)=1-\frac{1}{y}. |
| calc.reg.0760 | regression-analysis.tex:950 | must_be_generated_from_support_notebook | migration_required | \paragraph{\(\lambda = -0.5\):} |
| calc.reg.0761 | regression-analysis.tex:954 | must_be_checked_against_support_notebook | checked_in_support_output | y(\lambda)=2\left(1-\frac{1}{\sqrt{y}}\right). |
| calc.reg.0762 | regression-analysis.tex:959 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{\(\lambda = 0\):} |
| calc.reg.0763 | regression-analysis.tex:968 | must_be_generated_from_support_notebook | migration_required | \paragraph{\(\lambda = 0.5\):} |
| calc.reg.0764 | regression-analysis.tex:972 | must_be_checked_against_support_notebook | checked_in_support_output | y(\lambda)=2(\sqrt{y}-1). |
| calc.reg.0765 | regression-analysis.tex:977 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{\(\lambda = 1\):} |
| calc.reg.0766 | regression-analysis.tex:981 | must_be_checked_against_support_notebook | checked_in_support_output | y(\lambda)=y-1. |
| calc.reg.0767 | regression-analysis.tex:986 | must_be_checked_against_support_notebook | checked_in_support_output | \paragraph{\(\lambda = 2\):} |
| calc.reg.0768 | regression-analysis.tex:990 | must_be_checked_against_support_notebook | checked_in_support_output | y(\lambda)=\frac{y^2-1}{2}. |
| calc.reg.0769 | regression-analysis.tex:1017 | must_be_generated_from_support_notebook | migration_required | Standard linear regression & -- & $y = b_0 + b_1x$ & $\hat{y} = b_0 + b_1x$ \\ |
| calc.reg.0770 | regression-analysis.tex:1018 | must_be_generated_from_support_notebook | migration_required | Exponential & ln(y) & $ln(y) = b_0 + b_1x$ & $\hat{y} = e^{b_0 + b_1x}$ \\ |
| calc.reg.0771 | regression-analysis.tex:1019 | must_be_generated_from_support_notebook | migration_required | Quadratic & sqrt(y) & $\sqrt{y} = b_0 + b_1x$ & $\hat{y} = (b_0 + b_1x)^2$ \\ |
| calc.reg.0772 | regression-analysis.tex:1020 | must_be_generated_from_support_notebook | migration_required | Inverse & 1/y & $1/y = b_0 + b_1x$ & $\hat{y} = 1 / (b_0 + b_1x)$ \\ |
| calc.reg.0773 | regression-analysis.tex:1021 | must_be_generated_from_support_notebook | migration_required | Logarithmic & ln(x) & $y = b_0 + b_1ln(x)$ & $\hat{y} = b_0 + b_1ln(x)$ \\ |
| calc.reg.0774 | regression-analysis.tex:1022 | must_be_generated_from_support_notebook | migration_required | Power & ln(y), ln(x) & $ln(y) = b_0 + b_1ln(x)$ & $\hat{y} = e^{b_0} \cdot x^{b_1}$ \\ |
| calc.reg.0775 | regression-analysis.tex:1169 | must_be_checked_against_support_notebook | checked_in_support_output | h_i = \frac{1}{n} + \frac{(x_i - \bar{x})^2}{\sum_{j=1}^{n}(x_j - \bar{x})^2} |
| calc.reg.0776 | regression-analysis.tex:1173 | must_be_checked_against_support_notebook | checked_in_support_output | Equation \ref{eq:hat_value} shows that $h_i$ increases as the distance between $x_i$ and $\bar{x}$ increases. Therefore, in simple linear regression high-leverage observations lie outside the normal range of observati... |
| calc.reg.0777 | regression-analysis.tex:1184 | must_be_checked_against_support_notebook | checked_in_support_output | e_i^* = \frac{e_i}{s_{e(-i)}\sqrt{1 - h_i}} |
| calc.reg.0778 | regression-analysis.tex:1200 | must_be_checked_against_support_notebook | checked_in_support_output | The Studentized residual $e_i^*$ follows a $t$ distribution with $n - k - 2$ degrees of freedom. Be careful, however, to look up all observations with a Studentized residual greater than 2. First, we expect to find ap... |
| calc.reg.0779 | regression-analysis.tex:1215 | must_be_checked_against_support_notebook | checked_in_support_output | We can observe in Figure \ref{fig:H7_qqplot} that the unadjusted $p$ value of the largest absolute Studentized residual is multiplied by the number of tests $n = 36$ to arrive at the Bonferroni $p$ value. Since the Bo... |
| calc.reg.0780 | regression-analysis.tex:1222 | must_be_checked_against_support_notebook | checked_in_support_output | D_i = \frac{e_i^{*2}}{k+1}\frac{h_i}{1-h_i} |
| calc.reg.0781 | regression-analysis.tex:1237 | must_be_checked_against_support_notebook | checked_in_support_output | If the cut-off is chosen too low (for example, $D_i > \frac{4}{n-k-1}$), observations with only mild influence may be flagged. This may lead to unnecessary investigation and could result in the removal of observations... |
| calc.reg.0782 | regression-analysis.tex:1239 | static_theoretical_or_illustrative | intentional_manual | As a rule of thumb, observations with a Cook's distance greater than 1 are often considered highly influential and generally warrant investigation. Observations with Cook's distance between 0.5 and 1 may merit review,... |
| calc.reg.0783 | regression-analysis.tex:1241 | must_be_checked_against_support_notebook | checked_in_support_output | Figure \ref{fig:H7_influenceplot} combines three measures that are commonly used to assess influential observations. The horizontal axis shows the hat-values (leverage), the vertical axis shows the Studentized residua... |
| calc.reg.0784 | regression-analysis.tex:1260 | must_be_generated_from_support_notebook | migration_required | 22 & 2012/10 & \textbf{-4.1680952} &          0.2463804 & \textbf{0.448000286} \\ |
| calc.reg.0785 | regression-analysis.tex:1261 | must_be_generated_from_support_notebook | migration_required | 29 & 2013/05 &           0.2155177 & \textbf{0.5187665} & 0.006479471 \\ |
| calc.reg.0786 | regression-analysis.tex:1262 | must_be_generated_from_support_notebook | migration_required | 30 & 2013/06 &           1.3124479 & \textbf{0.4899321} & \textbf{0.201612590} \\ |
| calc.reg.0787 | regression-analysis.tex:1263 | must_be_generated_from_support_notebook | migration_required | 34 & 2013/10 &  \textbf{2.3990931} & \textbf{0.6194744} & \textbf{1.001187652} \\ |
| calc.reg.0788 | regression-analysis.tex:1264 | must_be_generated_from_support_notebook | migration_required | 36 & 2013/12 & \textbf{-2.2533566} &          0.1021413 & 0.063025927 \\ |
| calc.reg.0789 | regression-analysis.tex:1273 | static_theoretical_or_illustrative | intentional_manual | The observations with the largest absolute Studentized residuals are 22, 34, and 36, whereas the observations with the largest leverage values are 34, 29, and 30. The three most influential observations, as measured b... |
| calc.reg.0790 | regression-analysis.tex:1299 | static_theoretical_or_illustrative | intentional_manual | In our case, only the October 2012 residual was below the lower threshold $\tau_L$, defined as the 5th percentile of the residual distribution. The adjusted October 2012 revenue is therefore set equal to its fitted va... |
| calc.reg.0791 | regression-analysis.tex:1306 | must_be_checked_against_support_notebook | checked_in_support_output | width=12cm, |
| calc.reg.0792 | regression-analysis.tex:1307 | must_be_checked_against_support_notebook | checked_in_support_output | height=6cm, |
| calc.reg.0793 | regression-analysis.tex:1310 | must_be_generated_from_support_notebook | migration_required | ymin=-5000000, ymax=2500000, |
| calc.reg.0794 | regression-analysis.tex:1311 | must_be_checked_against_support_notebook | checked_in_support_output | xtick={1,6,...,36}, |
| calc.reg.0795 | regression-analysis.tex:1315 | must_be_checked_against_support_notebook | checked_in_support_output | /pgf/number format/precision=1 |
| calc.reg.0796 | regression-analysis.tex:1317 | must_be_checked_against_support_notebook | checked_in_support_output | xticklabel style={rotate=45}, |
| calc.reg.0797 | regression-analysis.tex:1318 | must_be_checked_against_support_notebook | checked_in_support_output | title={Winsorization of Observation 22 (October 2012)}, |
| calc.reg.0798 | regression-analysis.tex:1319 | must_be_generated_from_support_notebook | migration_required | ytick={-5000000,-2500000,0,2500000}, |
| calc.reg.0799 | regression-analysis.tex:1320 | must_be_generated_from_support_notebook | migration_required | enlargelimits=0.1, |
| calc.reg.0800 | regression-analysis.tex:1324 | must_be_checked_against_support_notebook | checked_in_support_output | \addplot+[only marks, mark=*, mark size=2pt, KPMG_blue] coordinates { |
| calc.reg.0801 | regression-analysis.tex:1325 | static_theoretical_or_illustrative | intentional_manual | (1,-1288215) (2,-608990) (3,-1002086) (4,-725783) (5,47735) |
| calc.reg.0802 | regression-analysis.tex:1326 | static_theoretical_or_illustrative | intentional_manual | (6,-894259) (7,-1005443) (8,180658) (9,206435) (10,618143) |
| calc.reg.0803 | regression-analysis.tex:1327 | static_theoretical_or_illustrative | intentional_manual | (11,394919) (12,1341802) (13,1334097) (14,338355) (15,-600937) |
| calc.reg.0804 | regression-analysis.tex:1328 | static_theoretical_or_illustrative | intentional_manual | (16,1275732) (17,-657053) (18,-1038038) (19,-748714) (20,176320) |
| calc.reg.0805 | regression-analysis.tex:1329 | static_theoretical_or_illustrative | intentional_manual | (21,-390729) (22,-4830879) (23,-490111) (24,2129685) (25,99166) |
| calc.reg.0806 | regression-analysis.tex:1330 | static_theoretical_or_illustrative | intentional_manual | (26,1851338) (27,1481242) (28,2157458) (29,255669) (30,1555452) |
| calc.reg.0807 | regression-analysis.tex:1331 | static_theoretical_or_illustrative | intentional_manual | (31,911119) (32,899648) (33,501201) (34,2299683) (35,-2421841) |
| calc.reg.0808 | regression-analysis.tex:1336 | must_be_checked_against_support_notebook | checked_in_support_output | \addplot+[only marks, mark=*, mark size=3pt, KPMG_light_pink] coordinates {(22, -4830879)}; |
| calc.reg.0809 | regression-analysis.tex:1337 | must_be_checked_against_support_notebook | checked_in_support_output | \node[align=center, below, KPMG_light_pink] at (axis cs:22, -4830879) {Original}; |
| calc.reg.0810 | regression-analysis.tex:1340 | must_be_checked_against_support_notebook | checked_in_support_output | \addplot+[only marks, mark=*, mark size=3pt, KPMG_light_blue] coordinates {(22, -2421841)}; |
| calc.reg.0811 | regression-analysis.tex:1341 | must_be_checked_against_support_notebook | checked_in_support_output | \node[align=center, above, KPMG_light_blue] at (axis cs:22, -2421841) {Winsorized}; |
| calc.reg.0812 | regression-analysis.tex:1344 | static_theoretical_or_illustrative | intentional_manual | \draw[dashed, thick, gray] (axis cs:22,-4830879) -- (axis cs:22,-2421841); |
| calc.reg.0813 | regression-analysis.tex:1352 | must_be_generated_from_support_notebook | migration_required | We fit a new model, \ttblue{mod.3}, on the residual-winsorized data. The coefficient estimates of this model are summarized in Table \ref{tab:summary_mod_3} below. Following the AAG guidance (AAG A.63), the results sh... |
| calc.reg.0814 | regression-analysis.tex:1382 | must_be_checked_against_support_notebook | checked_in_support_output | VIF(x_j) = \frac{1}{1 - r_j^2} |
| calc.reg.0815 | regression-analysis.tex:1386 | static_theoretical_or_illustrative | intentional_manual | High VIF scores, particularly above 10, indicate the presence of multicollinearity and the need for action. If VIF > 10 for a particular predictor $x_j$, this implies that $r_j^2 > 0.9$. |
| calc.reg.0816 | regression-analysis.tex:1408 | must_be_checked_against_support_notebook | checked_in_support_output | GVIF_j^{1/(2df_j)} = \sqrt{VIF_j}. |
| calc.reg.0817 | regression-analysis.tex:1414 | must_be_checked_against_support_notebook | checked_in_support_output | \sqrt{10} \approx 3.16. |
| calc.reg.0818 | regression-analysis.tex:1417 | static_theoretical_or_illustrative | intentional_manual | Thus, when using the adjusted GVIF scale, values above about 3.16 may indicate substantial multicollinearity. Values well below this threshold do not suggest serious variance inflation. |
| calc.reg.0819 | regression-analysis.tex:1418 | must_be_generated_from_support_notebook | migration_required | For the \emph{Case: US SteamCo}, the largest VIF in \ttblue{mod.1} is 5.60 (for \ttblue{coolDD}), and the largest adjusted GVIF in \ttblue{mod.3} is 2.47 (also for \ttblue{coolDD}).\footnote{See Exercise \ref{ex:vif}}... |
| calc.reg.0820 | regression-analysis.tex:1431 | static_theoretical_or_illustrative | intentional_manual | In statistical analysis, the terms \emph{variation} and \emph{variance} are frequently encountered, each carrying distinct implications despite their apparent similarity. While both concepts pertain to the dispersion ... |
| calc.reg.0821 | regression-analysis.tex:1438 | must_be_checked_against_support_notebook | checked_in_support_output | \draw [->, >=stealth] (0,0) -- (10, 0) node[below] {production}; |
| calc.reg.0822 | regression-analysis.tex:1439 | must_be_checked_against_support_notebook | checked_in_support_output | \draw [->, >=stealth] (0,0) -- (0, 5.5) node[left] {revenue}; |
| calc.reg.0823 | regression-analysis.tex:1441 | static_theoretical_or_illustrative | intentional_manual | \draw (0,1) -- (10, 4.6) node[above] {$\hat{y}$}; |
| calc.reg.0824 | regression-analysis.tex:1443 | static_theoretical_or_illustrative | intentional_manual | \draw (0, 2.89) [dashed] node[left] {$\bar{y}$} -- (10, 2.89); |
| calc.reg.0825 | regression-analysis.tex:1445 | static_theoretical_or_illustrative | intentional_manual | \draw [Parenthesis-Parenthesis] (1.0, 2.91) -- node[left] {explained} (1.0, 1.4); |
| calc.reg.0826 | regression-analysis.tex:1446 | static_theoretical_or_illustrative | intentional_manual | \draw [Parenthesis-Parenthesis] (1.2, 1.4) -- node[right] {unexplained} (1.2, 0.9); |
| calc.reg.0827 | regression-analysis.tex:1448 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (1, 2.89) -- (1, 0.9) node[left] {$y_i$}; |
| calc.reg.0828 | regression-analysis.tex:1449 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (2, 2.89) -- (2, 1.8); |
| calc.reg.0829 | regression-analysis.tex:1450 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (3, 2.89) -- (3, 1.8); |
| calc.reg.0830 | regression-analysis.tex:1451 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (3.5, 2.89) -- (3.5, 2.2); |
| calc.reg.0831 | regression-analysis.tex:1452 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (3.8, 2.89) -- (3.8, 2.6); |
| calc.reg.0832 | regression-analysis.tex:1453 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (4.5, 2.89) -- (4.5, 2.5); |
| calc.reg.0833 | regression-analysis.tex:1454 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (4.9, 2.89) -- (4.9, 3.4); |
| calc.reg.0834 | regression-analysis.tex:1455 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (5.9, 2.89) -- (5.9, 3.4); |
| calc.reg.0835 | regression-analysis.tex:1456 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (6.0, 2.89) -- (6.0, 3.2); |
| calc.reg.0836 | regression-analysis.tex:1457 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (7.1, 2.89) -- (7.1, 4.2); |
| calc.reg.0837 | regression-analysis.tex:1458 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (7.3, 2.89) -- (7.3, 3.6); |
| calc.reg.0838 | regression-analysis.tex:1459 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (8.2, 2.89) -- (8.2, 4.8); |
| calc.reg.0839 | regression-analysis.tex:1460 | static_theoretical_or_illustrative | intentional_manual | \draw [-o] (9.5, 2.89) -- (9.5, 4.2); |
| calc.reg.0840 | regression-analysis.tex:1463 | static_theoretical_or_illustrative | intentional_manual | \draw (5.23, 0) [dotted] node[below] {$\bar{x}$} -- (5.23, 2.89);  % Correctly position $\bar{x}$ and $\bar{y}$ |
| calc.reg.0841 | regression-analysis.tex:1465 | static_theoretical_or_illustrative | intentional_manual | \draw (0, 2.89) [dashed] node[left] {$\bar{y}$} -- (5.23, 2.89); % Correct $\bar{y}$ position |
| calc.reg.0842 | regression-analysis.tex:1494 | static_theoretical_or_illustrative | intentional_manual | Explained   & Regression (SSR) & $\sum{(\hat{y}_i - \bar{y})^2}$ & $k$\\ |
| calc.reg.0843 | regression-analysis.tex:1495 | must_be_generated_from_support_notebook | migration_required | Unexplained & Residuals (SSE)  & $\sum{(y_i - \hat{y})^2}$       & $n - k - 1$\\ |
| calc.reg.0844 | regression-analysis.tex:1499 | must_be_generated_from_support_notebook | migration_required | Total & Total (TSS) & $\sum{(y_i - \bar{y})^2}$ & $n - 1$ \\ |
| calc.reg.0845 | regression-analysis.tex:1509 | must_be_checked_against_support_notebook | checked_in_support_output | Note that $s^2_y = TSS/(n-1)$, and that therefore $TSS = s^2_y (n - 1)$. |
| calc.reg.0846 | regression-analysis.tex:1514 | must_be_checked_against_support_notebook | checked_in_support_output | r = b_1 \frac{s_x}{s_y} |
| calc.reg.0847 | regression-analysis.tex:1523 | static_theoretical_or_illustrative | intentional_manual | The correlation coefficient $r$ takes values between -1 and +1. The sign of the coefficient indicates the direction of the relationship and the numerical value indicates the strength. The correlation is perfect when t... |
| calc.reg.0848 | regression-analysis.tex:1530 | must_be_checked_against_support_notebook | checked_in_support_output | r^2 = \frac{\text{SSR}}{\text{TSS}} |
| calc.reg.0849 | regression-analysis.tex:1537 | must_be_checked_against_support_notebook | checked_in_support_output | \sum{(y_i - \bar{y})^2} = 9.5307 \cdot 10^{14} |
| calc.reg.0850 | regression-analysis.tex:1553 | must_be_generated_from_support_notebook | migration_required | production & 3.7804e+14 & 1  & 3.7804e+14  \\ |
| calc.reg.0851 | regression-analysis.tex:1554 | must_be_generated_from_support_notebook | migration_required | residuals  & 5.7503e+14 & 34 & 1.6913e+13  \\ |
| calc.reg.0852 | regression-analysis.tex:1558 | must_be_generated_from_support_notebook | migration_required | Total      & 9.5307e+14 & 35 &  \\ |
| calc.reg.0853 | regression-analysis.tex:1569 | must_be_checked_against_support_notebook | checked_in_support_output | The analysis shows that the sum of squares of the regression is $3.7804 \cdot 10^{14}$, and the sum of squares of the residuals is $5.7503 \cdot 10^{14}$. The total sum of squares is $3.7804 \cdot 10^{14} + 5.7503 \cd... |
| calc.reg.0854 | regression-analysis.tex:1577 | must_be_checked_against_support_notebook | checked_in_support_output | Thus, $MSR = SSR / df_R = 3.7804 \cdot 10^{14} / 1 = 3.7804 \cdot 10^{14}$, and $MSE = SSE / df_E = 5.7503 \cdot 10^{14} / 34 = 1.6913  \cdot 10^{13}$. |
| calc.reg.0855 | regression-analysis.tex:1582 | must_be_checked_against_support_notebook | checked_in_support_output | r^2 = \frac{SSR}{TSS} = \frac{3.7804 \cdot 10^{14}}{9.5307 \cdot 10^{14}} = 0.3967 |
| calc.reg.0856 | regression-analysis.tex:1585 | must_be_checked_against_support_notebook | checked_in_support_output | This result is similar to that reported in the brief summary of the model. We find that \ttblue{mod.0} explains 39.7\% of the revenue variation. Similarly, the \hlblue{residual standard deviation}\index{residual stand... |
| calc.reg.0857 | regression-analysis.tex:1588 | must_be_checked_against_support_notebook | checked_in_support_output | \text{MSE} = s_e = \sqrt{\frac{\text{SSE}}{n-k-1}} = \sqrt{\frac{5.7503 \cdot 10^{14}}{34}} = 4,112,487 |
| calc.reg.0858 | regression-analysis.tex:1591 | static_theoretical_or_illustrative | intentional_manual | Expanding \ttblue{mod.0} by adding the independent variables \ttblue{coolDD} and \ttblue{heatDD}, we get \ttblue{mod.1}. Its analysis of variance is summarized in Table \ref{tab:anova_mod1}. |
| calc.reg.0859 | regression-analysis.tex:1606 | must_be_generated_from_support_notebook | migration_required | production & 3.7804e+14 & 1  & 3.7804e+14 \\ |
| calc.reg.0860 | regression-analysis.tex:1607 | must_be_generated_from_support_notebook | migration_required | coolDD     & 3.5110e+14 & 1  & 3.5110e+14 \\ |
| calc.reg.0861 | regression-analysis.tex:1608 | must_be_generated_from_support_notebook | migration_required | heatDD     & 9.8390e+13 & 1  & 9.8390e+13 \\ |
| calc.reg.0862 | regression-analysis.tex:1609 | must_be_generated_from_support_notebook | migration_required | residuals  & 1.2554e+14 & 32 & 3.9232e+12 \\ |
| calc.reg.0863 | regression-analysis.tex:1613 | must_be_generated_from_support_notebook | migration_required | Total      & 9.5307e+14 & 35 &            \\ |
| calc.reg.0864 | regression-analysis.tex:1623 | static_theoretical_or_illustrative | intentional_manual | For \ttblue{mod.1}, the sum of squares regression, $SSR$, is the sum of the sum of squares of the three independent variables. |
| calc.reg.0865 | regression-analysis.tex:1626 | must_be_checked_against_support_notebook | checked_in_support_output | r^2 = \frac{\text{SSR}}{\text{TSS}} = \frac{3.7804 * 10^{14} + 3.5110 * 10^{14} + 9.8390 * 10^{13}}{9.5307 * 10^{14}} = 0.8683 |
| calc.reg.0866 | regression-analysis.tex:1629 | must_be_generated_from_support_notebook | migration_required | Note the increase in explained variation by adding the two additional variables to the model, \ttblue{coolDD} and \ttblue{heatDD}. Explained variance has increased from 39.67\% for \ttblue{mod.0} to 86.83\% for \ttblu... |
| calc.reg.0867 | regression-analysis.tex:1631 | static_theoretical_or_illustrative | intentional_manual | In this analysis, the calculation of the sum of squares is sequential in the sense that the effects of the independent variables are established in the order in which they were entered into the model specification. We... |
| calc.reg.0868 | regression-analysis.tex:1636 | must_be_generated_from_support_notebook | migration_required | The full summary table\footnote{See \ref{ex:summary.mod.0}} displays the values of the multiple $r^2$ (also referred to as the coefficient of determination\index{coefficient of determination}) and the adjusted $r^2$. ... |
| calc.reg.0869 | regression-analysis.tex:1641 | must_be_checked_against_support_notebook | checked_in_support_output | \text{adjusted } r^2 = r^2 - k \frac{1 - r^2}{n - k - 1} |
| calc.reg.0870 | regression-analysis.tex:1643 | must_be_generated_from_support_notebook | migration_required | The adjusted $r^2$ for \ttblue{mod.0} with $n = 36$ and $k = 1$ is then |
| calc.reg.0871 | regression-analysis.tex:1645 | must_be_checked_against_support_notebook | checked_in_support_output | \text{adjusted } r^2 = 0.3967 - \frac{1 - 0.3967}{34} = 0.3789 |
| calc.reg.0872 | regression-analysis.tex:1647 | must_be_generated_from_support_notebook | migration_required | For example, when we compare \ttblue{mod\_forward} from Exercise \ref{ex:modelling strategies} with \ttblue{mod.1} from Exercise \ref{ex:modelling_mod.1} we observe that the latter has a higher $r^2$ (0.8683) than the... |
| calc.reg.0873 | regression-analysis.tex:1654 | must_be_checked_against_support_notebook | checked_in_support_output | AIC = n \cdot \text{ln}(SSE / n) + 2k |
| calc.reg.0874 | regression-analysis.tex:1669 | static_theoretical_or_illustrative | intentional_manual | This point is important in the present chapter. Models \ttblue{mod.0}, \ttblue{model\_forward}, \ttblue{mod.1}, and \ttblue{mod.2} are fitted to the original estimation data. |
| calc.reg.0875 | regression-analysis.tex:1673 | static_theoretical_or_illustrative | intentional_manual | Table \ref{tab:comparison_mod_0_2} summarizes the performance of the models fitted to the original response data in terms of their multiple $r^2$, adjusted $r^2$, AIC, and BIC. |
| calc.reg.0876 | regression-analysis.tex:1684 | must_be_generated_from_support_notebook | migration_required | mod.0          & 0.3967 & 0.3789 & 1202.633 & 1207.383 \\ |
| calc.reg.0877 | regression-analysis.tex:1685 | must_be_generated_from_support_notebook | migration_required | model\_forward & 0.8667 & 0.8586 & 1150.277 & 1156.611 \\ |
| calc.reg.0878 | regression-analysis.tex:1686 | must_be_generated_from_support_notebook | migration_required | mod.1          & 0.8683 & 0.8559 & 1151.848 & 1159.766 \\ |
| calc.reg.0879 | regression-analysis.tex:1687 | must_be_generated_from_support_notebook | migration_required | mod.2          & 0.9170 & 0.8963 & 1143.217 & 1157.468 \\ |
| calc.reg.0880 | regression-analysis.tex:1694 | must_be_generated_from_support_notebook | migration_required | The assessment of regression model precision relies not only on overall goodness-of-fit statistics such as multiple $r^2$ and adjusted $r^2$, but also on measures of individual predictor strength and the overall stand... |
| calc.reg.0881 | regression-analysis.tex:1696 | must_be_generated_from_support_notebook | migration_required | The simple benchmark model \ttblue{mod.0} has an adjusted $r^2$ of 0.3789 and a BIC of 1207.383. The models that include additional predictors perform much better. \ttblue{model\_forward} and \ttblue{mod.1} both achie... |
| calc.reg.0882 | regression-analysis.tex:1698 | static_theoretical_or_illustrative | intentional_manual | Among the models fitted to the original response data, \ttblue{mod.2} has the highest adjusted $r^2$ and the lowest AIC. Its BIC is slightly higher than that of \ttblue{model\_forward}, reflecting the stronger penalty... |
| calc.reg.0883 | regression-analysis.tex:1700 | static_theoretical_or_illustrative | intentional_manual | After this comparison, we separately examine the effect of the outlying observation identified in the diagnostic analysis. Winsorizing observation 22 leads to \ttblue{mod.3}. The improvement in fit after winsorization... |
| calc.reg.0884 | regression-analysis.tex:1708 | static_theoretical_or_illustrative | intentional_manual | The standard error of the regression, although not tabulated, should also be interpreted in light of materiality. For example, AAG A.64 notes that if the standard error is less than about 75\% of materiality, the mode... |
| calc.reg.0885 | regression-analysis.tex:1744 | static_theoretical_or_illustrative | intentional_manual | Another graphical tool for assessing the normality of residuals is the QQ plot, previously introduced in the context of regression diagnostics. Figure \ref{fig:H7_qqplot}, on page \pageref{fig:H7_qqplot}, presents an ... |
| calc.reg.0886 | regression-analysis.tex:1772 | static_theoretical_or_illustrative | intentional_manual | Its calculation is quite complicated and based on order statistics. The $W$ statistic takes values between 0 and 1, with 1 being a perfect match with the normal distribution. |
| calc.reg.0887 | regression-analysis.tex:1780 | must_be_generated_from_support_notebook | generated_snippet_linked | \paragraph{Value of test statistic} We use the Shapiro--Wilk test to obtain the value of the $W$ statistic and its associated $p$ value. For \ttblue{mod.3}, the value of the $W$ statistic is \RegModThreeW, with a $p$ ... |
| calc.reg.0888 | regression-analysis.tex:1784 | handled_by_epic_214_model_test_output | epic_214_scope | The $p$ value of the Shapiro--Wilk test is \RegModThreeShapiroP. Con\-se\-quently, we do not reject the null hypothesis of normality at the conventional significance levels of 5\% or 1\%. The test therefore provides n... |
| calc.reg.0889 | regression-analysis.tex:1810 | static_theoretical_or_illustrative | intentional_manual | $H_0 : $ The residuals $\epsilon$ have constant variance. |
| calc.reg.0890 | regression-analysis.tex:1816 | static_theoretical_or_illustrative | intentional_manual | $H_1 : $ The residuals $\epsilon$ do not have constant variance. |
| calc.reg.0891 | regression-analysis.tex:1824 | must_be_checked_against_support_notebook | checked_in_support_output | e_i^2 = \alpha_0 + \alpha_1x_{1, i} + \alpha_2x_{2, i} + \ldots + \alpha_kx_{k, i} + u_i |
| calc.reg.0892 | regression-analysis.tex:1826 | static_theoretical_or_illustrative | intentional_manual | where $e_i^2$ is the squared residual of observation $i$, and $x_{1, i}, x_{2, i}, \ldots x_{k, i}$ are the values of the $k$ independent variables for observation $i$. |
| calc.reg.0893 | regression-analysis.tex:1828 | static_theoretical_or_illustrative | intentional_manual | If any of the $k$ independent variables is responsible for non-constant variance, its related coefficient $\alpha$ will be significant, and $r^2$ will increase. |
| calc.reg.0894 | regression-analysis.tex:1832 | must_be_checked_against_support_notebook | checked_in_support_output | BP = nr^2 |
| calc.reg.0895 | regression-analysis.tex:1844 | handled_by_epic_214_model_test_output | epic_214_scope | The $p$ value of the test statistic is \RegModThreeBpP. We therefore fail to reject the null hypothesis at conventional significance levels below \RegModThreeBpP, such as 5\% or 1\%. The model-validation test provides... |
| calc.reg.0896 | regression-analysis.tex:1873 | static_theoretical_or_illustrative | intentional_manual | If multiple bars exceeded the bounds, say, at lags 1 and 2, it could point to an AR(2) process. If all bars fall within the bounds, we conclude that the residuals are not significantly autocorrelated. |
| calc.reg.0897 | regression-analysis.tex:1904 | must_be_checked_against_support_notebook | checked_in_support_output | BG = nR^2 |
| calc.reg.0898 | regression-analysis.tex:1916 | must_be_checked_against_support_notebook | checked_in_support_output | In this example, the test is performed with order $p=3$. |
| calc.reg.0899 | regression-analysis.tex:1917 | static_theoretical_or_illustrative | intentional_manual | This means that the test evaluates whether the regression residuals exhibit autocorrelation at lags 1, 2, and 3. |
| calc.reg.0900 | regression-analysis.tex:1918 | handled_by_epic_214_model_test_output | epic_214_scope | Under the null hypothesis, the residuals are not autocorrelated at any of these lags. The reference distribution is therefore a chi-squared distribution with 3 degrees of freedom. |
| calc.reg.0901 | regression-analysis.tex:1921 | must_be_checked_against_support_notebook | checked_in_support_output | For example, when $p=3$, the test examines whether residuals in a given period are related to residuals from one, two, or three periods earlier. |
| calc.reg.0902 | regression-analysis.tex:1925 | must_be_checked_against_support_notebook | checked_in_support_output | For monthly or quarterly data, values of $p=2$ or $p=3$ are often a reasonable starting point. |
| calc.reg.0903 | regression-analysis.tex:1927 | must_be_checked_against_support_notebook | checked_in_support_output | If omitted, the default value is \ttblue{order = 1}, in which case only first-order autocorrelation is tested. |
| calc.reg.0904 | regression-analysis.tex:1931 | handled_by_epic_214_model_test_output | epic_214_scope | The $p$ value of the test statistic is \RegModThreeBgP. Therefore, we fail to reject the null hypothesis at conventional significance levels below \RegModThreeBgP, such as 5\% or 1\%. The model-validation test provide... |
| calc.reg.0905 | regression-analysis.tex:1951 | static_theoretical_or_illustrative | intentional_manual | + \beta_1(x_{1,t}-\rho x_{1,t-1}) |
| calc.reg.0906 | regression-analysis.tex:1975 | must_be_checked_against_support_notebook | checked_in_support_output | This transformation reduces the first-order autocorrelation in the residuals, provided that the AR(1) model is appropriate. The transformed variables are then used to estimate the regression model by ordinary least sq... |
| calc.reg.0907 | regression-analysis.tex:1997 | must_be_checked_against_support_notebook | checked_in_support_output | After applying the AR(1) correction, the Breusch--Godfrey test on \ttblue{mod.4} gives $BG = \RegModFourBg$ with $p = \RegModFourBgP$ (order 3), indicating no remaining evidence of residual autocorrelation at conventi... |
| calc.reg.0908 | regression-analysis.tex:2035 | must_be_generated_from_support_notebook | migration_required | \text{revenue} = 752,767 + 35.87 \cdot \text{production} - 121,381 \cdot \text{coolDD} |
| calc.reg.0909 | regression-analysis.tex:2041 | must_be_generated_from_support_notebook | migration_required | \text{revenue} = 3,972,293 + 12.64 \cdot \text{production} + 3,683 \cdot \text{coolDD} |
| calc.reg.0910 | regression-analysis.tex:2043 | must_be_generated_from_support_notebook | migration_required | The coefficient values take the interactions into account. Therefore, the intercept value is equal to $752,767 + 3,219,526 = 3,972,293$, the slope value for \ttblue{production} is equal to $35.87 - 23.23 = 12.64$, and... |
| calc.reg.0911 | regression-analysis.tex:2045 | must_be_checked_against_support_notebook | checked_in_support_output | Re-running the model-assumption checks for \ttblue{mod.5} gives Breusch--Pagan $BP = \RegModFiveBp$ ($p = \RegModFiveBpP$), Breusch--Godfrey $BG = \RegModFiveBg$ ($p = \RegModFiveBgP$, order 3), and Shapiro--Wilk $W =... |
| calc.reg.0912 | regression-analysis.tex:2067 | must_be_checked_against_support_notebook | checked_in_support_output | H_0 : \beta_j = 0 |
| calc.reg.0913 | regression-analysis.tex:2095 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Value of test statistic} We obtain estimates of the coefficients, their related standard errors, $t$ values, and $p$ values from Table \ref{tab:summary_mod_5}. |
| calc.reg.0914 | regression-analysis.tex:2100 | must_be_generated_from_support_notebook | migration_required | Among the remaining predictors, only the intercept exhibits a clearly non-significant $p$ value ($p = 0.525$). |
| calc.reg.0915 | regression-analysis.tex:2101 | must_be_checked_against_support_notebook | checked_in_support_output | The variable \ttblue{summer} has a $p$ value close to the conventional 5\% significance level ($p = 0.050173$). However, because \ttblue{summer} participates in a retained interaction term, it is kept in the model in ... |
| calc.reg.0916 | regression-analysis.tex:2116 | must_be_checked_against_support_notebook | checked_in_support_output | H_0 : \beta_1 = \beta_2 = \ldots = \beta_k = 0 |
| calc.reg.0917 | regression-analysis.tex:2139 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Value of test statistic} The value of the test statistic is $F = 81.8$, with 5 and 30 degrees of freedom, and a $p$ value of less than 2.2e-16. |
| calc.reg.0918 | regression-analysis.tex:2153 | static_theoretical_or_illustrative | intentional_manual | For the first month of the hold-out set (January 2014), the model can generate an expectation of revenue using the known values of the explanatory variables: production (606,400), coolDD (0), and whether the month is ... |
| calc.reg.0919 | regression-analysis.tex:2166 | must_be_generated_from_support_notebook | migration_required | intercept           &   752,767 & 1                 &    752,767 \\ |
| calc.reg.0920 | regression-analysis.tex:2167 | must_be_generated_from_support_notebook | migration_required | production          &     35.87 & 606,400           & 21,752,892 \\ |
| calc.reg.0921 | regression-analysis.tex:2168 | must_be_generated_from_support_notebook | migration_required | summer              & 3,219,526 & 0                 &          0 \\ |
| calc.reg.0922 | regression-analysis.tex:2169 | must_be_generated_from_support_notebook | migration_required | coolDD              &  -121,381 & 0                 &          0 \\ |
| calc.reg.0923 | regression-analysis.tex:2170 | must_be_generated_from_support_notebook | migration_required | production : summer &    -23.23 & 0 $\cdot$ 606,400 &          0 \\ |
| calc.reg.0924 | regression-analysis.tex:2171 | must_be_generated_from_support_notebook | migration_required | coolDD : summer     &   125,064 & 0 $\cdot$ 0       &          0 \\ |
| calc.reg.0925 | regression-analysis.tex:2183 | static_theoretical_or_illustrative | intentional_manual | The expectation of \ttblue{revenue} for January 2014 is 22,505,659, while the actual revenue from the hold-out set is 19,228,840. The difference is -3,276,819. |
| calc.reg.0926 | regression-analysis.tex:2192 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y}_* \pm t_{\alpha / 2} \cdot s_e \sqrt{\frac{1}{n} + \frac{(x_* - \bar{x})^2}{(n - 1) s_x^2}} |
| calc.reg.0927 | regression-analysis.tex:2198 | must_be_checked_against_support_notebook | checked_in_support_output | For example, when using a model with one single independent variable like \ttblue{mod.0} to create an expectation of $y$ = \ttblue{revenue} from $x$ = \ttblue{production}, in the rare case that we are interested in ob... |
| calc.reg.0928 | regression-analysis.tex:2202 | static_theoretical_or_illustrative | intentional_manual | a 99\% confidence interval around this estimate is then |
| calc.reg.0929 | regression-analysis.tex:2204 | must_be_checked_against_support_notebook | checked_in_support_output | \RegModZeroYHat \pm \RegModZeroT99 \cdot \RegModZeroResidualSd \sqrt{\frac{1}{\RegModZeroSampleSize} + \frac{(\RegModZeroXStar - \RegModZeroXMean)^2}{\RegModZeroDf \cdot \RegModZeroSxx}} = |
| calc.reg.0930 | regression-analysis.tex:2207 | must_be_checked_against_support_notebook | checked_in_support_output | \RegModZeroYHat \pm \RegModZeroPrecision99 |
| calc.reg.0931 | regression-analysis.tex:2213 | must_be_checked_against_support_notebook | checked_in_support_output | y_* \pm t_{\alpha / 2} \cdot s_e \sqrt{1 + \frac{1}{n} + \frac{(x_* - \bar{x})^2}{(n - 1) s_x^2}} |
| calc.reg.0932 | regression-analysis.tex:2221 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{(x_*-\bar{x})^2}{(n-1)s_x^2}, |
| calc.reg.0933 | regression-analysis.tex:2235 | static_theoretical_or_illustrative | intentional_manual | Table \ref{tab:expectations_holdout} and Figure \ref{fig:H7_expectations} summarize the recorded values, expectation and prediction interval bounds based on \ttblue{mod.5} for the hold-out period. |
| calc.reg.0934 | regression-analysis.tex:2249 | must_be_generated_from_support_notebook | migration_required | January 2014   &        19,228,840  & 18,270,762 & 22,505,659 & 26,740,557 & -3,276,819 \\ |
| calc.reg.0935 | regression-analysis.tex:2250 | must_be_generated_from_support_notebook | migration_required | February 2014  &        26,792,280  & 21,884,851 & 26,370,098 & 30,855,345 &    422,182 \\ |
| calc.reg.0936 | regression-analysis.tex:2251 | must_be_generated_from_support_notebook | migration_required | March 2014     & \hlred{19,935,840} & 24,872,800 & 29,651,399 & 34,429,998 & -9,715,559 \\ |
| calc.reg.0937 | regression-analysis.tex:2252 | must_be_generated_from_support_notebook | migration_required | April 2014     &        13,468,000  & 10,117,297 & 14,235,543 & 18,353,788 &   -767,543 \\ |
| calc.reg.0938 | regression-analysis.tex:2253 | must_be_generated_from_support_notebook | migration_required | May 2014       &         7,344,128  &  3,275,961 &  7,683,165 & 12,090,370 &   -339,037 \\ |
| calc.reg.0939 | regression-analysis.tex:2254 | must_be_generated_from_support_notebook | migration_required | June 2014      &        11,196,216  &  7,225,223 & 11,362,096 & 15,498,968 &   -165,880 \\ |
| calc.reg.0940 | regression-analysis.tex:2255 | must_be_generated_from_support_notebook | migration_required | July 2014      &        13,929,472  & 10,572,555 & 14,845,538 & 19,118,521 &   -916,066 \\ |
| calc.reg.0941 | regression-analysis.tex:2256 | must_be_generated_from_support_notebook | migration_required | August 2014    &        12,352,176  &  9,357,740 & 13,544,329 & 17,730,918 & -1,192,153 \\ |
| calc.reg.0942 | regression-analysis.tex:2257 | must_be_generated_from_support_notebook | migration_required | September 2014 &        12,628,944  &  8,613,794 & 13,497,081 & 18,380,369 &   -868,137 \\ |
| calc.reg.0943 | regression-analysis.tex:2258 | must_be_generated_from_support_notebook | migration_required | October 2014   &         9,361,000  &  8,358,271 & 12,609,214 & 16,860,157 & -3,248,214 \\ |
| calc.reg.0944 | regression-analysis.tex:2259 | must_be_generated_from_support_notebook | migration_required | November 2014  &        10,164,048  &  7,059,618 & 11,282,544 & 15,505,471 & -1,118,496 \\ |
| calc.reg.0945 | regression-analysis.tex:2260 | must_be_generated_from_support_notebook | migration_required | December 2014  &        18,377,456  & 16,921,330 & 21,094,017 & 25,266,704 & -2,716,561 \\ |
| calc.reg.0946 | regression-analysis.tex:2264 | must_be_generated_from_support_notebook | migration_required | Total          &174,778,400 &             & 198,680,683 & & -23,902,283 \\ |
| calc.reg.0947 | regression-analysis.tex:2278 | must_be_checked_against_support_notebook | checked_in_support_output | The prediction intervals are statistical tools for measuring the uncertainty around the monthly expectations; they are not, by themselves, the audit objective. The difference for January 2014 is consistent with the un... |
| calc.reg.0948 | regression-analysis.tex:2290 | static_theoretical_or_illustrative | intentional_manual | \hat{y}_{\text{Mar}} - 8,\!000,\!000. |
| calc.reg.0949 | regression-analysis.tex:2293 | static_theoretical_or_illustrative | intentional_manual | After this adjustment, the March difference is consistent with the uncertainty measured by the 99\% prediction interval for that month. Consequently, it no longer represents an unexplained deviation requiring further ... |
| calc.reg.0950 | regression-analysis.tex:2309 | static_theoretical_or_illustrative | intentional_manual | The monthly expectations serve as benchmarks for evaluating the recorded monthly revenues. As shown in Figure~\ref{fig:H7_expectations}, most monthly recorded amounts fall within their individual 99\% prediction inter... |
| calc.reg.0951 | regression-analysis.tex:2322 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y}_{\text{total}} = \sum_{i=1}^{12} \hat{y}_i. |
| calc.reg.0952 | regression-analysis.tex:2333 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i. |
| calc.reg.0953 | regression-analysis.tex:2340 | must_be_checked_against_support_notebook | checked_in_support_output | \hat{y}_{\text{total}} = 12\hat{\beta}_0 + \hat{\beta}_1 \sum_{i=1}^{12} x_i. |
| calc.reg.0954 | regression-analysis.tex:2344 | static_theoretical_or_illustrative | intentional_manual | The prediction variance of the annual total consists of two components. The first component reflects the uncertainty in the estimated regression coefficients. This component captures the covariance between the monthly... |
| calc.reg.0955 | regression-analysis.tex:2346 | static_theoretical_or_illustrative | intentional_manual | Under the assumption that the future residuals are uncorrelated and have common variance $\hat{\sigma}^2$, the prediction variance of the annual total is |
| calc.reg.0956 | regression-analysis.tex:2356 | static_theoretical_or_illustrative | intentional_manual | 12^2\operatorname{Var}(\hat{\beta}_0) |
| calc.reg.0957 | regression-analysis.tex:2359 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i=1}^{12} x_i |
| calc.reg.0958 | regression-analysis.tex:2363 | must_be_checked_against_support_notebook | checked_in_support_output | 2 \cdot 12 |
| calc.reg.0959 | regression-analysis.tex:2365 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i=1}^{12} x_i |
| calc.reg.0960 | regression-analysis.tex:2372 | static_theoretical_or_illustrative | intentional_manual | The first three terms represent the uncertainty arising from estimation of the regression coefficients and therefore capture the covariance between the monthly expectations. The final term, \(12\hat{\sigma}^2\), repre... |
| calc.reg.0961 | regression-analysis.tex:2426 | static_theoretical_or_illustrative | intentional_manual | If there is evidence of residual autocorrelation in the hold-out errors, the residual variance component in Equation~\ref{eq:annual_prediction_variance} should be adjusted to reflect that correlation. Specifically, th... |
| calc.reg.0962 | regression-analysis.tex:2428 | static_theoretical_or_illustrative | intentional_manual | For a total consisting of 12 monthly observations, the residual variance component becomes |
| calc.reg.0963 | regression-analysis.tex:2431 | must_be_checked_against_support_notebook | checked_in_support_output | \operatorname{Var}\!\left(\sum_{i=1}^{12}\varepsilon_i\right) |
| calc.reg.0964 | regression-analysis.tex:2433 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i=1}^{12}\operatorname{Var}(\varepsilon_i) |
| calc.reg.0965 | regression-analysis.tex:2438 | static_theoretical_or_illustrative | intentional_manual | Positive autocorrelation increases the annual prediction variance because the covariance terms are positive; negative autocorrelation decreases it. In practice, these covariances may be estimated from an autoregressiv... |
| calc.reg.0966 | regression-analysis.tex:2478 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 4. Choose an appropriate test and its test statistic} |
| calc.reg.0967 | regression-analysis.tex:2487 | must_be_generated_from_support_notebook | migration_required | \hspace*{1.2cm}\=\hspace*{1.4cm}\=\hspace*{0.2cm}\= \kill |
| calc.reg.0968 | regression-analysis.tex:2496 | must_be_generated_from_support_notebook | generated_snippet_linked | \paragraph{Step 5. Derive the distribution of the test statistic under the hypotheses} |
| calc.reg.0969 | regression-analysis.tex:2497 | handled_by_epic_214_model_test_output | epic_214_scope | Under the alternative hypothesis $H_1$, which assumes that the recorded revenue is not materially misstated, the test statistic $T$ follows a central $t$~distribution with $n-k-1$ degrees of freedom. This distribution... |
| calc.reg.0970 | regression-analysis.tex:2499 | handled_by_epic_214_model_test_output | epic_214_scope | Under the null hypothesis $H_0$, where the recorded revenue is materially overstated or understated, the test statistic follows a non-central $t$~distribution. Since $T$ is a standardized statistic, the non-centrality... |
| calc.reg.0971 | regression-analysis.tex:2518 | handled_by_epic_214_model_test_output | epic_214_scope | A 99\% prediction interval has a central tail probability of 0.01. In the audit hypothesis test, this probability concerns the alternative hypothesis of no material misstatement and therefore represents Type II error ... |
| calc.reg.0972 | regression-analysis.tex:2523 | must_be_generated_from_support_notebook | generated_snippet_linked | The Acceptable Difference Range is defined by the 99\% prediction interval around the expected difference between the expected and recorded revenue: |
| calc.reg.0973 | regression-analysis.tex:2527 | must_be_generated_from_support_notebook | generated_snippet_linked | A test statistic that falls between these bounds provides sufficient evidence to reject the audit null hypothesis of material misstatement. Test statistics below the lower bound or above the upper bound do not provide... |
| calc.reg.0974 | regression-analysis.tex:2529 | handled_by_epic_214_model_test_output | epic_214_scope | \paragraph{Step 8. Compute the value of the test statistic from the sample} |
| calc.reg.0975 | regression-analysis.tex:2560 | static_theoretical_or_illustrative | intentional_manual | where $s_{\text{comb}}$ is the combined prediction standard error. If the account is not materially misstated, $T$ follows a central $t$ distribution with $n - k - 1$ degrees of freedom. |
| calc.reg.0976 | regression-analysis.tex:2598 | handled_by_epic_214_model_test_output | epic_214_scope | These probabilities express the likelihood that a material misstatement of size $PM$ would produce a difference outside the decision bounds. Their complement, $\alpha$, is the risk that a material misstatement of size... |
| calc.reg.0977 | regression-analysis.tex:2618 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-1-1} |
| calc.reg.0978 | regression-analysis.tex:2629 | must_be_checked_against_support_notebook | checked_in_support_output | \input{generated/workshop-output/exercise-5-2-1} |
| calc.reg.0979 | regression-analysis.tex:2644 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-1} |
| calc.reg.0980 | regression-analysis.tex:2645 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-2} |
| calc.reg.0981 | regression-analysis.tex:2646 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-3} |
| calc.reg.0982 | regression-analysis.tex:2647 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-4} |
| calc.reg.0983 | regression-analysis.tex:2648 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-5} |
| calc.reg.0984 | regression-analysis.tex:2649 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-6} |
| calc.reg.0985 | regression-analysis.tex:2650 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-7} |
| calc.reg.0986 | regression-analysis.tex:2651 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-3-8} |
| calc.reg.0987 | regression-analysis.tex:2662 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-4-1} |
| calc.reg.0988 | regression-analysis.tex:2671 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-5-1} |
| calc.reg.0989 | regression-analysis.tex:2681 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-6-1} |
| calc.reg.0990 | regression-analysis.tex:2682 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-6-2} |
| calc.reg.0991 | regression-analysis.tex:2691 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-7-1} |
| calc.reg.0992 | regression-analysis.tex:2692 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-7-2} |
| calc.reg.0993 | regression-analysis.tex:2693 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-7-3} |
| calc.reg.0994 | regression-analysis.tex:2694 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-7-4} |
| calc.reg.0995 | regression-analysis.tex:2703 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-8-1} |
| calc.reg.0996 | regression-analysis.tex:2712 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-9-1} |
| calc.reg.0997 | regression-analysis.tex:2713 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-9-2} |
| calc.reg.0998 | regression-analysis.tex:2714 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-9-3} |
| calc.reg.0999 | regression-analysis.tex:2723 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-10-1} |
| calc.reg.1000 | regression-analysis.tex:2734 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-11-1} |
| calc.reg.1001 | regression-analysis.tex:2743 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-12-1} |
| calc.reg.1002 | regression-analysis.tex:2752 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-13-1} |
| calc.reg.1003 | regression-analysis.tex:2753 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-13-2} |
| calc.reg.1004 | regression-analysis.tex:2754 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-13-3} |
| calc.reg.1005 | regression-analysis.tex:2763 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-14-1} |
| calc.reg.1006 | regression-analysis.tex:2772 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-15-1} |
| calc.reg.1007 | regression-analysis.tex:2773 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-15-2} |
| calc.reg.1008 | regression-analysis.tex:2782 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-16-1} |
| calc.reg.1009 | regression-analysis.tex:2791 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-17-1} |
| calc.reg.1010 | regression-analysis.tex:2792 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-17-2} |
| calc.reg.1011 | regression-analysis.tex:2801 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-18-1} |
| calc.reg.1012 | regression-analysis.tex:2802 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-18-2} |
| calc.reg.1013 | regression-analysis.tex:2813 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-19-1} |
| calc.reg.1014 | regression-analysis.tex:2814 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-19-2} |
| calc.reg.1015 | regression-analysis.tex:2815 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-19-3} |
| calc.reg.1016 | regression-analysis.tex:2816 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-19-4} |
| calc.reg.1017 | regression-analysis.tex:2817 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-19-5} |
| calc.reg.1018 | regression-analysis.tex:2826 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-20-1} |
| calc.reg.1019 | regression-analysis.tex:2827 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-20-2} |
| calc.reg.1020 | regression-analysis.tex:2828 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-20-3} |
| calc.reg.1021 | regression-analysis.tex:2837 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-21-1} |
| calc.reg.1022 | regression-analysis.tex:2846 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-22-1} |
| calc.reg.1023 | regression-analysis.tex:2847 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-22-2} |
| calc.reg.1024 | regression-analysis.tex:2858 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-23-1} |
| calc.reg.1025 | regression-analysis.tex:2859 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-23-2} |
| calc.reg.1026 | regression-analysis.tex:2860 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-23-3} |
| calc.reg.1027 | regression-analysis.tex:2869 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-24-1} |
| calc.reg.1028 | regression-analysis.tex:2870 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-24-2} |
| calc.reg.1029 | regression-analysis.tex:2879 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-25-1} |
| calc.reg.1030 | regression-analysis.tex:2880 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-25-2} |
| calc.reg.1031 | regression-analysis.tex:2889 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-26-1} |
| calc.reg.1032 | regression-analysis.tex:2890 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-26-2} |
| calc.reg.1033 | regression-analysis.tex:2891 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-26-3} |
| calc.reg.1034 | regression-analysis.tex:2892 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-26-4} |
| calc.reg.1035 | regression-analysis.tex:2901 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-27-1} |
| calc.reg.1036 | regression-analysis.tex:2910 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-28-1} |
| calc.reg.1037 | regression-analysis.tex:2919 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-29-1} |
| calc.reg.1038 | regression-analysis.tex:2930 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-30-1} |
| calc.reg.1039 | regression-analysis.tex:2939 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-31-1} |
| calc.reg.1040 | regression-analysis.tex:2940 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-31-2} |
| calc.reg.1041 | regression-analysis.tex:2941 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-31-3} |
| calc.reg.1042 | regression-analysis.tex:2942 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-31-4} |
| calc.reg.1043 | regression-analysis.tex:2953 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-32-1} |
| calc.reg.1044 | regression-analysis.tex:2962 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-33-1} |
| calc.reg.1045 | regression-analysis.tex:2963 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-33-2} |
| calc.reg.1046 | regression-analysis.tex:2972 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-34-1} |
| calc.reg.1047 | regression-analysis.tex:2983 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-35-1} |
| calc.reg.1048 | regression-analysis.tex:2984 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-35-2} |
| calc.reg.1049 | regression-analysis.tex:2985 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-35-3} |
| calc.reg.1050 | regression-analysis.tex:2995 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-1} |
| calc.reg.1051 | regression-analysis.tex:2996 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-2} |
| calc.reg.1052 | regression-analysis.tex:2997 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-3} |
| calc.reg.1053 | regression-analysis.tex:2998 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-4} |
| calc.reg.1054 | regression-analysis.tex:2999 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-5} |
| calc.reg.1055 | regression-analysis.tex:3000 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-5-36-6} |
| calc.reg.1056 | regression-analysis.tex:3015 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-1-1} |
| calc.reg.1057 | regression-analysis.tex:3024 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-2-1} |
| calc.reg.1058 | regression-analysis.tex:3033 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-1} |
| calc.reg.1059 | regression-analysis.tex:3034 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-2} |
| calc.reg.1060 | regression-analysis.tex:3035 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-3} |
| calc.reg.1061 | regression-analysis.tex:3036 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-4} |
| calc.reg.1062 | regression-analysis.tex:3037 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-5} |
| calc.reg.1063 | regression-analysis.tex:3038 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-6} |
| calc.reg.1064 | regression-analysis.tex:3039 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-7} |
| calc.reg.1065 | regression-analysis.tex:3040 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-3-8} |
| calc.reg.1066 | regression-analysis.tex:3049 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-4-1} |
| calc.reg.1067 | regression-analysis.tex:3058 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-5-1} |
| calc.reg.1068 | regression-analysis.tex:3067 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-6-1} |
| calc.reg.1069 | regression-analysis.tex:3068 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-6-2} |
| calc.reg.1070 | regression-analysis.tex:3077 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-7-1} |
| calc.reg.1071 | regression-analysis.tex:3078 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-7-2} |
| calc.reg.1072 | regression-analysis.tex:3079 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-7-3} |
| calc.reg.1073 | regression-analysis.tex:3080 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-7-4} |
| calc.reg.1074 | regression-analysis.tex:3089 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-8-1} |
| calc.reg.1075 | regression-analysis.tex:3098 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-9-1} |
| calc.reg.1076 | regression-analysis.tex:3099 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-9-2} |
| calc.reg.1077 | regression-analysis.tex:3100 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-9-3} |
| calc.reg.1078 | regression-analysis.tex:3109 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-10-1} |
| calc.reg.1079 | regression-analysis.tex:3118 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-11-1} |
| calc.reg.1080 | regression-analysis.tex:3127 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-12-1} |
| calc.reg.1081 | regression-analysis.tex:3136 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-13-1} |
| calc.reg.1082 | regression-analysis.tex:3137 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-13-2} |
| calc.reg.1083 | regression-analysis.tex:3138 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-13-3} |
| calc.reg.1084 | regression-analysis.tex:3147 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-14-1} |
| calc.reg.1085 | regression-analysis.tex:3156 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-15-1} |
| calc.reg.1086 | regression-analysis.tex:3157 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-15-2} |
| calc.reg.1087 | regression-analysis.tex:3166 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-16-1} |
| calc.reg.1088 | regression-analysis.tex:3175 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-17-1} |
| calc.reg.1089 | regression-analysis.tex:3176 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-17-2} |
| calc.reg.1090 | regression-analysis.tex:3185 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-18-1} |
| calc.reg.1091 | regression-analysis.tex:3186 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-18-2} |
| calc.reg.1092 | regression-analysis.tex:3195 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-19-1} |
| calc.reg.1093 | regression-analysis.tex:3196 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-19-2} |
| calc.reg.1094 | regression-analysis.tex:3197 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-19-3} |
| calc.reg.1095 | regression-analysis.tex:3198 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-19-4} |
| calc.reg.1096 | regression-analysis.tex:3199 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-19-5} |
| calc.reg.1097 | regression-analysis.tex:3208 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-20-1} |
| calc.reg.1098 | regression-analysis.tex:3209 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-20-2} |
| calc.reg.1099 | regression-analysis.tex:3210 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-20-3} |
| calc.reg.1100 | regression-analysis.tex:3219 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-21-1} |
| calc.reg.1101 | regression-analysis.tex:3228 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-22-1} |
| calc.reg.1102 | regression-analysis.tex:3229 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-22-2} |
| calc.reg.1103 | regression-analysis.tex:3238 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-23-1} |
| calc.reg.1104 | regression-analysis.tex:3239 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-23-2} |
| calc.reg.1105 | regression-analysis.tex:3240 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-23-3} |
| calc.reg.1106 | regression-analysis.tex:3249 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-24-1} |
| calc.reg.1107 | regression-analysis.tex:3250 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-24-2} |
| calc.reg.1108 | regression-analysis.tex:3259 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-25-1} |
| calc.reg.1109 | regression-analysis.tex:3260 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-25-2} |
| calc.reg.1110 | regression-analysis.tex:3269 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-26-1} |
| calc.reg.1111 | regression-analysis.tex:3270 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-26-2} |
| calc.reg.1112 | regression-analysis.tex:3271 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-26-3} |
| calc.reg.1113 | regression-analysis.tex:3272 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-26-4} |
| calc.reg.1114 | regression-analysis.tex:3281 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-27-1} |
| calc.reg.1115 | regression-analysis.tex:3290 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-28-1} |
| calc.reg.1116 | regression-analysis.tex:3299 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-29-1} |
| calc.reg.1117 | regression-analysis.tex:3308 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-30-1} |
| calc.reg.1118 | regression-analysis.tex:3317 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-31-1} |
| calc.reg.1119 | regression-analysis.tex:3318 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-31-2} |
| calc.reg.1120 | regression-analysis.tex:3319 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-31-3} |
| calc.reg.1121 | regression-analysis.tex:3320 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-31-4} |
| calc.reg.1122 | regression-analysis.tex:3329 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-32-1} |
| calc.reg.1123 | regression-analysis.tex:3338 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-33-1} |
| calc.reg.1124 | regression-analysis.tex:3339 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-33-2} |
| calc.reg.1125 | regression-analysis.tex:3348 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-34-1} |
| calc.reg.1126 | regression-analysis.tex:3357 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-35-1} |
| calc.reg.1127 | regression-analysis.tex:3358 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-35-2} |
| calc.reg.1128 | regression-analysis.tex:3359 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-35-3} |
| calc.reg.1129 | regression-analysis.tex:3368 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-1} |
| calc.reg.1130 | regression-analysis.tex:3369 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-2} |
| calc.reg.1131 | regression-analysis.tex:3370 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-3} |
| calc.reg.1132 | regression-analysis.tex:3371 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-4} |
| calc.reg.1133 | regression-analysis.tex:3372 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-5} |
| calc.reg.1134 | regression-analysis.tex:3373 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-5-36-6} |

## Goodness of Fit

- Support notebook: notebooks/support/goodness-of-fit/support.html
- Classified calculation candidates: 175

| ID | Location | Classification | Check status | Context |
| --- | --- | --- | --- | --- |
| calc.gof.1135 | goodness-of-fit.tex:71 | static_theoretical_or_illustrative | intentional_manual | Imagine opening a book of logarithm tables in the nineteenth century. The first pages are noticeably more worn than the later pages. This curious observation led astronomer and mathematician Simon Newcomb (1835-1909) ... |
| calc.gof.1136 | goodness-of-fit.tex:73 | static_theoretical_or_illustrative | intentional_manual | Newcomb's observation attracted little attention until physicist Frank Benford (1883-1948) independently rediscovered the phenomenon almost fifty years later. Benford collected more than 20,000 observations from diver... |
| calc.gof.1137 | goodness-of-fit.tex:92 | static_theoretical_or_illustrative | intentional_manual | --- Karl Pearson (1857--1936), \textit{The Grammar of Science} (1900) |
| calc.gof.1138 | goodness-of-fit.tex:104 | must_be_checked_against_support_notebook | checked_in_support_output | <= 30 & |
| calc.gof.1139 | goodness-of-fit.tex:112 | must_be_generated_from_support_notebook | migration_required | Number & 9 & 41 & 15 & 4 & 69 \\ |
| calc.gof.1140 | goodness-of-fit.tex:138 | must_be_generated_from_support_notebook | migration_required | Number & $n_1$ & $n_2$ & $n_3$ & \ldots & $n_i$ & \ldots & $n_k$ & $n$ \\ |
| calc.gof.1141 | goodness-of-fit.tex:139 | must_be_generated_from_support_notebook | migration_required | Probability & $\pi_1$ & $\pi_2$ & $\pi_3$ & \ldots & $\pi_i$ & \ldots & $\pi_k$ & 1 \\ |
| calc.gof.1142 | goodness-of-fit.tex:164 | must_be_generated_from_support_notebook | migration_required | Count & 250 & 100 & 275 & 625 \\ |
| calc.gof.1143 | goodness-of-fit.tex:165 | must_be_generated_from_support_notebook | migration_required | Proportion & 0.40 & 0.16 & 0.44 & 1.00 \\ |
| calc.gof.1144 | goodness-of-fit.tex:174 | handled_by_epic_214_model_test_output | epic_214_scope | For a goodness-of-fit test, the hypotheses examine whether the distribution of satisfaction in the follow-up year is the same as the distribution observed in the base year. Because all 625 customers were surveyed in t... |
| calc.gof.1145 | goodness-of-fit.tex:178 | must_be_checked_against_support_notebook | checked_in_support_output | H_0 : \pi_1 = 0.40, \pi_2 = 0.16, \pi_3 = 0.44 |
| calc.gof.1146 | goodness-of-fit.tex:187 | static_theoretical_or_illustrative | intentional_manual | The follow-up study found that, from a sample of 40 customers, 15 were (very) dissatisfied, 12 were neutral, and 13 were (very) satisfied. The observed frequencies are summarized in Table \ref{tab:client_satisfaction_... |
| calc.gof.1147 | goodness-of-fit.tex:199 | must_be_generated_from_support_notebook | migration_required | Observed frequency & 15 & 12 & 13 & 40 \\ |
| calc.gof.1148 | goodness-of-fit.tex:209 | must_be_checked_against_support_notebook | checked_in_support_output | \pi_1 = 0.40,\qquad \pi_2 = 0.16,\qquad \pi_3 = 0.44 |
| calc.gof.1149 | goodness-of-fit.tex:212 | must_be_checked_against_support_notebook | checked_in_support_output | The expected frequencies are therefore obtained by multiplying these proportions by the sample size $n=40$: |
| calc.gof.1150 | goodness-of-fit.tex:215 | must_be_checked_against_support_notebook | checked_in_support_output | E_1 = 40(0.40) = 16.0,\qquad |
| calc.gof.1151 | goodness-of-fit.tex:216 | must_be_checked_against_support_notebook | checked_in_support_output | E_2 = 40(0.16) = 6.4,\qquad |
| calc.gof.1152 | goodness-of-fit.tex:217 | must_be_checked_against_support_notebook | checked_in_support_output | E_3 = 40(0.44) = 17.6. |
| calc.gof.1153 | goodness-of-fit.tex:231 | must_be_generated_from_support_notebook | migration_required | Observed ($O_i$) & 15 & 12 & 13 \\ |
| calc.gof.1154 | goodness-of-fit.tex:232 | must_be_generated_from_support_notebook | migration_required | Expected ($E_i$) & 16.0 & 6.4 & 17.6 \\ |
| calc.gof.1155 | goodness-of-fit.tex:250 | must_be_generated_from_support_notebook | migration_required | \chi^2 &= \sum_{i=1}^{k} \frac{(O_i-E_i)^2}{E_i} \label{eq:chi_square_test_statistic} \\ |
| calc.gof.1156 | goodness-of-fit.tex:251 | must_be_generated_from_support_notebook | migration_required | &= \frac{(15-16)^2}{16} + \frac{(12-6.4)^2}{6.4} + \frac{(13-17.6)^2}{17.6} \nonumber \\ |
| calc.gof.1157 | goodness-of-fit.tex:252 | must_be_checked_against_support_notebook | checked_in_support_output | &= 0.063 + 4.900 + 1.202 \nonumber \\ |
| calc.gof.1158 | goodness-of-fit.tex:253 | must_be_checked_against_support_notebook | checked_in_support_output | &= 6.165. \nonumber |
| calc.gof.1159 | goodness-of-fit.tex:255 | must_be_checked_against_support_notebook | checked_in_support_output | Since there are $k=3$ categories and no parameters are estimated from the sample, the number of degrees of freedom is |
| calc.gof.1160 | goodness-of-fit.tex:258 | must_be_checked_against_support_notebook | checked_in_support_output | df = k-1 = 3-1 = 2. |
| calc.gof.1161 | goodness-of-fit.tex:260 | must_be_checked_against_support_notebook | checked_in_support_output | For a significance level of $\alpha=0.05$, the critical value is $\chi^2_{0.05,2} = 5.991$. Because |
| calc.gof.1162 | goodness-of-fit.tex:263 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = 6.165 > \chi^2_{0.05,2} = 5.991, |
| calc.gof.1163 | goodness-of-fit.tex:271 | must_be_checked_against_support_notebook | checked_in_support_output | p = P(\chi^2_2 \geq 6.165) \approx 0.046. |
| calc.gof.1164 | goodness-of-fit.tex:275 | handled_by_epic_214_model_test_output | epic_214_scope | \noindent Since $p < 0.05$, the null hypothesis is rejected. |
| calc.gof.1165 | goodness-of-fit.tex:288 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i=1}^{k}\pi_i = 1. |
| calc.gof.1166 | goodness-of-fit.tex:299 | static_theoretical_or_illustrative | intentional_manual | (O_1,O_2, \ldots, O_k) \sim \text{Multinomial}(n; \pi_1, \pi_2, \ldots, \pi_k). |
| calc.gof.1167 | goodness-of-fit.tex:318 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i = 1}^{k} \left(\frac{O_i - E_i}{\sqrt{E_i}}\right)^2 |
| calc.gof.1168 | goodness-of-fit.tex:323 | must_be_checked_against_support_notebook | checked_in_support_output | df = k - p - 1 |
| calc.gof.1169 | goodness-of-fit.tex:367 | must_be_generated_from_support_notebook | migration_required | \parbox[t]{1.5 cm}{Digit} & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\ |
| calc.gof.1170 | goodness-of-fit.tex:370 | must_be_generated_from_support_notebook | migration_required | Frequency & 86 & 48 & 23 & 32 & 24 & 36 & 19 & 18 & 14 \\ |
| calc.gof.1171 | goodness-of-fit.tex:381 | must_be_checked_against_support_notebook | checked_in_support_output | P(i) = \log_{10} \left( \frac{i + 1}{i} \right) |
| calc.gof.1172 | goodness-of-fit.tex:383 | must_be_checked_against_support_notebook | checked_in_support_output | \log_{10}\left(1+\frac{1}{i}\right), |
| calc.gof.1173 | goodness-of-fit.tex:387 | must_be_checked_against_support_notebook | checked_in_support_output | where (i = 1,2,\ldots,9). Thus, (P(i)) denotes the probability that the first digit of a number is equal to (i). |
| calc.gof.1174 | goodness-of-fit.tex:402 | must_be_generated_from_support_notebook | migration_required | \parbox[t]{0.95 cm}{Series} & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & $n$\\ |
| calc.gof.1175 | goodness-of-fit.tex:404 | must_be_generated_from_support_notebook | migration_required | Rivers & 31.0 & 16.4 & 10.7 & 11.3 & 7.2 & 8.6 & 5.5 & 4.2 & 5.1 & 335 \\ |
| calc.gof.1176 | goodness-of-fit.tex:405 | must_be_generated_from_support_notebook | migration_required | Am. Leag. & 32.7 & 17.6 & 12.6 & 9.8 & 7.4 & 6.4 & 4.9 & 5.6 & 3.0 & 1458 \\ |
| calc.gof.1177 | goodness-of-fit.tex:406 | must_be_generated_from_support_notebook | migration_required | Cost Data & 32.4 & 18.8 & 10.1 & 10.1 & 9.8 & 5.5 & 4.7 & 5.5 & 3.1 & 741 \\ |
| calc.gof.1178 | goodness-of-fit.tex:407 | must_be_generated_from_support_notebook | migration_required | Reader's D & 33.4 & 18.5 & 12.4 & 7.5 & 7.1 & 6.5 & 5.5 & 4.9 & 4.2 & 308 \\ |
| calc.gof.1179 | goodness-of-fit.tex:408 | must_be_generated_from_support_notebook | migration_required | Mol. Wgt. & 26.7 & 25.2 & 15.4 & 10.8 & 6.7 & 5.1 & 4.1 & 2.8 & 3.2 & 1800 \\ |
| calc.gof.1180 | goodness-of-fit.tex:410 | must_be_generated_from_support_notebook | migration_required | Average & 31.2 & 19.3 & 12.2 & 9.9 & 7.6 & 6.4 & 4.9 & 4.6 & 3.7 & 4643 \\ |
| calc.gof.1181 | goodness-of-fit.tex:452 | static_theoretical_or_illustrative | intentional_manual | 6,000 and 9,500, only numbers beginning with the digits 6, 7, 8, or 9 |
| calc.gof.1182 | goodness-of-fit.tex:492 | must_be_checked_against_support_notebook | checked_in_support_output | $n=300$ observations. We use the nine-step approach from Section \ref{sec:the_nine_step_approach} to investigate the data. |
| calc.gof.1183 | goodness-of-fit.tex:505 | must_be_generated_from_support_notebook | migration_required | (\pi_1,\pi_2,\ldots,\pi_9) = (&0.3010, 0.1761, 0.1249, 0.0969, 0.0792, 0.0669, 0.0580, \\ |
| calc.gof.1184 | goodness-of-fit.tex:512 | must_be_generated_from_support_notebook | migration_required | H_0 : (\pi_1,\pi_2,\ldots,\pi_9) = (&0.3010, 0.1761, 0.1249, 0.0969, 0.0792, \\ |
| calc.gof.1185 | goodness-of-fit.tex:513 | must_be_generated_from_support_notebook | migration_required | &0.0669, 0.0580, 0.0512, 0.0458), |
| calc.gof.1186 | goodness-of-fit.tex:519 | must_be_generated_from_support_notebook | migration_required | H_0 : (\pi_1,\pi_2,\ldots,\pi_9) \neq (&0.3010, 0.1761, 0.1249, 0.0969, 0.0792, \\ |
| calc.gof.1187 | goodness-of-fit.tex:520 | must_be_generated_from_support_notebook | migration_required | &0.0669, 0.0580, 0.0512, 0.0458), |
| calc.gof.1188 | goodness-of-fit.tex:543 | must_be_generated_from_support_notebook | migration_required | \parbox[t]{1 cm}{} & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\ |
| calc.gof.1189 | goodness-of-fit.tex:545 | must_be_generated_from_support_notebook | migration_required | $O_i$ & 86 & 48 & 23 & 32 & 24 & 36 & 19 & 18 & 14 \\ |
| calc.gof.1190 | goodness-of-fit.tex:546 | must_be_generated_from_support_notebook | migration_required | $E_i = n.P(i)$ & 90.3 & 52.8 & 37.5 & 29.1 & 23.8 & 20.1 & 17.4 & 15.3 & 13.7  \\ |
| calc.gof.1191 | goodness-of-fit.tex:567 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = \sum_{i=1}^{9} |
| calc.gof.1192 | goodness-of-fit.tex:568 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{(O_i-E_i)^2}{E_i}, |
| calc.gof.1193 | goodness-of-fit.tex:575 | handled_by_epic_214_model_test_output | epic_214_scope | The test statistic $\chi^2$ follows a chi-squared distribution with $df = 8$ degrees of freedom. |
| calc.gof.1194 | goodness-of-fit.tex:587 | handled_by_epic_214_model_test_output | epic_214_scope | Under the null hypothesis, the test statistic follows approximately a chi-square distribution with $df = k-1 = 9-1 = 8$ degrees of freedom, where $k$ is the number of possible first digits. For a significance level of... |
| calc.gof.1195 | goodness-of-fit.tex:590 | handled_by_epic_214_model_test_output | epic_214_scope | distribution with 8 degrees of freedom. Values of the test statistic that |
| calc.gof.1196 | goodness-of-fit.tex:613 | must_be_checked_against_support_notebook | checked_in_support_output | \(\frac{(O_i-E_i)^2}{E_i}\) \\ |
| calc.gof.1197 | goodness-of-fit.tex:615 | must_be_generated_from_support_notebook | migration_required | 1 & 86 & 90.31 & 18.57 & 0.21 \\ |
| calc.gof.1198 | goodness-of-fit.tex:616 | must_be_generated_from_support_notebook | migration_required | 2 & 48 & 52.83 & 23.30 & 0.44 \\ |
| calc.gof.1199 | goodness-of-fit.tex:617 | must_be_generated_from_support_notebook | migration_required | 3 & 23 & 37.48 & 209.72 & 5.60 \\ |
| calc.gof.1200 | goodness-of-fit.tex:618 | must_be_generated_from_support_notebook | migration_required | 4 & 32 & 29.07 & 8.57 & 0.29 \\ |
| calc.gof.1201 | goodness-of-fit.tex:619 | must_be_generated_from_support_notebook | migration_required | 5 & 24 & 23.75 & 0.06 & 0.00 \\ |
| calc.gof.1202 | goodness-of-fit.tex:620 | must_be_generated_from_support_notebook | migration_required | 6 & 36 & 20.08 & 253.32 & 12.61 \\ |
| calc.gof.1203 | goodness-of-fit.tex:621 | must_be_generated_from_support_notebook | migration_required | 7 & 19 & 17.40 & 2.57 & 0.15 \\ |
| calc.gof.1204 | goodness-of-fit.tex:622 | must_be_generated_from_support_notebook | migration_required | 8 & 18 & 15.35 & 7.05 & 0.46 \\ |
| calc.gof.1205 | goodness-of-fit.tex:623 | must_be_generated_from_support_notebook | migration_required | 9 & 14 & 13.73 & 0.07 & 0.01 \\ |
| calc.gof.1206 | goodness-of-fit.tex:625 | must_be_generated_from_support_notebook | migration_required | \textbf{Total} & 300 & 300.00 & & \(\chi^2 = 19.77\) \\ |
| calc.gof.1207 | goodness-of-fit.tex:632 | handled_by_epic_214_model_test_output | epic_214_scope | \noindent The final test statistic is $\chi^2 = 19.77$. |
| calc.gof.1208 | goodness-of-fit.tex:636 | handled_by_epic_214_model_test_output | epic_214_scope | Because $\chi^2 = 19.77 > 15.51$, the test statistic falls within the rejection region. Therefore, the null hypothesis is rejected at the 5\% significance level. |
| calc.gof.1209 | goodness-of-fit.tex:648 | handled_by_epic_214_model_test_output | epic_214_scope | An advantage of the chi-square statistic is that its individual components can be examined separately. Each quantity $(O_i-E_i)^2/E_i$ represents the contribution of digit \(i\) to the overall test statistic. |
| calc.gof.1210 | goodness-of-fit.tex:653 | handled_by_epic_214_model_test_output | epic_214_scope | Together they account for more than \(90\%\) of the total test statistic. |
| calc.gof.1211 | goodness-of-fit.tex:667 | must_be_checked_against_support_notebook | checked_in_support_output | D = 10,11,12,\ldots,99. |
| calc.gof.1212 | goodness-of-fit.tex:677 | must_be_checked_against_support_notebook | checked_in_support_output | 1+\frac{1}{d} |
| calc.gof.1213 | goodness-of-fit.tex:679 | must_be_checked_against_support_notebook | checked_in_support_output | \qquad d=10,11,\ldots,99. |
| calc.gof.1214 | goodness-of-fit.tex:709 | must_be_checked_against_support_notebook | checked_in_support_output | O_i = {39,69,60,72,70,58,65,55,59,53}, |
| calc.gof.1215 | goodness-of-fit.tex:711 | handled_by_epic_214_model_test_output | epic_214_scope | for digits (0,1,2,\ldots,9), respectively. These frequencies are tested against the null hypothesis that the digits follow a discrete uniform distribution. |
| calc.gof.1216 | goodness-of-fit.tex:715 | must_be_checked_against_support_notebook | checked_in_support_output | Let $\pi_i$ denote the probability that a digit is equal to $i$, where $i=0,1,\ldots,9$. Under the discrete uniform distribution, |
| calc.gof.1217 | goodness-of-fit.tex:718 | must_be_checked_against_support_notebook | checked_in_support_output | \pi_0=\pi_1=\cdots=\pi_9=0.10. |
| calc.gof.1218 | goodness-of-fit.tex:738 | must_be_generated_from_support_notebook | migration_required | \parbox[t]{1.3 cm}{Digit} & 0 & 1 & 2 & 3 & \ldots & 9 & Tot.\\ |
| calc.gof.1219 | goodness-of-fit.tex:740 | must_be_generated_from_support_notebook | migration_required | $O_i$ & 39 & 69 & 60 & 72 & \ldots & 53 & 600\\ |
| calc.gof.1220 | goodness-of-fit.tex:741 | must_be_generated_from_support_notebook | migration_required | $E_i$ & 60 & 60 & 60 & 60 & \ldots & 60 & 600\\ |
| calc.gof.1221 | goodness-of-fit.tex:742 | must_be_generated_from_support_notebook | migration_required | $(O_i - E_i)^2$ & 441 & 81 & 0 & 144 & \ldots & 49 & \\ |
| calc.gof.1222 | goodness-of-fit.tex:743 | must_be_generated_from_support_notebook | migration_required | $(O_i - E_i)^2 / E_i$ & 7.35 & 1.35 & 0.00 & 2.40 & \ldots & 0.82 & 14.50\\ |
| calc.gof.1223 | goodness-of-fit.tex:751 | must_be_checked_against_support_notebook | checked_in_support_output | The minimum sample size required for the chi-square goodness-of-fit test follows from the condition that each expected frequency must satisfy $E_i \geq 5$. Under a discrete uniform distribution, \(\pi_i = 0.1\) for ea... |
| calc.gof.1224 | goodness-of-fit.tex:754 | must_be_checked_against_support_notebook | checked_in_support_output | n \geq \frac{5}{0.1}=50. |
| calc.gof.1225 | goodness-of-fit.tex:762 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = 14.50. |
| calc.gof.1226 | goodness-of-fit.tex:767 | must_be_checked_against_support_notebook | checked_in_support_output | df = 10-1 = 9. |
| calc.gof.1227 | goodness-of-fit.tex:769 | static_theoretical_or_illustrative | intentional_manual | At the 5\% significance level, the critical value is |
| calc.gof.1228 | goodness-of-fit.tex:772 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2_{0.05,9}=16.92. |
| calc.gof.1229 | goodness-of-fit.tex:777 | handled_by_epic_214_model_test_output | epic_214_scope | p = 0.106. |
| calc.gof.1230 | goodness-of-fit.tex:785 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = 14.50 < 16.92, |
| calc.gof.1231 | goodness-of-fit.tex:787 | handled_by_epic_214_model_test_output | epic_214_scope | the test statistic does not fall within the critical region. Consequently, the null hypothesis is not rejected at the 5\% significance level. |
| calc.gof.1232 | goodness-of-fit.tex:821 | must_be_checked_against_support_notebook | checked_in_support_output | \sqrt{36}=6. |
| calc.gof.1233 | goodness-of-fit.tex:826 | must_be_checked_against_support_notebook | checked_in_support_output | 1.613923 - (-2.51122) = 4.125143. |
| calc.gof.1234 | goodness-of-fit.tex:831 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{4.125143}{6} \approx 0.6891742. |
| calc.gof.1235 | goodness-of-fit.tex:842 | must_be_generated_from_support_notebook | migration_required | $(-2.55 \leq X < -1.85)$ & 2 \\ |
| calc.gof.1236 | goodness-of-fit.tex:843 | must_be_generated_from_support_notebook | migration_required | $(-1.85 \leq X < -1.15)$ & 1 \\ |
| calc.gof.1237 | goodness-of-fit.tex:844 | must_be_generated_from_support_notebook | migration_required | $(-1.15 \leq X < -0.45)$ & 10 \\ |
| calc.gof.1238 | goodness-of-fit.tex:845 | must_be_generated_from_support_notebook | migration_required | $(-0.45 \leq X < 0.25)$ & 10 \\ |
| calc.gof.1239 | goodness-of-fit.tex:846 | must_be_generated_from_support_notebook | migration_required | $(0.25 \leq X < 0.95)$ & 5 \\ |
| calc.gof.1240 | goodness-of-fit.tex:847 | must_be_generated_from_support_notebook | migration_required | $(0.95 \leq X < 1.65)$ & 8 \\ |
| calc.gof.1241 | goodness-of-fit.tex:901 | must_be_checked_against_support_notebook | checked_in_support_output | where $n=36$ and $\pi_i$ is the probability of falling in class $i$ under the standard normal distribution. |
| calc.gof.1242 | goodness-of-fit.tex:909 | must_be_generated_from_support_notebook | migration_required | $(X < -2.55)$              & 0.0054 & 0  & 0.19 \\ |
| calc.gof.1243 | goodness-of-fit.tex:910 | must_be_generated_from_support_notebook | migration_required | $(-2.55 \leq X < -1.85)$  & 0.0268 & 2  & 0.96 \\ |
| calc.gof.1244 | goodness-of-fit.tex:911 | must_be_generated_from_support_notebook | migration_required | $(-1.85 \leq X < -1.15)$  & 0.0929 & 1  & 3.34 \\ |
| calc.gof.1245 | goodness-of-fit.tex:912 | must_be_generated_from_support_notebook | migration_required | $(-1.15 \leq X < -0.45)$  & 0.2013 & 10 & 7.25 \\ |
| calc.gof.1246 | goodness-of-fit.tex:913 | must_be_generated_from_support_notebook | migration_required | $(-0.45 \leq X < 0.25)$   & 0.2724 & 10 & 9.80 \\ |
| calc.gof.1247 | goodness-of-fit.tex:914 | must_be_generated_from_support_notebook | migration_required | $(0.25 \leq X < 0.95)$    & 0.2302 & 5  & 8.29 \\ |
| calc.gof.1248 | goodness-of-fit.tex:915 | must_be_generated_from_support_notebook | migration_required | $(0.95 \leq X < 1.65)$    & 0.1216 & 8  & 4.38 \\ |
| calc.gof.1249 | goodness-of-fit.tex:916 | must_be_generated_from_support_notebook | migration_required | $(X \geq 1.65)$            & 0.0495 & 0  & 1.78 \\ |
| calc.gof.1250 | goodness-of-fit.tex:918 | must_be_generated_from_support_notebook | migration_required | \textbf{Total}             & 1.0000 & 36 & 36.00 \\ |
| calc.gof.1251 | goodness-of-fit.tex:932 | must_be_checked_against_support_notebook | checked_in_support_output | \sum_{i=1}^{8} |
| calc.gof.1252 | goodness-of-fit.tex:933 | must_be_checked_against_support_notebook | checked_in_support_output | \frac{(O_i-E_i)^2}{E_i}, |
| calc.gof.1253 | goodness-of-fit.tex:945 | must_be_checked_against_support_notebook | checked_in_support_output | $(\frac{(O_i-E_i)^2}{E_i})$ \\ |
| calc.gof.1254 | goodness-of-fit.tex:947 | must_be_generated_from_support_notebook | migration_required | $(X < -2.55)$              & 0  & 0.19 & 0.04  & 0.19 \\ |
| calc.gof.1255 | goodness-of-fit.tex:948 | must_be_generated_from_support_notebook | migration_required | $(-2.55 \leq X < -1.85)$  & 2  & 0.96 & 1.07  & 1.11 \\ |
| calc.gof.1256 | goodness-of-fit.tex:949 | must_be_generated_from_support_notebook | migration_required | $(-1.85 \leq X < -1.15)$  & 1  & 3.34 & 5.50  & 1.64 \\ |
| calc.gof.1257 | goodness-of-fit.tex:950 | must_be_generated_from_support_notebook | migration_required | $(-1.15 \leq X < -0.45)$  & 10 & 7.25 & 7.58  & 1.05 \\ |
| calc.gof.1258 | goodness-of-fit.tex:951 | must_be_generated_from_support_notebook | migration_required | $(-0.45 \leq X < 0.25)$   & 10 & 9.80 & 0.04  & 0.00 \\ |
| calc.gof.1259 | goodness-of-fit.tex:952 | must_be_generated_from_support_notebook | migration_required | $(0.25 \leq X < 0.95)$    & 5  & 8.29 & 10.82 & 1.30 \\ |
| calc.gof.1260 | goodness-of-fit.tex:953 | must_be_generated_from_support_notebook | migration_required | $(0.95 \leq X < 1.65)$    & 8  & 4.38 & 13.13 & 3.00 \\ |
| calc.gof.1261 | goodness-of-fit.tex:954 | must_be_generated_from_support_notebook | migration_required | $(X \geq 1.65)$            & 0  & 1.78 & 3.17  & 1.78 \\ |
| calc.gof.1262 | goodness-of-fit.tex:956 | must_be_generated_from_support_notebook | migration_required | \textbf{Total}             & 36 & 36.00 &       & $(\chi^2 = 10.09)$ \\ |
| calc.gof.1263 | goodness-of-fit.tex:965 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = 10.09. |
| calc.gof.1264 | goodness-of-fit.tex:973 | must_be_checked_against_support_notebook | checked_in_support_output | \alpha = 0.05. |
| calc.gof.1265 | goodness-of-fit.tex:981 | must_be_checked_against_support_notebook | checked_in_support_output | df = k-1 = 8-1 = 7. |
| calc.gof.1266 | goodness-of-fit.tex:986 | static_theoretical_or_illustrative | intentional_manual | At the 5\% significance level, the critical value is |
| calc.gof.1267 | goodness-of-fit.tex:989 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2_{0.05,7} = 14.07. |
| calc.gof.1268 | goodness-of-fit.tex:992 | handled_by_epic_214_model_test_output | epic_214_scope | The rejection region therefore consists of values of the test statistic greater than 14.07. |
| calc.gof.1269 | goodness-of-fit.tex:999 | must_be_checked_against_support_notebook | checked_in_support_output | \chi^2 = 10.09 < 14.07, |
| calc.gof.1270 | goodness-of-fit.tex:1001 | handled_by_epic_214_model_test_output | epic_214_scope | the test statistic does not fall within the rejection region. Therefore, the null hypothesis is not rejected at the 5\% significance level. |
| calc.gof.1271 | goodness-of-fit.tex:1009 | handled_by_epic_214_model_test_output | epic_214_scope | p = 0.184. |
| calc.gof.1272 | goodness-of-fit.tex:1048 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-1-1} |
| calc.gof.1273 | goodness-of-fit.tex:1057 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-1} |
| calc.gof.1274 | goodness-of-fit.tex:1058 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-2} |
| calc.gof.1275 | goodness-of-fit.tex:1059 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-3} |
| calc.gof.1276 | goodness-of-fit.tex:1060 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-4} |
| calc.gof.1277 | goodness-of-fit.tex:1061 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-5} |
| calc.gof.1278 | goodness-of-fit.tex:1062 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-6} |
| calc.gof.1279 | goodness-of-fit.tex:1063 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-7} |
| calc.gof.1280 | goodness-of-fit.tex:1072 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-8} |
| calc.gof.1281 | goodness-of-fit.tex:1081 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-9} |
| calc.gof.1282 | goodness-of-fit.tex:1090 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-10} |
| calc.gof.1283 | goodness-of-fit.tex:1099 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-11} |
| calc.gof.1284 | goodness-of-fit.tex:1100 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-12} |
| calc.gof.1285 | goodness-of-fit.tex:1101 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-13} |
| calc.gof.1286 | goodness-of-fit.tex:1102 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-14} |
| calc.gof.1287 | goodness-of-fit.tex:1103 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-15} |
| calc.gof.1288 | goodness-of-fit.tex:1104 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-16} |
| calc.gof.1289 | goodness-of-fit.tex:1113 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-17} |
| calc.gof.1290 | goodness-of-fit.tex:1114 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output/exercise-6-2-18} |
| calc.gof.1291 | goodness-of-fit.tex:1125 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-1-1} |
| calc.gof.1292 | goodness-of-fit.tex:1134 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-1} |
| calc.gof.1293 | goodness-of-fit.tex:1135 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-2} |
| calc.gof.1294 | goodness-of-fit.tex:1136 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-3} |
| calc.gof.1295 | goodness-of-fit.tex:1137 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-4} |
| calc.gof.1296 | goodness-of-fit.tex:1138 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-5} |
| calc.gof.1297 | goodness-of-fit.tex:1139 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-6} |
| calc.gof.1298 | goodness-of-fit.tex:1140 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-7} |
| calc.gof.1299 | goodness-of-fit.tex:1149 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-8} |
| calc.gof.1300 | goodness-of-fit.tex:1158 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-9} |
| calc.gof.1301 | goodness-of-fit.tex:1167 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-10} |
| calc.gof.1302 | goodness-of-fit.tex:1176 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-11} |
| calc.gof.1303 | goodness-of-fit.tex:1177 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-12} |
| calc.gof.1304 | goodness-of-fit.tex:1178 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-13} |
| calc.gof.1305 | goodness-of-fit.tex:1179 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-14} |
| calc.gof.1306 | goodness-of-fit.tex:1180 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-15} |
| calc.gof.1307 | goodness-of-fit.tex:1181 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-16} |
| calc.gof.1308 | goodness-of-fit.tex:1190 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-17} |
| calc.gof.1309 | goodness-of-fit.tex:1191 | static_theoretical_or_illustrative | intentional_manual | \input{generated/workshop-output-python/exercise-6-2-18} |

## Intentional Exclusions and Exceptions

- Formula-only expressions without instantiated numeric substitution are classified static_theoretical_or_illustrative.
- Chapter constants and case-given values used as narrative setup are classified static_theoretical_or_illustrative unless part of an explicit computed result line.
- p-values/test statistics/critical-region outputs are classified handled_by_epic_214_model_test_output when they align with structured model/test-output verification scope.
