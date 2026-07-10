from __future__ import annotations

from typing import Any

import numpy as np
import pandas as pd

from .errors import ErrorDetails, FSAuditConversionError
from .models import NotebookContext


def python_to_r(value: Any, context: NotebookContext | None = None) -> Any:
    try:
        from rpy2.robjects import conversion, default_converter, numpy2ri, pandas2ri
        from rpy2.robjects.conversion import localconverter
    except ModuleNotFoundError as exc:
        raise FSAuditConversionError(
            "rpy2 is not installed",
            ErrorDetails(
                operation="python-to-r",
                notebook_context=context,
                remediation="Install rpy2 in the active Python environment.",
            ),
        ) from exc

    try:
        with localconverter(default_converter + pandas2ri.converter + numpy2ri.converter):
            return conversion.get_conversion().py2rpy(value)
    except Exception as exc:  # pragma: no cover - exercised through integration tests
        raise FSAuditConversionError(
            "Failed to convert Python value to R",
            ErrorDetails(
                operation="python-to-r",
                notebook_context=context,
                r_error=str(exc),
                remediation="Check that inputs use scalar, vector, pandas, or numpy-compatible types.",
            ),
        ) from exc


def _is_r_null(value: Any) -> bool:
    try:
        from rpy2.rinterface_lib.sexp import NULLType

        return isinstance(value, NULLType)
    except ModuleNotFoundError:
        return False


def _recursive_r_to_python(value: Any, context: NotebookContext | None = None) -> Any:
    from rpy2.robjects import ListVector
    from rpy2.robjects.vectors import DataFrame

    if _is_r_null(value):
        return None

    if isinstance(value, DataFrame):
        from rpy2.robjects import conversion, default_converter, pandas2ri, numpy2ri
        from rpy2.robjects.conversion import localconverter

        with localconverter(default_converter + pandas2ri.converter + numpy2ri.converter):
            converted = conversion.get_conversion().rpy2py(value)
        if isinstance(converted, pd.DataFrame):
            return converted
        return pd.DataFrame(converted)

    if isinstance(value, ListVector):
        names = list(value.names)
        has_names = bool(names) and all(name not in (None, "") for name in names)
        if has_names:
            return {name: _recursive_r_to_python(item, context=context) for name, item in zip(names, value)}
        return [_recursive_r_to_python(item, context=context) for item in value]

    from rpy2.robjects import conversion, default_converter, pandas2ri, numpy2ri
    from rpy2.robjects.conversion import localconverter

    with localconverter(default_converter + pandas2ri.converter + numpy2ri.converter):
        converted = conversion.get_conversion().rpy2py(value)

    if isinstance(converted, np.generic):
        return converted.item()
    if isinstance(converted, np.ndarray):
        return converted.tolist()
    return converted


def r_to_python(value: Any, context: NotebookContext | None = None) -> Any:
    try:
        return _recursive_r_to_python(value, context=context)
    except FSAuditConversionError:
        raise
    except Exception as exc:  # pragma: no cover - exercised through integration tests
        raise FSAuditConversionError(
            "Failed to convert R value to Python",
            ErrorDetails(
                operation="r-to-python",
                notebook_context=context,
                r_error=str(exc),
                remediation="Inspect the returned R object and add a dedicated conversion rule if needed.",
            ),
        ) from exc
