#!/usr/bin/env python3

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any, Dict, List, Optional

SUPPORTED_SCHEMA_VERSIONS = {"workshop-ir/1.0.0", "workshop-ir/1.1.0"}
RENDERER_VERSION = "1.0.0"


class RendererError(Exception):
    def __init__(
        self,
        stage: str,
        chapter: Optional[str],
        block_id: Optional[str],
        code: str,
        message: str,
        remediation: str,
    ) -> None:
        self.stage = stage
        self.chapter = chapter
        self.block_id = block_id
        self.code = code
        self.message = message
        self.remediation = remediation
        super().__init__(
            f"[{code}] stage={stage} chapter={chapter or '-'} block={block_id or '-'} "
            f"message={message} remediation={remediation}"
        )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Render deterministic Python notebooks from workshop IR.")
    parser.add_argument("--input-ir", required=True, help="Path to IR JSON input file.")
    parser.add_argument("--output-notebook", required=True, help="Path to output .ipynb file.")
    parser.add_argument("--target-language", default="python", help="Render target language (default: python).")
    parser.add_argument(
        "--exercise-refs",
        default=None,
        help="Optional comma-separated exercise refs to render in explicit order.",
    )
    return parser.parse_args()


def load_ir(input_ir: Path) -> Dict[str, Any]:
    if not input_ir.exists():
        raise FileNotFoundError(f"IR file does not exist: {input_ir}")
    return json.loads(input_ir.read_text(encoding="utf-8"))


def normalize_lines(value: Any) -> List[str]:
    if value is None:
        return []
    if isinstance(value, str):
        return value.splitlines()
    if isinstance(value, list):
        out: List[str] = []
        for item in value:
            out.extend(str(item).splitlines())
        return out
    return [str(value)]


def stable_cell_id(seed: str) -> str:
    digest = hashlib.sha1(seed.encode("utf-8")).hexdigest()[:16]
    return f"cell-{digest}"


def validate_ir_structure(ir: Dict[str, Any]) -> None:
    schema_version = ir.get("schema_version")
    if schema_version not in SUPPORTED_SCHEMA_VERSIONS:
        raise RendererError(
            stage="validate-ir",
            chapter=None,
            block_id=None,
            code="E100",
            message=f"unsupported schema version '{schema_version}'",
            remediation=f"use one of: {', '.join(sorted(SUPPORTED_SCHEMA_VERSIONS))}",
        )

    required_top = ["chapter", "source", "exercises"]
    for field in required_top:
        if field not in ir:
            raise RendererError(
                stage="validate-ir",
                chapter=None,
                block_id=None,
                code="E101",
                message=f"missing required top-level field '{field}'",
                remediation="ensure canonical IR is passed to renderer",
            )

    exercises = ir.get("exercises")
    if not isinstance(exercises, list) or len(exercises) == 0:
        raise RendererError(
            stage="validate-ir",
            chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
            block_id=None,
            code="E102",
            message="IR has no exercises",
            remediation="provide IR generated from support.Rmd with exercise sections",
        )

    expected_ordinal = 1
    seen_refs = set()
    for ex in exercises:
        ex_ref = str(ex.get("exercise_ref", ""))
        if ex_ref in seen_refs:
            raise RendererError(
                stage="validate-ir",
                chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                block_id=None,
                code="E103",
                message=f"duplicate exercise_ref '{ex_ref}'",
                remediation="ensure IR exercises are unique by exercise_ref",
            )
        seen_refs.add(ex_ref)

        ordinal = ex.get("ordinal")
        if ordinal != expected_ordinal:
            raise RendererError(
                stage="validate-ir",
                chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                block_id=None,
                code="E104",
                message=f"exercise ordinal mismatch for {ex_ref}: expected {expected_ordinal}, got {ordinal}",
                remediation="ensure IR exercises are emitted in contiguous source order",
            )
        expected_ordinal += 1

        blocks = ex.get("blocks", [])
        expected_seq = 1
        for block in blocks:
            seq = block.get("sequence")
            if seq != expected_seq:
                raise RendererError(
                    stage="validate-ir",
                    chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                    block_id=str(block.get("block_id", "-")),
                    code="E105",
                    message=f"block sequence mismatch: expected {expected_seq}, got {seq}",
                    remediation="ensure IR block sequences are contiguous per exercise",
                )
            expected_seq += 1

            block_type = block.get("block_type")
            if block_type not in {"narrative", "code"}:
                raise RendererError(
                    stage="validate-ir",
                    chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                    block_id=str(block.get("block_id", "-")),
                    code="E106",
                    message=f"unsupported block_type '{block_type}'",
                    remediation="use canonical IR narrative/code block types",
                )


def get_authoring_context(block: Dict[str, Any]) -> Dict[str, Any]:
    ctx = block.get("authoring_context")
    if not isinstance(ctx, dict):
        return {
            "lang_scope": "shared",
            "mode": "base",
            "kind": "any",
            "requires": [],
        }
    return {
        "lang_scope": ctx.get("lang_scope", "shared"),
        "mode": ctx.get("mode", "base"),
        "kind": ctx.get("kind", "any"),
        "requires": ctx.get("requires", []),
        "override_target_block_id": ctx.get("override_target_block_id"),
    }


def resolve_blocks_for_language(
    exercise: Dict[str, Any], target_language: str, chapter: str
) -> List[Dict[str, Any]]:
    blocks = exercise.get("blocks", [])
    effective: List[Dict[str, Any]] = []
    shared_base_index: Dict[str, int] = {}
    override_targets_used = set()

    for block in blocks:
        if block.get("support_only") is True:
            continue

        ctx = get_authoring_context(block)
        mode = ctx.get("mode")
        lang_scope = ctx.get("lang_scope")
        block_id = str(block.get("block_id", ""))

        if mode == "base":
            if lang_scope != "shared":
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E200",
                    message="base block must use lang_scope=shared",
                    remediation="set authoring_context.lang_scope to shared for base blocks",
                )
            shared_base_index[block_id] = len(effective)
            effective.append(block)
            continue

        if mode == "only":
            if lang_scope == target_language:
                effective.append(block)
            continue

        if mode == "override":
            if lang_scope != target_language:
                continue

            target_id = ctx.get("override_target_block_id")
            if not target_id:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E201",
                    message="override block missing override_target_block_id",
                    remediation="ensure parser emits override target references",
                )

            if target_id in override_targets_used:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E202",
                    message=f"duplicate override for target block '{target_id}'",
                    remediation="keep only one override per target block and language",
                )

            if target_id not in shared_base_index:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E203",
                    message=f"override target '{target_id}' not found in shared base sequence",
                    remediation="ensure override targets a prior shared base block in same exercise",
                )

            target_pos = shared_base_index[target_id]
            target_block = effective[target_pos]
            if target_block.get("block_type") != block.get("block_type"):
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E204",
                    message="override block type does not match target block type",
                    remediation="use matching block types for override and target",
                )

            effective[target_pos] = block
            override_targets_used.add(target_id)
            continue

        raise RendererError(
            stage="resolve-overrides",
            chapter=chapter,
            block_id=block_id,
            code="E205",
            message=f"unsupported authoring mode '{mode}'",
            remediation="use one of: base, only, override",
        )

    return effective


def as_markdown_cell(source_lines: List[str], seed: str, traceability: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "cell_type": "markdown",
        "id": stable_cell_id(seed),
        "metadata": {
            "language": "markdown",
            "traceability": traceability,
        },
        "source": [f"{line}\n" for line in source_lines],
    }


def as_code_cell(source_lines: List[str], seed: str, traceability: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "cell_type": "code",
        "id": stable_cell_id(seed),
        "metadata": {
            "language": "python",
            "traceability": traceability,
        },
        "execution_count": None,
        "outputs": [],
        "source": [f"{line}\n" for line in source_lines],
    }


def to_traceability(exercise: Dict[str, Any], block: Optional[Dict[str, Any]]) -> Dict[str, Any]:
    base = {
        "exercise_id": exercise.get("exercise_id"),
        "exercise_ref": exercise.get("exercise_ref"),
    }
    if block is None:
        return base

    trace = block.get("traceability", {}) if isinstance(block.get("traceability"), dict) else {}
    base.update(
        {
            "block_id": block.get("block_id"),
            "source_file": trace.get("source_file"),
            "source_block_key": trace.get("source_block_key"),
            "source_span": block.get("source_span"),
        }
    )
    return base


def select_exercises(
    exercises: List[Dict[str, Any]],
    requested_refs: Optional[List[str]],
    chapter_number: str,
) -> List[Dict[str, Any]]:
    if not requested_refs:
        return exercises

    by_ref = {str(ex.get("exercise_ref")): ex for ex in exercises}
    selected: List[Dict[str, Any]] = []
    for ref in requested_refs:
        if ref not in by_ref:
            raise RendererError(
                stage="select-exercises",
                chapter=chapter_number,
                block_id=None,
                code="E120",
                message=f"requested exercise_ref '{ref}' not present in IR",
                remediation="align requested exercise refs with configured workshop track and IR contents",
            )
        selected.append(by_ref[ref])

    return selected


def render_notebook(
    ir: Dict[str, Any],
    target_language: str,
    exercise_refs: Optional[List[str]] = None,
) -> Dict[str, Any]:
    validate_ir_structure(ir)

    chapter_number = str(ir.get("chapter", {}).get("chapter_number", "-"))
    chapter_title = str(ir.get("chapter", {}).get("title", ""))

    cells: List[Dict[str, Any]] = []

    exercises = select_exercises(ir["exercises"], exercise_refs, chapter_number)

    for exercise in exercises:
        ex_ref = str(exercise.get("exercise_ref"))
        label = str(exercise.get("label") or f"Exercise {ex_ref}")
        heading_lines = [f"## {label}"]
        cells.append(
            as_markdown_cell(
                heading_lines,
                seed=f"exercise-heading:{ex_ref}",
                traceability=to_traceability(exercise, None),
            )
        )

        resolved_blocks = resolve_blocks_for_language(exercise, target_language=target_language, chapter=chapter_number)
        for block in resolved_blocks:
            block_id = str(block.get("block_id"))
            block_type = block.get("block_type")
            content = block.get("content", {}) if isinstance(block.get("content"), dict) else {}
            traceability = to_traceability(exercise, block)

            if block_type == "narrative":
                source_lines = normalize_lines(content.get("narrative_lines", []))
                cells.append(
                    as_markdown_cell(
                        source_lines,
                        seed=f"narrative:{ex_ref}:{block_id}",
                        traceability=traceability,
                    )
                )
            elif block_type == "code":
                source_lines = normalize_lines(content.get("code_lines", []))
                cells.append(
                    as_code_cell(
                        source_lines,
                        seed=f"code:{ex_ref}:{block_id}",
                        traceability=traceability,
                    )
                )
            else:
                raise RendererError(
                    stage="render-cells",
                    chapter=chapter_number,
                    block_id=block_id,
                    code="E300",
                    message=f"unsupported block type '{block_type}' during render",
                    remediation="use canonical narrative/code block types",
                )

    notebook = {
        "cells": cells,
        "metadata": {
            "ada_renderer": {
                "version": RENDERER_VERSION,
                "target_language": target_language,
                "ir_schema_version": ir.get("schema_version"),
                "chapter_id": ir.get("chapter", {}).get("chapter_id"),
                "chapter_number": ir.get("chapter", {}).get("chapter_number"),
                "chapter_title": chapter_title,
                "workshop_id": ir.get("chapter", {}).get("workshop_id"),
                "source_file": ir.get("source", {}).get("file_path"),
            },
            "kernelspec": {
                "display_name": "Python 3",
                "language": "python",
                "name": "python3",
            },
            "language_info": {
                "name": "python",
            },
        },
        "nbformat": 4,
        "nbformat_minor": 5,
    }

    return notebook


def write_notebook(notebook: Dict[str, Any], output_notebook: Path) -> None:
    output_notebook.parent.mkdir(parents=True, exist_ok=True)
    text = json.dumps(notebook, ensure_ascii=False, indent=2, sort_keys=True)
    output_notebook.write_text(text + "\n", encoding="utf-8")


def main() -> None:
    args = parse_args()

    input_ir = Path(args.input_ir)
    output_notebook = Path(args.output_notebook)

    ir = load_ir(input_ir)
    exercise_refs = None
    if args.exercise_refs:
        exercise_refs = [part.strip() for part in args.exercise_refs.split(",") if part.strip()]

    notebook = render_notebook(
        ir=ir,
        target_language=args.target_language,
        exercise_refs=exercise_refs,
    )
    write_notebook(notebook, output_notebook)


if __name__ == "__main__":
    main()
