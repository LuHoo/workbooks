#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("probability-distributions", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("probability-distributions")
