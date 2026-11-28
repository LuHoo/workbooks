"""Helpers for notebook-derived manuscript calculation registry entries."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Literal, Optional

ChapterPrefix = Literal["pro", "est", "aux", "hyp", "reg", "gof"]
EntryKind = Literal["worked_calculation", "inline_values", "table_values", "report_only"]
LanguageScope = Literal["shared", "r", "python", "exception"]


def _prefix(identifier: str) -> str:
    return identifier.split(".", 1)[0]


def _validate_identifier(identifier: str) -> None:
    parts = identifier.split(".")
    if len(parts) < 2 or parts[0] not in {"pro", "est", "aux", "hyp", "reg", "gof"}:
        raise ValueError(f"Invalid manuscript calculation identifier: {identifier}")
    for part in parts[1:]:
        if not part or not all(char.islower() or char.isdigit() or char == "_" for char in part):
            raise ValueError(f"Invalid manuscript calculation identifier: {identifier}")


def format_value(raw: float, fmt: str) -> str:
    if fmt == "integer":
        return f"{raw:,.0f}"
    if fmt.startswith("number:"):
        digits = int(fmt.split(":", 1)[1])
        return f"{raw:,.{digits}f}"
    if fmt.startswith("percentage:"):
        digits = int(fmt.split(":", 1)[1])
        return f"{raw * 100:,.{digits}f}\\%"
    if fmt.startswith("pvalue:") or fmt.startswith("statistic:"):
        digits = int(fmt.split(":", 1)[1])
        return f"{raw:,.{digits}f}"
    raise ValueError(f"Unsupported manuscript calculation format: {fmt}")


@dataclass
class RegistryValue:
    id: str
    raw: float
    format: str
    role: Optional[str] = None
    display: Optional[str] = None
    tolerance: Optional[float] = None
    language_scope: Optional[LanguageScope] = None

    def as_dict(self) -> dict[str, object]:
        _validate_identifier(self.id)
        role = self.role or self.id.rsplit(".", 1)[1]
        out: dict[str, object] = {
            "id": self.id,
            "role": role,
            "raw": self.raw,
            "display": self.display or format_value(self.raw, self.format),
            "format": self.format,
        }
        if self.tolerance is not None:
            out["tolerance"] = self.tolerance
        if self.language_scope is not None:
            out["language_scope"] = self.language_scope
        return out


@dataclass
class RegistryEntry:
    id: str
    kind: EntryKind
    source_notebook: str
    source_context: str
    values: list[RegistryValue] = field(default_factory=list)
    source_dataset: Optional[str] = None
    target_snippet: Optional[str] = None
    tolerance: float = 1e-8
    language_scope: LanguageScope = "shared"
    equation_labels: list[str] = field(default_factory=list)

    def as_dict(self) -> dict[str, object]:
        _validate_identifier(self.id)
        chapter_prefix = _prefix(self.id)
        value_dicts = [value.as_dict() for value in self.values]
        value_ids = [str(value["id"]) for value in value_dicts]
        duplicates = {value_id for value_id in value_ids if value_ids.count(value_id) > 1}
        if duplicates:
            raise ValueError(f"Duplicate registry value IDs: {', '.join(sorted(duplicates))}")
        bad_prefixes = [value_id for value_id in value_ids if _prefix(value_id) != chapter_prefix]
        if bad_prefixes:
            raise ValueError(
                f"Value IDs must use group prefix {chapter_prefix}: {', '.join(bad_prefixes)}"
            )
        out: dict[str, object] = {
            "schema_version": 1,
            "id": self.id,
            "kind": self.kind,
            "chapter_prefix": chapter_prefix,
            "source_notebook": self.source_notebook,
            "source_context": self.source_context,
            "tolerance": self.tolerance,
            "language_scope": self.language_scope,
            "values": value_dicts,
        }
        if self.source_dataset:
            out["source_dataset"] = self.source_dataset
        if self.target_snippet:
            out["target_snippet"] = self.target_snippet
        if self.equation_labels:
            out["equation_labels"] = list(self.equation_labels)
        return out
