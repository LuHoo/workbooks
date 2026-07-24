#!/usr/bin/env Rscript

parse_args <- function(args) {
  out <- list(
    output_rds = "generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.rds",
    output_csv = "generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.csv.gz",
    sim_size = 50000L,
    progress_every = 5000L,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--output-rds")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-rds")
      out$output_rds <- args[[i]]
    } else if (identical(arg, "--output-csv")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-csv")
      out$output_csv <- args[[i]]
    } else if (identical(arg, "--sim-size")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --sim-size")
      out$sim_size <- as.integer(args[[i]])
      if (is.na(out$sim_size) || out$sim_size < 1L) {
        stop("--sim-size must be a positive integer")
      }
    } else if (identical(arg, "--progress-every")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --progress-every")
      out$progress_every <- as.integer(args[[i]])
      if (is.na(out$progress_every) || out$progress_every < 1L) {
        stop("--progress-every must be a positive integer")
      }
    } else if (identical(arg, "--help") || identical(arg, "-h")) {
      out$help <- TRUE
    } else {
      stop("Unsupported option: ", arg)
    }
    i <- i + 1L
  }

  out
}

print_help <- function() {
  cat(
    "Usage:\n",
    "  Rscript scripts/recompute-auxiliary-sampling-simulation.R [options]\n\n",
    "Options:\n",
    "  --output-rds <path>       RDS artifact path.\n",
    "  --output-csv <path>       Optional CSV.GZ artifact path. Use '' to skip.\n",
    "  --sim-size <n>            Number of simulation iterations (default: 50000).\n",
    "  --progress-every <n>      Progress interval in result rows (default: 5000).\n",
    "  --help                    Show this help.\n",
    sep = ""
  )
}

recompute_auxiliary_sampling_simulation <- function(
  output_rds = "generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.rds",
  output_csv = "generated/cache/auxiliary-variables-and-stratification/H4_samplingDistributions-simResult.csv.gz",
  sim_size = 50000L,
  progress_every = 5000L
) {
  if (!requireNamespace("FSaudit", quietly = TRUE)) {
    stop("The FSaudit package is required.")
  }

  sim_size <- as.integer(sim_size)
  progress_every <- as.integer(progress_every)
  pm <- 260000
  cl <- 0.95
  n <- 100
  estimators <- c("Ratio", "Difference", "Regression")
  distributions <- c("Constant difference", "No intercept", "Slope and intercept", "Sporadic errors")
  inventory_data <- FSaudit::inventoryData
  n_results <- sim_size * length(estimators) * length(distributions)

  sim_result <- data.frame(matrix(ncol = 5, nrow = n_results))
  names(sim_result) <- c("estimator", "distr", "m", "estimate", "coverage")

  cvs_sample <- FSaudit::cvs_obj(
    desPrec = 200000,
    n = n,
    bv = inventory_data$bv,
    id = inventory_data$item,
    cl = cl,
    seed = 1
  )

  start <- Sys.time()
  for (i in seq_len(sim_size)) {
    cvs_sample <- FSaudit::select(cvs_sample, seed = i)
    av_cvs <- inventory_data[
      match(cvs_sample$sample$item, inventory_data$item),
      c("item", "av_mus", "av_reg", "av_dif", "av_rat")
    ]

    for (j in seq_along(distributions)) {
      av_current <- switch(
        distributions[[j]],
        "Constant difference" = av_cvs$av_dif,
        "No intercept" = av_cvs$av_rat,
        "Slope and intercept" = av_cvs$av_reg,
        "Sporadic errors" = av_cvs$av_mus
      )

      for (k in seq_along(estimators)) {
        r <- (i - 1L) * length(distributions) * length(estimators) +
          (j - 1L) * length(estimators) + k
        sim_result[r, 1] <- estimators[[k]]
        sim_result[r, 2] <- distributions[[j]]

        cvs_sample <- FSaudit::evaluate(cvs_sample, av = av_current)
        if (identical(estimators[[k]], "Ratio")) {
          est <- cvs_sample$evalResults$`Most likely total error ratio`
          precision <- cvs_sample$evalResults$Estimates[3, 3]
          m <- cvs_sample$evalResults$`Ratio estimation`$`#_Errors`
        } else if (identical(estimators[[k]], "Difference")) {
          est <- cvs_sample$evalResults$`Most likely total error difference`
          precision <- cvs_sample$evalResults$Estimates[3, 2]
          m <- cvs_sample$evalResults$`Difference estimation`$`#_Errors`
        } else {
          est <- cvs_sample$evalResults$`Most likely total error regression`
          precision <- cvs_sample$evalResults$Estimates[3, 4]
          m <- cvs_sample$evalResults$`Regression estimation`$`#_Errors`
        }

        sim_result[r, 3] <- m
        sim_result[r, 4] <- est
        sim_result[r, 5] <- (est - precision < pm) & (est + precision > pm)

        if (r %% progress_every == 0L) {
          message(r, " of ", n_results)
        }
      }
    }
  }
  end <- Sys.time()

  artifact <- list(
    params = list(
      cache_version = 1L,
      simSize = sim_size,
      every = progress_every,
      estimators = estimators,
      distributions = distributions,
      n = n,
      cl = cl,
      pm = pm
    ),
    simResult = sim_result,
    generated_at = end,
    elapsed_seconds = as.numeric(difftime(end, start, units = "secs"))
  )

  dir.create(dirname(output_rds), recursive = TRUE, showWarnings = FALSE)
  saveRDS(artifact, output_rds)
  message("Wrote ", output_rds)

  if (!is.null(output_csv) && nzchar(output_csv)) {
    dir.create(dirname(output_csv), recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(sim_result, gzfile(output_csv), row.names = FALSE)
    message("Wrote ", output_csv)
  }

  invisible(artifact)
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  if (isTRUE(args$help)) {
    print_help()
    return(invisible(NULL))
  }

  recompute_auxiliary_sampling_simulation(
    output_rds = args$output_rds,
    output_csv = args$output_csv,
    sim_size = args$sim_size,
    progress_every = args$progress_every
  )
}

if (sys.nframe() == 0L) {
  main()
}
