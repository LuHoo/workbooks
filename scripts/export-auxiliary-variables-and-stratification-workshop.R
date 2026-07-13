#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("auxiliary-variables-and-stratification", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("auxiliary-variables-and-stratification")
export_python_workshop_tex_by_config_id(
	"auxiliary-variables-and-stratification",
	output_tex_path = "workshop03_Python.tex"
)
