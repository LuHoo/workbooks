#!/usr/bin/env Rscript

find_repo_root <- function(start = getwd()) {
  path <- normalizePath(start, mustWork = TRUE)

  repeat {
    if (file.exists(file.path(path, ".git"))) return(path)
    parent <- dirname(path)
    if (identical(parent, path)) {
      stop("Could not find the repository root from: ", start, call. = FALSE)
    }
    path <- parent
  }
}

h4_sampling_distributions_params <- function() {
  list(
    cache_version = 1L,
    simSize = 50000L,
    every = 5000L,
    estimators = c("Ratio", "Difference", "Regression"),
    distributions = c(
      "Constant difference",
      "No intercept",
      "Slope and intercept",
      "Sporadic errors"
    ),
    n = 100L,
    cl = 0.95,
    pm = 260000
  )
}

h4_sampling_distributions_cache_dir <- function(root = find_repo_root()) {
  file.path(root, "generated", "cache", "auxiliary-variables-and-stratification")
}

h4_sampling_distributions_cache_file <- function(root = find_repo_root()) {
  file.path(
    h4_sampling_distributions_cache_dir(root),
    "H4_samplingDistributions-simResult.rds"
  )
}

load_h4_sampling_distributions_cache <- function(params = h4_sampling_distributions_params(),
                                                 root = find_repo_root(),
                                                 required = FALSE) {
  cache_file <- h4_sampling_distributions_cache_file(root)

  if (!file.exists(cache_file)) {
    if (!required) return(NULL)
    stop(
      "Missing H4 sampling distributions cache: ", cache_file,
      "\nRun `Rscript scripts/compute-h4-sampling-distributions-cache.R` to generate it.",
      call. = FALSE
    )
  }

  cached <- readRDS(cache_file)
  if (!identical(cached$params, params)) {
    if (!required) return(NULL)
    stop(
      "The H4 sampling distributions cache is stale for the current parameters.",
      "\nRun `Rscript scripts/compute-h4-sampling-distributions-cache.R` to refresh it.",
      call. = FALSE
    )
  }

  cached
}

compute_h4_sampling_distributions_cache <- function(params = h4_sampling_distributions_params(),
                                                    root = find_repo_root(),
                                                    force = FALSE) {
  if (!requireNamespace("FSaudit", quietly = TRUE)) {
    stop("The FSaudit package is required to compute the H4 simulation cache.", call. = FALSE)
  }

  cache_dir <- h4_sampling_distributions_cache_dir(root)
  cache_file <- h4_sampling_distributions_cache_file(root)
  dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)

  if (!force) {
    cached <- load_h4_sampling_distributions_cache(params, root, required = FALSE)
    if (!is.null(cached)) {
      message("Using existing cache at ", cache_file)
      return(invisible(cached))
    }
  }

  library(FSaudit)

  inventory <- inventoryData
  n_est <- length(params$estimators)
  n_dist <- length(params$distributions)
  n_results <- params$simSize * n_est * n_dist

  simResult <- data.frame(matrix(ncol = 5, nrow = n_results))
  names(simResult) <- c("estimator", "distr", "m", "estimate", "coverage")

  cvsSample <- cvs_obj(
    desPrec = 200000,
    n = params$n,
    bv = inventory$bv,
    id = inventory$item,
    cl = params$cl,
    seed = 1
  )

  start <- Sys.time()

  for (i in seq_len(params$simSize)) {
    cvsSample <- FSaudit::select(cvsSample, seed = i)
    avCVS <- inventory[
      match(cvsSample$sample$item, inventory$item),
      c("item", "av_mus", "av_reg", "av_dif", "av_rat")
    ]

    for (j in seq_along(params$distributions)) {
      distribution <- params$distributions[[j]]
      if (distribution == "Constant difference") {
        avC <- avCVS$av_dif
      } else if (distribution == "No intercept") {
        avC <- avCVS$av_rat
      } else if (distribution == "Slope and intercept") {
        avC <- avCVS$av_reg
      } else {
        avC <- avCVS$av_mus
      }

      for (k in seq_along(params$estimators)) {
        estimator <- params$estimators[[k]]
        r <- (i - 1L) * n_dist * n_est + (j - 1L) * n_est + k
        simResult[r, 1] <- estimator
        simResult[r, 2] <- distribution

        cvsSample <- evaluate(cvsSample, av = avC)
        switch(
          estimator,
          "Ratio" = {
            est <- cvsSample$evalResults$`Most likely total error ratio`
            precision <- cvsSample$evalResults$Estimates[3, 3]
            m <- cvsSample$evalResults$`Ratio estimation`$`#_Errors`
          },
          "Difference" = {
            est <- cvsSample$evalResults$`Most likely total error difference`
            precision <- cvsSample$evalResults$Estimates[3, 2]
            m <- cvsSample$evalResults$`Difference estimation`$`#_Errors`
          },
          "Regression" = {
            est <- cvsSample$evalResults$`Most likely total error regression`
            precision <- cvsSample$evalResults$Estimates[3, 4]
            m <- cvsSample$evalResults$`Regression estimation`$`#_Errors`
          }
        )

        lower <- est - precision
        upper <- est + precision
        simResult[r, 3] <- m
        simResult[r, 4] <- est
        simResult[r, 5] <- (lower < params$pm) & (upper > params$pm)

        if (r %% params$every == 0L) {
          message(r, " of ", n_results)
        }
      }
    }
  }

  end <- Sys.time()
  cached <- list(
    params = params,
    simResult = simResult,
    generated_at = Sys.time(),
    elapsed_seconds = as.numeric(difftime(end, start, units = "secs"))
  )

  saveRDS(cached, cache_file)
  message("Saved simulation cache to ", cache_file)
  invisible(cached)
}

main <- function(args = commandArgs(trailingOnly = TRUE)) {
  force <- "--force" %in% args
  cached <- compute_h4_sampling_distributions_cache(force = force)
  message(
    "Cache ready at ", h4_sampling_distributions_cache_file(),
    " (elapsed ", round(cached$elapsed_seconds, 1), " seconds)"
  )
}

if (sys.nframe() == 0) {
  main()
}