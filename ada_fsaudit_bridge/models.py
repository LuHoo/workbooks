from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any


@dataclass(slots=True)
class NotebookContext:
    chapter: str | None = None
    exercise: str | None = None
    notebook: str | None = None

    def as_dict(self) -> dict[str, str]:
        out: dict[str, str] = {}
        if self.chapter:
            out["chapter"] = self.chapter
        if self.exercise:
            out["exercise"] = self.exercise
        if self.notebook:
            out["notebook"] = self.notebook
        return out


@dataclass(slots=True)
class EnvironmentDiagnostics:
    r_version: str | None = None
    fsaudit_version: str | None = None
    library_paths: list[str] = field(default_factory=list)
    configured_seed: int | None = None
    context: dict[str, str] = field(default_factory=dict)

    def as_dict(self) -> dict[str, Any]:
        return {
            "r_version": self.r_version,
            "fsaudit_version": self.fsaudit_version,
            "library_paths": list(self.library_paths),
            "configured_seed": self.configured_seed,
            "context": dict(self.context),
        }
