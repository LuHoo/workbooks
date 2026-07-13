from __future__ import annotations

import random
from dataclasses import replace
from typing import Any

import numpy as np
import pandas as pd

from .models import NotebookContext
from .native_stats import lower_bound, upper_bound
from .session import FSAuditSession

BRIDGE_VERSION = "0.1.0"

_SESSION: FSAuditSession | None = None
_CONTEXT = NotebookContext()


def _get_session() -> FSAuditSession:
    global _SESSION
    if _SESSION is None:
        _SESSION = FSAuditSession()
    _SESSION.set_context(_CONTEXT)
    return _SESSION


def configure_environment(
    seed: int | None = None,
    numpy_seed: int | None = None,
    python_seed: int | None = None,
    r_seed: int | None = None,
    r_library_paths: list[str] | None = None,
    require_fsaudit_version: str | None = None,
) -> dict[str, Any]:
    global _SESSION
    _SESSION = FSAuditSession(
        library_paths=r_library_paths,
        require_fsaudit_version=require_fsaudit_version,
    )
    session = _get_session()
    session.ensure_initialized()

    if seed is not None:
        random.seed(seed)
        np.random.seed(seed)
        session.set_seed(seed)
    else:
        if python_seed is not None:
            random.seed(python_seed)
        if numpy_seed is not None:
            np.random.seed(numpy_seed)
        if r_seed is not None:
            session.set_seed(r_seed)

    return bridge_diagnostics()


def set_notebook_context(
    chapter: str | None = None,
    exercise: str | None = None,
    notebook: str | None = None,
) -> None:
    global _CONTEXT
    _CONTEXT = NotebookContext(chapter=chapter, exercise=exercise, notebook=notebook)
    if _SESSION is not None:
        _SESSION.set_context(_CONTEXT)


def bridge_diagnostics() -> dict[str, Any]:
    diagnostics = _get_session().diagnostics().as_dict()
    diagnostics["bridge_version"] = BRIDGE_VERSION
    return diagnostics


class _BaseSampler:
    def __init__(self, session: FSAuditSession, r_object: Any, context: NotebookContext) -> None:
        self._session = session
        self._r_object = r_object
        self._context = replace(context)

    def _mutate(self, function_name: str, **kwargs: Any) -> _BaseSampler:
        self._r_object = self._session.call_function(
            function_name,
            self._r_object,
            context=self._context,
            **kwargs,
        )
        return self

    @property
    def n(self) -> Any:
        return self._session.get_named_value(self._r_object, "n", context=self._context)

    @property
    def popn(self) -> Any:
        return self._session.get_named_value(self._r_object, "popn", context=self._context)

    @property
    def popBv(self) -> Any:
        return self._session.get_named_value(self._r_object, "popBv", context=self._context)

    @property
    def sample(self) -> pd.DataFrame | None:
        sample = self._session.get_named_value(self._r_object, "sample", context=self._context)
        return sample if isinstance(sample, pd.DataFrame) else None

    @property
    def eval_results(self) -> Any:
        return self._session.get_named_value(self._r_object, "evalResults", context=self._context)

    def summary(self) -> dict[str, Any]:
        fields = ["n", "popn", "popBv", "sample", "evalResults"]
        out: dict[str, Any] = {}
        for field in fields:
            try:
                out[field] = self._session.get_named_value(self._r_object, field, context=self._context)
            except Exception:
                continue
        return out

    def field(self, name: str) -> Any:
        return self._session.get_named_value(self._r_object, name, context=self._context)

    def field_names(self) -> list[str]:
        names = self._session.ro.r["names"](self._r_object)
        return [str(name) for name in names]


class AttributeSampler(_BaseSampler):
    def size(self, **kwargs: Any) -> AttributeSampler:
        return self._mutate("size", **kwargs)


class MonetaryUnitSampler(_BaseSampler):
    def size(self, **kwargs: Any) -> MonetaryUnitSampler:
        return self._mutate("size", **kwargs)

    def select(self, **kwargs: Any) -> MonetaryUnitSampler:
        return self._mutate("select", **kwargs)

    def evaluate(self, **kwargs: Any) -> MonetaryUnitSampler:
        return self._mutate("evaluate", **kwargs)


class ClassicalVariableSampler(_BaseSampler):
    def stratify(self, **kwargs: Any) -> ClassicalVariableSampler:
        return self._mutate("stratify", **kwargs)

    def size(self, **kwargs: Any) -> ClassicalVariableSampler:
        return self._mutate("size", **kwargs)

    def select(self, **kwargs: Any) -> ClassicalVariableSampler:
        return self._mutate("select", **kwargs)

    def evaluate(self, **kwargs: Any) -> ClassicalVariableSampler:
        return self._mutate("evaluate", **kwargs)


def load_dataset(name: str) -> pd.DataFrame:
    dataset = _get_session().load_dataset(name)
    if not isinstance(dataset, pd.DataFrame):
        return pd.DataFrame(dataset)
    return dataset


def att_sample(**kwargs: Any) -> AttributeSampler:
    session = _get_session()
    r_object = session.call_function("att_obj", context=_CONTEXT, **kwargs)
    return AttributeSampler(session, r_object, _CONTEXT)


def mus_sample(**kwargs: Any) -> MonetaryUnitSampler:
    session = _get_session()
    r_object = session.call_function("mus_obj", context=_CONTEXT, **kwargs)
    return MonetaryUnitSampler(session, r_object, _CONTEXT)


def cvs_sample(**kwargs: Any) -> ClassicalVariableSampler:
    session = _get_session()
    r_object = session.call_function("cvs_obj", context=_CONTEXT, **kwargs)
    return ClassicalVariableSampler(session, r_object, _CONTEXT)


def reset_session() -> None:
    global _SESSION
    _SESSION = None
