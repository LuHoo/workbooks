#!/usr/bin/env bash
set -euo pipefail

INPUT_DIR="generated/python-notebooks"
ARTIFACTS_DIR="generated/notebook-execution-artifacts"
TIMEOUT_SECONDS="600"
PUBLISHED_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --input-dir)
      INPUT_DIR="$2"
      shift 2
      ;;
    --artifacts-dir)
      ARTIFACTS_DIR="$2"
      shift 2
      ;;
    --timeout)
      TIMEOUT_SECONDS="$2"
      shift 2
      ;;
    --published-dir)
      PUBLISHED_DIR="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      echo "Usage: $0 [--input-dir <dir>] [--artifacts-dir <dir>] [--timeout <seconds>] [--published-dir <dir>]" >&2
      exit 2
      ;;
  esac
done

echo "[shared-validation] Enforcing strict Python output guardrail"
python3 scripts/ci/check-generated-python-notebooks.py \
  --input-dir "$INPUT_DIR"

if [[ -n "$PUBLISHED_DIR" ]]; then
  echo "[shared-validation] Enforcing generated notebook artifact edit policy"
  python3 scripts/ci/check-generated-python-notebooks.py \
    --input-dir "$INPUT_DIR" \
    --checks hygiene \
    --published-dir "$PUBLISHED_DIR"
fi

echo "[shared-validation] Running R/Python equivalence checks (phase 1)"
python3 scripts/ci/assert-r-python-equivalence.py \
  --chapters 1,6

echo "[shared-validation] Running R/Python equivalence checks (phase 2)"
python3 scripts/ci/assert-r-python-equivalence.py \
  --chapters 1,2,3,4,5,6

echo "[shared-validation] Executing representative R workshops"
Rscript scripts/ci/execute-r-workshop-smoke.R

echo "[shared-validation] Executing generated Python notebooks"
python3 scripts/ci/execute-generated-python-notebooks.py \
  --input-dir "$INPUT_DIR" \
  --artifacts-dir "$ARTIFACTS_DIR" \
  --timeout "$TIMEOUT_SECONDS"
