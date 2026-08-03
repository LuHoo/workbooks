#!/usr/bin/env bash
set -euo pipefail

# Fast local mirror of the failure-prone Notebook Execution Validation slice.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/generated/python-notebooks"
ARTIFACTS_DIR="${ROOT_DIR}/generated/notebook-execution-artifacts"
TIMEOUT_SECONDS="${NOTEBOOK_EXEC_TIMEOUT:-600}"

cd "${ROOT_DIR}"

echo "[narrow] 1/4 Validate manuscript calculations"
Rscript scripts/ci/validate-manuscript-calculations.R \
  --output-json generated/worked-calculations/validation-report.json \
  --output-summary generated/worked-calculations/validation-report.md

echo "[narrow] 2/4 Export canonical generated Python notebooks"
Rscript scripts/export-python-notebooks.R --output-dir "${OUT_DIR}"

echo "[narrow] 3/4 Enforce generated notebook artifact policy"
python3 scripts/ci/check-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --checks hygiene \
  --published-dir notebooks/workshops

echo "[narrow] 4/4 Execute generated Python notebooks"
python3 scripts/ci/execute-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --artifacts-dir "${ARTIFACTS_DIR}" \
  --timeout "${TIMEOUT_SECONDS}"

echo "[narrow] PASS"
