#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("regression-analysis", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("regression-analysis")
# chap07.tex directly includes generated/workshop-output-python chunks inline;
# no separate workshop07_Python.tex scaffold is needed.
