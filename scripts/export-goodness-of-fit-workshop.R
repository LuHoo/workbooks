#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)

# Chapter 6 chunks rely on regression-model objects built in chapter 5.
# Source the chapter 5 wrapper in-process to preserve object state.
source("scripts/export-regression-analysis-workshop.R", chdir = FALSE)

export_workshop_by_config_id("goodness-of-fit", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("goodness-of-fit")
export_python_workshop_tex_by_config_id(
	"goodness-of-fit",
	output_tex_path = "workshop06_Python.tex"
)
