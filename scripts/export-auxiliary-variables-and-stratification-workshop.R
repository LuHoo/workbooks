#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("auxiliary-variables-and-stratification", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("auxiliary-variables-and-stratification")
generate_python_workshop_scaffold("workshop04_R.tex", "workshop04_Python.tex")
