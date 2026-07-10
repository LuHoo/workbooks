#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("probability-distributions")

python_notebook <- "notebooks/python/workshop02_python.ipynb"
python_workshop_tex <- "workshop02_Python.tex"

if (!file.exists(python_notebook)) {
	stop("Missing Python workshop notebook: ", python_notebook)
}

status <- system2(
	"python",
	c("scripts/export-python-workshop.py", "--input", python_notebook, "--output", python_workshop_tex)
)
if (!identical(status, 0L)) {
	stop("Failed to generate ", python_workshop_tex, " from ", python_notebook)
}
