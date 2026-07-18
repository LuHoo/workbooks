#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/ci/publish-workbooks-from-ada.sh --workbooks-repo /absolute/path/to/workbooks [options]

Options:
  --ada-repo <path>        Path to private ADA repo (default: current directory)
  --workbooks-repo <path>  Path to public workbooks repo (required)
  --base-ref <ref>         Base ref for support.Rmd change detection (default: origin/main)
  --head-ref <ref>         Head ref for support.Rmd change detection (default: HEAD)
  --skip-export            Skip export commands and only sync/check
  -h, --help               Show this help

Behavior:
  1) Detects support notebook changes in ADA.
  2) Runs exports in ADA (unless --skip-export).
  3) Syncs notebooks/workshops from ADA to the workbooks repo root.
  4) Prints exact commit/push commands to publish in the workbooks repo.
EOF
}

ADA_REPO="$PWD"
WORKBOOKS_REPO=""
BASE_REF="origin/main"
HEAD_REF="HEAD"
SKIP_EXPORT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ada-repo)
      ADA_REPO="$2"
      shift 2
      ;;
    --workbooks-repo)
      WORKBOOKS_REPO="$2"
      shift 2
      ;;
    --base-ref)
      BASE_REF="$2"
      shift 2
      ;;
    --head-ref)
      HEAD_REF="$2"
      shift 2
      ;;
    --skip-export)
      SKIP_EXPORT=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ -z "$WORKBOOKS_REPO" ]]; then
  echo "ERROR: --workbooks-repo is required." >&2
  usage
  exit 2
fi

if [[ ! -d "$ADA_REPO/.git" ]]; then
  echo "ERROR: ADA repo path is not a git repository: $ADA_REPO" >&2
  exit 2
fi

if [[ ! -d "$WORKBOOKS_REPO/.git" ]]; then
  echo "ERROR: workbooks repo path is not a git repository: $WORKBOOKS_REPO" >&2
  exit 2
fi

if [[ ! -d "$ADA_REPO/notebooks/workshops" ]]; then
  echo "ERROR: source directory not found: $ADA_REPO/notebooks/workshops" >&2
  exit 2
fi

SOURCE_REAL="$(cd "$ADA_REPO/notebooks/workshops" && pwd -P)"
WORKBOOKS_REAL="$(cd "$WORKBOOKS_REPO" && pwd -P)"
if [[ "$SOURCE_REAL" == "$WORKBOOKS_REAL" ]]; then
  echo "ERROR: source and target resolve to the same directory." >&2
  echo "Use a separate workbooks clone path for --workbooks-repo." >&2
  exit 2
fi

if ! git -C "$ADA_REPO" rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
  echo "ERROR: base ref not found in ADA repo: $BASE_REF" >&2
  exit 2
fi

if ! git -C "$ADA_REPO" rev-parse --verify "$HEAD_REF" >/dev/null 2>&1; then
  echo "ERROR: head ref not found in ADA repo: $HEAD_REF" >&2
  exit 2
fi

RANGE="${BASE_REF}...${HEAD_REF}"
SUPPORT_CHANGES="$(git -C "$ADA_REPO" diff --name-only "$RANGE" -- 'notebooks/support/**/support.Rmd' || true)"

if [[ -n "$SUPPORT_CHANGES" ]]; then
  echo "Detected support.Rmd changes in ADA ($RANGE):"
  echo "$SUPPORT_CHANGES"
else
  echo "No support.Rmd changes detected in ADA ($RANGE)."
fi

if [[ "$SKIP_EXPORT" -eq 0 ]]; then
  echo "Running exports in ADA..."
  (
    cd "$ADA_REPO"
    Rscript scripts/export-workshops.R
    Rscript scripts/export-python-notebooks.R
  )
else
  echo "Skipping export step (--skip-export)."
fi

echo "Syncing ADA notebooks/workshops into workbooks repo root..."
rsync -a --delete --exclude '.git' "$ADA_REPO/notebooks/workshops/" "$WORKBOOKS_REPO/"

echo "\nWorkbooks repo status:"
git -C "$WORKBOOKS_REPO" status -sb

WB_STATUS="$(git -C "$WORKBOOKS_REPO" status --porcelain)"
WB_BRANCH="$(git -C "$WORKBOOKS_REPO" rev-parse --abbrev-ref HEAD)"
WB_UPSTREAM="$(git -C "$WORKBOOKS_REPO" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"

if [[ -z "$WB_STATUS" ]]; then
  echo "\nNo changes to publish in workbooks."
else
  echo "\nChanges detected in workbooks. Suggested publish commands:"
  echo "  git -C \"$WORKBOOKS_REPO\" add -A"
  echo "  git -C \"$WORKBOOKS_REPO\" commit -m \"Publish workshops from ADA\""
  echo "  git -C \"$WORKBOOKS_REPO\" push origin $WB_BRANCH"
fi

if [[ -n "$WB_UPSTREAM" ]]; then
  AHEAD_COUNT="$(git -C "$WORKBOOKS_REPO" rev-list --count "${WB_UPSTREAM}..HEAD")"
  if [[ "$AHEAD_COUNT" -gt 0 ]]; then
    echo "\nNOTICE: workbooks branch is ahead of upstream by $AHEAD_COUNT commit(s)."
    echo "Push pending commits with:"
    echo "  git -C \"$WORKBOOKS_REPO\" push origin $WB_BRANCH"
  fi
fi

if [[ -n "$SUPPORT_CHANGES" && -z "$WB_STATUS" ]]; then
  echo "\nWARNING: support.Rmd changed in ADA, but workbooks has no publish diff now."
  echo "If you expected student-facing output changes, verify export inputs and mappings."
fi
