#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("hypothesis-testing", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("hypothesis-testing")
export_python_workshop_tex_by_config_id(
	"hypothesis-testing",
	output_tex_path = "workshop04_Python.tex"
)
