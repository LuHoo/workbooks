#!/usr/bin/env python3

import argparse
import json
import math
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import numpy as np
from scipy.stats import binom, chi2, chisquare, f, hypergeom, norm, poisson, t

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from ada_fsaudit_bridge.native_stats import lower_bound, upper_bound


@dataclass
class Mismatch:
    chapter: str
    metric: str
    python_value: Any
    r_value: Any
    detail: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Assert R/Python numeric equivalence for representative workshop metrics."
    )
    parser.add_argument(
        "--chapters",
        default="1,3,4,5,6",
        help="Comma-separated chapter list to validate (default: 1,3,4,5,6).",
    )
    parser.add_argument(
        "--abs-tol",
        type=float,
        default=1e-8,
        help="Absolute tolerance for floating-point comparisons.",
    )
    parser.add_argument(
        "--rel-tol",
        type=float,
        default=1e-8,
        help="Relative tolerance for floating-point comparisons.",
    )
    return parser.parse_args()


def run_r_metrics(chapter: str) -> dict[str, Any]:
    snippets: dict[str, str] = {
        "1": """
suppressPackageStartupMessages(library(jsonlite))
N <- 331; M <- 17; n <- 60
mu <- 60 * 17 / 331
t_val <- (1004 - 1030) / (73.8 / sqrt(10))
f_crit <- qf(p = 0.05, df1 = 25, df2 = 23, lower.tail = FALSE)
out <- list(
  hyper_p0 = dhyper(0, M, N - M, n),
  hyper_p1 = dhyper(1, M, N - M, n),
  hyper_cdf1 = phyper(1, M, N - M, n),
  hyper_sf1 = phyper(1, M, N - M, n, lower.tail = FALSE),
  binom_p1 = dbinom(1, n, M / N),
  poisson_p1 = dpois(1, mu),
  poisson_cdf1 = ppois(1, mu),
  norm_cdf = pnorm(1012, 1030, 115.26 / sqrt(200)),
  t_cdf = pt(t_val, 9),
  chi2_q95 = qchisq(0.95, 9),
  chi2_q05 = qchisq(0.05, 9),
  f_crit = f_crit,
  f_sf = pf(f_crit, 25, 23, lower.tail = FALSE)
)
cat(toJSON(out, auto_unbox = TRUE, digits = NA))
""",
        "3": """
suppressPackageStartupMessages(library(jsonlite))
if (!requireNamespace("FSaudit", quietly = TRUE)) {
  stop("FSaudit is required for chapter 3 equivalence checks")
}
out <- list(
  upper_hyper = FSaudit::upper(popn = 3500, n = 100, k = 2, alpha = 0.05),
    lower_hyper = FSaudit::lower(popn = 3500, n = 100, k = 2, alpha = 0.05)
)
cat(toJSON(out, auto_unbox = TRUE, digits = NA))
""",
        "4": """
suppressPackageStartupMessages(library(jsonlite))
out <- list(
  sig_level_1 = phyper(1, 60, 1140, 45),
  sig_level_2 = phyper(2, 60, 1140, 102),
  type2_power = phyper(0, 24, 1176, 45, lower.tail = FALSE),
  one_sided_ub_0 = FSaudit::upper(popn = 1200, n = 102, k = 0, alpha = 0.10) / 1200,
  one_sided_ub_3 = FSaudit::upper(popn = 1200, n = 102, k = 3, alpha = 0.10) / 1200
)
cat(toJSON(out, auto_unbox = TRUE, digits = NA))
""",
        "5": """
suppressPackageStartupMessages(library(jsonlite))
x <- 1:10
y <- c(2.4, 2.9, 3.8, 4.2, 5.1, 5.4, 6.3, 6.8, 7.1, 8.0)
model <- lm(y ~ x)
out <- list(
  intercept = unname(coef(model)[1]),
  slope = unname(coef(model)[2]),
  r_squared = summary(model)$r.squared
)
cat(toJSON(out, auto_unbox = TRUE, digits = NA))
""",
        "6": """
suppressPackageStartupMessages(library(jsonlite))
observed <- c(15, 12, 13)
p <- c(0.40, 0.16, 0.44)
n <- sum(observed)
expected <- n * p
chi_sq <- sum((observed - expected)^2 / expected)
df <- length(observed) - 1
alpha <- 0.05
digits <- 1:9
probabilities <- log10((digits + 1) / digits)
chisq_builtin <- suppressWarnings(chisq.test(x = observed, p = p))
out <- list(
  expected = expected,
  chi_sq = chi_sq,
  critical_value = qchisq(1 - alpha, df),
  p_value = pchisq(chi_sq, df, lower.tail = FALSE),
  chisq_builtin_stat = unname(chisq_builtin$statistic),
  chisq_builtin_p = chisq_builtin$p.value,
  benford_first = probabilities[1],
  benford_sum = sum(probabilities)
)
cat(toJSON(out, auto_unbox = TRUE, digits = NA))
""",
    }

    code = snippets.get(chapter)
    if code is None:
        raise ValueError(f"Unsupported chapter: {chapter}")

    proc = subprocess.run(
        ["Rscript", "-e", code],
        check=False,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        raise RuntimeError(
            f"R equivalence computation failed for chapter {chapter}: {proc.stderr or proc.stdout}"
        )
    return json.loads(proc.stdout)


def python_metrics(chapter: str) -> dict[str, Any]:
    if chapter == "1":
        N = 331
        M = 17
        n = 60
        mu = 60 * 17 / 331
        t_val = (1004 - 1030) / (73.8 / math.sqrt(10))
        f_crit = f.ppf(0.95, 25, 23)
        return {
            "hyper_p0": hypergeom.pmf(0, N, M, n),
            "hyper_p1": hypergeom.pmf(1, N, M, n),
            "hyper_cdf1": hypergeom.cdf(1, N, M, n),
            "hyper_sf1": hypergeom.sf(1, N, M, n),
            "binom_p1": binom.pmf(1, n, M / N),
            "poisson_p1": poisson.pmf(1, mu),
            "poisson_cdf1": poisson.cdf(1, mu),
            "norm_cdf": norm.cdf(1012, 1030, 115.26 / math.sqrt(200)),
            "t_cdf": t.cdf(t_val, 9),
            "chi2_q95": chi2.ppf(0.95, 9),
            "chi2_q05": chi2.ppf(0.05, 9),
            "f_crit": f_crit,
            "f_sf": f.sf(f_crit, 25, 23),
        }

    if chapter == "3":
        return {
            "upper_hyper": upper_bound(k=2, popn=3500, n=100, alpha=0.05),
            "lower_hyper": lower_bound(k=2, popn=3500, n=100, alpha=0.05),
        }

    if chapter == "4":
        return {
            "sig_level_1": hypergeom.cdf(1, 1200, 60, 45),
            "sig_level_2": hypergeom.cdf(2, 1200, 60, 102),
            "type2_power": hypergeom.sf(0, 1200, 24, 45),
            "one_sided_ub_0": upper_bound(k=0, popn=1200, n=102, alpha=0.10) / 1200,
            "one_sided_ub_3": upper_bound(k=3, popn=1200, n=102, alpha=0.10) / 1200,
        }

    if chapter == "5":
        x = np.arange(1, 11, dtype=float)
        y = np.array([2.4, 2.9, 3.8, 4.2, 5.1, 5.4, 6.3, 6.8, 7.1, 8.0], dtype=float)
        slope, intercept = np.polyfit(x, y, 1)
        y_hat = intercept + slope * x
        ss_res = float(np.sum((y - y_hat) ** 2))
        ss_tot = float(np.sum((y - y.mean()) ** 2))
        return {
            "intercept": float(intercept),
            "slope": float(slope),
            "r_squared": 1.0 - ss_res / ss_tot,
        }

    if chapter == "6":
        observed = np.array([15.0, 12.0, 13.0])
        p = np.array([0.40, 0.16, 0.44])
        n = observed.sum()
        expected = n * p
        chi_sq = float(np.sum((observed - expected) ** 2 / expected))
        digits = np.arange(1.0, 10.0)
        probabilities = np.log10((digits + 1.0) / digits)
        chisq_builtin = chisquare(f_obs=observed, f_exp=expected)
        return {
            "expected": expected.tolist(),
            "chi_sq": chi_sq,
            "critical_value": float(chi2.ppf(0.95, 2)),
            "p_value": float(chi2.sf(chi_sq, 2)),
            "chisq_builtin_stat": float(chisq_builtin.statistic),
            "chisq_builtin_p": float(chisq_builtin.pvalue),
            "benford_first": float(probabilities[0]),
            "benford_sum": float(probabilities.sum()),
        }

    raise ValueError(f"Unsupported chapter: {chapter}")


def compare_values(
    chapter: str,
    metric: str,
    py_val: Any,
    r_val: Any,
    abs_tol: float,
    rel_tol: float,
    mismatches: list[Mismatch],
) -> None:
    if isinstance(py_val, list) and isinstance(r_val, list):
        if len(py_val) != len(r_val):
            mismatches.append(
                Mismatch(chapter, metric, py_val, r_val, "list length differs")
            )
            return
        for i, (py_item, r_item) in enumerate(zip(py_val, r_val)):
            compare_values(
                chapter,
                f"{metric}[{i}]",
                py_item,
                r_item,
                abs_tol,
                rel_tol,
                mismatches,
            )
        return

    if isinstance(py_val, (int, float)) and isinstance(r_val, (int, float)):
        if math.isclose(float(py_val), float(r_val), rel_tol=rel_tol, abs_tol=abs_tol):
            return
        mismatches.append(
            Mismatch(
                chapter,
                metric,
                py_val,
                r_val,
                f"outside tolerance abs={abs_tol} rel={rel_tol}",
            )
        )
        return

    if py_val != r_val:
        mismatches.append(Mismatch(chapter, metric, py_val, r_val, "values differ"))


def main() -> None:
    args = parse_args()
    chapters = [c.strip() for c in args.chapters.split(",") if c.strip()]

    mismatches: list[Mismatch] = []
    for chapter in chapters:
        py_metrics = python_metrics(chapter)
        r_metrics = run_r_metrics(chapter)

        missing_in_r = sorted(set(py_metrics) - set(r_metrics))
        missing_in_py = sorted(set(r_metrics) - set(py_metrics))
        if missing_in_r:
            mismatches.append(
                Mismatch(chapter, "<keys>", list(py_metrics.keys()), list(r_metrics.keys()), f"missing in R: {missing_in_r}")
            )
            continue
        if missing_in_py:
            mismatches.append(
                Mismatch(chapter, "<keys>", list(py_metrics.keys()), list(r_metrics.keys()), f"missing in Python: {missing_in_py}")
            )
            continue

        for metric in sorted(py_metrics.keys()):
            compare_values(
                chapter,
                metric,
                py_metrics[metric],
                r_metrics[metric],
                args.abs_tol,
                args.rel_tol,
                mismatches,
            )

    if mismatches:
        print("R/Python equivalence check failed")
        for mismatch in mismatches:
            print("---")
            print(f"Chapter: {mismatch.chapter}")
            print(f"Metric: {mismatch.metric}")
            print(f"Python: {mismatch.python_value}")
            print(f"R: {mismatch.r_value}")
            print(f"Detail: {mismatch.detail}")
        print("Remediation: align renderer mappings or chapter-specific Python overrides with R workshop semantics.")
        raise SystemExit(1)

    print(f"R/Python equivalence check passed for chapters: {', '.join(chapters)}")


if __name__ == "__main__":
    main()
