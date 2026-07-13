source("scripts/workshop-export-config.R", chdir = FALSE)

# Compatibility layer only.
#
# The authoritative workshop registry is defined in scripts/workshop-export-config.R.
# This file derives the legacy `notebooks` object from that canonical manifest so
# older callers can keep working without maintaining a second hand-authored registry.
notebooks <- get_notebook_manifest()
