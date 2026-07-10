from __future__ import annotations

from scipy.stats import binom, hypergeom


def upper_bound(k: int, popn: int, n: int, alpha: float, dist: str = "hyper") -> int:
    if k < 0 or popn <= 0 or n <= 0:
        raise ValueError("k, popn, and n must be non-negative with popn/n > 0")
    if dist not in {"hyper", "binom"}:
        raise ValueError("dist must be 'hyper' or 'binom'")

    lower = min(max(k, 0), popn)
    upper = popn
    best = lower

    while lower <= upper:
        mid = (lower + upper) // 2
        if dist == "hyper":
            tail = hypergeom.cdf(k, popn, mid, n)
        else:
            tail = binom.cdf(k, n, mid / popn)

        if tail > alpha:
            best = mid
            lower = mid + 1
        else:
            upper = mid - 1

    return int(best)


def lower_bound(k: int, popn: int, n: int, alpha: float, dist: str = "hyper") -> int:
    if k < 0 or popn <= 0 or n <= 0:
        raise ValueError("k, popn, and n must be non-negative with popn/n > 0")
    if dist not in {"hyper", "binom"}:
        raise ValueError("dist must be 'hyper' or 'binom'")

    lower = 0
    upper = min(popn, popn - (n - k)) if dist == "hyper" else popn
    best = 0

    while lower <= upper:
        mid = (lower + upper) // 2
        if dist == "hyper":
            tail = hypergeom.sf(k - 1, popn, mid, n)
        else:
            tail = binom.sf(k - 1, n, mid / popn)

        if tail > alpha:
            best = mid
            upper = mid - 1
        else:
            lower = mid + 1

    return int(best)
