from __future__ import annotations

import importlib.util
import sys
from pathlib import Path


MODULE_PATH = Path("ada_fsaudit_bridge/manuscript_registry.py")


def load_module():
    spec = importlib.util.spec_from_file_location("manuscript_registry", MODULE_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def main() -> None:
    registry = load_module()

    value = registry.RegistryValue(
        id="aux.mpu.total_audit_value",
        raw=864212.48,
        format="number:2",
    )
    value_dict = value.as_dict()
    assert value_dict["role"] == "total_audit_value"
    assert value_dict["display"] == "864,212.48"

    entry = registry.RegistryEntry(
        id="aux.mpu.estimator",
        kind="worked_calculation",
        source_notebook="notebooks/support/auxiliary-variables-and-stratification/support.Rmd",
        source_context="unit test",
        target_snippet="generated/worked-calculations/aux-mpu-estimator.tex",
        values=[value],
    ).as_dict()
    assert entry["schema_version"] == 1
    assert entry["chapter_prefix"] == "aux"
    assert entry["language_scope"] == "shared"

    try:
        registry.RegistryValue(id="bad.id", raw=1, format="integer").as_dict()
    except ValueError as exc:
        assert "Invalid manuscript calculation identifier" in str(exc)
    else:
        raise AssertionError("invalid ID should fail")

    print("Manuscript registry Python helper tests passed.")


if __name__ == "__main__":
    main()
