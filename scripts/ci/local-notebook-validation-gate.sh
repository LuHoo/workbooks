#!/usr/bin/env bash
set -euo pipefail

# Mirrors the critical CI path that has produced late failures.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/generated/python-notebooks"
ARTIFACTS_DIR="${ROOT_DIR}/generated/notebook-execution-artifacts"

cd "${ROOT_DIR}"

echo "[gate] Generating Python notebooks"
Rscript scripts/export-python-notebooks.R --output-dir "${OUT_DIR}"

echo "[gate] Validating manuscript calculations"
Rscript scripts/ci/validate-manuscript-calculations.R

echo "[gate] Checking strict Python guardrail"
python3 scripts/ci/check-generated-python-notebooks.py --input-dir "${OUT_DIR}"

echo "[gate] Checking generated Python workshop LaTeX includes"
Rscript scripts/ci/check-generated-python-workshop-includes.R

echo "[gate] Checking for monolithic Python workshop TeX generation"
Rscript scripts/ci/check-no-python-workshop-monoliths.R

echo "[gate] Verifying deterministic generation"
bash scripts/ci/verify-deterministic-notebook-generation.sh

echo "[gate] Enforcing generated artifact edit policy for published notebooks"
python3 scripts/ci/check-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --checks hygiene \
  --published-dir notebooks/workshops

echo "[gate] Running R/Python equivalence checks"
python3 scripts/ci/assert-r-python-equivalence.py --chapters 1,6
python3 scripts/ci/assert-r-python-equivalence.py --chapters 1,2,3,4,5,6

echo "[gate] Running R smoke execution"
Rscript scripts/ci/execute-r-workshop-smoke.R --policy deterministic-sampling-v2

echo "[gate] Executing generated Python notebooks"
python3 scripts/ci/execute-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --artifacts-dir "${ARTIFACTS_DIR}" \
  --timeout 600

echo "[gate] PASS"
