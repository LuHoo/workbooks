#!/usr/bin/env python3

import argparse
import json
import os
import shlex
import shutil
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path


SCHEMA_VERSION = "1.0.0"
REPO_ROOT = Path(__file__).resolve().parents[2]


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def relpath_or_abs(path: Path) -> str:
    try:
        return str(path.relative_to(REPO_ROOT))
    except ValueError:
        return str(path)


def default_python_bin() -> str:
    venv_python = REPO_ROOT / ".venv" / "bin" / "python"
    if venv_python.exists():
        return str(venv_python)
    return sys.executable


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run the canonical local notebook validation pipeline and emit a unified machine-readable report."
    )
    parser.add_argument(
        "--input-dir",
        default="generated/python-notebooks",
        help="Directory where canonical generated Python notebooks are written for validation.",
    )
    parser.add_argument(
        "--published-dir",
        default="notebooks/workshops",
        help="Published notebook directory used for publication-readiness checks.",
    )
    parser.add_argument(
        "--metadata-dir",
        default="metadata/traceability",
        help="Traceability metadata directory used for parity validation.",
    )
    parser.add_argument(
        "--artifacts-dir",
        default="generated/notebook-execution-artifacts",
        help="Directory for notebook execution artifacts.",
    )
    parser.add_argument(
        "--report-json",
        default="generated/validation/local-validation-report.json",
        help="Output path for the combined machine-readable validation report.",
    )
    parser.add_argument(
        "--logs-dir",
        default="generated/validation/logs",
        help="Directory where per-stage logs are written.",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=600,
        help="Per-cell timeout in seconds for generated Python notebook execution.",
    )
    parser.add_argument(
        "--python-bin",
        default=default_python_bin(),
        help="Python interpreter used for Python-based validators (defaults to .venv/bin/python when available).",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Emit the planned validation report structure without executing validators.",
    )
    return parser.parse_args()


def ensure_parent_dir(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)


def write_report(report: dict, report_path: Path) -> None:
    ensure_parent_dir(report_path)
    report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")


def stage_template(name: str, message: str) -> dict:
    return {
        "name": name,
        "status": "not-run",
        "duration_seconds": 0.0,
        "exit_code": None,
        "message": message,
        "started_at": None,
        "completed_at": None,
        "artifacts": {},
        "substeps": [],
    }


def command_preview(cmd: list[str]) -> str:
    return " ".join(shlex.quote(part) for part in cmd)


def run_substep(cmd: list[str], log_path: Path, dry_run: bool) -> tuple[dict, int]:
    started_at = utc_now()
    started_monotonic = time.monotonic()
    preview = command_preview(cmd)

    substep = {
        "name": log_path.stem,
        "command": preview,
        "status": "not-run",
        "duration_seconds": 0.0,
        "exit_code": None,
        "log_path": relpath_or_abs(log_path),
        "started_at": started_at,
        "completed_at": None,
    }

    ensure_parent_dir(log_path)

    if dry_run:
        substep["status"] = "skipped"
        substep["completed_at"] = utc_now()
        substep["message"] = "Dry run: command not executed."
        log_path.write_text("[dry-run] " + preview + "\n", encoding="utf-8")
        return substep, 0

    proc = subprocess.run(
        cmd,
        cwd=REPO_ROOT,
        text=True,
        capture_output=True,
        check=False,
    )

    combined_output = []
    combined_output.append(f"$ {preview}")
    if proc.stdout:
        combined_output.append(proc.stdout.rstrip())
    if proc.stderr:
        combined_output.append(proc.stderr.rstrip())
    log_path.write_text("\n".join(combined_output).rstrip() + "\n", encoding="utf-8")

    if proc.stdout:
        print(proc.stdout, end="")
    if proc.stderr:
        print(proc.stderr, end="", file=sys.stderr)

    substep["duration_seconds"] = round(time.monotonic() - started_monotonic, 3)
    substep["exit_code"] = proc.returncode
    substep["completed_at"] = utc_now()
    substep["status"] = "passed" if proc.returncode == 0 else "failed"
    return substep, proc.returncode


def build_stages(args: argparse.Namespace, report_path: Path, logs_dir: Path) -> list[dict]:
    parity_json = report_path.parent / "parity-traceability-report.json"
    parity_summary = report_path.parent / "parity-traceability-summary.txt"
    execution_report = Path(args.artifacts_dir) / "python-notebook-execution-report.json"

    return [
        {
            "name": "generation_validation",
            "message": "Verify deterministic generation and regenerate canonical Python notebooks for downstream validation.",
            "artifacts": {
                "generated_notebooks_dir": args.input_dir,
            },
            "substeps": [
                {
                    "label": "deterministic-generation",
                    "cmd": [
                        "bash",
                        "scripts/ci/verify-deterministic-notebook-generation.sh",
                    ],
                },
                {
                    "label": "generate-python-notebooks",
                    "cmd": [
                        "Rscript",
                        "scripts/export-python-notebooks.R",
                        "--output-dir",
                        args.input_dir,
                    ],
                },
            ],
        },
        {
            "name": "notebook_hygiene",
            "message": "Reject generated Python notebooks with execution artifacts or raw R-only constructs.",
            "artifacts": {},
            "substeps": [
                {
                    "label": "strict-hygiene",
                    "cmd": [
                        args.python_bin,
                        "scripts/ci/check-generated-python-notebooks.py",
                        "--input-dir",
                        args.input_dir,
                    ],
                },
            ],
        },
        {
            "name": "parity_validation",
            "message": "Validate exercise parity, LO mappings, and FSAudit coverage against generated notebooks.",
            "artifacts": {
                "report_json": relpath_or_abs(parity_json),
                "summary_txt": relpath_or_abs(parity_summary),
            },
            "substeps": [
                {
                    "label": "parity-and-traceability",
                    "cmd": [
                        "Rscript",
                        "scripts/ci/validate-parity-and-traceability.R",
                        "--notebooks-dir",
                        args.input_dir,
                        "--metadata-dir",
                        args.metadata_dir,
                        "--output-json",
                        str(parity_json),
                        "--output-summary",
                        str(parity_summary),
                    ],
                },
            ],
        },
        {
            "name": "notebook_execution",
            "message": "Run numeric equivalence checks plus representative R and generated Python notebook execution.",
            "artifacts": {
                "artifacts_dir": args.artifacts_dir,
                "python_execution_report": relpath_or_abs(execution_report),
            },
            "substeps": [
                {
                    "label": "equivalence-phase-1",
                    "cmd": [
                        args.python_bin,
                        "scripts/ci/assert-r-python-equivalence.py",
                        "--chapters",
                        "1,6",
                    ],
                },
                {
                    "label": "equivalence-phase-2",
                    "cmd": [
                        args.python_bin,
                        "scripts/ci/assert-r-python-equivalence.py",
                        "--chapters",
                        "1,2,3,4,5,6",
                    ],
                },
                {
                    "label": "r-workshop-smoke",
                    "cmd": [
                        "Rscript",
                        "scripts/ci/execute-r-workshop-smoke.R",
                        "--policy",
                        "deterministic-sampling-v2",
                    ],
                },
                {
                    "label": "execute-generated-python-notebooks",
                    "cmd": [
                        args.python_bin,
                        "scripts/ci/execute-generated-python-notebooks.py",
                        "--input-dir",
                        args.input_dir,
                        "--artifacts-dir",
                        args.artifacts_dir,
                        "--timeout",
                        str(args.timeout),
                    ],
                },
            ],
        },
        {
            "name": "publication_readiness",
            "message": "Verify published Python notebooks match canonical generated outputs and remain publication-safe.",
            "artifacts": {
                "published_dir": args.published_dir,
            },
            "substeps": [
                {
                    "label": "publication-artifact-policy",
                    "cmd": [
                        args.python_bin,
                        "scripts/ci/check-generated-python-notebooks.py",
                        "--input-dir",
                        args.input_dir,
                        "--checks",
                        "hygiene",
                        "--published-dir",
                        args.published_dir,
                    ],
                },
            ],
        },
    ]


def main() -> int:
    args = parse_args()
    os.chdir(REPO_ROOT)

    report_path = Path(args.report_json)
    logs_dir = Path(args.logs_dir)
    logs_dir.mkdir(parents=True, exist_ok=True)
    Path(args.artifacts_dir).mkdir(parents=True, exist_ok=True)

    report = {
        "schema_version": SCHEMA_VERSION,
        "validation_run": {
            "status": "running",
            "started_at": utc_now(),
            "completed_at": None,
            "duration_seconds": 0.0,
            "entrypoint": "scripts/ci/run-local-validation.py",
            "report_path": relpath_or_abs(report_path),
            "repo_root": str(REPO_ROOT),
        },
        "stages": [],
    }
    write_report(report, report_path)

    started_monotonic = time.monotonic()
    stages = build_stages(args, report_path, logs_dir)
    failed_stage = None

    for index, stage_spec in enumerate(stages, start=1):
        stage = stage_template(stage_spec["name"], stage_spec["message"])
        stage["started_at"] = utc_now()
        stage_start = time.monotonic()
        stage["artifacts"] = stage_spec.get("artifacts", {})

        exit_code = 0
        for substep_spec in stage_spec["substeps"]:
          log_path = logs_dir / f"{index:02d}-{substep_spec['label']}.log"
          substep, substep_exit = run_substep(substep_spec["cmd"], log_path, args.dry_run)
          stage["substeps"].append(substep)
          if substep_exit != 0:
            exit_code = substep_exit
            break

        stage["duration_seconds"] = round(time.monotonic() - stage_start, 3)
        stage["completed_at"] = utc_now()
        if args.dry_run:
            stage["status"] = "skipped"
            stage["exit_code"] = 0
            stage["message"] = "Dry run: validation plan recorded without executing validators."
        elif exit_code == 0:
            stage["status"] = "passed"
            stage["exit_code"] = 0
        else:
            stage["status"] = "failed"
            stage["exit_code"] = exit_code
            failed_stage = stage["name"]

        report["stages"].append(stage)
        write_report(report, report_path)

        if failed_stage is not None:
            break

    if failed_stage is not None:
        remaining_specs = stages[len(report["stages"]):]
        for stage_spec in remaining_specs:
            skipped = stage_template(stage_spec["name"], f"Skipped because '{failed_stage}' failed.")
            skipped["status"] = "skipped"
            skipped["completed_at"] = utc_now()
            skipped["artifacts"] = stage_spec.get("artifacts", {})
            report["stages"].append(skipped)

    report["validation_run"]["completed_at"] = utc_now()
    report["validation_run"]["duration_seconds"] = round(time.monotonic() - started_monotonic, 3)
    if args.dry_run:
        report["validation_run"]["status"] = "skipped"
    elif failed_stage is not None:
        report["validation_run"]["status"] = "failed"
    else:
        report["validation_run"]["status"] = "passed"
    write_report(report, report_path)

    if args.dry_run:
        print(f"Dry run complete. Planned validation report written to {relpath_or_abs(report_path)}")
        return 0

    if failed_stage is not None:
        print(f"Local validation failed at stage '{failed_stage}'. Combined report: {relpath_or_abs(report_path)}")
        return 1

    print(f"Local validation passed. Combined report: {relpath_or_abs(report_path)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())