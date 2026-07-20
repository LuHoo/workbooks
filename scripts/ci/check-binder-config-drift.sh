#!/usr/bin/env bash

set -euo pipefail

authoritative_dir=".binder"
mirror_dir="notebooks/workshops/.binder"

files=(
  runtime.txt
  install.R
  requirements.txt
  postBuild
  apt.txt
)

missing=0
drift=0

for path in "$authoritative_dir" "$mirror_dir"; do
  if [[ ! -d "$path" ]]; then
    echo "Missing Binder config directory: $path" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo "Binder drift check failed before comparison." >&2
  echo "Expected authoritative ADA Binder config at $authoritative_dir and workbooks mirror at $mirror_dir." >&2
  exit 1
fi

for file in "${files[@]}"; do
  source_file="$authoritative_dir/$file"
  mirror_file="$mirror_dir/$file"

  if [[ ! -f "$source_file" ]]; then
    echo "Missing authoritative Binder file: $source_file" >&2
    missing=1
    continue
  fi

  if [[ ! -f "$mirror_file" ]]; then
    echo "Missing ADA Binder mirror file: $mirror_file" >&2
    missing=1
    continue
  fi

  if ! cmp -s "$source_file" "$mirror_file"; then
    echo "Binder config drift detected for $file" >&2
    diff -u "$source_file" "$mirror_file" || true
    drift=1
  fi
done

if [[ "$missing" -ne 0 || "$drift" -ne 0 ]]; then
  echo >&2
  echo "Authoritative Binder owner: LuHoo/ada (.binder)." >&2
  echo "Workbooks Binder files under notebooks/workshops/.binder are a required mirror for the Binder-facing publication target." >&2
  echo "Remediation: update the authoritative ADA Binder files first, then mirror the same content into notebooks/workshops/.binder/." >&2
  exit 1
fi

echo "Binder config mirror check passed: workbooks Binder files match authoritative ADA .binder files."