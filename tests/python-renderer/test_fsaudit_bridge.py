#!/usr/bin/env python3

import unittest

from ada_fsaudit_bridge import (
    att_sample,
    bridge_diagnostics,
    configure_environment,
    cvs_sample,
    load_dataset,
    mus_sample,
    reset_session,
    set_notebook_context,
    upper_bound,
)
from ada_fsaudit_bridge.errors import FSAuditEnvironmentError


class FSAuditBridgeSmokeTests(unittest.TestCase):
    def setUp(self) -> None:
        reset_session()
        set_notebook_context(chapter="test", exercise="bridge")
        try:
            configure_environment(seed=123, require_fsaudit_version="0.3.4")
        except FSAuditEnvironmentError as exc:
            self.skipTest(str(exc))

    def test_bridge_diagnostics_report_versions(self) -> None:
        diagnostics = bridge_diagnostics()
        self.assertEqual(diagnostics["fsaudit_version"], "0.3.4")
        self.assertTrue(diagnostics["r_version"])

    def test_load_dataset_returns_dataframe(self) -> None:
        frame = load_dataset("inventoryData")
        self.assertIn("bv", frame.columns)
        self.assertEqual(len(frame), 3500)

    def test_att_workflow_sizes_sample(self) -> None:
        sample = att_sample(alpha=0.1, popdev=60, popn=1200, c=0).size()
        self.assertEqual(sample.n, 45)

    def test_mus_workflow_sizes_sample(self) -> None:
        accounts_receivable = load_dataset("accounts_receivable")
        sample = mus_sample(
            bv=accounts_receivable["amount"],
            id=accounts_receivable["invoice"],
        ).size(cl=0.95, pm=450000, ee=100000, evalMeth="Stringer")
        self.assertEqual(sample.n, 145)
        self.assertEqual(sample.popn, 10000)

    def test_cvs_workflow_selects_and_evaluates(self) -> None:
        inventory_data = load_dataset("inventoryData")
        sample = cvs_sample(
            n=400,
            bv=inventory_data["bv"],
            id=inventory_data["item"],
            seed=1234,
        ).select()
        audit_values = inventory_data.set_index("item").loc[sample.sample["item"], "av"]
        sample.evaluate(av=audit_values)
        self.assertEqual(sample.n, 400)
        self.assertIsNotNone(sample.sample)
        self.assertIsNotNone(sample.eval_results)

    def test_native_upper_bound_matches_known_value(self) -> None:
        self.assertEqual(upper_bound(k=0, popn=1200, n=102, alpha=0.10), 26)


if __name__ == "__main__":
    unittest.main()