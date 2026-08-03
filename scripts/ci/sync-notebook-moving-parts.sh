#!/usr/bin/env bash
set -euo pipefail

# Synchronize the three moving parts:
# 1) canonical generated notebooks,
# 2) published notebooks in notebooks/workshops,
# 3) policy guardrail parity check.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/generated/python-notebooks"

cd "${ROOT_DIR}"

echo "[sync] 1/3 Regenerate canonical generated Python notebooks"
Rscript scripts/export-python-notebooks.R --output-dir "${OUT_DIR}"

echo "[sync] 2/3 Republish mapped notebooks into notebooks/workshops"
Rscript scripts/publish-python-notebooks.R \
  --input-dir "${OUT_DIR}" \
  --output-dir notebooks/workshops

echo "[sync] 3/3 Verify publication parity policy"
python3 scripts/ci/check-generated-python-notebooks.py \
  --input-dir "${OUT_DIR}" \
  --checks hygiene \
  --published-dir notebooks/workshops

echo "[sync] PASS"

echo "[sync] Next: commit submodule changes in notebooks/workshops, push that branch, then commit the parent submodule pointer."
