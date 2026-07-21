#!/usr/bin/env python3

import argparse
import json
import re
import textwrap
from pathlib import Path


MAX_TEX_PROSE_LINE_LENGTH = 59
MAX_TEX_VERBATIM_LINE_LENGTH = 59


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
    parser.add_argument("--output", help="Path to output .tex")
    parser.add_argument(
        "--chunk-output-dir",
        help=(
            "Directory for per-exercise chunk TeX output "
            "(exercise-<chapter>-<exercise>-<chunk>.tex)."
        ),
    )
    parser.add_argument(
        "--expected-chunks",
        help=(
            "Comma-separated exercise chunk counts, for example "
            "'1.1:3,1.2:1'. Required with --chunk-output-dir."
        ),
    )
    parser.add_argument(
        "--fallback-output-dir",
        help=(
            "Optional directory with existing workshop chunk files to reuse "
            "light-blue output blocks when notebook cells have no outputs."
        ),
    )
    parser.add_argument(
        "--expect-generated-metadata",
        action="store_true",
        help="Require generated-notebook metadata. Use for IR-rendered notebooks.",
    )
    args = parser.parse_args()

    if not args.output and not args.chunk_output_dir:
        parser.error("Provide either --output or --chunk-output-dir.")
    if args.chunk_output_dir and not args.expected_chunks:
        parser.error("--expected-chunks is required with --chunk-output-dir.")
    return args


def escape_latex(text: str) -> str:
    text = re.sub(r"(?<!\\)%", r"\\%", text)
    text = re.sub(r"(?<!\\)&", r"\\&", text)
    text = re.sub(r"(?<!\\)_", r"\\_", text)
    text = re.sub(r"(?<!\\)#", r"\\#", text)
    return text


def escape_latex_code(text: str) -> str:
    backslash_token = "LATEXBACKSLASHTOKEN"
    text = text.replace("\\", backslash_token)
    text = text.replace("{", r"\{")
    text = text.replace("}", r"\}")
    text = text.replace("$", r"\$")
    text = escape_latex(text)
    return text.replace(backslash_token, r"\textbackslash{}")


def convert_inline(text: str) -> str:
    token_re = re.compile(r"`[^`]*`|\$[^$]*\$|\\\([^)]*\\\)|\\\[[^]]*\\\]|\*[^*]+\*")
    parts = []
    cursor = 0

    for match in token_re.finditer(text):
        start, end = match.span()
        if start > cursor:
            parts.append(escape_latex(text[cursor:start]))
        token = text[start:end]
        if token.startswith("`"):
            parts.append(r"\ttblue{" + escape_latex(token[1:-1]) + "}")
        elif token.startswith("$") or token.startswith(r"\(") or token.startswith(r"\["):
            parts.append(token)
        else:
            parts.append(r"\emph{" + escape_latex(token[1:-1]) + "}")
        cursor = end

    if cursor < len(text):
        parts.append(escape_latex(text[cursor:]))

    return "".join(parts)


def normalize_source(source) -> list[str]:
    if isinstance(source, list):
        raw = "".join(source)
    else:
        raw = str(source)
    return raw.splitlines()


def wrap_latex_prose_line(text: str, max_length: int = MAX_TEX_PROSE_LINE_LENGTH) -> list[str]:
    stripped = text.strip()
    if len(stripped) <= max_length:
        return [stripped]

    words = stripped.split()
    if not words:
        return [""]


    wrapped: list[str] = []
    current = words[0]
    for word in words[1:]:
        candidate = current + " " + word
        if len(candidate) <= max_length:
            current = candidate
        else:
            wrapped.append(current)
            current = word
    wrapped.append(current)
    return wrapped


def wrap_latex_prose_with_optional_prefix(
    text: str,
    prefix: str,
    max_length: int = MAX_TEX_PROSE_LINE_LENGTH,
) -> list[str]:
    effective_first_line_max = max(20, max_length - len(prefix))
    wrapped = wrap_latex_prose_line(text, max_length=effective_first_line_max)
    if not wrapped:
        return [prefix.rstrip()]

    wrapped[0] = prefix + wrapped[0]
    for idx in range(1, len(wrapped)):
        if len(wrapped[idx]) > max_length:
            secondary = wrap_latex_prose_line(wrapped[idx], max_length=max_length)
            wrapped[idx:idx + 1] = secondary
    return wrapped


def wrap_verbatim_line(text: str, max_length: int = MAX_TEX_VERBATIM_LINE_LENGTH) -> list[str]:
    if len(text) <= max_length:
        return [text]
    wrapped = textwrap.wrap(
        text,
        width=max_length,
        break_long_words=True,
        break_on_hyphens=False,
        replace_whitespace=False,
        drop_whitespace=False,
    )
    candidates = wrapped if wrapped else [text]

    # Final safeguard: never emit a segment longer than the configured limit.
    clamped: list[str] = []
    for segment in candidates:
        if len(segment) <= max_length:
            clamped.append(segment)
            continue
        start = 0
        while start < len(segment):
            clamped.append(segment[start : start + max_length])
            start += max_length
    return clamped


def render_markdown_cell(lines: list[str]) -> list[str]:
    out = []
    paragraph_start = True
    for line in lines:
        stripped = line.strip()
        if not stripped:
            out.append("")
            paragraph_start = True
            continue

        if stripped.startswith("### "):
            out.append(r"\subsubsection*{" + convert_inline(stripped[4:].strip()) + "}")
            paragraph_start = True
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
            paragraph_start = True
            continue

        if stripped.startswith("# "):
            out.append(r"\subsection*{" + convert_inline(stripped[2:].strip()) + "}")
            paragraph_start = True
            continue

        prefix = r"\noindent " if paragraph_start else ""
        out.extend(wrap_latex_prose_with_optional_prefix(convert_inline(line), prefix=prefix))
        paragraph_start = False

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


def _leading_spaces(line: str) -> int:
    return len(line) - len(line.lstrip(" "))


def strip_internal_workflow_lines(source_lines: list[str]) -> list[str]:
    filtered: list[str] = []
    skipping_set_context_def = False
    def_indent = 0

    for line in source_lines:
        stripped = line.strip()

        # Internal context sync helper should not be shown to students.
        if not skipping_set_context_def and re.match(r"^\s*def\s+ada_set_context\s*\(", line):
            skipping_set_context_def = True
            def_indent = _leading_spaces(line)
            continue

        if skipping_set_context_def:
            if not stripped:
                continue
            current_indent = _leading_spaces(line)
            if current_indent > def_indent:
                continue
            skipping_set_context_def = False

        # Context calls are workflow-internal and should not appear in book output.
        if re.match(r"^\s*ada_set_context\s*\(.*\)\s*;?\s*$", line):
            continue

        filtered.append(line)

    return filtered


def render_code_cell(source_lines: list[str], output_lines: list[str]) -> list[str]:
    source_lines = strip_internal_workflow_lines(source_lines)
    out = [r"\begin{Verbatim}[commandchars=\\\{\}]"]
    for line in source_lines:
        escaped_line = escape_latex_code(line)
        for wrapped_line in wrap_verbatim_line(escaped_line):
            if wrapped_line.strip():
                out.append(r"\textcolor{ada_blue}{" + wrapped_line + "}")
            else:
                out.append("")
    if output_lines:
        for line in output_lines:
            escaped_line = escape_latex_code(line)
            for wrapped_line in wrap_verbatim_line(escaped_line):
                if wrapped_line.strip():
                    out.append(r"\textcolor{ada_light_blue}{" + wrapped_line + "}")
                else:
                    out.append("")
    out.append(r"\end{Verbatim}")
    return out


def parse_expected_chunks(spec: str) -> dict[str, int]:
    parsed: dict[str, int] = {}
    for entry in spec.split(","):
        item = entry.strip()
        if not item:
            continue
        if ":" not in item:
            raise ValueError(
                f"Invalid --expected-chunks entry '{item}'. Expected format <exercise>:<count>."
            )
        exercise_ref, count_text = item.split(":", 1)
        exercise_ref = exercise_ref.strip()
        count_text = count_text.strip()
        if not exercise_ref or not count_text:
            raise ValueError(
                f"Invalid --expected-chunks entry '{item}'. Expected format <exercise>:<count>."
            )
        count = int(count_text)
        if count < 1:
            raise ValueError(f"Expected chunk count must be >= 1 for exercise '{exercise_ref}'.")
        parsed[exercise_ref] = count
    if not parsed:
        raise ValueError("--expected-chunks produced no exercise entries.")
    return parsed


def split_exercise_heading(lines: list[str]) -> tuple[str, str, list[str]] | None:
    for idx, line in enumerate(lines):
        stripped = line.strip()
        if not stripped:
            continue
        match = re.match(r"^##\s+Exercise\s+([0-9]+\.[0-9]+)(?:\.|\s+)(.*)$", stripped)
        if not match:
            return None
        exercise_ref = match.group(1)
        title = match.group(2).strip()
        remaining = lines[idx + 1 :]
        return exercise_ref, title, remaining
    return None


def markdown_lines_to_workshop_latex(lines: list[str]) -> list[str]:
    out: list[str] = []
    in_display_math = False
    paragraph_start = True
    for line in lines:
        stripped = line.strip()
        if stripped in {"$$", r"\[", r"\]"}:
            out.append(line)
            in_display_math = not in_display_math
            if not in_display_math:
                paragraph_start = True
            continue
        if in_display_math:
            out.append(line)
            continue
        if not stripped:
            out.append("")
            paragraph_start = True
            continue
        prefix = r"\noindent " if paragraph_start else ""
        out.extend(wrap_latex_prose_with_optional_prefix(convert_inline(line), prefix=prefix))
        paragraph_start = False
    return out


def render_verbatim_block(lines: list[str], color: str) -> list[str]:
    if not lines:
        return []
    out = [rf"\begin{{Verbatim}}[breaklines=true,formatcom=\color{{{color}}}]"]
    for line in lines:
        out.extend(wrap_verbatim_line(line))
    out.append(r"\end{Verbatim}")
    return out


def collect_fallback_output_lines(chunk_tex_path: Path) -> list[str]:
    if not chunk_tex_path.exists():
        return []

    lines = chunk_tex_path.read_text(encoding="utf-8").splitlines()
    output_blocks: list[list[str]] = []
    in_output = False
    current: list[str] = []

    for line in lines:
        if line.startswith(r"\begin{Verbatim}") and "ada_light_blue" in line:
            in_output = True
            current = []
            continue
        if in_output and line.strip() == r"\end{Verbatim}":
            output_blocks.append(current)
            in_output = False
            current = []
            continue
        if in_output:
            current.append(line)

    flattened: list[str] = []
    for block in output_blocks:
        if flattened and block:
            flattened.append("")
        flattened.extend(block)
    while flattened and not flattened[-1].strip():
        flattened.pop()
    return flattened


def finalize_exercise(exercise: dict | None) -> None:
    if exercise is None:
        return
    chunks = exercise["chunks"]
    pending = exercise["pending_prose"]
    if chunks:
        chunks[-1]["prose_after"] = pending


def collect_exercise_chunks(notebook: dict) -> dict[str, list[dict]]:
    exercises: dict[str, list[dict]] = {}
    current: dict | None = None

    for cell in notebook.get("cells", []):
        cell_type = cell.get("cell_type")
        source_lines = normalize_source(cell.get("source", []))

        if cell_type == "markdown":
            heading = split_exercise_heading(source_lines)
            if heading is not None:
                finalize_exercise(current)
                exercise_ref, _title, remaining_lines = heading
                current = {
                    "exercise_ref": exercise_ref,
                    "chunks": [],
                    "pending_prose": markdown_lines_to_workshop_latex(remaining_lines),
                }
                exercises[exercise_ref] = current["chunks"]
                continue

            if current is not None:
                current["pending_prose"].extend(markdown_lines_to_workshop_latex(source_lines))
            continue

        if cell_type != "code" or current is None:
            continue

        code_lines = strip_internal_workflow_lines(source_lines)
        chunk = {
            "source": code_lines,
            "output": collect_output_text(cell.get("outputs", [])),
            "prose_before": current["pending_prose"],
            "prose_after": [],
        }
        current["chunks"].append(chunk)
        current["pending_prose"] = []

    finalize_exercise(current)
    return exercises


def compose_chunk_tex(source_ref: str, prose_before: list[str], body_blocks: list[str], prose_after: list[str]) -> list[str]:
    header = [
        "% -----------------------------------------------------------------------------",
        "% This file is automatically generated.",
        "% Do not edit manually.",
        f"% Source: {source_ref}",
        "% -----------------------------------------------------------------------------",
        "",
        "",
    ]
    compact_wrapper = [
        r"\par\addvspace{\topsep}",
        r"\begingroup",
        r"\fvset{listparameters={%",
        r"  \setlength{\topsep}{0pt}%",
        r"  \setlength{\partopsep}{0pt}%",
        r"  \setlength{\parsep}{0pt}%",
        r"  \setlength{\itemsep}{0pt}%",
        r"}}",
    ]
    compact_wrapper.extend(body_blocks)
    compact_wrapper.extend([
        r"\endgroup",
        r"\par\addvspace{\topsep}",
    ])

    generated = header + prose_before + [""] + compact_wrapper + prose_after
    while generated and not generated[-1].strip():
        generated.pop()
    return generated


def chunk_output_path(chunk_output_dir: Path, exercise_ref: str, chunk_index: int) -> Path:
    exercise_slug = exercise_ref.replace(".", "-")
    return chunk_output_dir / f"exercise-{exercise_slug}-{chunk_index}.tex"


def export_notebook_chunks(
    input_path: Path,
    chunk_output_dir: Path,
    expected_chunks: dict[str, int],
    fallback_output_dir: Path | None,
    expect_generated_metadata: bool,
) -> None:
    notebook = load_notebook(input_path)
    validate_notebook_shape(notebook, input_path)
    source_ref, _ada_renderer = metadata_export_context(
        notebook,
        input_path,
        expect_generated_metadata,
    )

    chunks_by_exercise = collect_exercise_chunks(notebook)

    for exercise_ref, expected_count in expected_chunks.items():
        actual_chunks = chunks_by_exercise.get(exercise_ref, [])
        if len(actual_chunks) != expected_count:
            raise ExportValidationError(
                stage="validate-chunks",
                notebook_path=input_path,
                issue=(
                    f"exercise {exercise_ref} has {len(actual_chunks)} code chunks; "
                    f"expected {expected_count}"
                ),
                remediation="Regenerate notebook and verify exercise/chunk mapping metadata and directives.",
            )

        for idx, chunk in enumerate(actual_chunks, start=1):
            output_lines = chunk["output"]
            if not output_lines and fallback_output_dir is not None:
                fallback_path = chunk_output_path(fallback_output_dir, exercise_ref, idx)
                output_lines = collect_fallback_output_lines(fallback_path)

            body = []
            body.extend(render_verbatim_block(chunk["source"], "ada_blue"))
            if output_lines:
                body.extend(render_verbatim_block(output_lines, "ada_light_blue"))

            output_lines_tex = compose_chunk_tex(
                source_ref=source_ref,
                prose_before=chunk["prose_before"],
                body_blocks=body,
                prose_after=chunk["prose_after"],
            )
            output_path = chunk_output_path(chunk_output_dir, exercise_ref, idx)
            output_path.parent.mkdir(parents=True, exist_ok=True)
            output_path.write_text("\n".join(output_lines_tex) + "\n", encoding="utf-8")


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


def export_notebook(
    input_path: Path,
    output_path: Path,
    expect_generated_metadata: bool,
    fallback_output_dir: Path | None,
) -> None:
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
    current_exercise_ref: str | None = None
    current_chunk_index = 0

    for cell in notebook.get("cells", []):
        cell_type = cell.get("cell_type")
        source_lines = normalize_source(cell.get("source", []))

        if cell_type == "markdown":
            heading = split_exercise_heading(source_lines)
            if heading is not None:
                current_exercise_ref = heading[0]
                current_chunk_index = 0
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
            if not output_lines and fallback_output_dir is not None and current_exercise_ref is not None:
                current_chunk_index += 1
                fallback_path = chunk_output_path(fallback_output_dir, current_exercise_ref, current_chunk_index)
                output_lines = collect_fallback_output_lines(fallback_path)
            elif current_exercise_ref is not None:
                current_chunk_index += 1
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

    if not input_path.exists():
        raise FileNotFoundError(f"Input notebook does not exist: {input_path}")

    if args.output:
        output_path = Path(args.output)
        fallback_dir = Path(args.fallback_output_dir) if args.fallback_output_dir else None
        export_notebook(
            input_path,
            output_path,
            expect_generated_metadata=args.expect_generated_metadata,
            fallback_output_dir=fallback_dir,
        )

    if args.chunk_output_dir:
        expected_chunks = parse_expected_chunks(args.expected_chunks)
        fallback_dir = Path(args.fallback_output_dir) if args.fallback_output_dir else None
        export_notebook_chunks(
            input_path=input_path,
            chunk_output_dir=Path(args.chunk_output_dir),
            expected_chunks=expected_chunks,
            fallback_output_dir=fallback_dir,
            expect_generated_metadata=args.expect_generated_metadata,
        )


if __name__ == "__main__":
    main()
