#!/usr/bin/env bash
set -euo pipefail

# Easy-to-remember alias for local narrow validation chain.
exec bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/local-notebook-narrow-chain.sh" "$@"
