#!/usr/bin/env bash
set -euo pipefail

BASE_REF="${1:-origin/main}"
HEAD_REF="${2:-HEAD}"

if ! git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
  echo "ERROR: base ref '$BASE_REF' does not exist." >&2
  exit 2
fi

if ! git rev-parse --verify "$HEAD_REF" >/dev/null 2>&1; then
  echo "ERROR: head ref '$HEAD_REF' does not exist." >&2
  exit 2
fi

RANGE="${BASE_REF}...${HEAD_REF}"

support_changes="$(git diff --name-only "$RANGE" -- 'notebooks/support/**/support.Rmd')"

if [[ -z "$support_changes" ]]; then
  echo "OK: no support.Rmd changes in $RANGE."
  exit 0
fi

echo "Detected support.Rmd changes:" 
echo "$support_changes"

workshop_changes="$(git diff --name-only "$RANGE" -- 'notebooks/workshops/**')"

if [[ -z "$workshop_changes" ]]; then
  echo "ERROR: support.Rmd changed, but no changes were detected in notebooks/workshops/." >&2
  echo "Run the export workflow and include the generated workshop outputs." >&2
  exit 1
fi

echo "Detected notebooks/workshops changes:" 
echo "$workshop_changes"

# If notebooks/workshops is a nested repo, enforce that its changes are committed
# and pushed to its public upstream.
if [[ -f notebooks/workshops/.git || -d notebooks/workshops/.git ]]; then
  if [[ -n "$(git -C notebooks/workshops status --porcelain)" ]]; then
    echo "ERROR: notebooks/workshops has uncommitted changes." >&2
    echo "Commit those changes in the public workshops repository first." >&2
    exit 1
  fi

  if ! upstream_ref="$(git -C notebooks/workshops rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)"; then
    echo "ERROR: notebooks/workshops has no upstream branch configured." >&2
    echo "Configure an upstream and push to the public repository." >&2
    exit 1
  fi

  ahead_count="$(git -C notebooks/workshops rev-list --count "${upstream_ref}..HEAD")"
  if [[ "$ahead_count" -gt 0 ]]; then
    echo "ERROR: notebooks/workshops has ${ahead_count} local commit(s) not pushed to ${upstream_ref}." >&2
    echo "Push the public workshops repository before continuing." >&2
    exit 1
  fi

  echo "OK: notebooks/workshops nested repository is committed and pushed (${upstream_ref})."
else
  echo "WARNING: notebooks/workshops is not configured as a nested repository; push status to public repo cannot be verified automatically." >&2
fi

echo "PASS: support.Rmd changes are accompanied by workshop outputs and public publication checks."
