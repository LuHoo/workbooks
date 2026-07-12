#!/usr/bin/env Rscript

source("scripts/export-workshop-output.R", chdir = FALSE)

export_workshop_by_config_id("auxiliary-variables-and-stratification", parser_engine = "ir")
