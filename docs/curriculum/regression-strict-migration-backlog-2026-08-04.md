# Regression Strict Migration Backlog

Date: 2026-08-04

Total regression migration-required rows: 71

## Cluster 1: lines 615-615

| Line | Values | Context |
|---:|---|---|
| 615 | 2, 1, 7 | \ttblue{mod.2} & Extension of \ttblue{mod.1} that includes interaction terms to capture differential effects in summer and non-summer periods. & \ref{sub:disaggregation_ch07}\\ |

## Cluster 2: lines 785-788

| Line | Values | Context |
|---:|---|---|
| 785 | 1.0000, 0.6298, 0.1304, 0.6541 | revenue    &  1.0000 &  0.6298 & -0.1304 &  0.6541 \\ |
| 786 | 0.6298, 1.0000, 0.5788, 0.0487 | production &  0.6298 &  1.0000 &  0.5788 & -0.0487 \\ |
| 787 | 0.1304, 0.5788, 1.0000, 0.7248 | coolDD     & -0.1304 &  0.5788 &  1.0000 & -0.7248 \\ |
| 788 | 0.6541, 0.0487, 0.7248, 1.0000 | heatDD     &  0.6541 & -0.0487 & -0.7248 &  1.0000 \\ |

## Cluster 3: lines 810-810

| Line | Values | Context |
|---:|---|---|
| 810 | 1, 0, 1, 2, 1, 1 | Adding the additional variables \texttt{coolDD} and \texttt{heatDD} has improved the fit of the model. The residual standard deviation decreased from \footnote{See Exercises \ref{ex:modelling_mod0} and \ref{ex:modelli... |

## Cluster 4: lines 872-878

| Line | Values | Context |
|---:|---|---|
| 872 | 467201, 34.26, 120941, 1495 | \text{revenue} = 467,201 + 34.26 \cdot \text{production} -120,941 \cdot \text{coolDD} + 1,495 \cdot \text{heatDD} |
| 875 | 1, 467201, 4923031, 5390232, 34.26, 23.63, 10.63, 120941, 124446, 3505, 1495, 13340, 11845 | For the summer months, when \ttblue{summer = 1}, the interaction terms apply, and they adjust the intercept and the predictors. The \ttblue{intercept} of 467,201 is adjusted upward by 4,923,031 to 5,390,232, the produ... |
| 878 | 5390232, 10.63, 3505, 11845 | \text{revenue} = 5,390,232 + 10.63 \cdot \text{production} + 3,505 \cdot \text{coolDD} -11,845 \cdot \text{heatDD} |

## Cluster 5: lines 950-950

| Line | Values | Context |
|---:|---|---|
| 950 | 0.5 | \paragraph{\(\lambda = -0.5\):} |

## Cluster 6: lines 968-968

| Line | Values | Context |
|---:|---|---|
| 968 | 0.5 | \paragraph{\(\lambda = 0.5\):} |

## Cluster 7: lines 1017-1022

| Line | Values | Context |
|---:|---|---|
| 1017 | 0, 1, 0, 1 | Standard linear regression & -- & $y = b_0 + b_1x$ & $\hat{y} = b_0 + b_1x$ \\ |
| 1018 | 0, 1, 0, 1 | Exponential & ln(y) & $ln(y) = b_0 + b_1x$ & $\hat{y} = e^{b_0 + b_1x}$ \\ |
| 1019 | 0, 1, 0, 1, 2 | Quadratic & sqrt(y) & $\sqrt{y} = b_0 + b_1x$ & $\hat{y} = (b_0 + b_1x)^2$ \\ |
| 1020 | 1, 1, 0, 1, 1, 0, 1 | Inverse & 1/y & $1/y = b_0 + b_1x$ & $\hat{y} = 1 / (b_0 + b_1x)$ \\ |
| 1021 | 0, 1, 0, 1 | Logarithmic & ln(x) & $y = b_0 + b_1ln(x)$ & $\hat{y} = b_0 + b_1ln(x)$ \\ |
| 1022 | 0, 1, 0, 1 | Power & ln(y), ln(x) & $ln(y) = b_0 + b_1ln(x)$ & $\hat{y} = e^{b_0} \cdot x^{b_1}$ \\ |

## Cluster 8: lines 1260-1264

| Line | Values | Context |
|---:|---|---|
| 1260 | 22, 2012, 10, 4.1680952, 0.2463804, 0.448000286 | 22 & 2012/10 & \textbf{-4.1680952} &          0.2463804 & \textbf{0.448000286} \\ |
| 1261 | 29, 2013, 05, 0.2155177, 0.5187665, 0.006479471 | 29 & 2013/05 &           0.2155177 & \textbf{0.5187665} & 0.006479471 \\ |
| 1262 | 30, 2013, 06, 1.3124479, 0.4899321, 0.201612590 | 30 & 2013/06 &           1.3124479 & \textbf{0.4899321} & \textbf{0.201612590} \\ |
| 1263 | 34, 2013, 10, 2.3990931, 0.6194744, 1.001187652 | 34 & 2013/10 &  \textbf{2.3990931} & \textbf{0.6194744} & \textbf{1.001187652} \\ |
| 1264 | 36, 2013, 12, 2.2533566, 0.1021413, 0.063025927 | 36 & 2013/12 & \textbf{-2.2533566} &          0.1021413 & 0.063025927 \\ |

## Cluster 9: lines 1310-1310

| Line | Values | Context |
|---:|---|---|
| 1310 | 5000000, 2500000 | ymin=-5000000, ymax=2500000, |

## Cluster 10: lines 1319-1320

| Line | Values | Context |
|---:|---|---|
| 1319 | 5000000, 2500000, 0250, 0000 | ytick={-5000000,-2500000,0,2500000}, |
| 1320 | 0.1 | enlargelimits=0.1, |

## Cluster 11: lines 1352-1352

| Line | Values | Context |
|---:|---|---|
| 1352 | 3, 3, 63, 3, 2.0 | We fit a new model, \ttblue{mod.3}, on the residual-winsorized data. The coefficient estimates of this model are summarized in Table \ref{tab:summary_mod_3} below. Following the AAG guidance (AAG A.63), the results sh... |

## Cluster 12: lines 1418-1418

| Line | Values | Context |
|---:|---|---|
| 1418 | 1, 5.60, 3, 2.47 | For the \emph{Case: US SteamCo}, the largest VIF in \ttblue{mod.1} is 5.60 (for \ttblue{coolDD}), and the largest adjusted GVIF in \ttblue{mod.3} is 2.47 (also for \ttblue{coolDD}).\footnote{See Exercise \ref{ex:vif}}... |

## Cluster 13: lines 1495-1499

| Line | Values | Context |
|---:|---|---|
| 1495 | 2, 1 | Unexplained & Residuals (SSE)  & $\sum{(y_i - \hat{y})^2}$       & $n - k - 1$\\ |
| 1499 | 2, 1 | Total & Total (TSS) & $\sum{(y_i - \bar{y})^2}$ & $n - 1$ \\ |

## Cluster 14: lines 1553-1558

| Line | Values | Context |
|---:|---|---|
| 1553 | 3.7804, 14, 1, 3.7804, 14 | production & 3.7804e+14 & 1  & 3.7804e+14  \\ |
| 1554 | 5.7503, 14, 34, 1.6913, 13 | residuals  & 5.7503e+14 & 34 & 1.6913e+13  \\ |
| 1558 | 9.5307, 14, 35 | Total      & 9.5307e+14 & 35 &  \\ |

## Cluster 15: lines 1606-1613

| Line | Values | Context |
|---:|---|---|
| 1606 | 3.7804, 14, 1, 3.7804, 14 | production & 3.7804e+14 & 1  & 3.7804e+14 \\ |
| 1607 | 3.5110, 14, 1, 3.5110, 14 | coolDD     & 3.5110e+14 & 1  & 3.5110e+14 \\ |
| 1608 | 9.8390, 13, 1, 9.8390, 13 | heatDD     & 9.8390e+13 & 1  & 9.8390e+13 \\ |
| 1609 | 1.2554, 14, 32, 3.9232, 12 | residuals  & 1.2554e+14 & 32 & 3.9232e+12 \\ |
| 1613 | 9.5307, 14, 35 | Total      & 9.5307e+14 & 35 &            \\ |

## Cluster 16: lines 1629-1629

| Line | Values | Context |
|---:|---|---|
| 1629 | 39.67%, 0, 86.83%, 1 | Note the increase in explained variation by adding the two additional variables to the model, \ttblue{coolDD} and \ttblue{heatDD}. Explained variance has increased from 39.67\% for \ttblue{mod.0} to 86.83\% for \ttblu... |

## Cluster 17: lines 1636-1636

| Line | Values | Context |
|---:|---|---|
| 1636 | 0, 2, 2, 2, 2 | The full summary table\footnote{See \ref{ex:summary.mod.0}} displays the values of the multiple $r^2$ (also referred to as the coefficient of determination\index{coefficient of determination}) and the adjusted $r^2$. ... |

## Cluster 18: lines 1643-1647

| Line | Values | Context |
|---:|---|---|
| 1643 | 2, 0, 36, 1 | The adjusted $r^2$ for \ttblue{mod.0} with $n = 36$ and $k = 1$ is then |
| 1647 | 1, 1, 2, 0.8683, 0.8667, 1, 2, 0.8559, 1, 0.8586 | For example, when we compare \ttblue{mod\_forward} from Exercise \ref{ex:modelling strategies} with \ttblue{mod.1} from Exercise \ref{ex:modelling_mod.1} we observe that the latter has a higher $r^2$ (0.8683) than the... |

## Cluster 19: lines 1684-1687

| Line | Values | Context |
|---:|---|---|
| 1684 | 0, 0.3967, 0.3789, 1202.633, 1207.383 | mod.0          & 0.3967 & 0.3789 & 1202.633 & 1207.383 \\ |
| 1685 | 0.8667, 0.8586, 1150.277, 1156.611 | model\_forward & 0.8667 & 0.8586 & 1150.277 & 1156.611 \\ |
| 1686 | 1, 0.8683, 0.8559, 1151.848, 1159.766 | mod.1          & 0.8683 & 0.8559 & 1151.848 & 1159.766 \\ |
| 1687 | 2, 0.9170, 0.8963, 1143.217, 1157.468 | mod.2          & 0.9170 & 0.8963 & 1143.217 & 1157.468 \\ |

## Cluster 20: lines 1694-1696

| Line | Values | Context |
|---:|---|---|
| 1694 | 2, 2, 62, 04, 0, 2, 0 | The assessment of regression model precision relies not only on overall goodness-of-fit statistics such as multiple $r^2$ and adjusted $r^2$, but also on measures of individual predictor strength and the overall stand... |
| 1696 | 0, 2, 0.3789, 1207.383, 1, 2, 0.85, 1, 1 | The simple benchmark model \ttblue{mod.0} has an adjusted $r^2$ of 0.3789 and a BIC of 1207.383. The models that include additional predictors perform much better. \ttblue{model\_forward} and \ttblue{mod.1} both achie... |

## Cluster 21: lines 2035-2043

| Line | Values | Context |
|---:|---|---|
| 2035 | 752767, 35.87, 121381 | \text{revenue} = 752,767 + 35.87 \cdot \text{production} - 121,381 \cdot \text{coolDD} |
| 2041 | 3972293, 12.64, 3683 | \text{revenue} = 3,972,293 + 12.64 \cdot \text{production} + 3,683 \cdot \text{coolDD} |
| 2043 | 752767, 3219526, 3972293, 35.87, 23.23, 12.64, 121381, 125064, 3683 | The coefficient values take the interactions into account. Therefore, the intercept value is equal to $752,767 + 3,219,526 = 3,972,293$, the slope value for \ttblue{production} is equal to $35.87 - 23.23 = 12.64$, and... |

## Cluster 22: lines 2100-2100

| Line | Values | Context |
|---:|---|---|
| 2100 | 0.525 | Among the remaining predictors, only the intercept exhibits a clearly non-significant $p$ value ($p = 0.525$). |

## Cluster 23: lines 2166-2171

| Line | Values | Context |
|---:|---|---|
| 2166 | 752767, 1, 752767 | intercept           &   752,767 & 1                 &    752,767 \\ |
| 2167 | 35.87, 606400, 21752892 | production          &     35.87 & 606,400           & 21,752,892 \\ |
| 2168 | 3219526, 0, 0 | summer              & 3,219,526 & 0                 &          0 \\ |
| 2169 | 121381, 0, 0 | coolDD              &  -121,381 & 0                 &          0 \\ |
| 2170 | 23.23, 0, 606400, 0 | production : summer &    -23.23 & 0 $\cdot$ 606,400 &          0 \\ |
| 2171 | 125064, 0, 0, 0 | coolDD : summer     &   125,064 & 0 $\cdot$ 0       &          0 \\ |

## Cluster 24: lines 2249-2264

| Line | Values | Context |
|---:|---|---|
| 2249 | 2014, 19228840, 18270762, 22505659, 26740557, 3276819 | January 2014   &        19,228,840  & 18,270,762 & 22,505,659 & 26,740,557 & -3,276,819 \\ |
| 2250 | 2014, 26792280, 21884851, 26370098, 30855345, 422182 | February 2014  &        26,792,280  & 21,884,851 & 26,370,098 & 30,855,345 &    422,182 \\ |
| 2251 | 2014, 19935840, 24872800, 29651399, 34429998, 9715559 | March 2014     & \hlred{19,935,840} & 24,872,800 & 29,651,399 & 34,429,998 & -9,715,559 \\ |
| 2252 | 2014, 13468000, 10117297, 14235543, 18353788, 767543 | April 2014     &        13,468,000  & 10,117,297 & 14,235,543 & 18,353,788 &   -767,543 \\ |
| 2253 | 2014, 7344128, 3275961, 7683165, 12090370, 339037 | May 2014       &         7,344,128  &  3,275,961 &  7,683,165 & 12,090,370 &   -339,037 \\ |
| 2254 | 2014, 11196216, 7225223, 11362096, 15498968, 165880 | June 2014      &        11,196,216  &  7,225,223 & 11,362,096 & 15,498,968 &   -165,880 \\ |
| 2255 | 2014, 13929472, 10572555, 14845538, 19118521, 916066 | July 2014      &        13,929,472  & 10,572,555 & 14,845,538 & 19,118,521 &   -916,066 \\ |
| 2256 | 2014, 12352176, 9357740, 13544329, 17730918, 1192153 | August 2014    &        12,352,176  &  9,357,740 & 13,544,329 & 17,730,918 & -1,192,153 \\ |
| 2257 | 2014, 12628944, 8613794, 13497081, 18380369, 868137 | September 2014 &        12,628,944  &  8,613,794 & 13,497,081 & 18,380,369 &   -868,137 \\ |
| 2258 | 2014, 9361000, 8358271, 12609214, 16860157, 3248214 | October 2014   &         9,361,000  &  8,358,271 & 12,609,214 & 16,860,157 & -3,248,214 \\ |
| 2259 | 2014, 10164048, 7059618, 11282544, 15505471, 1118496 | November 2014  &        10,164,048  &  7,059,618 & 11,282,544 & 15,505,471 & -1,118,496 \\ |
| 2260 | 2014, 18377456, 16921330, 21094017, 25266704, 2716561 | December 2014  &        18,377,456  & 16,921,330 & 21,094,017 & 25,266,704 & -2,716,561 \\ |
| 2264 | 174778400, 198680683, 23902283 | Total          &174,778,400 &             & 198,680,683 & & -23,902,283 \\ |

## Cluster 25: lines 2487-2487

| Line | Values | Context |
|---:|---|---|
| 2487 | 1.2, 1.4, 0.2 | \hspace*{1.2cm}\=\hspace*{1.4cm}\=\hspace*{0.2cm}\= \kill |

