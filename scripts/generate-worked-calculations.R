#!/usr/bin/env Rscript

parse_args <- function(args) {
  out <- list(
    output_dir = "generated/worked-calculations",
    values_dir = "generated/cache/manuscript-calculation-values",
    check = FALSE,
    help = FALSE
  )

  i <- 1L
  while (i <= length(args)) {
    arg <- args[[i]]
    if (identical(arg, "--output-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --output-dir")
      out$output_dir <- args[[i]]
    } else if (identical(arg, "--values-dir")) {
      i <- i + 1L
      if (i > length(args)) stop("Missing value after --values-dir")
      out$values_dir <- args[[i]]
    } else if (identical(arg, "--check")) {
      out$check <- TRUE
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
    "  Rscript scripts/generate-worked-calculations.R [options]\n\n",
    "Options:\n",
    "  --output-dir <path>  Directory for generated snippets and metadata (default: generated/worked-calculations)\n",
    "  --values-dir <path>  Directory containing notebook-emitted JSON values (default: generated/cache/manuscript-calculation-values)\n",
    "  --check              Fail if committed generated files are stale\n",
    sep = ""
  )
}

source("R/manuscript-calculation-registry.R", chdir = FALSE)
source("R/manuscript-calculation-renderer.R", chdir = FALSE)

format_raw <- function(x, tolerance = NULL) {
  mc_assert_numeric_scalar(x, "x")

  digits <- 16L
  if (!is.null(tolerance) && is.finite(tolerance) && tolerance > 0) {
    digits <- max(0L, ceiling(-log10(tolerance)))
    x <- round(x, digits = digits)
    return(formatC(x, format = "f", digits = digits, decimal.mark = "."))
  }

  formatC(x, format = "fg", digits = digits, flag = "#")
}

json_escape <- function(x) {
  x <- gsub("\\\\", "\\\\\\\\", x)
  x <- gsub("\"", "\\\\\"", x)
  x <- gsub("\n", "\\\\n", x)
  x
}

json_string <- function(x) {
  paste0("\"", json_escape(x), "\"")
}

json_value_object <- function(item, default_tolerance = NULL) {
  raw_tolerance <- item$tolerance %||% default_tolerance
  lines <- c(
    "    {",
    paste0("      \"id\": ", json_string(item$id), ","),
    paste0("      \"role\": ", json_string(item$role), ","),
    paste0("      \"raw\": ", format_raw(item$raw, raw_tolerance), ","),
    paste0("      \"display\": ", json_string(item$display), ","),
    paste0("      \"format\": ", json_string(item$format))
  )
  if (!is.null(item$tolerance)) {
    lines[length(lines)] <- paste0(lines[length(lines)], ",")
    lines <- c(lines, paste0("      \"tolerance\": ", format_raw(item$tolerance, item$tolerance)))
  }
  if (!is.null(item$language_scope)) {
    lines[length(lines)] <- paste0(lines[length(lines)], ",")
    lines <- c(lines, paste0("      \"language_scope\": ", json_string(item$language_scope)))
  }
  c(lines, "    }")
}

write_json_metadata <- function(path, metadata) {
  value_blocks <- lapply(metadata$values, json_value_object, default_tolerance = metadata$tolerance)
  value_lines <- character()
  for (i in seq_along(value_blocks)) {
    block <- value_blocks[[i]]
    if (i < length(value_blocks)) {
      block[length(block)] <- paste0(block[length(block)], ",")
    }
    value_lines <- c(value_lines, block)
  }

  lines <- c(
    "{",
    paste0("  \"schema_version\": ", metadata$schema_version, ","),
    paste0("  \"id\": ", json_string(metadata$id), ","),
    paste0("  \"kind\": ", json_string(metadata$kind), ","),
    paste0("  \"chapter_prefix\": ", json_string(metadata$chapter_prefix), ","),
    paste0("  \"source_notebook\": ", json_string(metadata$source_notebook), ","),
    paste0("  \"source_context\": ", json_string(metadata$source_context), ","),
    paste0("  \"source_dataset\": ", json_string(metadata$source_dataset), ","),
    paste0("  \"target_snippet\": ", json_string(metadata$target_snippet), ","),
    paste0("  \"tolerance\": ", format_raw(metadata$tolerance, metadata$tolerance), ","),
    paste0("  \"language_scope\": ", json_string(metadata$language_scope), ","),
    "  \"equation_labels\": [",
    paste0(
      "    ",
      paste(vapply(metadata$equation_labels, json_string, character(1L)), collapse = ", ")
    ),
    "  ],",
    "  \"values\": [",
    value_lines,
    "  ]",
    "}"
  )
  writeLines(lines, path, useBytes = TRUE)
}

aux_mpu_template <- function() {
  c(
    "The total \\hlblue{audit value}\\index{audit value} of the {{sample_size}} sampled items $\\sum y =$ {{total_audit_value}}, resulting in the mean audit value",
    "",
    "\\begin{equation*}",
    "\\overline{y} = \\frac{\\sum{y_i}}{n} = \\frac{{{total_audit_value}}}{{{sample_size}}} = {{mean_audit_value}}",
    "\\end{equation*}",
    "",
    "We then use Equation \\ref{eq:estimate_total}",
    "\\begin{equation*}",
    "  \\hat{Y}_{MPU} = N\\frac{\\sum y_i}{n} = {{population_size}} \\cdot {{mean_audit_value}} = {{estimated_population_value}}",
    "\\end{equation*}",
    "to estimate the population value.",
    "The variance of the audit values is calculated with Equation \\ref{eq:sample_var_shortcut}",
    "",
    "\\begin{align*}",
    paste0("s_y^2 &= \\frac{\\sum{y^2} - (\\sum{y})^2 / n}{n - 1} ", "\\\\"),
    "&= \\frac{{{sum_squared_audit_values}} - {{total_audit_value}}^2 / {{sample_size}}}{{{sample_size}} - 1} = {{audit_value_variance}}",
    "\\end{align*}"
  )
}

aux_regression_template <- function() {
  c(
    "Using the results summarized in Table \\ref{tab:sample_results}, the estimated slope parameter is",
    "",
    "\\begin{equation*}",
    "b_1 = \\frac{{{sum_cross}} - \\frac{{{sum_book}} \\cdot {{{sum_audit}}}}{{{sample_size}}}}{{{sum_squared_book}} - \\frac{({{{sum_book}}})^2}{{{sample_size}}}} = {{slope}}",
    "\\end{equation*}",
    "",
    "The estimated total value of the population is therefore",
    "\\begin{equation*}",
    "\\hat{Y}_R = {{population_size}} \\cdot {{sample_mean_audit}} + {{slope}} \\cdot ({{population_book_total}} - {{population_size}} \\cdot {{sample_mean_book}}) = {{estimated_population_value}}",
    "\\end{equation*}",
    "",
    "The covariance $c_{xy}$ and regression variance are",
    "\\begin{equation*}",
    "c_{xy} = {{covariance}}",
    "\\end{equation*}",
    "with audit-value variance $s_y^2 = {{audit_variance}}$ and book-value variance $s_x^2 = {{book_variance}}$.",
    "\\begin{equation*}",
    "s_{y,R}^2 = {{regression_variance}}",
    "\\end{equation*}",
    "",
    "A 95\\% two-sided prediction interval is calculated as",
    "\\begin{equation*}",
    "{{estimated_population_value}} \\pm {{g_factor}} \\cdot {{t_value}} \\cdot \\sqrt{{{regression_variance}}} = {{estimated_population_value}} \\pm {{precision}}",
    "\\end{equation*}",
    "",
    "which provides the prediction interval [{{interval_lower}}; {{interval_upper}}].",
    "",
    "The correlation between book and audit values is {{correlation}}, yielding adjustment factor",
    "\\begin{equation*}",
    "\\sqrt{1-r_{xy}^2} = {{adjustment_factor}}",
    "\\end{equation*}",
    "and adjusted MPU precision",
    "\\begin{equation*}",
    "{{mpu_precision}} \\cdot \\sqrt{\\frac{{{sample_size}} - 1}{{{sample_size}} - 2}} \\cdot {{adjustment_factor}} = {{mpu_precision_adjusted}}",
    "\\end{equation*}"
  )
}

aux_difference_template <- function() {
  c(
    "Applying these formulas to the results of \\emph{Case: Valuation of Inventories} in Table \\ref{tab:sample_results}, we obtain the following results.",
    "",
    "\\begin{equation*}",
    "\\hat{Y}_D = {{population_book_total}} - {{population_size}} \\cdot \\frac{{{sum_difference}}}{{{sample_size}}} = {{estimated_population_value}}",
    "\\end{equation*}",
    "",
    "The variance of the differences is",
    "\\begin{equation*}",
    "s_d^2 = \\frac{{{sum_squared_difference}} - ({{sum_difference}})^2 / {{sample_size}}}{{{sample_size}} - 1} = {{difference_variance}}",
    "\\end{equation*}",
    "",
    "The resulting two-sided 95\\% prediction interval is",
    "\\begin{equation*}",
    "{{estimated_population_value}} \\pm {{g_factor}} \\cdot {{t_value}} \\cdot \\sqrt{{{difference_variance}}} = {{estimated_population_value}} \\pm {{precision}}",
    "\\end{equation*}",
    "",
    "which provides the prediction interval [{{interval_lower}}; {{interval_upper}}]."
  )
}

aux_ratio_template <- function() {
  c(
    "Applying these formulas to the results of \\emph{Case: Valuation of Inventories} in Table \\ref{tab:sample_results}, we obtain the following results.",
    "The population contains {{population_size}} inventory items.",
    "",
    "\\begin{equation*}",
    "q = \\frac{{{sum_audit}}}{{{sum_book}}} = {{q_factor}}",
    "\\end{equation*}",
    "\\begin{equation*}",
    "\\hat{Y}_Q = {{population_book_total}} \\cdot {{q_factor}} = {{estimated_population_value}}",
    "\\end{equation*}",
    "",
    "The variance of the ratio estimator is",
    "\\begin{align*}",
    "s_q^2",
    "&=",
    "\\frac{\\scalebox{0.92}{$",
    "{{sum_squared_audit}}",
    "-2\\cdot{{q_factor}}\\cdot{{sum_cross}}",
    " +{{q_factor}}^2\\cdot{{sum_squared_book}}",
    paste0("$}}{", "{{sample_size}}", "-1} ", "\\\\"),
    "&= {{ratio_variance}}",
    "\\end{align*}",
    "",
    "The resulting two-sided 95\\% prediction interval is",
    "\\begin{equation*}",
    "{{estimated_population_value}} \\pm {{g_factor}} \\cdot {{t_value}} \\cdot \\sqrt{{{ratio_variance}}} = {{estimated_population_value}} \\pm {{precision}}",
    "\\end{equation*}",
    "",
    "which provides the prediction interval [{{interval_lower}}; {{interval_upper}}]."
  )
}

aux_sporadic_ratio_variance_component_template <- function() {
  c(
    "Notebook-emitted sporadic-errors ratio-variance component for chapter inline linkage:",
    "\\begin{equation*}",
    "s_{q,m}^2 = {{sporadic_ratio_variance_component}}",
    "\\end{equation*}"
  )
}

aux_stratified_mpu_estimate_template <- function() {
  c(
    "Notebook-emitted stratified MPU estimate for chapter inline linkage:",
    "\\begin{equation*}",
    "\\hat{Y}_{MPU} = {{stratified_mpu_estimate}}",
    "\\end{equation*}"
  )
}

est_mean_point_template <- function() {
  c(
    "The result for our sample is",
    "",
    "\\begin{equation*}",
    "\\bar{y} = \\frac{{{sample_total_gross}}}{{{sample_size}}} = {{sample_mean}}",
    "\\end{equation*}"
  )
}

est_total_point_template <- function() {
  c(
    "The estimated total gross payroll for January 20XX is therefore",
    "",
    "\\begin{equation*}",
    "\\hat{Y} = {{population_size}} \\cdot \\frac{{{sample_total_gross}}}{{{sample_size}}} = {{estimated_total_gross}}",
    "\\end{equation*}"
  )
}

est_mean_two_sided_95_template <- function() {
  c(
    "First, we estimate the variance in the population from the variance of the sample.",
    "",
    "\\begin{equation*}",
    "s^2 = \\frac{ (1,612 - {{sample_mean}})^2 + (4,818 - {{sample_mean}})^2 + \\ldots}{{{sample_size}}-1} = {{sample_variance}}",
    "\\end{equation*}",
    "",
    "The calculation of the standard error is then",
    "",
    "\\begin{equation}",
    "s_{\\bar{y}} = \\sqrt{\\frac{{{sample_variance}}}{{{sample_size}}}} = \\frac{{{sample_sd}}}{\\sqrt{{{sample_size}}}}",
    "\\end{equation}",
    "",
    "We multiply the standard error by the relevant $t$ value.",
    "",
    "\\begin{equation*}",
    "{{sample_mean}} \\pm {{t_value_95}} \\cdot \\frac{{{sample_sd}}}{\\sqrt{{{sample_size}}}} = {{sample_mean}} \\pm {{precision_95}}",
    "\\end{equation*}",
    "",
    "Therefore, we can be 95\\% confident that the interval [{{lower_95}}, {{upper_95}}] contains the true population mean. Expanding this over the number of employees in the population of $N =$ {{population_size}}, we obtain a 95\\% two-sided confidence interval for the total monthly salary cost of [{{total_lower_95}},\\hspace{0.5em} {{total_upper_95}}]."
  )
}

est_mean_two_sided_99_template <- function() {
  c(
    "If we desire a statement with a different confidence level, the value of $t$ must be changed. For example, at 99\\% confidence the corresponding $t$ value is approximately {{t_value_99}}, leading to bounds of",
    "",
    "\\begin{equation*}",
    "{{sample_mean}} \\pm {{t_value_99}} \\cdot \\frac{{{sample_sd}}}{\\sqrt{{{sample_size}}}} = {{sample_mean}} \\pm {{precision_99}}",
    "\\end{equation*}",
    "and the interval estimate is [{{lower_99}},\\hspace{0.5em} {{upper_99}}]. This creates a 99\\% two-sided confidence interval for the total monthly salary cost in a population of {{population_size}} employees: [{{total_lower_99}}, {{total_upper_99}}]. Note that the 99\\% confidence interval is wider than the 95\\% confidence interval."
  )
}

est_mean_one_sided_upper_95_template <- function() {
  c(
    "Note that we do not split $\\alpha$, but apply it to a single tail. Applying this to the results from the sample, we get for the maximum",
    "",
    "\\begin{equation*}",
    "{{sample_mean}} + {{t_value_one_sided_95}} \\cdot \\frac{{{sample_sd}}}{\\sqrt{{{sample_size}}}} = {{upper_one_sided_95}}",
    "\\end{equation*}",
    "and the interpretation is that we can be 95\\% confident that the true mean monthly payroll does not exceed {{upper_one_sided_95}}, and the total payroll charge for the month does not exceed {{total_upper_one_sided_95}}."
  )
}

est_mean_two_sided_finite_95_template <- function() {
  c(
    "Using the values from \\emph{Case: Salaries}, the two-sided 95\\% confidence interval\\index{confidence interval}\\index{interval!confidence} is now calculated as",
    "",
    "\\begin{equation*}",
    "{{sample_mean}} \\pm {{t_value_95}} \\cdot \\frac{{{sample_sd}}}{\\sqrt{{{sample_size}}}}\\sqrt{\\frac{{{population_size}} - {{sample_size}}}{{{population_size}}-1}} = {{sample_mean}} \\pm {{precision_finite_95}}",
    "\\end{equation*}",
    "",
    "By considering the finite-population correction factor, the precision achieved\\index{precision!achieved} is reduced from {{precision_95}} to {{precision_finite_95}}.",
    "",
    "It is always permissible to use the finite-population correction factor regardless of the value of $n / N$, but if the sample is less than 10\\% of the population, then the correction is close to 1 (no correction). In our case, the sample proportion was {{sample_size}} / {{population_size}} $\\approx$ 2.2\\%, and the correction $\\sqrt(({{population_size}} - {{sample_size}})/({{population_size}}-1))$ $\\approx$ {{fpc_factor}}."
  )
}

est_mean_minimum_sample_size_infinite_template <- function() {
  c(
    "For the sample of 50 employees, the results are",
    "",
    "\\begin{equation*}",
    "n = \\frac{{{population_size}}^2 \\cdot {{t_value_95}}^2 \\cdot {{sample_variance}}}{{{target_precision_600k}}^2} = {{min_n_infinite}}.",
    "\\end{equation*}",
    "",
    "The sample size must be at least {{min_n_infinite_ceiling}} to achieve a precision\\index{precision} of {{target_precision_600k}} with 95\\% confidence. Given that we already sampled 50 employees, the \\hlblue{additional sample}\\index{additional sample}\\index{sample!additional} must have a size of $n' = {{additional_n_required}}$."
  )
}

est_mean_stein_interval_template <- function() {
  c(
    "Applying Equation \\ref{eq:stein} to these results, we obtain",
    "",
    "\\begin{equation*}",
    "{{population_size}} \\cdot {{sample2_mean}} \\pm {{population_size}} \\cdot {{t_value_95}} \\cdot \\frac{{{sample_sd}}}{\\sqrt{{{n_total}}}} = {{stein_total_point}} \\pm {{target_precision_600k}}",
    "\\end{equation*}",
    "",
    "Under Stein's method, the precision achieved is, by definition, equal to the target precision, i.e. {{stein_precision}}."
  )
}

est_mean_minimum_sample_size_finite_template <- function() {
  c(
    "The required minimum sample size to satisfy $E \\leq {{target_precision_300k}}$ is now calculated at",
    "",
    "\\begin{align*}",
    "\\gamma &= \\frac{{{target_precision_300k}}^2}{{{population_size}} \\cdot {{t_value_95}}^2 \\cdot {{sample_variance}}} = {{gamma_finite}} \\\\",
    "n &\\geq \\frac{{{population_size}}}{1 + {{gamma_finite}}} = {{min_n_finite}}",
    "\\end{align*}",
    "",
    "The total sample size required to obtain an estimate of the mean monthly payroll with a precision of {{target_precision_300k}} at 95\\% confidence is {{min_n_finite_ceiling}}. This is more than 10\\% of the population size; therefore, we were right to use the finite-population correction factor. If we had not anticipated that the required sample size would have been unnecessarily large, not taking the finite-population correction factor into account would have resulted in a sample size of {{min_n_infinite_300k}}."
  )
}

est_prop_binomial_interval_95_template <- function() {
  c(
    "Using the results from the sample, we can calculate the lower bound as",
    "",
    "\\begin{equation*}",
    "p_l = \\frac{{{k}}}{{{k}} + ({{n}} - {{k}} + 1) \\cdot {{f_value_lower}}} = {{p_lower}}",
    "\\end{equation*}",
    "and the upper bound as",
    "\\begin{equation*}",
    "p_u = \\frac{{{k}} + 1}{{{k}} + 1 + ({{n}} - {{k}})/{{f_value_upper}}} = {{p_upper}}",
    "\\end{equation*}",
    "",
    "The interval estimate is [47.2\\%, 75.4\\%].\\footnote{Throughout this book we round lower bounds up and upper bounds down.\\index{rounding}}"
  )
}

est_prop_point_estimate_template <- function() {
  c(
    "In the sample of 50 employees we found {{k}} women; therefore, the estimated proportion is ${{k}} / {{n}} = {{p_hat}}$."
  )
}

est_prop_total_point_estimate_template <- function() {
  c(
    "For our sample, we estimate the number of women employed at {{population_size}} $\\cdot$ {{k}} / {{n}} = {{estimated_number_women}}. Note that this estimate is not an integer, and we do not need to round it."
  )
}

est_prop_minimum_sample_size_normal_template <- function() {
  c(
    "We obtained $p = {{p_hat}}$ and the interval estimate was [47.2\\%, 75.3\\%]. If we set $E= 10\\% =.1$, the minimum required sample size $n$ is",
    "",
    "\\begin{equation*}",
    "n \\geq \\frac{{{z_value_95}}^2 \\cdot {{p_hat}} \\cdot {{one_minus_p_hat}}}{{{target_prop_precision}}^2}  = {{min_n_prop}}",
    "\\end{equation*}",
    "and it follows that the sample must be extended to $n$ = {{min_n_prop_ceiling}}."
  )
}

est_prop_binomial_interval_extended_template <- function() {
  c(
    "We now double-check if the sample size is sufficient, assuming we find the same proportion of women in the additional sample of {{additional_n}} items (overall $k' = 0.62 \\cdot {{n_extended}} = 56.4$, rounded to {{k_extended}}). This gives us",
    "",
    "\\begin{equation*}",
    "p_l = \\frac{{{k_extended}}}{{{k_extended}} + ({{n_extended}} - {{k_extended}} + 1) \\cdot {{f_value_lower_extended}}} = {{p_lower_extended}}",
    "\\end{equation*}",
    "and the upper bound as",
    "\\begin{equation*}",
    "p_u = \\frac{{{k_extended}} + 1}{{{k_extended}} + 1 + ({{n_extended}} - {{k_extended}})/{{f_value_upper_extended}}} = {{p_upper_extended}}",
    "\\end{equation*}",
    "",
    "The interval estimate is reduced to [51.9\\%, 72.6\\%]."
  )
}

hyp_mus_sample_size_template <- function() {
  c(
    "In Table \\ref{tab:attribute_sample_sizes_alpha05}, the sampling interval $SI_k$ for $k$ tolerated errors is calculated by dividing the total book value $X$ by the minimum required sample size $n_k$. For example, $SI_2 =$ {{population_book_total}} / {{n_2}} = {{sampling_interval_k2}}. This implies that if we tolerate two errors and we find two errors, the point estimate equals $k \\cdot SI_2 =$ 2 $\\cdot$ {{sampling_interval_k2}} = {{expected_error_k2}}. Tolerating two errors, therefore, is synonymous with building error tolerance for an expected error of {{expected_error_k2}}.",
    "",
    "Similarly, if the expected error is {{sampling_interval_k1}}, the sample size $n =$ {{n_1}} and the critical region $\\{k | k \\leq 1\\}$.",
    "",
    "In \\emph{Case: Accounts receivable circularization}, the expected error $EE =$ {{expected_error}}. Therefore, we need to find a $t^*$ between the sample sizes $n_1 =$ {{n_1}} and $n_2 =$ {{n_2}} such that the point estimate $t^* X / n^* = EE$.",
    "",
    "Applying formula \\ref{eq:MUS_sample_size} to the parameters from the \\emph{Case: Accounts receivable circularization}, we obtain:",
    "",
    "\\begin{equation*}",
    "n^* = \\frac{1 - \\frac{{{n_1}}}{{{n_2}} - {{n_1}}}}{\\frac{{{expected_error}}}{{{population_book_total}}} - \\frac{1}{{{n_2}} - {{n_1}}}} = {{n_star}}",
    "\\end{equation*}",
    "Rounding this sample size upward leads to a required sample size $n =$ {{n_required}}.\\footnote{This calculation assumes that the sample is evaluated with the Stringer bound method. If the cell evaluation method is used, the sample size is usually lower, because errors with a small tainting have no effect on the precision achieved.} We can calculate the number of tolerable taintings from",
    "",
    "\\begin{equation*}",
    "t_{tol} = k + \\frac{EE - M_{U, k}}{M_{U, k+1} - M_{U, k}} = 1 + \\frac{{{performance_materiality}} - {{mu_1}}}{{{mu_2}} - {{mu_1}}} = {{t_tol}}",
    "\\end{equation*}",
    "where $k$ and $k+1$ are the two numbers of errors between which the sample size has been interpolated.",
    "",
    "The conclusion is that, if we expect a total error in the population of {{expected_error}}, the minimum sample size is {{n_required}}, and we can tolerate one 100\\% error and a partial error of {{partial_tainting_pct}}."
  )
}

hyp_mus_attribute_sample_sizes_rows_template <- function() {
  c(
    "0 & {{n_0}} & {{sampling_interval_k0}} & {{expected_error_k0}} \\\\",
    "1 & {{n_1}} & {{sampling_interval_k1}} & {{expected_error_k1}} \\\\",
    "2 & {{n_2}} & {{sampling_interval_k2}} & {{expected_error_k2}} \\\\",
    "3 & {{n_3}} & {{sampling_interval_k3}} & {{expected_error_k3}}"
  )
}

hyp_cell_evaluation_steps_template <- function() {
  c(
    "\\paragraph{Step 1.} When no errors are found, we only calculate the basic precision, which is the upper bound on the error calculated using Equation \\ref{eq:upper_bound}: $M_U[0] = {{mu_0}}$.",
    "",
    "\\paragraph{Step 2.} The first error is a 100\\% error; therefore, $t_1 = {{t_1}}$ and $\\bar{t}_1 = {{tbar_1}}$.",
    "\\begin{itemize}",
    "\\item \\emph{Simple spread}: $M_U[1] \\bar{t}_1 = {{mu_1}} \\cdot {{tbar_1}} = {{simple_1}}$.",
    "\\item \\emph{Load and spread}: Stage $M_U[0] + t_1 \\frac{X}{n} = {{mu_0}} + {{t_1}} \\cdot {{sampling_interval}} = {{load_1}}$.",
    "\\item \\emph{Stage} $M_U$: $\\max({{simple_1}}, {{load_1}}) = {{stage_1}}$.",
    "\\end{itemize}",
    "",
    "\\paragraph{Step 3.} The second error is a 20\\% error; therefore, $t_2 = {{t_2}}$ and $\\bar{t}_2 = {{tbar_2}}$.",
    "\\begin{itemize}",
    "\\item \\emph{Simple spread}: $M_U[2] \\bar{t}_2 = {{mu_2}} \\cdot {{tbar_2}} = {{simple_2}}$.",
    "\\item \\emph{Load and spread}: Stage $M_U[1] + t_2 \\frac{X}{n} = {{stage_1}} + {{t_2}} \\cdot {{sampling_interval}} = {{load_2}}$.",
    "\\item \\emph{Stage} $M_U$: $\\max({{simple_2}}, {{load_2}}) = {{stage_2}}$.",
    "\\end{itemize}",
    "",
    "\\paragraph{Step 4.} The third error is a 4\\% error; therefore, $t_3 = {{t_3}}$ and $\\bar{t}_3 = {{tbar_3}}$.",
    "\\begin{itemize}",
    "\\item \\emph{Simple spread}: $M_U[3] \\bar{t}_3 = {{mu_3}} \\cdot {{tbar_3}} = {{simple_3}}$.",
    "\\item \\emph{Load and spread}: Stage $M_U[2] + t_3 \\frac{X}{n} = {{stage_2}} + {{t_3}} \\cdot {{sampling_interval}} = {{load_3}}$.",
    "\\item \\emph{Stage} $M_U$: $\\max({{simple_3}}, {{load_3}}) = {{stage_3}}$.",
    "\\end{itemize}",
    "",
    "\\bigskip",
    "The conclusion is that we may assert, with 95\\% confidence, that the total misstatement does not exceed the \\emph{upper confidence bound} of {{stage_3}}. Note that the projected misstatement of {{projected_misstatement}} is not different from that calculated using the Stringer-bound evaluation method.",
    "Again, the auditor interpretation of the statistical conclusion is discussed in Section \\ref{sec:auditor_interpretation}."
  )
}

reg_annual_expectation_interval_template <- function() {
  c(
    "For the \\emph{Case: US SteamCo}, the annual expectation is obtained by summing the 12 monthly expectations after adjusting the March 2014 expectation for the corroborated winter storm effect.\\footnote{See Exercise \\ref{ex:Combining_12_monthly_predictions}} The resulting annual expectation is:",
    "",
    "\\begin{equation*}",
    "\\hat{y}_{\\text{total}} = {{annual_prediction}}.",
    "\\end{equation*}",
    "",
    "Using the variances and covariance of the estimated regression coefficients together with the residual variance yields a combined prediction standard error of",
    "",
    "\\begin{equation*}",
    "s_{\\text{comb}} = {{annual_se}}.",
    "\\end{equation*}",
    "",
    "The corresponding annual prediction-variance components are approximately ${{var_mean_annual}}$ from coefficient uncertainty and ${{var_future_annual}}$ from future residual variation. Thus, about {{coefficient_share}} of annual prediction variance comes from parameter estimation and {{future_share}} from future-period noise.",
    "",
    "With a 99\\% prediction interval and the appropriate $t$ critical value, the resulting acceptable prediction range for the annual revenue is",
    "",
    "\\begin{equation*}",
    "{{annual_interval_lower}}",
    "\\le",
    "y_{\\text{total}}",
    "\\le",
    "{{annual_interval_upper}}.",
    "\\end{equation*}",
    "",
    "The recorded annual revenue for 2014 equals",
    "",
    "\\begin{equation*}",
    "y_{\\text{recorded}} = {{annual_recorded}},",
    "\\end{equation*}",
    "so that the annual difference, defined as recorded revenue minus expected revenue, is",
    "",
    "\\begin{equation*}",
    "{{annual_recorded}} - {{annual_prediction}} = {{annual_difference}}.",
    "\\end{equation*}",
    "",
    "The annual difference is consistent with the uncertainty measured by the adjusted 99\\% acceptable difference range. The substantive analytical procedure therefore does not identify a remaining significant unexplained difference at the annual level, and the auditor can proceed to determine whether the evidence and achieved assurance are sufficient to reject material misstatement.",
    "",
    "Consequently, the annual difference of {{annual_difference_abs}} is first compared with the adjusted 99\\% acceptable difference range. Because the annual difference falls within that range, the substantive analytical procedure does not identify a significant unexplained difference requiring further investigation."
  )
}

reg_annual_assurance_template <- function() {
  c(
    "For the \\emph{Case: US SteamCo}, the annual expectation is $\\hat{y}_{\\text{total}} = {{annual_prediction}}$, the recorded annual revenue is $y_{\\text{recorded}} = {{annual_recorded}}$, and the combined prediction standard error is $s_{comb} = {{annual_se}}$. Hence, the observed annual difference is",
    "",
    "\\[",
    "D = y_{\\text{recorded}} - \\hat{y}_{\\text{total}} = {{annual_difference}}.",
    "\\]",
    "",
    "Using $PM = {{performance_materiality}}$ and $s_{comb} = {{annual_se}}$ for US SteamCo, we obtain",
    "",
    "\\[",
    "\\lambda_{PM} = \\frac{{{performance_materiality}}}{{{annual_se}}} \\approx {{delta}}.",
    "\\]",
    "",
    "For US SteamCo, the resulting 99\\% acceptable difference range for the annual difference is",
    "",
    "\\[",
    "\\text{ADR} = [{{adr_lower}},\\ {{adr_upper}}],",
    "\\]",
    "",
    "which corresponds to standardized decision bounds of approximately",
    "",
    "\\[",
    "c_L = {{c_lower}}, \\qquad c_U = {{c_upper}}.",
    "\\]",
    "",
    "For US SteamCo,",
    "",
    "\\[",
    "T = \\frac{{{annual_difference}}}{{{annual_se}}} \\approx {{test_statistic}}.",
    "\\]",
    "",
    "In the US SteamCo case, $T={{test_statistic}}$ lies between the decision bounds $[{{c_lower}}, {{c_upper}}]$, so the observed difference falls within the acceptable range. The achieved assurance at the chapter settings ($PM={{performance_materiality}}$, 99\\% central interval) is {{assurance_over}} in the overstatement direction and {{assurance_under}} in the understatement direction, which should be evaluated against the auditor's required minimum assurance level.",
    "",
    "Using the chapter's case settings $PM = {{performance_materiality}}$ and $\\beta = 0.01$, the achieved assurance is {{assurance_over}} for detecting a material overstatement and {{assurance_under}} for detecting a material understatement."
  )
}

reg_annual_decision_bounds_template <- function() {
  c(
    "For US SteamCo, the 99\\% acceptable difference range implied by the standardized decision bounds is",
    "",
    "\\[",
    "\\text{ADR} = [{{adr_lower}},\\ {{adr_upper}}],",
    "\\]",
    "",
    "which corresponds to standardized bounds",
    "",
    "\\[",
    "c_L = {{c_lower}}, \\qquad c_U = {{c_upper}}.",
    "\\]",
    "",
    "Equivalently, dividing the acceptable difference range by $s_{comb}={{annual_se}}$ yields the same standardized decision rule $T \\in [{{c_lower}}, {{c_upper}}]$."
  )
}

inline_values_placeholder_template <- function() {
  c("Notebook-emitted inline values group (macro snippet generated in derived outputs).")
}

required_entries <- list(
  list(id = "aux.mpu.estimator", file = "aux.mpu.estimator.json", template = aux_mpu_template),
  list(id = "aux.regression.estimator", file = "aux.regression.estimator.json", template = aux_regression_template),
  list(id = "aux.difference.estimator", file = "aux.difference.estimator.json", template = aux_difference_template),
  list(id = "aux.ratio.estimator", file = "aux.ratio.estimator.json", template = aux_ratio_template),
  list(id = "est.mean.point_estimate", file = "est.mean.point_estimate.json", template = est_mean_point_template),
  list(id = "est.total.point_estimate", file = "est.total.point_estimate.json", template = est_total_point_template),
  list(id = "est.mean.two_sided_interval_95", file = "est.mean.two_sided_interval_95.json", template = est_mean_two_sided_95_template),
  list(id = "est.mean.two_sided_interval_99", file = "est.mean.two_sided_interval_99.json", template = est_mean_two_sided_99_template),
  list(id = "est.mean.one_sided_upper_95", file = "est.mean.one_sided_upper_95.json", template = est_mean_one_sided_upper_95_template),
  list(id = "est.mean.two_sided_finite_95", file = "est.mean.two_sided_finite_95.json", template = est_mean_two_sided_finite_95_template),
  list(id = "est.mean.minimum_sample_size_infinite", file = "est.mean.minimum_sample_size_infinite.json", template = est_mean_minimum_sample_size_infinite_template),
  list(id = "est.mean.stein_interval", file = "est.mean.stein_interval.json", template = est_mean_stein_interval_template),
  list(id = "est.mean.minimum_sample_size_finite", file = "est.mean.minimum_sample_size_finite.json", template = est_mean_minimum_sample_size_finite_template),
  list(id = "est.prop.point_estimate", file = "est.prop.point_estimate.json", template = est_prop_point_estimate_template),
  list(id = "est.prop.total_point_estimate", file = "est.prop.total_point_estimate.json", template = est_prop_total_point_estimate_template),
  list(id = "est.prop.binomial_interval_95", file = "est.prop.binomial_interval_95.json", template = est_prop_binomial_interval_95_template),
  list(id = "est.prop.minimum_sample_size_normal", file = "est.prop.minimum_sample_size_normal.json", template = est_prop_minimum_sample_size_normal_template),
  list(id = "est.prop.binomial_interval_extended", file = "est.prop.binomial_interval_extended.json", template = est_prop_binomial_interval_extended_template),
  list(id = "hyp.mus.sample_size", file = "hyp.mus.sample_size.json", template = hyp_mus_sample_size_template),
  list(id = "hyp.mus.attribute_sample_sizes_rows", file = "hyp.mus.attribute_sample_sizes_rows.json", template = hyp_mus_attribute_sample_sizes_rows_template),
  list(id = "hyp.cell.evaluation_steps", file = "hyp.cell.evaluation_steps.json", template = hyp_cell_evaluation_steps_template),
  list(id = "reg.annual.expectation_interval", file = "reg.annual.expectation_interval.json", template = reg_annual_expectation_interval_template),
  list(id = "reg.annual.assurance", file = "reg.annual.assurance.json", template = reg_annual_assurance_template),
  list(id = "reg.annual.decision_bounds", file = "reg.annual.decision_bounds.json", template = reg_annual_decision_bounds_template),
  list(id = "pro.inline.linked_values", file = "pro.inline.linked_values.json", template = inline_values_placeholder_template),
  list(id = "reg.inline.linked_values", file = "reg.inline.linked_values.json", template = inline_values_placeholder_template)
)

normalize_registry_value <- function(item, default_tolerance = NULL, default_scope = NULL) {
  required <- c("id", "raw", "format")
  missing <- required[!vapply(required, function(k) !is.null(item[[k]]), logical(1L))]
  if (length(missing)) {
    stop("Notebook values entry is missing required field(s): ", paste(missing, collapse = ", "), call. = FALSE)
  }

  role <- item$role %||% sub("^.*\\.", "", item$id)
  display <- item$display %||% NULL
  tolerance <- item$tolerance %||% default_tolerance
  scope <- item$language_scope %||% default_scope

  mc_value(
    id = as.character(item$id),
    role = as.character(role),
    raw = as.numeric(item$raw),
    format = as.character(item$format),
    display = if (is.null(display)) NULL else as.character(display),
    tolerance = if (is.null(tolerance)) NULL else as.numeric(tolerance),
    language_scope = if (is.null(scope)) NULL else as.character(scope)
  )
}

read_notebook_values_entry <- function(path, expected_id) {
  if (!file.exists(path)) {
    return(NULL)
  }
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required to read notebook-emitted manuscript calculation values.")
  }

  raw_entry <- jsonlite::fromJSON(path, simplifyVector = FALSE)
  entry_id <- raw_entry$id %||% NA_character_
  if (!identical(entry_id, expected_id)) {
    stop("Notebook values file has unexpected id: ", entry_id, " (expected ", expected_id, ")", call. = FALSE)
  }

  default_tol <- suppressWarnings(as.numeric(raw_entry$tolerance %||% 1e-8))
  if (!is.finite(default_tol)) default_tol <- 1e-8
  default_scope <- raw_entry$language_scope %||% "shared"

  values <- lapply(
    raw_entry$values,
    normalize_registry_value,
    default_tolerance = default_tol,
    default_scope = default_scope
  )

  metadata <- mc_group(
    id = expected_id,
    kind = raw_entry$kind %||% "worked_calculation",
    source_notebook = raw_entry$source_notebook %||% "notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
    source_context = raw_entry$source_context %||% "Notebook-emitted values for MPU estimator",
    source_dataset = raw_entry$source_dataset %||% "FSaudit::inventoryData",
    target_snippet = raw_entry$target_snippet,
    tolerance = default_tol,
    language_scope = as.character(default_scope),
    equation_labels = raw_entry$equation_labels %||% character(),
    values = values
  )

  list(metadata = metadata, source = "notebook_values", entry_file = basename(path))
}

resolve_aux_entries <- function(values_dir) {
  resolved <- vector("list", length(required_entries))
  for (i in seq_along(required_entries)) {
    spec <- required_entries[[i]]
    notebook_values_path <- file.path(values_dir, spec$file)
    from_notebook <- read_notebook_values_entry(notebook_values_path, spec$id)
    if (is.null(from_notebook)) {
      stop(
        paste(
          c(
            "Missing notebook-emitted values for ", spec$id, ".",
            paste0("Expected file: ", notebook_values_path),
            "Regenerate values via the relevant chapter support export and rerun:",
            "  Rscript scripts/export-workshops.R --slug <chapter-slug>",
            "  Rscript scripts/generate-worked-calculations.R"
          ),
          collapse = "\n"
        ),
        call. = FALSE
      )
    }
    resolved[[i]] <- c(from_notebook, list(template = spec$template))
  }
  resolved
}

render_aux_outputs <- function(resolved_entry) {
  list(
    tex = mc_render_snippet(resolved_entry$metadata, resolved_entry$template()),
    metadata = resolved_entry$metadata,
    source = resolved_entry$source,
    target_snippet = resolved_entry$metadata$target_snippet
  )
}

render_derived_outputs <- function(resolved_entries) {
  by_id <- stats::setNames(
    lapply(resolved_entries, function(entry) entry$metadata),
    vapply(resolved_entries, function(entry) entry$metadata$id, character(1L))
  )

  get_entry_values <- function(id) {
    entry <- by_id[[id]]
    if (is.null(entry)) {
      stop("Missing resolved metadata for ", id, call. = FALSE)
    }
    mc_values_by_role(entry$values)
  }

  get_display <- function(id, role) {
    values_by_role <- get_entry_values(id)
    value <- values_by_role[[role]]
    if (is.null(value)) {
      stop(id, " is missing value role: ", role, call. = FALSE)
    }
    value$display
  }

  get_raw <- function(id, role) {
    values_by_role <- get_entry_values(id)
    value <- values_by_role[[role]]
    if (is.null(value)) {
      stop(id, " is missing value role: ", role, call. = FALSE)
    }
    as.numeric(value$raw)
  }

  macro_line <- function(name, display) {
    display_math <- gsub(",", "{,}", display, fixed = TRUE)
    paste0("\\providecommand{\\", name, "}{\\ifmmode ", display_math, "\\else ", display, "\\fi}")
  }

  derived_id <- "est.mean.point_estimate_inline_values"
  derived_source_notebook <- "notebooks/support/population-estimation/support.Rmd"
  derived_target_snippet <- "generated/worked-calculations/est-mean-point-estimate-inline-value.tex"

  sample_size <- get_raw("est.mean.two_sided_interval_95", "sample_size")
  df_95 <- sample_size - 1
  if (!is.finite(df_95) || df_95 < 0) {
    stop("Unable to derive valid df from est.mean.two_sided_interval_95 sample_size", call. = FALSE)
  }

  total_precision_95 <- get_raw("est.mean.two_sided_interval_95", "total_upper_95") -
    get_raw("est.total.point_estimate", "estimated_total_gross")
  if (!is.finite(total_precision_95)) {
    stop("Unable to derive est.mean total precision value", call. = FALSE)
  }

  df_95_display <- mc_format_value(df_95, "integer")
  total_precision_95_display <- mc_format_value(total_precision_95, "integer")

  derived_values <- list(
    mc_value(id = "est.mean.inline_point_estimate", role = "point_estimate", raw = get_raw("est.mean.point_estimate", "sample_mean"), format = "number:2"),
    mc_value(id = "est.mean.inline_lower_95", role = "lower_95", raw = get_raw("est.mean.two_sided_interval_95", "lower_95"), format = "number:2"),
    mc_value(id = "est.mean.inline_upper_95", role = "upper_95", raw = get_raw("est.mean.two_sided_interval_95", "upper_95"), format = "number:2"),
    mc_value(id = "est.mean.inline_total_lower_95", role = "total_lower_95", raw = get_raw("est.mean.two_sided_interval_95", "total_lower_95"), format = "integer"),
    mc_value(id = "est.mean.inline_total_upper_95", role = "total_upper_95", raw = get_raw("est.mean.two_sided_interval_95", "total_upper_95"), format = "integer"),
    mc_value(id = "est.mean.inline_total_precision_95", role = "total_precision_95", raw = total_precision_95, format = "integer"),
    mc_value(id = "est.mean.inline_sample_size", role = "sample_size", raw = get_raw("est.mean.two_sided_interval_95", "sample_size"), format = "integer"),
    mc_value(id = "est.mean.inline_df", role = "df", raw = df_95, format = "integer"),
    mc_value(id = "est.mean.inline_sample_variance", role = "sample_variance", raw = get_raw("est.mean.two_sided_interval_95", "sample_variance"), format = "integer"),
    mc_value(id = "est.mean.inline_sample2_mean", role = "sample2_mean", raw = get_raw("est.mean.stein_interval", "sample2_mean"), format = "number:2"),
    mc_value(id = "est.mean.inline_population_size", role = "population_size", raw = get_raw("est.mean.two_sided_interval_95", "population_size"), format = "integer"),
    mc_value(id = "est.prop.inline_k", role = "k", raw = get_raw("est.prop.point_estimate", "k"), format = "integer"),
    mc_value(id = "est.prop.inline_n", role = "n", raw = get_raw("est.prop.point_estimate", "n"), format = "integer"),
    mc_value(id = "est.prop.inline_target_precision", role = "target_precision", raw = get_raw("est.prop.minimum_sample_size_normal", "target_prop_precision"), format = "number:1")
  )

  derived_metadata <- mc_group(
    id = derived_id,
    kind = "inline_values",
    source_notebook = derived_source_notebook,
    source_context = "Derived inline macros for Estimation chapter prose values",
    source_dataset = "FSaudit::salaries",
    target_snippet = derived_target_snippet,
    tolerance = 1e-8,
    language_scope = "r",
    values = derived_values
  )

  aux_derived_id <- "aux.inline_linked_values"
  aux_derived_source_notebook <- "notebooks/support/auxiliary-variables-and-stratification/support.Rmd"
  aux_derived_target_snippet <- "generated/worked-calculations/aux-inline-linked-values.tex"

  sporadic_ratio_variance_component <-
    (230244509 - 2 * 0.9825 * 231280871 + 0.9825^2 * 234376912) / (6 - 1)
  stratified_mpu_estimate <- 1650470.12 + 4008343.01 + 2011887.29

  aux_derived_values <- list(
    mc_value(
      id = "aux.inline.sporadic_ratio_variance_component",
      role = "sporadic_ratio_variance_component",
      raw = sporadic_ratio_variance_component,
      format = "integer"
    ),
    mc_value(
      id = "aux.inline.stratified_mpu_estimate",
      role = "stratified_mpu_estimate",
      raw = stratified_mpu_estimate,
      format = "number:2"
    )
  )

  aux_derived_metadata <- mc_group(
    id = aux_derived_id,
    kind = "inline_values",
    source_notebook = aux_derived_source_notebook,
    source_context = "Derived inline macros for Auxiliary chapter prose values",
    source_dataset = "FSaudit::accounts_receivable + FSaudit::inventoryData",
    target_snippet = aux_derived_target_snippet,
    tolerance = 1e-8,
    language_scope = "r",
    values = aux_derived_values
  )

  prob_derived_id <- "pro.inline.linked_values"
  prob_derived_source_notebook <- "notebooks/support/probability-distributions/support.Rmd"
  prob_derived_target_snippet <- "generated/worked-calculations/prob-inline-linked-values.tex"

  reg_derived_id <- "reg.inline.linked_values"
  reg_derived_source_notebook <- "notebooks/support/regression-analysis/support.Rmd"
  reg_derived_target_snippet <- "generated/worked-calculations/reg-inline-linked-values.tex"

  list(
    list(
      filename = "est-mean-point-estimate-inline-value.tex",
      content = c(
        "% Generated by scripts/generate-worked-calculations.R; do not edit by hand.",
        "% Derived from Estimation worked-calculation registry values.",
        paste0("% Registry ID: ", derived_id),
        paste0("% Source notebook: ", derived_source_notebook),
        macro_line("EstMeanPointEstimate", get_display("est.mean.point_estimate", "sample_mean")),
        macro_line("EstMeanLower95", get_display("est.mean.two_sided_interval_95", "lower_95")),
        macro_line("EstMeanUpper95", get_display("est.mean.two_sided_interval_95", "upper_95")),
        macro_line("EstMeanTotalLower95", get_display("est.mean.two_sided_interval_95", "total_lower_95")),
        macro_line("EstMeanTotalUpper95", get_display("est.mean.two_sided_interval_95", "total_upper_95")),
        macro_line("EstMeanTotalPrecision95", total_precision_95_display),
        macro_line("EstMeanSampleSize", get_display("est.mean.two_sided_interval_95", "sample_size")),
        macro_line("EstMeanDf", df_95_display),
        macro_line("EstMeanSampleVariance", get_display("est.mean.two_sided_interval_95", "sample_variance")),
        macro_line("EstMeanSampleTwoMean", get_display("est.mean.stein_interval", "sample2_mean")),
        macro_line("EstPopulationSize", get_display("est.mean.two_sided_interval_95", "population_size")),
        macro_line("EstPropK", get_display("est.prop.point_estimate", "k")),
        macro_line("EstPropSampleSize", get_display("est.prop.point_estimate", "n")),
        macro_line("EstPropTargetPrecision", get_display("est.prop.minimum_sample_size_normal", "target_prop_precision"))
      ),
      metadata = derived_metadata,
      target_snippet = derived_target_snippet
    ),
    list(
      filename = "aux-inline-linked-values.tex",
      content = c(
        "% Generated by scripts/generate-worked-calculations.R; do not edit by hand.",
        "% Derived from Auxiliary worked-calculation registry values.",
        paste0("% Registry ID: ", aux_derived_id),
        paste0("% Source notebook: ", aux_derived_source_notebook),
        macro_line(
          "AuxSporadicRatioVariance",
          mc_format_value(sporadic_ratio_variance_component, "integer")
        ),
        macro_line(
          "AuxStratifiedMpuEstimate",
          mc_format_value(stratified_mpu_estimate, "number:2")
        )
      ),
      metadata = aux_derived_metadata,
      target_snippet = aux_derived_target_snippet
    ),
    list(
      filename = "prob-inline-linked-values.tex",
      content = c(
        "% Generated by scripts/generate-worked-calculations.R; do not edit by hand.",
        "% Derived from Probability worked-calculation registry values.",
        paste0("% Registry ID: ", prob_derived_id),
        paste0("% Source notebook: ", prob_derived_source_notebook),
        macro_line("ProbPopulationSize", get_display("pro.inline.linked_values", "population_size")),
        macro_line("ProbErrorCount", get_display("pro.inline.linked_values", "error_count")),
        macro_line("ProbCorrectCount", get_display("pro.inline.linked_values", "correct_count")),
        macro_line("ProbSampleSize", get_display("pro.inline.linked_values", "sample_size")),
        macro_line("ProbFirstCorrectProbability", get_display("pro.inline.linked_values", "first_correct_probability")),
        macro_line("ProbSecondCorrectGivenFirstCorrect", get_display("pro.inline.linked_values", "second_correct_given_first_correct")),
        macro_line("ProbSecondCorrectGivenFirstIncorrect", get_display("pro.inline.linked_values", "second_correct_given_first_incorrect")),
        macro_line("ProbZeroErrorProbability", get_display("pro.inline.linked_values", "zero_error_probability"))
      ),
      metadata = by_id[[prob_derived_id]],
      target_snippet = prob_derived_target_snippet
    ),
    list(
      filename = "reg-inline-linked-values.tex",
      content = c(
        "% Generated by scripts/generate-worked-calculations.R; do not edit by hand.",
        "% Derived from Regression worked-calculation registry values.",
        paste0("% Registry ID: ", reg_derived_id),
        paste0("% Source notebook: ", reg_derived_source_notebook),
        macro_line("RegModThreeW", get_display("reg.inline.linked_values", "mod3_w")),
        macro_line("RegModThreeShapiroP", get_display("reg.inline.linked_values", "mod3_shapiro_p")),
        macro_line("RegModThreeBp", get_display("reg.inline.linked_values", "mod3_bp")),
        macro_line("RegModThreeBpP", get_display("reg.inline.linked_values", "mod3_bp_p")),
        macro_line("RegModThreeBg", get_display("reg.inline.linked_values", "mod3_bg")),
        macro_line("RegModThreeBgP", get_display("reg.inline.linked_values", "mod3_bg_p")),
        macro_line("RegModFourBg", get_display("reg.inline.linked_values", "mod4_bg")),
        macro_line("RegModFourBgP", get_display("reg.inline.linked_values", "mod4_bg_p")),
        macro_line("RegModFiveBp", get_display("reg.inline.linked_values", "mod5_bp")),
        macro_line("RegModFiveBpP", get_display("reg.inline.linked_values", "mod5_bp_p")),
        macro_line("RegModFiveBg", get_display("reg.inline.linked_values", "mod5_bg")),
        macro_line("RegModFiveBgP", get_display("reg.inline.linked_values", "mod5_bg_p")),
        macro_line("RegModFiveW", get_display("reg.inline.linked_values", "mod5_w")),
        macro_line("RegModFiveShapiroP", get_display("reg.inline.linked_values", "mod5_shapiro_p"))
      ),
      metadata = by_id[[reg_derived_id]],
      target_snippet = reg_derived_target_snippet
    )
  )
}

write_outputs <- function(output_dir, values_dir) {
  resolved_entries <- resolve_aux_entries(values_dir)
  rendered <- lapply(resolved_entries, render_aux_outputs)
  derived <- render_derived_outputs(resolved_entries)
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  output_paths <- character()
  for (item in rendered) {
    snippet_basename <- sub("\\.tex$", "", basename(item$target_snippet))
    tex_path <- file.path(output_dir, paste0(snippet_basename, ".tex"))
    json_path <- file.path(output_dir, paste0(snippet_basename, ".json"))
    writeLines(item$tex, tex_path, useBytes = TRUE)
    write_json_metadata(json_path, item$metadata)
    output_paths <- c(output_paths, tex_path, json_path)
  }

  for (item in derived) {
    output_path <- file.path(output_dir, item$filename)
    writeLines(item$content, output_path, useBytes = TRUE)
    output_paths <- c(output_paths, output_path)

    if (!is.null(item$metadata)) {
      snippet_basename <- sub("\\.tex$", "", basename(item$target_snippet %||% item$filename))
      json_path <- file.path(output_dir, paste0(snippet_basename, ".json"))
      write_json_metadata(json_path, item$metadata)
      output_paths <- c(output_paths, json_path)
    }
  }

  list(paths = output_paths, source = "notebook_values")
}

files_identical <- function(path_a, path_b) {
  isTRUE(identical(readBin(path_a, "raw", n = file.info(path_a)$size),
                   readBin(path_b, "raw", n = file.info(path_b)$size)))
}

json_metadata_equivalent <- function(expected_path, actual_path) {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("jsonlite is required to compare generated JSON metadata.")
  }

  expected <- jsonlite::fromJSON(expected_path, simplifyVector = FALSE)
  actual <- jsonlite::fromJSON(actual_path, simplifyVector = FALSE)

  scalar_fields <- c(
    "schema_version",
    "id",
    "kind",
    "chapter_prefix",
    "source_notebook",
    "source_context",
    "source_dataset",
    "target_snippet",
    "language_scope"
  )

  for (field in scalar_fields) {
    if (!identical(expected[[field]], actual[[field]])) {
      return(FALSE)
    }
  }

  if (!identical(expected$equation_labels, actual$equation_labels)) {
    return(FALSE)
  }

  if (length(expected$values) != length(actual$values)) {
    return(FALSE)
  }

  default_tolerance <- suppressWarnings(as.numeric(expected$tolerance %||% 0))
  if (!is.finite(default_tolerance)) {
    default_tolerance <- 0
  }

  value_tolerance <- function(item) {
    tol <- suppressWarnings(as.numeric(item$tolerance %||% default_tolerance))
    if (!is.finite(tol)) {
      return(default_tolerance)
    }
    tol
  }

  equal_numeric <- function(a, b, tol) {
    if (is.na(a) || is.na(b)) {
      return(is.na(a) && is.na(b))
    }
    abs(a - b) <= tol
  }

  for (i in seq_along(expected$values)) {
    e <- expected$values[[i]]
    a <- actual$values[[i]]
    if (!identical(e$id, a$id) || !identical(e$role, a$role) || !identical(e$format, a$format)) {
      return(FALSE)
    }

    e_scope <- e$language_scope %||% NULL
    a_scope <- a$language_scope %||% NULL
    if (!identical(e_scope, a_scope)) {
      return(FALSE)
    }

    e_raw <- suppressWarnings(as.numeric(e$raw))
    a_raw <- suppressWarnings(as.numeric(a$raw))
    tol <- max(value_tolerance(e), value_tolerance(a))
    if (!equal_numeric(e_raw, a_raw, tol)) {
      return(FALSE)
    }
  }

  TRUE
}

check_outputs <- function(output_dir, values_dir) {
  temp_dir <- tempfile("worked-calculations-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  expected <- write_outputs(temp_dir, values_dir)$paths
  target <- file.path(output_dir, basename(expected))
  failures <- character()

  for (i in seq_along(expected)) {
    if (!file.exists(target[[i]])) {
      failures <- c(failures, paste0("Missing generated file: ", target[[i]]))
      next
    }
    same <- if (grepl("\\.json$", expected[[i]], ignore.case = TRUE)) {
      json_metadata_equivalent(expected[[i]], target[[i]])
    } else {
      files_identical(expected[[i]], target[[i]])
    }
    if (!same) {
      failures <- c(failures, paste0("Stale generated file: ", target[[i]]))
    }
  }

  if (length(failures)) {
    stop(
      paste(
        c(
          "Worked calculation check failed. Regenerate with:",
          "  Rscript scripts/generate-worked-calculations.R",
          failures
        ),
        collapse = "\n"
      ),
      call. = FALSE
    )
  }
}

args <- parse_args(commandArgs(trailingOnly = TRUE))
if (isTRUE(args$help)) {
  print_help()
  quit(status = 0L)
}

if (isTRUE(args$check)) {
  check_outputs(args$output_dir, args$values_dir)
  message("Generated worked calculations are up to date.")
} else {
  out <- write_outputs(args$output_dir, args$values_dir)
  paths <- out$paths
  message("Wrote generated worked calculations:\n  ", paste(paths, collapse = "\n  "))
  message("Source mode: ", out$source)
}
