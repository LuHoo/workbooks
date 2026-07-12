from __future__ import annotations

from dataclasses import dataclass

from .models import EnvironmentDiagnostics, NotebookContext


@dataclass(slots=True)
class ErrorDetails:
    operation: str
    function_name: str | None = None
    notebook_context: NotebookContext | None = None
    r_error: str | None = None
    remediation: str | None = None
    diagnostics: EnvironmentDiagnostics | None = None


class FSAuditBridgeError(RuntimeError):
    def __init__(self, message: str, details: ErrorDetails) -> None:
        self.details = details
        super().__init__(self._format_message(message))

    def _format_message(self, message: str) -> str:
        parts = [message, f"operation={self.details.operation}"]
        if self.details.function_name:
            parts.append(f"function={self.details.function_name}")
        if self.details.notebook_context:
            context = self.details.notebook_context.as_dict()
            if context:
                parts.append(
                    "context=" + ",".join(f"{key}:{value}" for key, value in context.items())
                )
        if self.details.r_error:
            parts.append(f"r_error={self.details.r_error}")
        if self.details.remediation:
            parts.append(f"remediation={self.details.remediation}")
        return " | ".join(parts)


class FSAuditPackageNotInstalledError(FSAuditBridgeError):
    pass


class FSAuditVersionMismatchError(FSAuditBridgeError):
    pass


class FSAuditInputError(FSAuditBridgeError):
    pass


class FSAuditConversionError(FSAuditBridgeError):
    pass


class FSAuditExecutionError(FSAuditBridgeError):
    pass


class FSAuditEnvironmentError(FSAuditBridgeError):
    pass
