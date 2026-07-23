#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("regression-analysis", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("regression-analysis")
export_python_workshop_tex_by_config_id(
	"regression-analysis",
	# Keep a monolithic regression artifact for debugging/legacy use,
	# but avoid clobbering chapter-5 workshop05_Python.tex.
	output_tex_path = "generated/workshop-output-python/workshop-regression-analysis_Python.tex"
)
