#!/usr/bin/env bash
set -euo pipefail

# Mirrors the critical CI path that has produced late failures.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/generated/python-notebooks"
ARTIFACTS_DIR="${ROOT_DIR}/generated/notebook-execution-artifacts"

cd "${ROOT_DIR}"

echo "[gate] Generating Python notebooks"
Rscript scripts/export-python-notebooks.R --output-dir "${OUT_DIR}"

echo "[gate] Checking strict Python guardrail"
python3 scripts/ci/check-generated-python-notebooks.py --input-dir "${OUT_DIR}"

echo "[gate] Running R/Python equivalence checks"
python3 scripts/ci/assert-r-python-equivalence.py --chapters 1,6
python3 scripts/ci/assert-r-python-equivalence.py --chapters 1,2,3,4,5,6

echo "[gate] Running R smoke execution"
Rscript scripts/ci/execute-r-workshop-smoke.R

echo "[gate] Executing generated Python notebooks"
python3 scripts/ci/execute-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --artifacts-dir "${ARTIFACTS_DIR}" \
  --timeout 600

echo "[gate] PASS"
