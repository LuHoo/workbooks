#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("hypothesis-testing", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("hypothesis-testing")
generate_python_workshop_scaffold("workshop05_R.tex", "workshop05_Python.tex")
