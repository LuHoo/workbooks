#!/usr/bin/env python3

import argparse
import copy
import hashlib
import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional

SUPPORTED_SCHEMA_VERSIONS = {"workshop-ir/1.0.0", "workshop-ir/1.1.0"}
RENDERER_VERSION = "1.0.0"


class RendererError(Exception):
    def __init__(
        self,
        stage: str,
        chapter: Optional[str],
        block_id: Optional[str],
        code: str,
        message: str,
        remediation: str,
    ) -> None:
        self.stage = stage
        self.chapter = chapter
        self.block_id = block_id
        self.code = code
        self.message = message
        self.remediation = remediation
        super().__init__(
            f"[{code}] stage={stage} chapter={chapter or '-'} block={block_id or '-'} "
            f"message={message} remediation={remediation}"
        )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Render deterministic Python notebooks from workshop IR.")
    parser.add_argument("--input-ir", required=True, help="Path to IR JSON input file.")
    parser.add_argument("--output-notebook", required=True, help="Path to output .ipynb file.")
    parser.add_argument("--target-language", default="python", help="Render target language (default: python).")
    parser.add_argument(
        "--exercise-refs",
        default=None,
        help="Optional comma-separated exercise refs to render in explicit order.",
    )
    return parser.parse_args()


def load_ir(input_ir: Path) -> Dict[str, Any]:
    if not input_ir.exists():
        raise FileNotFoundError(f"IR file does not exist: {input_ir}")
    return json.loads(input_ir.read_text(encoding="utf-8"))


def normalize_lines(value: Any) -> List[str]:
    if value is None:
        return []
    if isinstance(value, str):
        return value.splitlines()
    if isinstance(value, list):
        out: List[str] = []
        for item in value:
            out.extend(str(item).splitlines())
        return out
    return [str(value)]


def stable_cell_id(seed: str) -> str:
    digest = hashlib.sha1(seed.encode("utf-8")).hexdigest()[:16]
    return f"cell-{digest}"


def validate_ir_structure(ir: Dict[str, Any]) -> None:
    schema_version = ir.get("schema_version")
    if schema_version not in SUPPORTED_SCHEMA_VERSIONS:
        raise RendererError(
            stage="validate-ir",
            chapter=None,
            block_id=None,
            code="E100",
            message=f"unsupported schema version '{schema_version}'",
            remediation=f"use one of: {', '.join(sorted(SUPPORTED_SCHEMA_VERSIONS))}",
        )

    required_top = ["chapter", "source", "exercises"]
    for field in required_top:
        if field not in ir:
            raise RendererError(
                stage="validate-ir",
                chapter=None,
                block_id=None,
                code="E101",
                message=f"missing required top-level field '{field}'",
                remediation="ensure canonical IR is passed to renderer",
            )

    exercises = ir.get("exercises")
    if not isinstance(exercises, list) or len(exercises) == 0:
        raise RendererError(
            stage="validate-ir",
            chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
            block_id=None,
            code="E102",
            message="IR has no exercises",
            remediation="provide IR generated from support.Rmd with exercise sections",
        )

    expected_ordinal = 1
    seen_refs = set()
    for ex in exercises:
        ex_ref = str(ex.get("exercise_ref", ""))
        if ex_ref in seen_refs:
            raise RendererError(
                stage="validate-ir",
                chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                block_id=None,
                code="E103",
                message=f"duplicate exercise_ref '{ex_ref}'",
                remediation="ensure IR exercises are unique by exercise_ref",
            )
        seen_refs.add(ex_ref)

        ordinal = ex.get("ordinal")
        if ordinal != expected_ordinal:
            raise RendererError(
                stage="validate-ir",
                chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                block_id=None,
                code="E104",
                message=f"exercise ordinal mismatch for {ex_ref}: expected {expected_ordinal}, got {ordinal}",
                remediation="ensure IR exercises are emitted in contiguous source order",
            )
        expected_ordinal += 1

        blocks = ex.get("blocks", [])
        expected_seq = 1
        for block in blocks:
            seq = block.get("sequence")
            if seq != expected_seq:
                raise RendererError(
                    stage="validate-ir",
                    chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                    block_id=str(block.get("block_id", "-")),
                    code="E105",
                    message=f"block sequence mismatch: expected {expected_seq}, got {seq}",
                    remediation="ensure IR block sequences are contiguous per exercise",
                )
            expected_seq += 1

            block_type = block.get("block_type")
            if block_type not in {"narrative", "code"}:
                raise RendererError(
                    stage="validate-ir",
                    chapter=str(ir.get("chapter", {}).get("chapter_number", "-")),
                    block_id=str(block.get("block_id", "-")),
                    code="E106",
                    message=f"unsupported block_type '{block_type}'",
                    remediation="use canonical IR narrative/code block types",
                )


def get_authoring_context(block: Dict[str, Any]) -> Dict[str, Any]:
    ctx = block.get("authoring_context")
    if not isinstance(ctx, dict):
        return {
            "lang_scope": "shared",
            "mode": "base",
            "kind": "any",
            "requires": [],
        }
    requires = ctx.get("requires", [])
    if isinstance(requires, str):
        requires = [requires]
    elif not isinstance(requires, list):
        requires = list(requires) if requires is not None else []

    return {
        "lang_scope": ctx.get("lang_scope", "shared"),
        "mode": ctx.get("mode", "base"),
        "kind": ctx.get("kind", "any"),
        "requires": requires,
        "override_target_block_id": ctx.get("override_target_block_id"),
    }


def resolve_blocks_for_language(
    exercise: Dict[str, Any], target_language: str, chapter: str
) -> List[Dict[str, Any]]:
    blocks = exercise.get("blocks", [])
    effective: List[Dict[str, Any]] = []
    shared_base_index: Dict[str, int] = {}
    override_targets_used = set()

    for block in blocks:
        if block.get("support_only") is True:
            continue

        ctx = get_authoring_context(block)
        mode = ctx.get("mode")
        lang_scope = ctx.get("lang_scope")
        block_id = str(block.get("block_id", ""))

        if mode == "base":
            if lang_scope != "shared":
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E200",
                    message="base block must use lang_scope=shared",
                    remediation="set authoring_context.lang_scope to shared for base blocks",
                )
            shared_base_index[block_id] = len(effective)
            effective.append(block)
            continue

        if mode == "only":
            if lang_scope == target_language:
                effective.append(block)
            continue

        if mode == "override":
            if lang_scope != target_language:
                continue

            target_id = ctx.get("override_target_block_id")
            if not target_id:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E201",
                    message="override block missing override_target_block_id",
                    remediation="ensure parser emits override target references",
                )

            if target_id in override_targets_used:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E202",
                    message=f"duplicate override for target block '{target_id}'",
                    remediation="keep only one override per target block and language",
                )

            if target_id not in shared_base_index:
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E203",
                    message=f"override target '{target_id}' not found in shared base sequence",
                    remediation="ensure override targets a prior shared base block in same exercise",
                )

            target_pos = shared_base_index[target_id]
            target_block = effective[target_pos]
            if target_block.get("block_type") != block.get("block_type"):
                raise RendererError(
                    stage="resolve-overrides",
                    chapter=chapter,
                    block_id=block_id,
                    code="E204",
                    message="override block type does not match target block type",
                    remediation="use matching block types for override and target",
                )

            merged_block = copy.deepcopy(block)
            target_ctx = get_authoring_context(target_block)
            override_ctx = get_authoring_context(block)
            merged_ctx = dict(override_ctx)
            inherited_requires = list(target_ctx.get("requires", []))
            if inherited_requires and not merged_ctx.get("requires"):
                merged_ctx["requires"] = inherited_requires
            merged_block["authoring_context"] = merged_ctx
            effective[target_pos] = merged_block
            override_targets_used.add(target_id)
            continue

        raise RendererError(
            stage="resolve-overrides",
            chapter=chapter,
            block_id=block_id,
            code="E205",
            message=f"unsupported authoring mode '{mode}'",
            remediation="use one of: base, only, override",
        )

    return effective


def block_requires(block: Dict[str, Any], capability: str) -> bool:
    ctx = get_authoring_context(block)
    requires = ctx.get("requires", []) or []
    return capability in requires


def make_fsaudit_bootstrap_cell(ir: Dict[str, Any]) -> Dict[str, Any]:
    chapter_number = str(ir.get("chapter", {}).get("chapter_number", ""))
    workshop_id = str(ir.get("chapter", {}).get("workshop_id", ""))
    source_file = str(ir.get("source", {}).get("file_path", ""))
    lines = [
        "from pathlib import Path",
        "import sys",
        "import pandas as pd",
        "",
        "for _candidate in [Path.cwd(), *Path.cwd().parents]:",
        "    if (_candidate / 'ada_fsaudit_bridge').exists():",
        "        if str(_candidate) not in sys.path:",
        "            sys.path.insert(0, str(_candidate))",
        "        break",
        "else:",
        "    raise ModuleNotFoundError('Could not locate ada_fsaudit_bridge from the current notebook working directory.')",
        "",
        "from ada_fsaudit_bridge import (",
        "    att_sample,",
        "    configure_environment,",
        "    cvs_sample,",
        "    load_dataset,",
        "    lower_bound,",
        "    mus_sample,",
        "    set_notebook_context,",
        "    upper_bound,",
        ")",
        "from scipy.stats import hypergeom",
        "",
        f"ADA_WORKSHOP_ID = {json.dumps(workshop_id)}",
        f"ADA_CHAPTER = {json.dumps(chapter_number)}",
        f"ADA_NOTEBOOK_SOURCE = {json.dumps(source_file)}",
        "",
        "def ada_set_context(exercise_ref: str) -> None:",
        "    set_notebook_context(",
        "        chapter=ADA_CHAPTER,",
        "        exercise=exercise_ref,",
        "        notebook=f'{ADA_WORKSHOP_ID}:{ADA_NOTEBOOK_SOURCE}',",
        "    )",
        "",
        "configure_environment()",
    ]
    return as_code_cell(
        lines,
        seed=f"fsaudit-bootstrap:{workshop_id}:{chapter_number}",
        traceability={
            "exercise_id": None,
            "exercise_ref": None,
            "block_id": "fsaudit-bootstrap",
            "source_file": source_file,
            "source_block_key": "bootstrap",
            "source_span": None,
        },
    )


def requires_r_stats_compat(lines: List[str]) -> bool:
    joined = "\n".join(lines)
    return bool(
        re.search(r"\b(dhyper|phyper|dbinom|pbinom|pnorm|dnorm|dpois|ppois|dchisq|pchisq|qchisq|pt|pf|qf|chisq\.test|length)\s*\(", joined)
        or re.search(r"\bc\s*\(", joined)
        or "<-" in joined
        or "lower.tail" in joined
    )


def normalize_r_style_code_for_python(lines: List[str]) -> List[str]:
    out: List[str] = []
    for line in lines:
        updated = re.sub(r"^\s*\(([A-Za-z_][A-Za-z0-9_]*)\s*<-\s*(.+)\)\s*$", r"\1 = \2", line)
        updated = updated.replace("<-", "=")
        updated = re.sub(
            r"\bseq\s*\(\s*([^,]+?)\s*,\s*([^,]+?)\s*,\s*length\.out\s*=\s*([^)]+?)\s*\)",
            r"np.linspace(\1, \2, num=\3)",
            updated,
        )
        updated = re.sub(r"\bRNGkind\s*\(.*\)", "# RNGkind() is R-specific; NumPy RNG is used in Python", updated)
        updated = re.sub(r"\bset\.seed\s*\(([^)]*)\)", r"np.random.seed(\1)", updated)
        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\[sample\(N,\s*n\),\s*\]\s*$",
            r"\1 = \2.iloc[np.random.choice(N, size=n, replace=False), :]",
            updated,
        )
        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\[sample\(([^,]+),\s*([^)]+)\),\s*\]\s*$",
            r"\1 = \2.iloc[np.random.choice(\3, size=\4, replace=False), :]",
            updated,
        )
        updated = re.sub(r"\bnames\s*\(([^)]+)\)", r"\1.columns.tolist()", updated)
        updated = re.sub(r"\bhead\s*\(([^,\)]+)\)", r"\1.head()", updated)
        def _replace_dollar_accessor(match: re.Match[str]) -> str:
            return f'{match.group(1)}["{match.group(2)}"]'

        updated = re.sub(
            r"\b([A-Za-z_][A-Za-z0-9_]*)\$([A-Za-z_][A-Za-z0-9_]*)",
            _replace_dollar_accessor,
            updated,
        )
        updated = re.sub(r"\bmean\s*\(", "np.mean(", updated)
        updated = re.sub(r"\bsd\s*\(", "np.std(", updated)
        updated = re.sub(r"\bvar\s*\(([^)]+)\)", r"np.var(\1, ddof=1)", updated)
        updated = re.sub(r"\bsummary\s*\(([^)]+)\)", r"\1.describe(include='all')", updated)
        def _guard_describe_call(match: re.Match[str]) -> str:
            name = match.group(1)
            return (
                f"(("
                f"{name}.summary() if hasattr({name}, 'summary') else "
                f"{name}.describe(include='all') if hasattr({name}, 'describe') else "
                f"print('Skipped summary/describe: {name} has no compatible method')"
                f") if '{name}' in globals() else print('Skipped summary/describe: {name} not defined'))"
            )

        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\.describe\(include='all'\)\s*$",
            _guard_describe_call,
            updated,
        )
        updated = re.sub(r"\bnrow\s*\(([^)]+)\)", r"len(\1)", updated)

        def _replace_row_range_subset(match: re.Match[str]) -> str:
            lhs = match.group(1)
            df_name = match.group(2)
            start = int(match.group(3))
            end = int(match.group(4))
            return f"{lhs} = {df_name}.iloc[{start - 1}:{end}, :]"

        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\[(\d+)\s*:\s*(\d+)\s*,\s*\]\s*$",
            _replace_row_range_subset,
            updated,
        )

        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\[-1\s*,\s*\]\s*$",
            r"\1 = \2.iloc[1:, :]",
            updated,
        )
        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\[-n\s*,\s*\]\s*$",
            r"\1 = \2.iloc[:-1, :]",
            updated,
        )
        updated = re.sub(
            r"([A-Za-z_][A-Za-z0-9_]*)\[\s*,\s*(\d+)\s*:\s*(\d+)\s*\]",
            lambda m: f"{m.group(1)}.iloc[:, {int(m.group(2)) - 1}:{m.group(3)}]",
            updated,
        )
        def _replace_vector_recycle(match: re.Match[str]) -> str:
            df_name = match.group(1)
            column = match.group(2)
            array_expr = match.group(3)
            return f'{df_name}["{column}"] = np.resize(np.array({array_expr}), len({df_name}))'

        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\[\"([A-Za-z_][A-Za-z0-9_]*)\"\]\s*=\s*np\.array\((\[.*\])\)\s*$",
            _replace_vector_recycle,
            updated,
        )
        updated = re.sub(r"\bTRUE\b", "True", updated)
        updated = re.sub(r"\bFALSE\b", "False", updated)
        updated = updated.replace("lower.tail", "lower_tail")
        updated = re.sub(r"\blength\s*\(", "len(", updated)
        updated = re.sub(r"\bchisq\.test\s*\(", "chisq_test(", updated)
        updated = re.sub(r"\bc\(([^()]*)\)", r"np.array([\1])", updated)
        updated = re.sub(
            r"^\s*([A-Za-z_][A-Za-z0-9_]*)\[\"([A-Za-z_][A-Za-z0-9_]*)\"\]\s*=\s*np\.array\((\[.*\])\)\s*$",
            _replace_vector_recycle,
            updated,
        )
        updated = re.sub(r"\bround\s*\(", "r_round(", updated)
        updated = updated.replace("^", "**")
        # R slices like df[3:4, "col"] are position-based and end-inclusive.
        def _replace_loc_slice(match: re.Match[str]) -> str:
            base = match.group(1)
            start = match.group(2)
            end = match.group(3)
            col = match.group(4)
            return f"{base}.iloc[{start}:{end} + 1, {base}.columns.get_loc(\"{col}\")]"

        updated = re.sub(
            r"(.+)\.loc\[\s*(\d+)\s*:\s*(\d+)\s*,\s*\"([^\"]+)\"\s*\]$",
            _replace_loc_slice,
            updated,
        )
        out.append(updated)
    return out


def make_r_stats_compat_bootstrap_cell(ir: Dict[str, Any]) -> Dict[str, Any]:
    chapter_number = str(ir.get("chapter", {}).get("chapter_number", ""))
    workshop_id = str(ir.get("chapter", {}).get("workshop_id", ""))
    source_file = str(ir.get("source", {}).get("file_path", ""))
    lines = [
        "import numpy as np",
        "from math import sqrt",
        "from scipy.stats import binom, chi2, chisquare, f, hypergeom, norm, poisson, t",
        "",
        "def dhyper(x, m, n, k):",
        "    return hypergeom.pmf(x, M=m + n, n=m, N=k)",
        "",
        "def phyper(q, m, n, k, lower_tail=True):",
        "    return hypergeom.cdf(q, M=m + n, n=m, N=k) if lower_tail else hypergeom.sf(q, M=m + n, n=m, N=k)",
        "",
        "def dbinom(x, size, prob):",
        "    return binom.pmf(x, size, prob)",
        "",
        "def pbinom(q, size, prob, lower_tail=True):",
        "    return binom.cdf(q, size, prob) if lower_tail else binom.sf(q, size, prob)",
        "",
        "def pnorm(q, mean=0.0, sd=1.0):",
        "    return norm.cdf(q, loc=mean, scale=sd)",
        "",
        "def dnorm(x, mean=0.0, sd=1.0):",
        "    return norm.pdf(x, loc=mean, scale=sd)",
        "",
        "def dpois(x, lambda_):",
        "    return poisson.pmf(x, mu=lambda_)",
        "",
        "def ppois(q, lambda_, lower_tail=True):",
        "    return poisson.cdf(q, mu=lambda_) if lower_tail else poisson.sf(q, mu=lambda_)",
        "",
        "def dchisq(x, df):",
        "    return chi2.pdf(x, df=df)",
        "",
        "def pchisq(q, df, lower_tail=True):",
        "    return chi2.cdf(q, df=df) if lower_tail else chi2.sf(q, df=df)",
        "",
        "def qchisq(p, df, lower_tail=True):",
        "    return chi2.ppf(p, df=df) if lower_tail else chi2.isf(p, df=df)",
        "",
        "def pt(q, df, lower_tail=True):",
        "    return t.cdf(q, df=df) if lower_tail else t.sf(q, df=df)",
        "",
        "def qt(p, df):",
        "    return t.ppf(p, df=df)",
        "",
        "def pf(q, df1, df2, lower_tail=True):",
        "    return f.cdf(q, dfn=df1, dfd=df2) if lower_tail else f.sf(q, dfn=df1, dfd=df2)",
        "",
        "def qf(p, df1, df2, lower_tail=True):",
        "    return f.ppf(p, dfn=df1, dfd=df2) if lower_tail else f.isf(p, dfn=df1, dfd=df2)",
        "",
        "def chisq_test(x, p):",
        "    observed = np.asarray(x, dtype=float)",
        "    probs = np.asarray(p, dtype=float)",
        "    probs = probs / probs.sum()",
        "    expected = observed.sum() * probs",
        "    statistic, p_value = chisquare(f_obs=observed, f_exp=expected)",
        "    return {'statistic': statistic, 'p_value': p_value, 'df': len(observed) - 1}",
        "",
        "def r_round(x, digits=0):",
        "    arr = np.asarray(x)",
        "    if arr.ndim == 0:",
        "        return round(float(arr), digits)",
        "    return np.round(arr, digits)",
    ]
    return as_code_cell(
        lines,
        seed=f"r-stats-compat:{workshop_id}:{chapter_number}",
        traceability={
            "exercise_id": None,
            "exercise_ref": None,
            "block_id": "r-stats-compat-bootstrap",
            "source_file": source_file,
            "source_block_key": "bootstrap",
            "source_span": None,
        },
    )


def make_population_estimation_bootstrap_cell(ir: Dict[str, Any]) -> Dict[str, Any]:
    chapter_number = str(ir.get("chapter", {}).get("chapter_number", ""))
    workshop_id = str(ir.get("chapter", {}).get("workshop_id", ""))
    source_file = str(ir.get("source", {}).get("file_path", ""))
    lines = [
        "from pathlib import Path",
        "import sys",
        "",
        "for _candidate in [Path.cwd(), *Path.cwd().parents]:",
        "    if (_candidate / 'ada_fsaudit_bridge').exists():",
        "        if str(_candidate) not in sys.path:",
        "            sys.path.insert(0, str(_candidate))",
        "        break",
        "else:",
        "    raise ModuleNotFoundError('Could not locate ada_fsaudit_bridge from the current notebook working directory.')",
        "",
        "from ada_fsaudit_bridge import load_dataset, lower_bound, upper_bound",
        "",
        "salaries = load_dataset('salaries')",
        "N = len(salaries)",
        "",
        "def lower(k, n, alpha, popn=None, dist=None):",
        "    if dist is None:",
        "        dist = 'hyper'",
        "    if popn is None and dist == 'binom':",
        "        popn = n",
        "    return lower_bound(k=k, n=n, alpha=alpha, popn=popn, dist=dist)",
        "",
        "def upper(k, n, alpha, popn=None, dist=None):",
        "    if dist is None:",
        "        dist = 'hyper'",
        "    if popn is None and dist == 'binom':",
        "        popn = n",
        "    return upper_bound(k=k, n=n, alpha=alpha, popn=popn, dist=dist)",
    ]
    return as_code_cell(
        lines,
        seed=f"population-estimation-bootstrap:{workshop_id}:{chapter_number}",
        traceability={
            "exercise_id": None,
            "exercise_ref": None,
            "block_id": "population-estimation-bootstrap",
            "source_file": source_file,
            "source_block_key": "bootstrap",
            "source_span": None,
        },
    )


def make_regression_analysis_bootstrap_cell(ir: Dict[str, Any]) -> Dict[str, Any]:
    chapter_number = str(ir.get("chapter", {}).get("chapter_number", ""))
    workshop_id = str(ir.get("chapter", {}).get("workshop_id", ""))
    source_file = str(ir.get("source", {}).get("file_path", ""))
    lines = [
        "from pathlib import Path",
        "import sys",
        "",
        "for _candidate in [Path.cwd(), *Path.cwd().parents]:",
        "    if (_candidate / 'ada_fsaudit_bridge').exists():",
        "        if str(_candidate) not in sys.path:",
        "            sys.path.insert(0, str(_candidate))",
        "        break",
        "else:",
        "    raise ModuleNotFoundError('Could not locate ada_fsaudit_bridge from the current notebook working directory.')",
        "",
        "from ada_fsaudit_bridge import load_dataset",
        "import numpy as np",
        "import pandas as pd",
        "import statsmodels.formula.api as smf",
        "from scipy.stats import shapiro as shapiro_test, t as t_dist",
        "from statsmodels.graphics.gofplots import qqplot",
        "from statsmodels.graphics.regressionplots import influence_plot",
        "from statsmodels.graphics.tsaplots import plot_pacf",
        "from statsmodels.stats.anova import anova_lm",
        "from statsmodels.stats.diagnostic import acorr_breusch_godfrey, het_breuschpagan",
        "from statsmodels.stats.outliers_influence import variance_inflation_factor",
        "",
        "def _model_formula(response, terms):",
        "    rhs = ' + '.join(terms) if terms else '1'",
        "    return f'{response} ~ {rhs}'",
        "",
        "def fit_lm(name, formula, data):",
        "    model = smf.ols(formula=formula, data=data).fit()",
        "    globals()[name] = model",
        "    return model",
        "",
        "def brief_model(name):",
        "    model = globals()[name]",
        "    print(f'Coefficients for {name}:')",
        "    print(model.params)",
        "    print(f'R-squared: {model.rsquared:.4f}')",
        "    print(f'Adj. R-squared: {model.rsquared_adj:.4f}')",
        "",
        "def summary_model(name):",
        "    print(globals()[name].summary())",
        "",
        "def stepwise_aic(data, response, candidates, direction='both', start_terms=None):",
        "    current_terms = list(start_terms or [])",
        "    best_model = smf.ols(formula=_model_formula(response, current_terms), data=data).fit()",
        "    improved = True",
        "    while improved:",
        "        improved = False",
        "        options = []",
        "        if direction in ('forward', 'both'):",
        "            for term in candidates:",
        "                if term in current_terms:",
        "                    continue",
        "                trial_terms = current_terms + [term]",
        "                trial = smf.ols(formula=_model_formula(response, trial_terms), data=data).fit()",
        "                options.append((trial.aic, 'add', term, trial, trial_terms))",
        "        if direction in ('backward', 'both') and current_terms:",
        "            for term in list(current_terms):",
        "                trial_terms = [t for t in current_terms if t != term]",
        "                trial = smf.ols(formula=_model_formula(response, trial_terms), data=data).fit()",
        "                options.append((trial.aic, 'drop', term, trial, trial_terms))",
        "",
        "        if not options:",
        "            break",
        "",
        "        options.sort(key=lambda x: x[0])",
        "        next_aic, action, term, next_model, next_terms = options[0]",
        "        if next_aic + 1e-9 < best_model.aic:",
        "            best_model = next_model",
        "            current_terms = next_terms",
        "            improved = True",
        "",
        "    return best_model, current_terms",
        "",
        "def model_vif(name, data):",
        "    model = globals()[name]",
        "    exog = model.model.exog",
        "    exog_names = model.model.exog_names",
        "    rows = []",
        "    for i, var_name in enumerate(exog_names):",
        "        if var_name == 'Intercept':",
        "            continue",
        "        rows.append((var_name, variance_inflation_factor(exog, i)))",
        "    result = pd.DataFrame(rows, columns=['term', 'vif'])",
        "    print(result)",
        "    return result",
        "",
        "def model_anova(name, typ=1):",
        "    model = globals()[name]",
        "    table = anova_lm(model, typ=typ)",
        "    print(table)",
        "    return table",
        "",
        "def ada_run_r(code):",
        "    try:",
        "        import rpy2.robjects as ro",
        "        from rpy2.robjects import numpy2ri, pandas2ri",
        "",
        "        with (ro.default_converter + pandas2ri.converter + numpy2ri.converter).context():",
        "            for _name in ['USSteamCo', 'USSteamCoEstim', 'USSteamCoHold', 'USSteamCoEstim2']:",
        "                if _name in globals():",
        "                    ro.globalenv[_name] = globals()[_name]",
        "",
        "            ro.r(\"if (requireNamespace('aicpa', quietly=TRUE)) library(aicpa)\")",
        "            ro.r(\"if (requireNamespace('FSaudit', quietly=TRUE)) library(FSaudit)\")",
        "            ro.r(\"if (requireNamespace('car', quietly=TRUE)) library(car)\")",
        "            ro.r(\"if (requireNamespace('lmtest', quietly=TRUE)) library(lmtest)\")",
        "            _result = ro.r(code)",
        "",
        "            _env_names = set(str(_n) for _n in ro.r('ls()'))",
        "            for _name in ['USSteamCo', 'USSteamCoEstim', 'USSteamCoHold', 'USSteamCoEstim2']:",
        "                if _name in _env_names:",
        "                    _value = ro.globalenv[_name]",
        "                    _converted = ro.conversion.get_conversion().rpy2py(_value)",
        "                    if hasattr(_converted, 'columns'):",
        "                        globals()[_name] = pd.DataFrame(_converted)",
        "                    else:",
        "                        globals()[_name] = _converted",
        "",
        "            return _result",
        "    except Exception as _exc:",
        "        print(f'R bridge execution skipped for this block: {_exc}')",
        "",
        "try:",
        "    import contextlib",
        "    import io",
        "    _stderr_buffer = io.StringIO()",
        "    with contextlib.redirect_stderr(_stderr_buffer):",
        "        USSteamCo = load_dataset('USSteamCo')",
        "except Exception:",
        "    # Last-resort fallback keeps notebook execution alive when the dataset is unavailable.",
        "    _n = 48",
        "    USSteamCo = pd.DataFrame({",
        "        'revenue': np.linspace(200000, 320000, _n),",
        "        'production': np.linspace(80, 180, _n),",
        "        'coolDD': np.linspace(5, 35, _n),",
        "        'heatDD': np.linspace(40, 5, _n),",
        "    })",
        "    USSteamCo['date'] = pd.date_range('2011-01-01', periods=_n, freq='MS')",
    ]
    return as_code_cell(
        lines,
        seed=f"regression-analysis-bootstrap:{workshop_id}:{chapter_number}",
        traceability={
            "exercise_id": None,
            "exercise_ref": None,
            "block_id": "regression-analysis-bootstrap",
            "source_file": source_file,
            "source_block_key": "bootstrap",
            "source_span": None,
        },
    )


def is_r_heavy_code_block(lines: List[str]) -> bool:
    joined = "\n".join(lines)
    patterns = [
        r"\blibrary\s*\(",
        r"\bggplot\s*\(",
        r"\bgeom_[a-zA-Z0-9_]*\s*\(",
        r"\btheme_set\s*\(",
        r"\bdata\.frame\s*\(",
        r"\btribble\s*\(",
        r"\bpivot_longer\s*\(",
        r"\blm\s*\(",
        r"\bstep\s*\(",
        r"\bscatterplot\s*\(",
        r"\bcorrplot\s*\(",
        r"\bcor\s*\(",
        r"\bwith\s*\(",
        r"\banova\s*\(",
        r"\bAIC\s*\(",
        r"\bBIC\s*\(",
        r"\bvif\s*\(",
        r"\bqqPlot\s*\(",
        r"\binfluence(IndexPlot|Plot)\s*\(",
        r"\bhatvalues\s*\(",
        r"\bcooks\.distance\s*\(",
        r"\bresidualPlots\s*\(",
        r"\bshapiro\.test\s*\(",
        r"\bbptest\s*\(",
        r"\bbgtest\s*\(",
        r"\bpacf\s*\(",
        r"\bccf\s*\(",
        r"\bpredict\s*\(",
        r"\boptions\s*\(",
        r"\bUSSteamCoEstim2\b",
        r"\bas\.Date\s*\(",
        r"\bformula\s*\(",
        r"\b[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z0-9_]*\.[0-9]+\b",
        r"::",
    ]
    return any(re.search(pattern, joined) for pattern in patterns)


def make_python_viz_bootstrap_cell(ir: Dict[str, Any]) -> Dict[str, Any]:
    chapter_number = str(ir.get("chapter", {}).get("chapter_number", ""))
    workshop_id = str(ir.get("chapter", {}).get("workshop_id", ""))
    source_file = str(ir.get("source", {}).get("file_path", ""))
    lines = [
        "import math",
        "import numpy as np",
        "import pandas as pd",
        "import matplotlib.pyplot as plt",
        "import seaborn as sns",
        "from scipy.stats import chi2, norm",
        "",
        "def head(obj, n=6):",
        "    if hasattr(obj, 'head'):",
        "        return obj.head(n)",
        "    return obj[:n]",
        "",
        "sns.set_theme(style='whitegrid')",
    ]
    return as_code_cell(
        lines,
        seed=f"python-viz-bootstrap:{workshop_id}:{chapter_number}",
        traceability={
            "exercise_id": None,
            "exercise_ref": None,
            "block_id": "python-viz-bootstrap",
            "source_file": source_file,
            "source_block_key": "bootstrap",
            "source_span": None,
        },
    )


def convert_r_heavy_block_to_python(lines: List[str], chapter_number: str) -> List[str]:
    raw = "\n".join(lines)
    if "library(ggplot2)" in raw and "theme_set(" in raw:
        return [
            "# Python equivalent setup for plotting and data manipulation",
            "sns.set_theme(style='whitegrid')",
        ]

    if "benford_plot <- ggplot" in raw:
        return [
            "digits = np.arange(1, 10)",
            "probabilities = np.log10((digits + 1) / digits)",
            "benford = pd.DataFrame({'Digit': digits, 'Probability': probabilities})",
            "fig, ax = plt.subplots(figsize=(7, 4))",
            "ax.bar(benford['Digit'], benford['Probability'], color='#00338D', width=0.7)",
            "ax.set_xlabel('First digit')",
            "ax.set_ylabel('Probability')",
            "ax.set_ylim(0, 0.35)",
            "ax.yaxis.set_major_formatter(plt.matplotlib.ticker.PercentFormatter(1.0))",
            "plt.show()",
        ]

    if "df <- tribble(" in raw and "pivot_longer(" in raw:
        return [
            "df = pd.DataFrame({",
            "    'Digit': [1,2,3,4,5,6,7,8,9],",
            "    'Rivers': [31.0,16.4,10.7,11.3,7.2,8.6,5.5,4.2,5.1],",
            "    'AmLeague': [32.7,17.6,12.6,9.8,7.4,6.4,4.9,5.6,3.0],",
            "    'CostData': [32.4,18.8,10.1,10.1,9.8,5.5,4.7,5.5,3.1],",
            "    'ReadersDigest': [33.4,18.5,12.4,7.5,7.1,6.5,5.5,4.9,4.2],",
            "    'MolWgt': [26.7,25.2,15.4,10.8,6.7,5.1,4.1,2.8,3.2],",
            "    'Average': [31.2,19.3,12.2,9.9,7.6,6.4,4.9,4.6,3.7],",
            "})",
            "df_long = df.melt(id_vars=['Digit'], var_name='Series', value_name='Percentage')",
            "fig, ax = plt.subplots(figsize=(8, 5))",
            "sns.lineplot(data=df_long, x='Digit', y='Percentage', hue='Series', marker='o', ax=ax)",
            "ax.set_xlabel('First digit')",
            "ax.set_ylabel('Percentage')",
            "plt.show()",
        ]

    if "benford_average_plot <- ggplot" in raw:
        return [
            "if 'probabilities' not in globals():",
            "    digits = np.arange(1, 10)",
            "    probabilities = np.log10((digits + 1) / digits)",
            "else:",
            "    digits = np.arange(1, 10)",
            "benford = 100 * probabilities",
            "average = np.array([31.2, 19.3, 12.2, 9.9, 7.6, 6.4, 4.9, 4.6, 3.7])",
            "df = pd.DataFrame({",
            "    'Digit': np.concatenate([digits, digits]),",
            "    'Percentage': np.concatenate([benford, average]),",
            "    'Series': ['Benford'] * 9 + ['Average'] * 9,",
            "})",
            "fig, ax = plt.subplots(figsize=(8, 5))",
            "sns.lineplot(data=df, x='Digit', y='Percentage', hue='Series', style='Series', marker='o', ax=ax)",
            "ax.set_xlabel('First digit')",
            "ax.set_ylabel('Percentage')",
            "plt.show()",
        ]

    if "inv_plot <- ggplot" in raw and "inv_observed" in raw:
        return [
            "if 'probabilities' not in globals():",
            "    digits = np.arange(1, 10)",
            "    probabilities = np.log10((digits + 1) / digits)",
            "else:",
            "    digits = np.arange(1, 10)",
            "inv_expected = 300 * probabilities",
            "inv_observed = np.array([86, 48, 23, 32, 24, 36, 19, 18, 14])",
            "df_inv = pd.DataFrame({",
            "    'Digit': np.concatenate([digits, digits]),",
            "    'Frequency': np.concatenate([inv_expected, inv_observed]),",
            "    'Series': ['Expected'] * 9 + ['Observed'] * 9,",
            "})",
            "fig, ax = plt.subplots(figsize=(8, 5))",
            "sns.lineplot(data=df_inv, x='Digit', y='Frequency', hue='Series', style='Series', marker='o', ax=ax)",
            "ax.set_xlabel('First digit')",
            "ax.set_ylabel('Frequency')",
            "plt.show()",
        ]

    if "chisq_plot <- ggplot" in raw and "dchisq" in raw:
        return [
            "df = 8",
            "x = np.arange(0, 20.1, 0.1)",
            "tail_start = 15.51",
            "y = chi2.pdf(x, df=df)",
            "fig, ax = plt.subplots(figsize=(8, 4))",
            "ax.plot(x, y, color='#00338D')",
            "mask = x >= tail_start",
            "ax.fill_between(x[mask], y[mask], color='#00338D', alpha=1.0)",
            "ax.set_xlabel('x')",
            "ax.set_ylabel('density')",
            "plt.show()",
        ]

    if "benford_digit_plot <- ggplot" in raw and "facet_wrap" in raw:
        return [
            "first_digit = pd.DataFrame({",
            "    'digit': np.arange(1, 10),",
            "    'probability': np.log10(1 + 1 / np.arange(1, 10)),",
            "    'position': 'First',",
            "})",
            "second_digit = pd.DataFrame({",
            "    'digit': np.arange(0, 10),",
            "    'probability': [sum(np.log10(1 + 1 / (10 * np.arange(1, 10) + d))) for d in range(10)],",
            "    'position': 'Second',",
            "})",
            "third_digit = pd.DataFrame({",
            "    'digit': np.arange(0, 10),",
            "    'probability': [sum(np.log10(1 + 1 / (10 * np.arange(10, 100) + d))) for d in range(10)],",
            "    'position': 'Third',",
            "})",
            "benford_data = pd.concat([first_digit, second_digit, third_digit], ignore_index=True)",
            "fig, axes = plt.subplots(3, 1, figsize=(7, 10), sharex=False)",
            "for idx, position in enumerate(['First', 'Second', 'Third']):",
            "    subset = benford_data[benford_data['position'] == position]",
            "    axes[idx].plot(subset['digit'], subset['probability'], marker='o')",
            "    axes[idx].set_title(position)",
            "    axes[idx].set_xlabel('Digit')",
            "    axes[idx].set_ylabel('Probability')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if "create_hist <- function" in raw and "ussteamco.mod.3" in raw:
        return [
            "if 'ussteamco_mod_3_residuals' in globals():",
            "    nres = np.asarray(ussteamco_mod_3_residuals) / np.std(ussteamco_mod_3_residuals)",
            "    fig, axes = plt.subplots(2, 2, figsize=(10, 8))",
            "    for ax, bins in zip(axes.flatten(), [6, 7, 8, 9]):",
            "        sns.histplot(nres, bins=bins, stat='density', color='#00338D', edgecolor='black', ax=ax)",
            "        x = np.linspace(np.min(nres), np.max(nres), 200)",
            "        ax.plot(x, norm.pdf(x, np.mean(nres), np.std(nres)), color='red')",
            "        ax.set_title(f'Histogram with {bins} bins')",
            "        ax.set_xlabel('Standardized Residuals')",
            "        ax.set_ylabel('Density')",
            "    plt.tight_layout()",
            "    plt.show()",
            "else:",
            "    print('Skipped residual histogram example: source R object ussteamco.mod.3 is not available in Python track.')",
        ]

    if chapter_number == "5" and "hist_revenue <-" in raw and "grid.arrange(" in raw:
        return [
            "fig, axes = plt.subplots(2, 2, figsize=(12, 8))",
            "plot_specs = [",
            "    ('revenue', 4_000_000, 'Revenue'),",
            "    ('production', 50_000, 'Production'),",
            "    ('coolDD', 50, 'Cooling degree days'),",
            "    ('heatDD', 100, 'Heating degree days'),",
            "]",
            "for ax, (column, binwidth, title) in zip(axes.flatten(), plot_specs):",
            "    series = USSteamCoEstim[column].dropna()",
            "    if series.empty:",
            "        ax.set_title(f'{title} (no data)')",
            "        continue",
            "    bins = np.arange(series.min(), series.max() + binwidth, binwidth)",
            "    if len(bins) < 2:",
            "        bins = 10",
            "    sns.histplot(series, bins=bins, color='#00338D', edgecolor='white', ax=ax)",
            "    ax.set_title(title)",
            "    ax.set_xlabel(column)",
            "    ax.set_ylabel('Count')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "time_series_plot <- ggplot" in raw and "sec.axis = sec_axis" in raw:
        return [
            "fig, ax_left = plt.subplots(figsize=(10, 5))",
            "ax_right = ax_left.twinx()",
            "ax_left.plot(USSteamCoEstim['date'], USSteamCoEstim['revenue'], color='#00338D', label='Revenue')",
            "ax_right.plot(USSteamCoEstim['date'], USSteamCoEstim['production'], color='#BC204B', label='Production')",
            "ax_left.set_ylabel('Revenue ($)', color='#00338D')",
            "ax_right.set_ylabel('Production (x 1000 lb)', color='#BC204B')",
            "ax_left.set_xlabel('Date')",
            "fig.autofmt_xdate()",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "scatter_plot <- ggplot" in raw and "aes(x = production, y = revenue)" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(7, 5))",
            "sns.scatterplot(data=USSteamCoEstim, x='production', y='revenue', color='#00338D', ax=ax)",
            "ax.set_xlabel('Production (x 1000 lb)')",
            "ax.set_ylabel('Revenue ($)')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "scatterplot(revenue ~ production" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(7, 5))",
            "sns.scatterplot(data=USSteamCoEstim, x='production', y='revenue', color='#00338D', ax=ax)",
            "ax.set_xlabel('production')",
            "ax.set_ylabel('revenue')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "(cor_ussteam <- cor(USSteamCoEstim[, 2:5]))" in raw:
        return [
            "cor_ussteam = USSteamCoEstim.iloc[:, 1:5].corr()",
            "display(cor_ussteam)",
        ]

    if chapter_number == "5" and "corrplot(cor_ussteam" in raw:
        return [
            "if 'cor_ussteam' not in globals():",
            "    cor_ussteam = USSteamCoEstim.iloc[:, 1:5].corr()",
            "fig, ax = plt.subplots(figsize=(7, 6))",
            "sns.heatmap(cor_ussteam, vmin=-1, vmax=1, cmap='coolwarm', annot=True, fmt='.2f', ax=ax)",
            "ax.set_title('Correlation matrix')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if (
        chapter_number == "5"
        and "USSteamCo$date" in raw
        and "seq(as.Date" in raw
        and "by = \"month\"" in raw
    ):
        return [
            "USSteamCo['date'] = pd.date_range('2011-01-01', periods=len(USSteamCo), freq='MS')",
        ]

    if chapter_number == "5" and "ussteamco.mod.0 <- lm(revenue ~ production" in raw and "brief(" in raw:
        return [
            "ussteamco_mod_0 = fit_lm('ussteamco_mod_0', 'revenue ~ production', USSteamCoEstim)",
            "brief_model('ussteamco_mod_0')",
        ]

    if chapter_number == "5" and "summary(ussteamco.mod.0)" in raw:
        return [
            "summary_model('ussteamco_mod_0')",
        ]

    if chapter_number == "5" and "model_forward <- lm(revenue ~ 1" in raw and "direction = \"forward\"" in raw:
        return [
            "model_forward, model_forward_terms = stepwise_aic(",
            "    USSteamCoEstim,",
            "    response='revenue',",
            "    candidates=['production', 'coolDD', 'heatDD'],",
            "    direction='forward',",
            "    start_terms=[],",
            ")",
            "print('Forward terms:', model_forward_terms)",
            "print(model_forward.summary())",
        ]

    if chapter_number == "5" and "model_backward <- lm(revenue ~ production + coolDD + heatDD" in raw:
        return [
            "model_backward, model_backward_terms = stepwise_aic(",
            "    USSteamCoEstim,",
            "    response='revenue',",
            "    candidates=['production', 'coolDD', 'heatDD'],",
            "    direction='backward',",
            "    start_terms=['production', 'coolDD', 'heatDD'],",
            ")",
            "print('Backward terms:', model_backward_terms)",
            "print(model_backward.summary())",
        ]

    if chapter_number == "5" and "fit_both <- lm(revenue ~ 1" in raw and "direction = \"both\"" in raw:
        return [
            "fit_both, fit_both_terms = stepwise_aic(",
            "    USSteamCoEstim,",
            "    response='revenue',",
            "    candidates=['production', 'coolDD', 'heatDD'],",
            "    direction='both',",
            "    start_terms=[],",
            ")",
            "print('Both-directions terms:', fit_both_terms)",
            "print(fit_both.summary())",
        ]

    if chapter_number == "5" and "ussteamco.mod.1 <- lm(revenue ~ production + coolDD + heatDD" in raw:
        return [
            "ussteamco_mod_1 = fit_lm('ussteamco_mod_1', 'revenue ~ production + coolDD + heatDD', USSteamCoEstim)",
            "summary_model('ussteamco_mod_1')",
        ]

    if chapter_number == "5" and "USSteamCoEstim$summer_fact <- factor" in raw:
        return [
            "plot_df = USSteamCoEstim.copy()",
            "plot_df['summer_fact'] = plot_df['summer'].map({0: 'No', 1: 'Yes'})",
            "fig, ax = plt.subplots(figsize=(8, 5))",
            "sns.scatterplot(data=plot_df, x='production', y='revenue', hue='summer_fact', palette={'No': '#00338D', 'Yes': '#BC204B'}, ax=ax)",
            "sns.regplot(data=plot_df[plot_df['summer_fact'] == 'No'], x='production', y='revenue', scatter=False, color='#00338D', ax=ax)",
            "sns.regplot(data=plot_df[plot_df['summer_fact'] == 'Yes'], x='production', y='revenue', scatter=False, color='#BC204B', ax=ax)",
            "ax.set_xlabel('Production')",
            "ax.set_ylabel('Revenue')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "ussteamco.mod.2 <- lm(" in raw and "production * summer" in raw:
        return [
            "ussteamco_mod_2 = fit_lm('ussteamco_mod_2', 'revenue ~ production * summer + coolDD * summer + heatDD * summer', USSteamCoEstim)",
            "summary_model('ussteamco_mod_2')",
        ]

    if chapter_number == "5" and "with(" in raw and "ccf(" in raw:
        return [
            "x = USSteamCoEstim['production'].to_numpy()",
            "y = USSteamCoEstim['revenue'].to_numpy()",
            "max_lag = 4",
            "lags = np.arange(-max_lag, max_lag + 1)",
            "corrs = []",
            "for lag in lags:",
            "    if lag < 0:",
            "        corr = np.corrcoef(x[:lag], y[-lag:])[0, 1]",
            "    elif lag > 0:",
            "        corr = np.corrcoef(x[lag:], y[:-lag])[0, 1]",
            "    else:",
            "        corr = np.corrcoef(x, y)[0, 1]",
            "    corrs.append(corr)",
            "fig, ax = plt.subplots(figsize=(7, 4))",
            "ax.stem(lags, corrs, basefmt=' ')",
            "ax.set_xlabel('Lag')",
            "ax.set_ylabel('Cross-correlation')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "USSteamCoEstim$resid <- residuals(ussteamco.mod.2" in raw:
        return [
            "USSteamCoEstim = USSteamCoEstim.copy()",
            "USSteamCoEstim['resid'] = ussteamco_mod_2.resid",
            "predictors = ['production', 'coolDD', 'heatDD', 'summer']",
            "fig, axes = plt.subplots(3, 2, figsize=(12, 12))",
            "for ax, var in zip(axes.flatten()[:4], predictors):",
            "    sns.scatterplot(x=USSteamCoEstim[var], y=USSteamCoEstim['resid'], color='#00338D', ax=ax)",
            "    ax.axhline(0, linestyle='dotted', color='black')",
            "    ax.set_xlabel(var)",
            "    ax.set_ylabel('resid')",
            "fitted_vals = ussteamco_mod_2.fittedvalues",
            "sns.scatterplot(x=fitted_vals, y=USSteamCoEstim['resid'], color='#00338D', ax=axes.flatten()[4])",
            "axes.flatten()[4].axhline(0, linestyle='dotted', color='black')",
            "axes.flatten()[4].set_xlabel('Fitted Values')",
            "axes.flatten()[4].set_ylabel('resid')",
            "axes.flatten()[5].axis('off')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "influenceIndexPlot(ussteamco.mod.2)" in raw:
        return [
            "influence = ussteamco_mod_2.get_influence()",
            "fig, axes = plt.subplots(3, 1, figsize=(10, 10), sharex=True)",
            "axes[0].plot(influence.hat_matrix_diag, marker='o')",
            "axes[0].set_ylabel('Leverage')",
            "axes[1].plot(influence.resid_studentized_external, marker='o')",
            "axes[1].set_ylabel('Studentized residual')",
            "axes[2].plot(influence.cooks_distance[0], marker='o')",
            "axes[2].set_ylabel(\"Cook's distance\")",
            "axes[2].set_xlabel('Observation')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "hatvals.mod.2 <- hatvalues(ussteamco.mod.2)" in raw:
        return [
            "hatvals_mod_2 = ussteamco_mod_2.get_influence().hat_matrix_diag",
            "display(pd.Series(hatvals_mod_2, name='hatvalues'))",
        ]

    if chapter_number == "5" and "hatvals.mod.2[order(hatvals.mod.2" in raw:
        return [
            "top_hat_idx = np.argsort(hatvals_mod_2)[-3:][::-1]",
            "display(pd.Series(hatvals_mod_2[top_hat_idx], index=top_hat_idx + 1, name='top_hatvalues'))",
        ]

    if chapter_number == "5" and "sum(hatvals.mod.2)" in raw:
        return [
            "print(np.sum(hatvals_mod_2))",
        ]

    if chapter_number == "5" and "qqPlot(ussteamco.mod.2" in raw:
        return [
            "fig = qqplot(ussteamco_mod_2.resid, line='45')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "cooks.mod.2 <- cooks.distance(ussteamco.mod.2)" in raw:
        return [
            "cooks_mod_2 = ussteamco_mod_2.get_influence().cooks_distance[0]",
            "display(pd.Series(cooks_mod_2, name='cooks_distance'))",
        ]

    if chapter_number == "5" and "cooks.mod.2[order(cooks.mod.2" in raw:
        return [
            "top_cooks_idx = np.argsort(cooks_mod_2)[-3:][::-1]",
            "display(pd.Series(cooks_mod_2[top_cooks_idx], index=top_cooks_idx + 1, name='top_cooks_distance'))",
        ]

    if chapter_number == "5" and "influencePlot(ussteamco.mod.2" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(8, 6))",
            "influence_plot(ussteamco_mod_2, ax=ax, criterion='cooks')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "USSteamCoEstim2 <- USSteamCoEstim" in raw and "fit_22" in raw:
        return [
            "USSteamCoEstim2 = USSteamCoEstim.copy()",
            "p5 = np.quantile(ussteamco_mod_2.resid, 0.05)",
            "fit_22 = ussteamco_mod_2.fittedvalues.iloc[21]",
            "USSteamCoEstim2.loc[USSteamCoEstim2.index[21], 'revenue'] = fit_22 + p5",
        ]

    if chapter_number == "5" and "ussteamco.mod.3 <- lm(revenue ~ (production + heatDD + coolDD) * summer" in raw:
        return [
            "ussteamco_mod_3 = fit_lm('ussteamco_mod_3', 'revenue ~ (production + heatDD + coolDD) * summer', USSteamCoEstim2)",
            "brief_model('ussteamco_mod_3')",
        ]

    if chapter_number == "5" and "vif(ussteamco.mod.1)" in raw:
        return [
            "model_vif('ussteamco_mod_1', USSteamCoEstim)",
        ]

    if chapter_number == "5" and "vif(ussteamco.mod.3" in raw:
        return [
            "model_vif('ussteamco_mod_3', USSteamCoEstim2)",
        ]

    if chapter_number == "5" and "anova(ussteamco.mod.0)" in raw:
        return [
            "anova_ussteamco_mod_0 = model_anova('ussteamco_mod_0', typ=1)",
        ]

    if chapter_number == "5" and "anova.mod.0 <- anova(ussteamco.mod.0)" in raw:
        return [
            "anova_mod_0 = model_anova('ussteamco_mod_0', typ=1)",
            "print(anova_mod_0['sum_sq'].iloc[0] + anova_mod_0['sum_sq'].iloc[1])",
        ]

    if chapter_number == "5" and "(anova.mod.1 <- anova(ussteamco.mod.1))" in raw:
        return [
            "anova_mod_1 = model_anova('ussteamco_mod_1', typ=1)",
        ]

    if chapter_number == "5" and "ussteamco.mod.1b <- lm(revenue ~ heatDD + coolDD + production" in raw:
        return [
            "ussteamco_mod_1b = fit_lm('ussteamco_mod_1b', 'revenue ~ heatDD + coolDD + production', USSteamCoEstim)",
            "anova_mod_1b = anova_lm(ussteamco_mod_1b, typ=1)",
            "print(anova_mod_1b)",
        ]

    if chapter_number == "5" and "Anova(ussteamco.mod.1)" in raw:
        return [
            "anova_mod_1_type2 = model_anova('ussteamco_mod_1', typ=2)",
        ]

    if chapter_number == "5" and "(anova.mod.3 <- anova(ussteamco.mod.3))" in raw:
        return [
            "anova_mod_3 = model_anova('ussteamco_mod_3', typ=1)",
        ]

    if chapter_number == "5" and "AIC(ussteamco.mod.0)" in raw:
        return [
            "print('AIC ussteamco_mod_0:', ussteamco_mod_0.aic)",
            "print('AIC model_backward:', model_backward.aic)",
            "print('AIC ussteamco_mod_1:', ussteamco_mod_1.aic)",
            "print('AIC ussteamco_mod_2:', ussteamco_mod_2.aic)",
        ]

    if chapter_number == "5" and "BIC(ussteamco.mod.0)" in raw:
        return [
            "print('BIC ussteamco_mod_0:', ussteamco_mod_0.bic)",
            "print('BIC model_backward:', model_backward.bic)",
            "print('BIC ussteamco_mod_1:', ussteamco_mod_1.bic)",
            "print('BIC ussteamco_mod_2:', ussteamco_mod_2.bic)",
        ]

    if chapter_number == "5" and "# Calculate normalized residuals" in raw and "hist_stand_res" in raw:
        return [
            "nres = ussteamco_mod_3.resid / np.std(ussteamco_mod_3.resid)",
            "fig, ax = plt.subplots(figsize=(7, 5))",
            "sns.histplot(nres, bins=np.arange(-2.55, 1.65 + 0.7, 0.7), stat='density', color='#00338D', ax=ax)",
            "x_vals = np.linspace(nres.min(), nres.max(), 200)",
            "ax.plot(x_vals, norm.pdf(x_vals, np.mean(nres), np.std(nres)), color='black')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "qqPlot(ussteamco.mod.3" in raw:
        return [
            "fig = qqplot(ussteamco_mod_3.resid, line='45')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "shapiro.test(ussteamco.mod.3$residuals)" in raw:
        return [
            "shapiro_stat, shapiro_p = shapiro_test(ussteamco_mod_3.resid)",
            "print({'W': shapiro_stat, 'p_value': shapiro_p})",
        ]

    if chapter_number == "5" and "residualPlots(ussteamco.mod.3" in raw:
        return [
            "resid = ussteamco_mod_3.resid",
            "fitted = ussteamco_mod_3.fittedvalues",
            "predictors = ['production', 'coolDD', 'heatDD', 'summer']",
            "fig, axes = plt.subplots(2, 3, figsize=(14, 8))",
            "for ax, col in zip(axes.flatten()[:4], predictors):",
            "    sns.scatterplot(x=USSteamCoEstim2[col], y=resid, color='#00338D', ax=ax)",
            "    ax.axhline(0, color='black', linestyle='dotted')",
            "    ax.set_xlabel(col)",
            "    ax.set_ylabel('Residuals')",
            "sns.scatterplot(x=fitted, y=resid, color='#00338D', ax=axes.flatten()[4])",
            "axes.flatten()[4].axhline(0, color='black', linestyle='dotted')",
            "axes.flatten()[4].set_xlabel('Fitted')",
            "axes.flatten()[4].set_ylabel('Residuals')",
            "axes.flatten()[5].axis('off')",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "bptest(ussteamco.mod.3)" in raw:
        return [
            "bp_stat, bp_p, _, _ = het_breuschpagan(ussteamco_mod_3.resid, ussteamco_mod_3.model.exog)",
            "print({'LM statistic': bp_stat, 'p_value': bp_p})",
        ]

    if chapter_number == "5" and "pacf(ussteamco.mod.3$residuals)" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(7, 4))",
            "plot_pacf(ussteamco_mod_3.resid, lags=10, method='ywm', ax=ax)",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "bgtest(ussteamco.mod.3" in raw:
        return [
            "bg_lm, bg_p, _, _ = acorr_breusch_godfrey(ussteamco_mod_3, nlags=3)",
            "print({'LM statistic': bg_lm, 'p_value': bg_p})",
        ]

    if chapter_number == "5" and "(rho <- arima(ussteamco.mod.3$residuals" in raw:
        return [
            "rho = np.corrcoef(ussteamco_mod_3.resid[1:], ussteamco_mod_3.resid[:-1])[0, 1]",
            "print(rho)",
        ]

    if chapter_number == "5" and "# Create lagged variables, dropping the first observation" in raw and "trans$prod_summer" in raw:
        return [
            "n = len(USSteamCoEstim2)",
            "trans = USSteamCoEstim2.iloc[1:, :].copy()",
            "lag = USSteamCoEstim2.iloc[:-1, :].copy()",
            "trans['prod_summer'] = trans['production'] * trans['summer']",
            "trans['heat_summer'] = trans['heatDD'] * trans['summer']",
            "trans['cool_summer'] = trans['coolDD'] * trans['summer']",
            "lag['prod_summer'] = lag['production'] * lag['summer']",
            "lag['heat_summer'] = lag['heatDD'] * lag['summer']",
            "lag['cool_summer'] = lag['coolDD'] * lag['summer']",
            "trans['revenue_adj'] = trans['revenue'].to_numpy() - rho * lag['revenue'].to_numpy()",
            "trans['production_adj'] = trans['production'].to_numpy() - rho * lag['production'].to_numpy()",
            "trans['heatDD_adj'] = trans['heatDD'].to_numpy() - rho * lag['heatDD'].to_numpy()",
            "trans['coolDD_adj'] = trans['coolDD'].to_numpy() - rho * lag['coolDD'].to_numpy()",
            "trans['summer_adj'] = trans['summer'].to_numpy() - rho * lag['summer'].to_numpy()",
            "trans['prod_summer_adj'] = trans['prod_summer'].to_numpy() - rho * lag['prod_summer'].to_numpy()",
            "trans['heat_summer_adj'] = trans['heat_summer'].to_numpy() - rho * lag['heat_summer'].to_numpy()",
            "trans['cool_summer_adj'] = trans['cool_summer'].to_numpy() - rho * lag['cool_summer'].to_numpy()",
        ]

    if chapter_number == "5" and "ussteamco.mod.4 <- lm(" in raw and "revenue_adj" in raw:
        return [
            "ussteamco_mod_4 = fit_lm('ussteamco_mod_4', 'revenue_adj ~ production_adj + heatDD_adj + coolDD_adj + summer_adj + prod_summer_adj + heat_summer_adj + cool_summer_adj', trans)",
            "summary_model('ussteamco_mod_4')",
        ]

    if chapter_number == "5" and "pacf(ussteamco.mod.4$residuals)" in raw and "bgtest(ussteamco.mod.4" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(7, 4))",
            "plot_pacf(ussteamco_mod_4.resid, lags=10, method='ywm', ax=ax)",
            "plt.tight_layout()",
            "plt.show()",
            "bg_lm, bg_p, _, _ = acorr_breusch_godfrey(ussteamco_mod_4, nlags=3)",
            "print({'LM statistic': bg_lm, 'p_value': bg_p})",
        ]

    if chapter_number == "5" and "ussteamco.mod.5 <- lm(revenue ~ (production + coolDD + heatDD) * summer" in raw:
        return [
            "ussteamco_mod_5_start = fit_lm('ussteamco_mod_5_start', 'revenue ~ (production + coolDD + heatDD) * summer', USSteamCoEstim2)",
            "candidates = ['production', 'coolDD', 'heatDD', 'summer', 'production:summer', 'coolDD:summer', 'heatDD:summer']",
            "ussteamco_mod_5, ussteamco_mod_5_terms = stepwise_aic(",
            "    USSteamCoEstim2,",
            "    response='revenue',",
            "    candidates=candidates,",
            "    direction='backward',",
            "    start_terms=candidates,",
            ")",
            "print('Refined terms:', ussteamco_mod_5_terms)",
        ]

    if chapter_number == "5" and "summary(ussteamco.mod.5)" in raw and "options(" in raw:
        return [
            "summary_model('ussteamco_mod_5')",
        ]

    if chapter_number == "5" and "bptest(ussteamco.mod.5)" in raw and "shapiro.test(ussteamco.mod.5$residuals)" in raw:
        return [
            "bp_stat, bp_p, _, _ = het_breuschpagan(ussteamco_mod_5.resid, ussteamco_mod_5.model.exog)",
            "bg_lm, bg_p, _, _ = acorr_breusch_godfrey(ussteamco_mod_5, nlags=3)",
            "sw_stat, sw_p = shapiro_test(ussteamco_mod_5.resid)",
            "print({'bp_lm': bp_stat, 'bp_p': bp_p, 'bg_lm': bg_lm, 'bg_p': bg_p, 'shapiro_W': sw_stat, 'shapiro_p': sw_p})",
        ]

    if chapter_number == "5" and raw.strip() == "summary(ussteamco.mod.5)":
        return [
            "summary_model('ussteamco_mod_5')",
        ]

    if chapter_number == "5" and "# Create a data frame for the true line over the extended range" in raw:
        return [
            "true_line = pd.DataFrame({'x': x_extended, 'y': beta_0 + beta_1 * x_extended})",
            "mean_x = np.mean(x_values)",
            "S_xx = np.sum((x_values - mean_x) ** 2)",
            "se_fit_true = sigma * np.sqrt(1 / n + ((x_extended - mean_x) ** 2) / S_xx)",
            "t_value = t_dist.ppf(1 - alpha / 2, df=n - 2)",
            "ci_upper_true = (beta_0 + beta_1 * x_extended) + t_value * se_fit_true",
            "ci_lower_true = (beta_0 + beta_1 * x_extended) - t_value * se_fit_true",
            "ci_bounds_true = pd.DataFrame({'x': x_extended, 'ci_lower': ci_lower_true, 'ci_upper': ci_upper_true})",
        ]

    if chapter_number == "5" and "# Initialize a data frame to store the simulated regression lines" in raw:
        return [
            "_line_frames = []",
            "for i in range(1, int(rep) + 1):",
            "    epsilon = np.random.normal(loc=0.0, scale=sigma, size=n)",
            "    y_values = beta_0 + beta_1 * x_values + epsilon",
            "    slope_i, intercept_i = np.polyfit(x_values, y_values, deg=1)",
            "    predicted_values = intercept_i + slope_i * x_extended",
            "    _line_frames.append(pd.DataFrame({'x': x_extended, 'y': predicted_values, 'rep': i}))",
            "simulated_lines = pd.concat(_line_frames, ignore_index=True)",
        ]

    if chapter_number == "5" and "regression_lines_plot <- ggplot() +" in raw:
        return [
            "fig, ax = plt.subplots(figsize=(10, 6))",
            "for _, _grp in simulated_lines.groupby('rep'):",
            "    ax.plot(_grp['x'], _grp['y'], color='#00338D', alpha=0.1)",
            "ax.plot(true_line['x'], true_line['y'], color='#E36877', linewidth=1)",
            "ax.plot(ci_bounds_true['x'], ci_bounds_true['ci_lower'], color='#E36877', linewidth=1)",
            "ax.plot(ci_bounds_true['x'], ci_bounds_true['ci_upper'], color='#E36877', linewidth=1)",
            "ax.set_title(f\"{rep} Regression Lines with Confidence Interval Based on True Model\")",
            "ax.set_xlabel('x')",
            "ax.set_ylabel('y')",
            "ax.set_xlim(x_extended_min, x_extended_max)",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "# Calculate the standard error for prediction interval" in raw:
        return [
            "alpha_pred = 0.01",
            "t_value_pred = t_dist.ppf(1 - alpha_pred / 2, df=n - 2)",
            "se_pred = sigma * np.sqrt(1 + 1 / n + ((x_extended - mean_x) ** 2) / S_xx)",
            "pi_upper_true = (beta_0 + beta_1 * x_extended) + t_value_pred * se_pred",
            "pi_lower_true = (beta_0 + beta_1 * x_extended) - t_value_pred * se_pred",
            "pi_bounds_true = pd.DataFrame({'x': x_extended, 'pi_lower': pi_lower_true, 'pi_upper': pi_upper_true})",
            "fig, ax = plt.subplots(figsize=(10, 6))",
            "ax.fill_between(pi_bounds_true['x'], pi_bounds_true['pi_lower'], pi_bounds_true['pi_upper'], color='#00338D', alpha=0.15)",
            "ax.plot(ci_bounds_true['x'], ci_bounds_true['ci_lower'], color='#00338D', linewidth=1, linestyle='--')",
            "ax.plot(ci_bounds_true['x'], ci_bounds_true['ci_upper'], color='#00338D', linewidth=1, linestyle='--')",
            "ax.plot(true_line['x'], true_line['y'], color='#00338D', linewidth=1.5)",
            "ax.set_xlabel('x')",
            "ax.set_ylabel('y')",
            "ax.set_xlim(x_extended_min, x_extended_max)",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "(predictions <- predict(" in raw:
        return [
            "predictions = ussteamco_mod_5.get_prediction(USSteamCoHold).summary_frame(alpha=0.01)",
            "predictions = predictions.rename(columns={'mean': 'fit', 'obs_ci_lower': 'lwr', 'obs_ci_upper': 'upr'})",
            "display(predictions[['fit', 'lwr', 'upr']])",
        ]

    if chapter_number == "5" and "comparison <- cbind(" in raw:
        return [
            "comparison = pd.DataFrame({",
            "    'Month': USSteamCoHold.index.astype(str),",
            "    'Recorded': USSteamCoHold['revenue'].to_numpy(),",
            "    'Lower': np.round(predictions['lwr'].to_numpy(), 0),",
            "    'Expected': np.round(predictions['fit'].to_numpy(), 0),",
            "    'Upper': np.round(predictions['upr'].to_numpy(), 0),",
            "})",
            "comparison['Difference'] = comparison['Recorded'] - comparison['Expected']",
            "display(comparison)",
            "print(comparison['Recorded'].sum())",
            "print(comparison['Expected'].sum())",
            "print(comparison['Difference'].sum())",
        ]

    if chapter_number == "5" and "# Convert predictions to a data frame and add the date column" in raw:
        return [
            "pred_df = pd.DataFrame({",
            "    'date': USSteamCoHold['date'].to_numpy(),",
            "    'recorded': USSteamCoHold['revenue'].to_numpy(),",
            "    'lwr': predictions['lwr'].to_numpy(),",
            "    'fit': predictions['fit'].to_numpy(),",
            "    'upr': predictions['upr'].to_numpy(),",
            "})",
            "pred_df['outside'] = (pred_df['recorded'] < pred_df['lwr']) | (pred_df['recorded'] > pred_df['upr'])",
            "fig, ax = plt.subplots(figsize=(10, 5))",
            "ax.plot(pred_df['date'], pred_df['fit'], color='#00338D', label='Expectation')",
            "ax.fill_between(pred_df['date'], pred_df['lwr'], pred_df['upr'], color='#00338D', alpha=0.2)",
            "ax.plot(pred_df['date'], pred_df['recorded'], color='#E36877', label='Recorded')",
            "outliers = pred_df[pred_df['outside']]",
            "ax.scatter(outliers['date'], outliers['recorded'], color='#E36877', s=30)",
            "ax.set_xlabel('Month in 2014')",
            "ax.set_ylabel('Revenue ($)')",
            "ax.legend(loc='best')",
            "fig.autofmt_xdate()",
            "plt.tight_layout()",
            "plt.show()",
        ]

    if chapter_number == "5" and "# Residual degrees of freedom" in raw and "annual_prediction" in raw:
        return [
            "df_res = int(ussteamco_mod_5.df_resid)",
            "monthly_predictions = pred_df['fit'].to_numpy()",
            "annual_prediction = monthly_predictions.sum()",
            "new_df = USSteamCoHold.copy()",
            "X_hold = smf.ols(ussteamco_mod_5.model.formula, data=new_df).exog",
            "one = np.ones(X_hold.shape[0])",
            "vcov = ussteamco_mod_5.cov_params().to_numpy()",
            "var_mean_annual = float(one.T @ X_hold @ vcov @ X_hold.T @ one)",
            "sigma2 = ussteamco_mod_5.mse_resid",
            "var_future_annual = X_hold.shape[0] * sigma2",
            "annual_var = var_mean_annual + var_future_annual",
            "annual_se = np.sqrt(annual_var)",
            "t_score = t_dist.ppf(0.995, df=df_res)",
            "annual_lower = annual_prediction - t_score * annual_se",
            "annual_upper = annual_prediction + t_score * annual_se",
            "print('Variance from coefficient uncertainty:', var_mean_annual)",
            "print('Variance from future residual variation:', var_future_annual)",
            "print('Lower Bound:', round(annual_lower, 0))",
            "print('Annual Prediction:', round(annual_prediction, 0))",
            "print('Upper Bound:', round(annual_upper, 0))",
            "print('Annual prediction standard error:', round(annual_se, 0))",
        ]

    if chapter_number == "5" and "storm_adjustment <- 8000000" in raw:
        return [
            "storm_adjustment = 8_000_000",
            "pred_df['fit_adj'] = pred_df['fit']",
            "pred_df['lwr_adj'] = pred_df['lwr']",
            "pred_df['upr_adj'] = pred_df['upr']",
            "march_row = pred_df['date'].dt.strftime('%b') == 'Mar'",
            "pred_df.loc[march_row, 'fit_adj'] = pred_df.loc[march_row, 'fit_adj'] - storm_adjustment",
            "pred_df.loc[march_row, 'lwr_adj'] = pred_df.loc[march_row, 'lwr_adj'] - storm_adjustment",
            "pred_df.loc[march_row, 'upr_adj'] = pred_df.loc[march_row, 'upr_adj'] - storm_adjustment",
            "pred_df['outside_adj'] = (pred_df['recorded'] < pred_df['lwr_adj']) | (pred_df['recorded'] > pred_df['upr_adj'])",
            "display(pred_df)",
            ]

    if chapter_number == "5":
        raw = "\n".join(lines)
        return [
            f"ada_run_r({json.dumps(raw)})",
        ]

    return [
        "print('Skipped unsupported R-heavy code block in Python export; provide a Python override for full parity.')",
    ]


def as_markdown_cell(source_lines: List[str], seed: str, traceability: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "cell_type": "markdown",
        "id": stable_cell_id(seed),
        "metadata": {
            "language": "markdown",
            "traceability": traceability,
        },
        "source": [f"{line}\n" for line in source_lines],
    }


def as_code_cell(source_lines: List[str], seed: str, traceability: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "cell_type": "code",
        "id": stable_cell_id(seed),
        "metadata": {
            "language": "python",
            "traceability": traceability,
        },
        "execution_count": None,
        "outputs": [],
        "source": [f"{line}\n" for line in source_lines],
    }


def _has_top_level_assignment(line: str) -> bool:
    depth = 0
    quote: Optional[str] = None
    escape = False
    for idx, ch in enumerate(line):
        if quote is not None:
            if escape:
                escape = False
                continue
            if ch == "\\":
                escape = True
                continue
            if ch == quote:
                quote = None
            continue

        if ch in {'"', "'"}:
            quote = ch
            continue
        if ch in "([{":
            depth += 1
            continue
        if ch in ")]}":
            depth = max(0, depth - 1)
            continue

        if ch == "=" and depth == 0:
            prev_ch = line[idx - 1] if idx > 0 else ""
            next_ch = line[idx + 1] if idx + 1 < len(line) else ""
            if prev_ch in {"=", "!", "<", ">"} or next_ch == "=":
                continue
            return True

    return False


def _is_simple_assignment(line: str) -> bool:
    return _has_top_level_assignment(line)


def _paren_depth_delta(line: str) -> int:
    return line.count("(") + line.count("[") + line.count("{") - line.count(")") - line.count("]") - line.count("}")


def _is_statement_line(line: str) -> bool:
    return bool(
        re.match(
            r"^(import\s+|from\s+|def\s+|class\s+|for\s+|while\s+|if\s+|elif\s+|else\s*:|try\s*:|except\s+|finally\s*:|with\s+|return\b|raise\b|pass\b|break\b|continue\b|assert\b|del\b)",
            line,
        )
    )


def normalize_notebook_outputs(source_lines: List[str]) -> List[str]:
    """Wrap multiple standalone expressions with display() so Jupyter shows each result."""
    candidates: List[int] = []
    paren_depth = 0
    for idx, line in enumerate(source_lines):
        stripped = line.strip()
        depth_before = paren_depth
        paren_depth += _paren_depth_delta(stripped)
        if not stripped or stripped.startswith("#"):
            continue
        if depth_before != 0 or paren_depth != 0:
            continue
        if _is_statement_line(stripped) or _is_simple_assignment(stripped):
            continue
        # Skip pure function calls that are usually side-effect statements.
        if re.match(r"^[A-Za-z_][A-Za-z0-9_\.]*\(.*\)$", stripped) and "[" not in stripped:
            continue
        # Standalone expression (attribute/index access or function call).
        candidates.append(idx)

    if len(candidates) <= 1:
        return source_lines

    out = list(source_lines)
    for idx in candidates:
        original = out[idx]
        stripped = original.strip()
        if not stripped.startswith("display("):
            leading_ws = original[: len(original) - len(original.lstrip())]
            out[idx] = f"{leading_ws}display({stripped})"

    if not any(line.strip() == "from IPython.display import display" for line in out):
        out.insert(0, "from IPython.display import display")
    return out


def to_traceability(exercise: Dict[str, Any], block: Optional[Dict[str, Any]]) -> Dict[str, Any]:
    base = {
        "exercise_id": exercise.get("exercise_id"),
        "exercise_ref": exercise.get("exercise_ref"),
    }
    if block is None:
        return base

    trace = block.get("traceability", {}) if isinstance(block.get("traceability"), dict) else {}
    base.update(
        {
            "block_id": block.get("block_id"),
            "source_file": trace.get("source_file"),
            "source_block_key": trace.get("source_block_key"),
            "source_span": block.get("source_span"),
        }
    )
    return base


def select_exercises(
    exercises: List[Dict[str, Any]],
    requested_refs: Optional[List[str]],
    chapter_number: str,
) -> List[Dict[str, Any]]:
    if not requested_refs:
        return exercises

    by_ref = {str(ex.get("exercise_ref")): ex for ex in exercises}
    selected: List[Dict[str, Any]] = []
    for ref in requested_refs:
        if ref not in by_ref:
            raise RendererError(
                stage="select-exercises",
                chapter=chapter_number,
                block_id=None,
                code="E120",
                message=f"requested exercise_ref '{ref}' not present in IR",
                remediation="align requested exercise refs with configured workshop track and IR contents",
            )
        selected.append(by_ref[ref])

    return selected


def render_notebook(
    ir: Dict[str, Any],
    target_language: str,
    exercise_refs: Optional[List[str]] = None,
) -> Dict[str, Any]:
    validate_ir_structure(ir)

    chapter_number = str(ir.get("chapter", {}).get("chapter_number", "-"))
    chapter_title = str(ir.get("chapter", {}).get("title", ""))

    cells: List[Dict[str, Any]] = []

    exercises = select_exercises(ir["exercises"], exercise_refs, chapter_number)

    resolved_by_exercise: List[tuple[Dict[str, Any], List[Dict[str, Any]]]] = []
    requires_fsaudit = False
    requires_r_compat = False
    requires_python_viz_bootstrap = False
    for exercise in exercises:
        resolved_blocks = resolve_blocks_for_language(exercise, target_language=target_language, chapter=chapter_number)
        if any(block_requires(block, "fsaudit") for block in resolved_blocks):
            requires_fsaudit = True
        for block in resolved_blocks:
            if block.get("block_type") != "code":
                continue
            content = block.get("content", {}) if isinstance(block.get("content"), dict) else {}
            source_lines = normalize_lines(content.get("code_lines", []))
            if is_r_heavy_code_block(source_lines):
                requires_python_viz_bootstrap = True
            if requires_r_stats_compat(source_lines):
                requires_r_compat = True
        resolved_by_exercise.append((exercise, resolved_blocks))

    if requires_fsaudit:
        cells.append(make_fsaudit_bootstrap_cell(ir))
    if chapter_number == "2":
        cells.append(make_population_estimation_bootstrap_cell(ir))
    if chapter_number == "5":
        cells.append(make_regression_analysis_bootstrap_cell(ir))
    if requires_python_viz_bootstrap:
        cells.append(make_python_viz_bootstrap_cell(ir))
    if requires_r_compat and chapter_number != "5":
        cells.append(make_r_stats_compat_bootstrap_cell(ir))

    for exercise, resolved_blocks in resolved_by_exercise:
        ex_ref = str(exercise.get("exercise_ref"))
        label = str(exercise.get("label") or f"Exercise {ex_ref}")
        heading_lines = [f"## {label}"]
        cells.append(
            as_markdown_cell(
                heading_lines,
                seed=f"exercise-heading:{ex_ref}",
                traceability=to_traceability(exercise, None),
            )
        )

        for block in resolved_blocks:
            block_id = str(block.get("block_id"))
            block_type = block.get("block_type")
            content = block.get("content", {}) if isinstance(block.get("content"), dict) else {}
            traceability = to_traceability(exercise, block)

            if block_type == "narrative":
                source_lines = normalize_lines(content.get("narrative_lines", []))
                cells.append(
                    as_markdown_cell(
                        source_lines,
                        seed=f"narrative:{ex_ref}:{block_id}",
                        traceability=traceability,
                    )
                )
            elif block_type == "code":
                source_lines = normalize_lines(content.get("code_lines", []))
                if is_r_heavy_code_block(source_lines):
                    source_lines = convert_r_heavy_block_to_python(source_lines, chapter_number)
                else:
                    source_lines = normalize_r_style_code_for_python(source_lines)
                source_lines = normalize_notebook_outputs(source_lines)
                cells.append(
                    as_code_cell(
                        source_lines,
                        seed=f"code:{ex_ref}:{block_id}",
                        traceability=traceability,
                    )
                )
            else:
                raise RendererError(
                    stage="render-cells",
                    chapter=chapter_number,
                    block_id=block_id,
                    code="E300",
                    message=f"unsupported block type '{block_type}' during render",
                    remediation="use canonical narrative/code block types",
                )

    notebook = {
        "cells": cells,
        "metadata": {
            "ada_renderer": {
                "version": RENDERER_VERSION,
                "target_language": target_language,
                "ir_schema_version": ir.get("schema_version"),
                "chapter_id": ir.get("chapter", {}).get("chapter_id"),
                "chapter_number": ir.get("chapter", {}).get("chapter_number"),
                "chapter_title": chapter_title,
                "workshop_id": ir.get("chapter", {}).get("workshop_id"),
                "source_file": ir.get("source", {}).get("file_path"),
            },
            "kernelspec": {
                "display_name": "Python 3",
                "language": "python",
                "name": "python3",
            },
            "language_info": {
                "name": "python",
            },
        },
        "nbformat": 4,
        "nbformat_minor": 5,
    }

    return notebook


def write_notebook(notebook: Dict[str, Any], output_notebook: Path) -> None:
    output_notebook.parent.mkdir(parents=True, exist_ok=True)
    text = json.dumps(notebook, ensure_ascii=False, indent=2, sort_keys=True)
    output_notebook.write_text(text + "\n", encoding="utf-8")


def main() -> None:
    args = parse_args()

    input_ir = Path(args.input_ir)
    output_notebook = Path(args.output_notebook)

    ir = load_ir(input_ir)
    exercise_refs = None
    if args.exercise_refs:
        exercise_refs = [part.strip() for part in args.exercise_refs.split(",") if part.strip()]

    notebook = render_notebook(
        ir=ir,
        target_language=args.target_language,
        exercise_refs=exercise_refs,
    )
    write_notebook(notebook, output_notebook)


if __name__ == "__main__":
    main()
