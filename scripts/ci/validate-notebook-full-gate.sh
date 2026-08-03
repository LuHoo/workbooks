#!/usr/bin/env bash
set -euo pipefail

# Easy-to-remember alias for full local validation gate.
exec bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/local-notebook-validation-gate.sh" "$@"
