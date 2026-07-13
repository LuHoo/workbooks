#!/usr/bin/env python3

import argparse
import importlib.util
import unittest
from pathlib import Path
from unittest.mock import patch


REPO_ROOT = Path(__file__).resolve().parents[2]
SCRIPT_PATH = REPO_ROOT / "scripts" / "ci" / "binder-launch-smoke.py"


def load_module():
    spec = importlib.util.spec_from_file_location("binder_launch_smoke", SCRIPT_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Unable to load module from {SCRIPT_PATH}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class _FakeResponse:
    def __init__(self, status_code=200, headers=None, lines=None):
        self.status_code = status_code
        self.headers = headers or {"content-type": "text/event-stream"}
        self._lines = lines or []

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        return False

    def iter_lines(self, decode_unicode=True):
        for line in self._lines:
            yield line

    def raise_for_status(self):
        if self.status_code >= 400:
            raise RuntimeError(f"HTTP {self.status_code}")


class BinderLaunchSmokeUnitTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.mod = load_module()

    def test_binder_build_stream_url_encodes_ref_and_urlpath(self):
        got = self.mod.binder_build_stream_url(
            target_repo="LuHoo/workbooks",
            target_ref="feature/new check",
            urlpath="lab/tree/My Notebook.ipynb",
        )
        self.assertEqual(
            got,
            "https://mybinder.org/build/gh/LuHoo/workbooks/feature%2Fnew%20check?urlpath=lab%2Ftree%2FMy%20Notebook.ipynb",
        )

    def test_stream_until_ready_sets_accept_header_and_parses_ready_event(self):
        args = argparse.Namespace(
            target_repo="LuHoo/workbooks",
            target_ref="main",
            urlpath="lab",
            build_timeout_seconds=120,
            event_timeout_seconds=30,
        )
        lines = [
            'data: {"phase": "launching", "message": "Server requested"}',
            'data: {"phase": "ready", "url": "https://hub.example/user/demo/", "token": "abc123"}',
        ]

        fake = _FakeResponse(status_code=200, lines=lines)
        with patch.object(self.mod.requests, "get", return_value=fake) as mock_get:
            ready = self.mod.stream_until_ready(args, [])

        self.assertEqual(ready.base_url, "https://hub.example/user/demo/")
        self.assertEqual(ready.token, "abc123")
        self.assertEqual(mock_get.call_args.kwargs["headers"], {"Accept": "text/event-stream"})
        self.assertTrue(mock_get.call_args.kwargs["stream"])

    def test_stream_until_ready_raises_actionable_error_for_failed_phase(self):
        args = argparse.Namespace(
            target_repo="LuHoo/workbooks",
            target_ref="main",
            urlpath="lab",
            build_timeout_seconds=120,
            event_timeout_seconds=30,
        )
        lines = [
            'data: {"phase": "failed", "status_code": 400, "message": "Missing Accept header: text/event-stream"}',
        ]

        fake = _FakeResponse(status_code=400, lines=lines)
        with patch.object(self.mod.requests, "get", return_value=fake):
            with self.assertRaises(RuntimeError) as ctx:
                self.mod.stream_until_ready(args, [])

        self.assertIn("Binder build failed", str(ctx.exception))
        self.assertIn("Missing Accept header", str(ctx.exception))


if __name__ == "__main__":
    unittest.main()