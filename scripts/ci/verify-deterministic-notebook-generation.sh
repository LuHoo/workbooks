#!/usr/bin/env bash
set -euo pipefail

RUN_A="/tmp/ada-generation-run-a"
RUN_B="/tmp/ada-generation-run-b"
KEEP_TEMP=0

usage() {
  cat <<'EOF'
Usage:
  bash scripts/ci/verify-deterministic-notebook-generation.sh [options]

Verifies deterministic local generation by running the canonical generators twice
into isolated output roots and comparing inventories, hashes, and notebook semantics.

Options:
  --run-a <path>     Override run A output root (default: /tmp/ada-generation-run-a)
  --run-b <path>     Override run B output root (default: /tmp/ada-generation-run-b)
  --keep-temp        Keep temporary output roots for debugging
  -h, --help         Show this help

Required local dependencies:
  - bash
  - Rscript with required project packages
  - python3
  - shasum (SHA-256)
  - diff, find, grep, sed
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --run-a)
      RUN_A="$2"
      shift 2
      ;;
    --run-b)
      RUN_B="$2"
      shift 2
      ;;
    --keep-temp)
      KEEP_TEMP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unsupported option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

cleanup() {
  if [[ "$KEEP_TEMP" -eq 0 ]]; then
    rm -rf "$RUN_A" "$RUN_B"
  else
    echo "[verify] Keeping outputs for debugging:"
    echo "  - $RUN_A"
    echo "  - $RUN_B"
  fi
}
trap cleanup EXIT

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 2
  fi
}

need_cmd bash
need_cmd Rscript
need_cmd python3
need_cmd shasum
need_cmd diff
need_cmd find
need_cmd grep
need_cmd sed

run_generation() {
  local run_root="$1"

  echo "[verify] Preparing isolated output root: $run_root"
  rm -rf "$run_root"
  mkdir -p "$run_root"/{ir,python-notebooks,published-python-notebooks,r-workshops,workshop-output}

  echo "[verify] Generating Workshop IR snapshots"
  ADA_OUT_IR="$run_root/ir" Rscript -e "
source('scripts/workshop-export-config.R', chdir = FALSE)
source('scripts/workshop-ir.R', chdir = FALSE)
out_dir <- Sys.getenv('ADA_OUT_IR')
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
for (cfg in get_workshop_export_configs()) {
  ir <- parse_support_notebook_to_ir(input_path = cfg\$source)
  write_workshop_ir_json(ir, output_path = file.path(out_dir, paste0(cfg\$id, '.json')), pretty = FALSE)
}
"

  echo "[verify] Generating distribution Python notebooks"
  Rscript scripts/export-python-notebooks.R --output-dir "$run_root/python-notebooks"

  echo "[verify] Applying publication naming/path mapping for Python notebooks"
  Rscript scripts/publish-python-notebooks.R \
    --input-dir "$run_root/python-notebooks" \
    --output-dir "$run_root/published-python-notebooks"

  echo "[verify] Generating distribution R workshop notebooks"
  Rscript scripts/export-workshops.R --output-dir "$run_root/r-workshops"

  echo "[verify] Generating workshop LaTeX fragments"
  ADA_OUT_LATEX="$run_root/workshop-output" Rscript -e "
source('scripts/workshop-export-config.R', chdir = FALSE)
source('scripts/export-workshop-output.R', chdir = FALSE)
out_dir <- Sys.getenv('ADA_OUT_LATEX')
for (cfg in get_workshop_export_configs()) {
  export_workshop_by_config(
    config = cfg,
    output_dir = out_dir,
    parser_engine = 'ir',
    enable_traceability = TRUE,
    traceability_strict = TRUE
  )
}
"
}

make_inventory() {
  local run_root="$1"
  local out_file="$2"
  (
    cd "$run_root"
    find . -type f | sed 's#^\./##' | LC_ALL=C sort
  ) > "$out_file"
}

make_hash_manifest() {
  local run_root="$1"
  local inventory_file="$2"
  local out_file="$3"

  : > "$out_file"
  while IFS= read -r rel_path; do
    [[ -z "$rel_path" ]] && continue
    local hash
    hash="$(shasum -a 256 "$run_root/$rel_path" | awk '{print $1}')"
    printf "%s  %s\n" "$hash" "$rel_path" >> "$out_file"
  done < "$inventory_file"
}

compare_notebooks_semantically() {
  local run_a="$1"
  local run_b="$2"

  python3 - "$run_a" "$run_b" <<'PY'
import json
import os
import re
import sys
from pathlib import Path

run_a = Path(sys.argv[1])
run_b = Path(sys.argv[2])

errors = []

def canonical(obj):
    return json.dumps(obj, ensure_ascii=False, sort_keys=True, indent=2) + "\n"

ipynb_paths = sorted([p for p in run_a.rglob("*.ipynb")])
for a_path in ipynb_paths:
    rel = a_path.relative_to(run_a)
    b_path = run_b / rel
    if not b_path.exists():
        errors.append(f"missing counterpart notebook: {rel}")
        continue

    a_nb = json.loads(a_path.read_text(encoding="utf-8"))
    b_nb = json.loads(b_path.read_text(encoding="utf-8"))

    if canonical(a_nb) != canonical(b_nb):
        errors.append(f"canonical notebook JSON differs: {rel}")

    a_cells = a_nb.get("cells", [])
    if [c.get("cell_type") for c in a_cells] != [c.get("cell_type") for c in b_nb.get("cells", [])]:
        errors.append(f"cell type sequence differs: {rel}")

    ids = []
    for idx, cell in enumerate(a_cells, start=1):
        cell_id = cell.get("id")
        if cell_id is not None:
            ids.append(cell_id)
            if not re.fullmatch(r"cell-[0-9a-f]{16}", str(cell_id)):
                errors.append(f"unstable/noncanonical cell id pattern in {rel} cell {idx}: {cell_id}")

        if cell.get("cell_type") == "code":
            if cell.get("execution_count") is not None:
                errors.append(f"execution_count is not null in distribution notebook {rel} cell {idx}")
            outputs = cell.get("outputs")
            if outputs != []:
                errors.append(f"outputs are not empty in distribution notebook {rel} cell {idx}")

    if len(ids) != len(set(ids)):
        errors.append(f"duplicate cell ids in notebook: {rel}")

    renderer_meta = a_nb.get("metadata", {}).get("ada_renderer", {})
    source_file = renderer_meta.get("source_file")
    if isinstance(source_file, str):
        if os.path.isabs(source_file):
            errors.append(f"absolute source_file path in notebook metadata: {rel} -> {source_file}")
        if any(token in source_file for token in ["/tmp/", "var/folders", "\\\\"]):
            errors.append(f"environment-specific source_file path in notebook metadata: {rel} -> {source_file}")

if errors:
    print("[verify] Notebook semantic checks failed:")
    for err in errors:
        print(f"  - {err}")
    sys.exit(1)

print("[verify] Notebook semantic checks passed")
PY
}

check_content_guards() {
  local run_root="$1"

  echo "[verify] Checking generated Rmd guardrails"
  if grep -R -n -E '<!--[[:space:]]*SUPPORT-ONLY:(START|END)|<!--[[:space:]]*ADA:(BEGIN|END|REQUIRES)' "$run_root/r-workshops"; then
    echo "[verify] Guardrail failure: leaked support-only or ADA directive markers in generated Rmd" >&2
    exit 1
  fi

  echo "[verify] Checking published notebook metadata guardrails"
  if grep -R -n -E '/tmp/|/var/folders/' "$run_root/published-python-notebooks"; then
    echo "[verify] Guardrail failure: environment-specific path fragment found in published notebooks" >&2
    exit 1
  fi

  echo "[verify] Checking generated LaTeX guardrails"
  if grep -R -n -E '/tmp/|/var/folders/' "$run_root/workshop-output"; then
    echo "[verify] Guardrail failure: environment-specific path fragment found in generated LaTeX" >&2
    exit 1
  fi
}

run_generation "$RUN_A"
run_generation "$RUN_B"

inv_a="$(mktemp)"
inv_b="$(mktemp)"
hash_a="$(mktemp)"
hash_b="$(mktemp)"

make_inventory "$RUN_A" "$inv_a"
make_inventory "$RUN_B" "$inv_b"

echo "[verify] Comparing file inventories"
if ! diff -u "$inv_a" "$inv_b"; then
  echo "[verify] File inventory mismatch between runs" >&2
  exit 1
fi

make_hash_manifest "$RUN_A" "$inv_a" "$hash_a"
make_hash_manifest "$RUN_B" "$inv_b" "$hash_b"

echo "[verify] Comparing SHA-256 hashes"
if ! diff -u "$hash_a" "$hash_b"; then
  echo "[verify] Hash mismatch between runs" >&2
  exit 1
fi

compare_notebooks_semantically "$RUN_A" "$RUN_B"
check_content_guards "$RUN_A"
check_content_guards "$RUN_B"

echo "[verify] Deterministic generation verified"
echo "[verify] Run roots: $RUN_A and $RUN_B"
