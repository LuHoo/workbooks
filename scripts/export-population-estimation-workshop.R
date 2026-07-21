#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("population-estimation", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("population-estimation")
generate_python_workshop_scaffold("workshop03_R.tex", "workshop03_Python.tex")
