#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)
source("scripts/export-python-workshop-output.R", chdir = FALSE)
source("scripts/workshop-export-config.R", chdir = FALSE)

export_workshop_by_config_id("probability-distributions", parser_engine = "ir")
export_python_workshop_chunks_by_config_id("probability-distributions")

config <- resolve_workshop_export_config_by_id("probability-distributions")
if (is.null(config)) {
	stop("Missing workshop export config for probability-distributions")
}

first_exercise <- names(config$expected_chunks)[[1L]]
chapter_number <- sub("\\..*$", "", first_exercise)

generated_python_notebook <- file.path(
	"generated",
	"python-notebooks",
	config$id,
	paste0("chapter-", chapter_number, ".ipynb")
)
legacy_python_notebook <- "notebooks/python/workshop02_python.ipynb"
python_notebook <- if (file.exists(generated_python_notebook)) generated_python_notebook else legacy_python_notebook
python_workshop_tex <- "workshop02_Python.tex"

if (!file.exists(python_notebook)) {
	stop(
		"Missing Python workshop notebook. Checked generated path '",
		generated_python_notebook,
		"' and legacy path '",
		legacy_python_notebook,
		"'."
	)
}

export_args <- c(
	"scripts/export-python-workshop.py",
	"--input", python_notebook,
	"--output", python_workshop_tex
)
if (identical(python_notebook, generated_python_notebook)) {
	export_args <- c(export_args, "--expect-generated-metadata")
}

python_bin <- Sys.which("python3")
if (!nzchar(python_bin)) {
	python_bin <- Sys.which("python")
}
if (!nzchar(python_bin)) {
	stop("Python executable not found. Install python3 or add python to PATH.")
}

status <- system2(
	python_bin,
	export_args
)
if (!identical(status, 0L)) {
	stop("Failed to generate ", python_workshop_tex, " from ", python_notebook)
}
