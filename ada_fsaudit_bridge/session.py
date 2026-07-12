from __future__ import annotations

from dataclasses import replace
from pathlib import Path
from typing import Any

from .conversion import python_to_r, r_to_python
from .errors import (
    ErrorDetails,
    FSAuditEnvironmentError,
    FSAuditExecutionError,
    FSAuditPackageNotInstalledError,
    FSAuditVersionMismatchError,
)
from .models import EnvironmentDiagnostics, NotebookContext


class FSAuditSession:
    def __init__(
        self,
        library_paths: list[str] | None = None,
        require_fsaudit_version: str | None = None,
    ) -> None:
        self.library_paths = list(library_paths or [])
        self.require_fsaudit_version = require_fsaudit_version
        self._initialized = False
        self._configured_seed: int | None = None
        self._context = NotebookContext()

    def ensure_initialized(self) -> None:
        if self._initialized:
            return

        try:
            import rpy2.robjects as ro
            from rpy2.robjects.packages import PackageNotInstalledError, importr
        except ModuleNotFoundError as exc:
            raise FSAuditEnvironmentError(
                "rpy2 is not installed in the active Python environment",
                ErrorDetails(
                    operation="initialize-session",
                    notebook_context=self._context,
                    remediation="Install rpy2 and ensure R is available on PATH.",
                ),
            ) from exc
        except Exception as exc:
            raise FSAuditEnvironmentError(
                "rpy2 could not initialize against the active R runtime",
                ErrorDetails(
                    operation="initialize-session",
                    notebook_context=self._context,
                    r_error=str(exc),
                    remediation=(
                        "Ensure Python, rpy2, and R use a compatible ABI combination. "
                        "On this machine, verify R_HOME points at the active framework and use a Python version supported by the installed rpy2 build."
                    ),
                ),
            ) from exc

        self.ro = ro
        self.importr = importr
        self.PackageNotInstalledError = PackageNotInstalledError

        if self.library_paths:
            current_paths = list(self.ro.r[".libPaths"]())
            merged = self.library_paths + [path for path in current_paths if path not in self.library_paths]
            self.ro.r[".libPaths"](self.ro.StrVector(merged))

        self.ro.r("options(stringsAsFactors = FALSE)")

        try:
            self.base = self.importr("base")
            self.utils = self.importr("utils")
            self.fsaudit = self.importr("FSaudit")
        except self.PackageNotInstalledError as exc:
            raise FSAuditPackageNotInstalledError(
                "The FSaudit R package is not installed or not reachable from the active R library paths",
                ErrorDetails(
                    operation="initialize-session",
                    function_name="library(FSaudit)",
                    notebook_context=self._context,
                    r_error=str(exc),
                    remediation="Install FSaudit in R or configure ADA_FSAUDIT_R_LIBS / configure_environment(..., r_library_paths=...).",
                    diagnostics=self.diagnostics(),
                ),
            ) from exc

        self._r_version = str(self.ro.r('as.character(getRversion())')[0])
        self._fsaudit_version = str(self.ro.r('as.character(packageVersion("FSaudit"))')[0])

        if self.require_fsaudit_version and self._fsaudit_version != self.require_fsaudit_version:
            raise FSAuditVersionMismatchError(
                "Installed FSaudit version does not match the configured requirement",
                ErrorDetails(
                    operation="initialize-session",
                    function_name="packageVersion",
                    notebook_context=self._context,
                    remediation=f"Install FSaudit {self.require_fsaudit_version} or update the bridge configuration.",
                    diagnostics=self.diagnostics(),
                ),
            )

        self._initialized = True

    def set_context(self, context: NotebookContext) -> None:
        self._context = replace(context)

    def diagnostics(self) -> EnvironmentDiagnostics:
        paths: list[str] = []
        if hasattr(self, "ro"):
            paths = [str(path) for path in list(self.ro.r[".libPaths"]())]
        else:
            paths = list(self.library_paths)
        return EnvironmentDiagnostics(
            r_version=getattr(self, "_r_version", None),
            fsaudit_version=getattr(self, "_fsaudit_version", None),
            library_paths=paths,
            configured_seed=self._configured_seed,
            context=self._context.as_dict(),
        )

    def set_seed(self, seed: int) -> None:
        self.ensure_initialized()
        self.ro.r["set.seed"](int(seed))
        self._configured_seed = int(seed)

    def load_dataset(self, name: str) -> Any:
        self.ensure_initialized()
        try:
            self.ro.r(f'data({name}, package = "FSaudit")')
            value = self.ro.r[name]
            return r_to_python(value, context=self._context)
        except Exception as exc:
            raise FSAuditExecutionError(
                f"Failed to load dataset '{name}' from FSaudit",
                ErrorDetails(
                    operation="load-dataset",
                    function_name="data",
                    notebook_context=self._context,
                    r_error=str(exc),
                    remediation="Check that the dataset name exists in FSaudit and that the package is installed correctly.",
                    diagnostics=self.diagnostics(),
                ),
            ) from exc

    def call_function(
        self,
        function_name: str,
        *args: Any,
        context: NotebookContext | None = None,
        **kwargs: Any,
    ) -> Any:
        self.ensure_initialized()
        active_context = context or self._context
        try:
            fn = getattr(self.fsaudit, function_name)
            r_args = [python_to_r(arg, context=active_context) for arg in args]
            r_kwargs = {
                key: python_to_r(value, context=active_context)
                for key, value in kwargs.items()
                if value is not None
            }
            return fn(*r_args, **r_kwargs)
        except Exception as exc:
            raise FSAuditExecutionError(
                f"FSaudit call '{function_name}' failed",
                ErrorDetails(
                    operation="call-r-function",
                    function_name=function_name,
                    notebook_context=active_context,
                    r_error=str(exc),
                    remediation="Inspect the provided arguments and confirm that the active R/FSaudit environment matches the notebook requirements.",
                    diagnostics=self.diagnostics(),
                ),
            ) from exc

    def get_named_value(self, r_object: Any, name: str, context: NotebookContext | None = None) -> Any:
        active_context = context or self._context
        try:
            value = r_object.rx2(name)
            return r_to_python(value, context=active_context)
        except Exception as exc:
            raise FSAuditExecutionError(
                f"Failed to read '{name}' from FSaudit object",
                ErrorDetails(
                    operation="read-r-object-field",
                    function_name=name,
                    notebook_context=active_context,
                    r_error=str(exc),
                    remediation="Inspect the returned FSaudit object fields and confirm the workflow produced the expected object type.",
                    diagnostics=self.diagnostics(),
                ),
            ) from exc


def discover_repo_root(start: Path | None = None) -> Path:
    current = (start or Path.cwd()).resolve()
    for candidate in [current, *current.parents]:
        if (candidate / ".git").exists():
            return candidate
    return current
