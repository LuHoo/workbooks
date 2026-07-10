#!/usr/bin/env python3

import argparse
import json
import re
from pathlib import Path


class ExportValidationError(ValueError):
    def __init__(self, stage: str, notebook_path: Path, issue: str, remediation: str):
        message = (
            f"[{stage}] {notebook_path}: {issue}. "
            f"Remediation: {remediation}"
        )
        super().__init__(message)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Export a Python workshop notebook to a LaTeX snippet."
    )
    parser.add_argument("--input", required=True, help="Path to input .ipynb")
    parser.add_argument("--output", required=True, help="Path to output .tex")
    parser.add_argument(
        "--expect-generated-metadata",
        action="store_true",
        help="Require generated-notebook metadata. Use for IR-rendered notebooks.",
    )
    return parser.parse_args()


def escape_latex(text: str) -> str:
    text = text.replace("\\", r"\textbackslash{}")
    text = text.replace("%", r"\%")
    text = text.replace("&", r"\&")
    text = text.replace("_", r"\_")
    text = text.replace("#", r"\#")
    return text


def convert_inline(text: str) -> str:
    parts = []
    i = 0
    while i < len(text):
        if text[i] == "`":
            j = text.find("`", i + 1)
            if j == -1:
                parts.append(escape_latex(text[i:]))
                break
            parts.append(r"\ttblue{" + escape_latex(text[i + 1 : j]) + "}")
            i = j + 1
            continue
        if text[i] == "*":
            j = text.find("*", i + 1)
            if j == -1:
                parts.append(escape_latex(text[i:]))
                break
            parts.append(r"\emph{" + escape_latex(text[i + 1 : j]) + "}")
            i = j + 1
            continue
        j = i
        while j < len(text) and text[j] not in "`*":
            j += 1
        parts.append(escape_latex(text[i:j]))
        i = j
    return "".join(parts)


def normalize_source(source) -> list[str]:
    if isinstance(source, list):
        raw = "".join(source)
    else:
        raw = str(source)
    return raw.splitlines()


def render_markdown_cell(lines: list[str]) -> list[str]:
    out = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            out.append("")
            continue

        if stripped.startswith("### "):
            out.append(r"\subsubsection*{" + convert_inline(stripped[4:].strip()) + "}")
            continue

        if stripped.startswith("## "):
            title = stripped[3:].strip()
            m = re.match(r"Exercise\s+([0-9.]+)\s+(.*)", title)
            if m:
                out.append("")
                out.append(r"\begin{exercise}")
                out.append(r"\textbf{" + convert_inline(m.group(2).strip()) + "}")
                out.append("")
            else:
                out.append(r"\subsection*{" + convert_inline(title) + "}")
            continue

        if stripped.startswith("# "):
            out.append(r"\subsection*{" + convert_inline(stripped[2:].strip()) + "}")
            continue

        out.append(convert_inline(line))

    return out


def collect_output_text(outputs: list[dict]) -> list[str]:
    lines: list[str] = []
    for output in outputs:
        output_type = output.get("output_type", "")
        if output_type == "stream":
            text = output.get("text", "")
            text_lines = normalize_source(text)
            lines.extend(text_lines)
            continue

        if output_type in {"execute_result", "display_data"}:
            data = output.get("data", {})
            text_plain = data.get("text/plain", "")
            text_lines = normalize_source(text_plain)
            lines.extend(text_lines)
            continue

        if output_type == "error":
            lines.append(f"{output.get('ename', 'Error')}: {output.get('evalue', '')}".strip())
            for tb in output.get("traceback", []):
                lines.append(tb)

    while lines and not lines[-1].strip():
        lines.pop()
    return lines


def render_code_cell(source_lines: list[str], output_lines: list[str]) -> list[str]:
    out = [r"\begin{Verbatim}[commandchars=\\\{\}]"]
    for line in source_lines:
        if line.strip():
            out.append(r"\textcolor{KPMG_blue}{" + line + "}")
        else:
            out.append("")
    if output_lines:
        for line in output_lines:
            if line.strip():
                out.append(r"\textcolor{KPMG_light_blue}{" + line + "}")
            else:
                out.append("")
    out.append(r"\end{Verbatim}")
    return out


def load_notebook(input_path: Path) -> dict:
    try:
        return json.loads(input_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise ExportValidationError(
            stage="load-notebook",
            notebook_path=input_path,
            issue=f"invalid JSON ({exc.msg})",
            remediation="Regenerate the notebook and retry export.",
        ) from exc


def validate_notebook_shape(notebook: dict, input_path: Path) -> None:
    cells = notebook.get("cells")
    if not isinstance(cells, list):
        raise ExportValidationError(
            stage="validate-structure",
            notebook_path=input_path,
            issue="missing or invalid 'cells' array",
            remediation="Use a valid Jupyter notebook (nbformat v4) as input.",
        )


def metadata_export_context(
    notebook: dict,
    input_path: Path,
    expect_generated_metadata: bool,
) -> tuple[str, dict | None]:
    metadata = notebook.get("metadata")
    if not isinstance(metadata, dict):
        metadata = {}

    ada_renderer = metadata.get("ada_renderer")
    if not isinstance(ada_renderer, dict):
        ada_renderer = None

    if expect_generated_metadata:
        if ada_renderer is None:
            raise ExportValidationError(
                stage="validate-metadata",
                notebook_path=input_path,
                issue="missing metadata.ada_renderer",
                remediation=(
                    "Provide a generated notebook from scripts/export-python-notebooks.R "
                    "or run without --expect-generated-metadata for legacy notebooks."
                ),
            )

        required_fields = [
            "chapter_number",
            "workshop_id",
            "source_file",
            "target_language",
        ]
        missing = [field for field in required_fields if field not in ada_renderer]
        if missing:
            raise ExportValidationError(
                stage="validate-metadata",
                notebook_path=input_path,
                issue=f"missing required metadata.ada_renderer fields: {', '.join(missing)}",
                remediation="Regenerate the notebook via scripts/export-python-notebooks.R.",
            )

        if ada_renderer.get("target_language") != "python":
            raise ExportValidationError(
                stage="validate-metadata",
                notebook_path=input_path,
                issue=(
                    "metadata.ada_renderer.target_language is not 'python' "
                    f"(found: {ada_renderer.get('target_language')!r})"
                ),
                remediation="Export a Python-target notebook before running this exporter.",
            )

    source_ref = str(input_path)
    if ada_renderer is not None and isinstance(ada_renderer.get("source_file"), str):
        source_ref = ada_renderer["source_file"]

    return source_ref, ada_renderer


def export_notebook(input_path: Path, output_path: Path, expect_generated_metadata: bool) -> None:
    notebook = load_notebook(input_path)
    validate_notebook_shape(notebook, input_path)
    source_ref, ada_renderer = metadata_export_context(
        notebook,
        input_path,
        expect_generated_metadata,
    )

    tex_lines = [
        "% -----------------------------------------------------------------------------",
        f"% This file is automatically generated from {source_ref}.",
        "% Do not edit manually.",
        "% -----------------------------------------------------------------------------",
        "",
    ]

    if ada_renderer is not None:
        chapter = ada_renderer.get("chapter_number")
        workshop_id = ada_renderer.get("workshop_id")
        tex_lines.append(f"% Workshop: {workshop_id} (chapter {chapter})")
        tex_lines.append("")

    in_exercise = False

    for cell in notebook.get("cells", []):
        cell_type = cell.get("cell_type")
        source_lines = normalize_source(cell.get("source", []))

        if cell_type == "markdown":
            rendered = render_markdown_cell(source_lines)
            for line in rendered:
                if line == r"\begin{exercise}":
                    if in_exercise:
                        tex_lines.append(r"\end{exercise}")
                        tex_lines.append("")
                    in_exercise = True
                tex_lines.append(line)
            tex_lines.append("")
            continue

        if cell_type == "code":
            outputs = cell.get("outputs", [])
            output_lines = collect_output_text(outputs)
            if not source_lines and not output_lines:
                continue
            tex_lines.extend(render_code_cell(source_lines, output_lines))
            tex_lines.append("")

    if in_exercise:
        tex_lines.append(r"\end{exercise}")
        tex_lines.append("")

    while tex_lines and not tex_lines[-1].strip():
        tex_lines.pop()

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text("\n".join(tex_lines) + "\n", encoding="utf-8")


def main() -> None:
    args = parse_args()
    input_path = Path(args.input)
    output_path = Path(args.output)

    if not input_path.exists():
        raise FileNotFoundError(f"Input notebook does not exist: {input_path}")

    export_notebook(
        input_path,
        output_path,
        expect_generated_metadata=args.expect_generated_metadata,
    )


if __name__ == "__main__":
    main()
