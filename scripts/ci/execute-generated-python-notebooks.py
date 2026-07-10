#!/usr/bin/env python3

import argparse
import json
import os
import platform
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

import nbformat
from nbclient import NotebookClient
from nbclient.exceptions import CellExecutionError


@dataclass
class NotebookFailure:
    notebook_path: str
    failing_cell_number: int | None
    failing_cell_source: str | None
    traceback: str
    remediation: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Execute generated Python notebooks with actionable diagnostics."
    )
    parser.add_argument(
        "--input-dir",
        required=True,
        help="Directory containing generated Python notebooks.",
    )
    parser.add_argument(
        "--artifacts-dir",
        default="generated/notebook-execution-artifacts",
        help="Directory where execution logs and executed notebooks are written.",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=600,
        help="Per-cell timeout in seconds.",
    )
    return parser.parse_args()


def runtime_details() -> dict:
    def run(cmd: list[str]) -> str:
        proc = subprocess.run(cmd, check=False, capture_output=True, text=True)
        return (proc.stdout or proc.stderr).strip()

    details = {
        "python_version": sys.version,
        "platform": platform.platform(),
        "cwd": os.getcwd(),
        "r_version": run(["R", "--version"]).splitlines()[0] if shutil_which("R") else "R not found",
        "fsaudit_version": run(["Rscript", "-e", "cat(as.character(packageVersion('FSaudit')))"]) if shutil_which("Rscript") else "Rscript not found",
        "rpy2_version": run([sys.executable, "-c", "import rpy2; print(rpy2.__version__)"]),
    }
    return details


def shutil_which(name: str) -> bool:
    return subprocess.run(["bash", "-lc", f"command -v {name}"], check=False, capture_output=True).returncode == 0


def find_error_cell(notebook) -> tuple[int | None, str | None, str]:
    for idx, cell in enumerate(notebook.cells, start=1):
        if cell.get("cell_type") != "code":
            continue
        for output in cell.get("outputs", []):
            if output.get("output_type") == "error":
                traceback = "\n".join(output.get("traceback", []))
                source = "".join(cell.get("source", []))
                return idx, source.strip()[:1000], traceback.strip()
    return None, None, "No error output captured"


def execute_notebook(path: Path, artifacts_dir: Path, timeout: int) -> NotebookFailure | None:
    with path.open("r", encoding="utf-8") as handle:
        notebook = nbformat.read(handle, as_version=4)

    client = NotebookClient(
        notebook,
        timeout=timeout,
        kernel_name="python3",
        resources={"metadata": {"path": str(Path.cwd())}},
    )

    try:
        client.execute()
    except CellExecutionError:
        cell_no, cell_source, traceback = find_error_cell(notebook)
        return NotebookFailure(
            notebook_path=str(path),
            failing_cell_number=cell_no,
            failing_cell_source=cell_source,
            traceback=traceback,
            remediation=(
                "Inspect the failing cell and ensure the Binder/CI environment includes all "
                "bridge dependencies (FSaudit, rpy2, R packages) and required datasets."
            ),
        )
    finally:
        output_path = artifacts_dir / "executed" / path.name
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with output_path.open("w", encoding="utf-8") as handle:
            nbformat.write(notebook, handle)

    return None


def main() -> None:
    args = parse_args()
    input_dir = Path(args.input_dir)
    artifacts_dir = Path(args.artifacts_dir)
    artifacts_dir.mkdir(parents=True, exist_ok=True)

    notebooks = sorted(input_dir.rglob("*.ipynb"))
    if not notebooks:
        raise FileNotFoundError(
            f"No notebooks found under {input_dir}. Remediation: run scripts/export-python-notebooks.R first."
        )

    report = {
        "runtime": runtime_details(),
        "executed": [],
        "failures": [],
    }

    failures: list[NotebookFailure] = []
    for notebook_path in notebooks:
        print(f"Executing {notebook_path}")
        failure = execute_notebook(notebook_path, artifacts_dir, args.timeout)
        report["executed"].append(str(notebook_path))
        if failure is not None:
            failures.append(failure)
            report["failures"].append(failure.__dict__)

    report_path = artifacts_dir / "python-notebook-execution-report.json"
    report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")

    if failures:
        print("Notebook execution failed. Diagnostics:")
        print(json.dumps(report["runtime"], indent=2))
        for failure in failures:
            print("---")
            print(f"Notebook path: {failure.notebook_path}")
            print(f"Failing cell: {failure.failing_cell_number}")
            print("Failing source:")
            print(failure.failing_cell_source or "<unknown>")
            print("Stack trace:")
            print(failure.traceback or "<no traceback>")
            print("Remediation:")
            print(failure.remediation)
        raise SystemExit(1)

    print("All generated Python notebooks executed successfully")


if __name__ == "__main__":
    main()
