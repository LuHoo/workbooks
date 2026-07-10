#!/usr/bin/env python3

import json
import re
import subprocess
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PARSER_SCRIPT = REPO_ROOT / "scripts" / "workshop-ir.R"
RENDERER_SCRIPT = REPO_ROOT / "scripts" / "workshop-ir-python-renderer.py"
ORCHESTRATOR_SCRIPT = REPO_ROOT / "scripts" / "export-python-notebooks.R"
EXPORTER_SCRIPT = REPO_ROOT / "scripts" / "export-python-workshop.py"
GOLDEN_NOTEBOOK = REPO_ROOT / "tests" / "python-renderer" / "fixtures" / "directive-valid-python.ipynb"


class RendererTestCase(unittest.TestCase):
    def parse_ir(self, source_rmd: Path) -> Path:
        tmp_ir = Path(tempfile.mkstemp(prefix="ir-", suffix=".json")[1])
        source_arg = str(source_rmd)
        try:
            source_arg = str(source_rmd.resolve().relative_to(REPO_ROOT.resolve()))
        except ValueError:
            source_arg = str(source_rmd)
        cmd = [
            "Rscript",
            str(PARSER_SCRIPT),
            "--input",
            source_arg,
            "--output",
            str(tmp_ir),
        ]
        subprocess.run(cmd, cwd=REPO_ROOT, check=True, capture_output=True, text=True)
        return tmp_ir

    def render_ipynb(self, ir_path: Path, output_path: Path) -> None:
        cmd = [
            "python3",
            str(RENDERER_SCRIPT),
            "--input-ir",
            str(ir_path),
            "--output-notebook",
            str(output_path),
            "--target-language",
            "python",
        ]
        subprocess.run(cmd, cwd=REPO_ROOT, check=True, capture_output=True, text=True)

    def read_json(self, path: Path):
        return json.loads(path.read_text(encoding="utf-8"))

    def collect_heading_refs(self, notebook_json):
        refs = []
        for cell in notebook_json["cells"]:
            if cell.get("cell_type") != "markdown":
                continue
            source = "".join(cell.get("source", []))
            match = re.search(r"Exercise\s+([0-9]+\.[0-9]+)", source)
            if match:
                refs.append(match.group(1))
        return refs

    def collect_code_text(self, notebook_json):
        return "\n".join(
            "".join(cell.get("source", []))
            for cell in notebook_json["cells"]
            if cell.get("cell_type") == "code"
        )

    def test_chapter_rendering_preserves_exercise_order(self):
        source = REPO_ROOT / "notebooks" / "support" / "probability-distributions" / "support.Rmd"
        ir_path = self.parse_ir(source)

        out_path = Path(tempfile.mkstemp(prefix="nb-", suffix=".ipynb")[1])
        self.render_ipynb(ir_path, out_path)

        ir_json = self.read_json(ir_path)
        nb_json = self.read_json(out_path)

        expected_refs = [ex["exercise_ref"] for ex in ir_json["exercises"]]
        actual_refs = self.collect_heading_refs(nb_json)

        self.assertEqual(actual_refs, expected_refs)
        self.assertEqual(nb_json["nbformat"], 4)
        self.assertEqual(nb_json["metadata"]["ada_renderer"]["target_language"], "python")

    def test_python_overrides_are_applied(self):
        source = REPO_ROOT / "tests" / "workshop-ir" / "fixtures" / "directive-valid-support.Rmd"
        ir_path = self.parse_ir(source)

        out_path = Path(tempfile.mkstemp(prefix="nb-", suffix=".ipynb")[1])
        self.render_ipynb(ir_path, out_path)

        nb_json = self.read_json(out_path)

        markdown_text = "\n".join(
            "".join(cell.get("source", []))
            for cell in nb_json["cells"]
            if cell.get("cell_type") == "markdown"
        )
        code_cells = [
            "".join(cell.get("source", []))
            for cell in nb_json["cells"]
            if cell.get("cell_type") == "code"
        ]

        self.assertIn("Python narrative override.", markdown_text)
        self.assertNotIn("Base narrative.", markdown_text)
        self.assertTrue(any("x = 1" in src for src in code_cells))
        self.assertFalse(any("x <- 1" in src for src in code_cells))
        self.assertTrue(any("fs_audit()" in src for src in code_cells))

    def test_renderer_is_deterministic_for_same_ir(self):
        source = REPO_ROOT / "notebooks" / "support" / "probability-distributions" / "support.Rmd"
        ir_path = self.parse_ir(source)

        out_path_a = Path(tempfile.mkstemp(prefix="nb-a-", suffix=".ipynb")[1])
        out_path_b = Path(tempfile.mkstemp(prefix="nb-b-", suffix=".ipynb")[1])

        self.render_ipynb(ir_path, out_path_a)
        self.render_ipynb(ir_path, out_path_b)

        self.assertEqual(out_path_a.read_bytes(), out_path_b.read_bytes())

    def test_invalid_override_reference_fails_with_actionable_error(self):
        source = REPO_ROOT / "tests" / "workshop-ir" / "fixtures" / "directive-valid-support.Rmd"
        ir_path = self.parse_ir(source)
        ir_json = self.read_json(ir_path)

        override_block = None
        for block in ir_json["exercises"][0]["blocks"]:
            ctx = block.get("authoring_context", {})
            if ctx.get("mode") == "override":
                override_block = block
                break

        self.assertIsNotNone(override_block)
        override_block["authoring_context"]["override_target_block_id"] = "BL-EX-9.1-999"

        bad_ir = Path(tempfile.mkstemp(prefix="ir-bad-", suffix=".json")[1])
        bad_ir.write_text(json.dumps(ir_json, sort_keys=True, indent=2) + "\n", encoding="utf-8")

        out_path = Path(tempfile.mkstemp(prefix="nb-bad-", suffix=".ipynb")[1])
        cmd = [
            "python3",
            str(RENDERER_SCRIPT),
            "--input-ir",
            str(bad_ir),
            "--output-notebook",
            str(out_path),
            "--target-language",
            "python",
        ]
        proc = subprocess.run(cmd, cwd=REPO_ROOT, check=False, capture_output=True, text=True)

        self.assertNotEqual(proc.returncode, 0)
        self.assertIn("E203", proc.stderr + proc.stdout)

    def test_directive_fixture_matches_golden_notebook(self):
        source = REPO_ROOT / "tests" / "workshop-ir" / "fixtures" / "directive-valid-support.Rmd"
        ir_path = self.parse_ir(source)

        out_path = Path(tempfile.mkstemp(prefix="nb-golden-", suffix=".ipynb")[1])
        self.render_ipynb(ir_path, out_path)

        self.assertEqual(out_path.read_bytes(), GOLDEN_NOTEBOOK.read_bytes())

    def test_orchestrator_generates_config_notebook(self):
        out_dir = Path(tempfile.mkdtemp(prefix="python-notebooks-"))
        cmd = [
            "Rscript",
            str(ORCHESTRATOR_SCRIPT),
            "--config-id",
            "probability-distributions",
            "--output-dir",
            str(out_dir),
        ]
        subprocess.run(cmd, cwd=REPO_ROOT, check=True, capture_output=True, text=True)

        out_nb = out_dir / "probability-distributions" / "chapter-1.ipynb"
        self.assertTrue(out_nb.exists())

        nb_json = self.read_json(out_nb)
        heading_refs = self.collect_heading_refs(nb_json)
        self.assertEqual(heading_refs[0], "1.1")

    def test_fsaudit_workshops_emit_bridge_bootstrap_and_python_overrides(self):
        cases = [
            (
                REPO_ROOT / "notebooks" / "support" / "hypothesis-testing" / "support.Rmd",
                ["att_sample", "mus_sample", "upper_bound", "ada_set_context"],
            ),
            (
                REPO_ROOT / "notebooks" / "support" / "auxiliary-variables-and-stratification" / "support.Rmd",
                ["cvs_sample", "load_dataset", "configure_environment()", "ada_set_context"],
            ),
        ]

        for source, required_tokens in cases:
            with self.subTest(source=source.name):
                ir_path = self.parse_ir(source)
                out_path = Path(tempfile.mkstemp(prefix="nb-bridge-", suffix=".ipynb")[1])
                self.render_ipynb(ir_path, out_path)
                nb_json = self.read_json(out_path)
                code_text = self.collect_code_text(nb_json)

                self.assertIn("from ada_fsaudit_bridge import", code_text)
                for token in required_tokens:
                    self.assertIn(token, code_text)

                for forbidden in ["library(FSaudit)", "<-", "RNGkind(", "phyper("]:
                    self.assertNotIn(forbidden, code_text)

    def test_python_exporter_uses_generated_notebook_metadata(self):
        out_dir = Path(tempfile.mkdtemp(prefix="python-notebooks-export-"))
        subprocess.run(
            [
                "Rscript",
                str(ORCHESTRATOR_SCRIPT),
                "--config-id",
                "probability-distributions",
                "--output-dir",
                str(out_dir),
            ],
            cwd=REPO_ROOT,
            check=True,
            capture_output=True,
            text=True,
        )

        notebook_path = out_dir / "probability-distributions" / "chapter-1.ipynb"
        tex_path = out_dir / "workshop-export.tex"

        subprocess.run(
            [
                "python3",
                str(EXPORTER_SCRIPT),
                "--input",
                str(notebook_path),
                "--output",
                str(tex_path),
                "--expect-generated-metadata",
            ],
            cwd=REPO_ROOT,
            check=True,
            capture_output=True,
            text=True,
        )

        tex_text = tex_path.read_text(encoding="utf-8")
        self.assertIn("generated from notebooks/support/probability-distributions/support.Rmd", tex_text)
        self.assertIn("Workshop: probability-distributions (chapter 1)", tex_text)

    def test_python_exporter_reports_missing_generated_metadata(self):
        notebook_path = Path(tempfile.mkstemp(prefix="legacy-nb-", suffix=".ipynb")[1])
        notebook_path.write_text(
            json.dumps(
                {
                    "nbformat": 4,
                    "nbformat_minor": 5,
                    "metadata": {},
                    "cells": [
                        {
                            "cell_type": "markdown",
                            "metadata": {},
                            "source": ["## Exercise 1.1 Demo"],
                        }
                    ],
                }
            )
            + "\n",
            encoding="utf-8",
        )
        tex_path = Path(tempfile.mkstemp(prefix="legacy-tex-", suffix=".tex")[1])

        proc = subprocess.run(
            [
                "python3",
                str(EXPORTER_SCRIPT),
                "--input",
                str(notebook_path),
                "--output",
                str(tex_path),
                "--expect-generated-metadata",
            ],
            cwd=REPO_ROOT,
            check=False,
            capture_output=True,
            text=True,
        )

        self.assertNotEqual(proc.returncode, 0)
        self.assertIn("[validate-metadata]", proc.stderr + proc.stdout)
        self.assertIn("missing metadata.ada_renderer", proc.stderr + proc.stdout)

    def test_probability_notebook_includes_r_stats_compat_shim(self):
        source = REPO_ROOT / "notebooks" / "support" / "probability-distributions" / "support.Rmd"
        ir_path = self.parse_ir(source)

        out_path = Path(tempfile.mkstemp(prefix="nb-prob-", suffix=".ipynb")[1])
        self.render_ipynb(ir_path, out_path)

        nb_json = self.read_json(out_path)
        code_cells = [
            "".join(cell.get("source", []))
            for cell in nb_json["cells"]
            if cell.get("cell_type") == "code"
        ]
        code_text = "\n".join(code_cells)

        self.assertIn("def dhyper", code_text)
        self.assertIn("def qf", code_text)
        self.assertIn("def qchisq", code_text)
        self.assertNotIn("<-", code_text)
        self.assertNotIn("lower.tail", code_text)


if __name__ == "__main__":
    unittest.main()
