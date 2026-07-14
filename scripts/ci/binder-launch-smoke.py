#!/usr/bin/env python3

import argparse
import json
import os
import time
import urllib.parse
from dataclasses import dataclass
from datetime import datetime, timezone

import requests


@dataclass
class BinderReadyPayload:
    base_url: str
    token: str | None


def utc_ts() -> str:
    return datetime.now(timezone.utc).isoformat()


def append_log(log_lines: list[str], line: str) -> None:
    log_lines.append(f"[{utc_ts()}] {line}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Launch smoke test for mybinder.org targets with timeout polling and JupyterLab readiness verification."
    )
    parser.add_argument("--target-repo", required=True, help="GitHub repo in owner/name format.")
    parser.add_argument("--target-ref", default="main", help="Git ref for Binder build (default: main).")
    parser.add_argument("--urlpath", default="lab", help="Binder urlpath to verify (default: lab).")
    parser.add_argument(
        "--build-timeout-seconds",
        type=int,
        default=1800,
        help="Max seconds to wait for Binder build/ready phase (default: 1800).",
    )
    parser.add_argument(
        "--launch-timeout-seconds",
        type=int,
        default=60,
        help="HTTP timeout for final Jupyter endpoint checks (default: 60).",
    )
    parser.add_argument(
        "--event-timeout-seconds",
        type=int,
        default=60,
        help="Read timeout per streamed event chunk (default: 60).",
    )
    parser.add_argument(
        "--log-file",
        required=True,
        help="Path to write full launch/build logs.",
    )
    return parser.parse_args()


def binder_build_stream_url(target_repo: str, target_ref: str, urlpath: str) -> str:
    encoded_ref = urllib.parse.quote(target_ref, safe="")
    encoded_urlpath = urllib.parse.quote(urlpath, safe="")
    return f"https://mybinder.org/build/gh/{target_repo}/{encoded_ref}?urlpath={encoded_urlpath}"


def binder_stream_headers() -> dict[str, str]:
    # BinderHub requires explicit SSE negotiation for /build requests.
    return {"Accept": "text/event-stream"}


def stream_until_ready(args: argparse.Namespace, log_lines: list[str]) -> BinderReadyPayload:
    url = binder_build_stream_url(args.target_repo, args.target_ref, args.urlpath)
    append_log(log_lines, f"Connecting to Binder event stream: {url}")

    start = time.monotonic()
    attempt = 0
    last_error: str | None = None

    while True:
        elapsed = time.monotonic() - start
        if elapsed > args.build_timeout_seconds:
            detail = f" Last stream error: {last_error}" if last_error else ""
            raise TimeoutError(
                f"Binder did not reach ready state within {args.build_timeout_seconds} seconds.{detail}"
            )

        attempt += 1
        append_log(log_lines, f"Opening Binder stream attempt {attempt}")

        try:
            with requests.get(
                url,
                stream=True,
                timeout=(15, args.event_timeout_seconds),
                headers=binder_stream_headers(),
            ) as resp:
                append_log(log_lines, f"Binder stream HTTP status: {resp.status_code}")

                content_type = resp.headers.get("content-type", "")
                if resp.status_code >= 400 and "text/event-stream" not in content_type:
                    resp.raise_for_status()

                saw_event = False
                for raw_line in resp.iter_lines(decode_unicode=True):
                    saw_event = True
                    elapsed = time.monotonic() - start
                    if elapsed > args.build_timeout_seconds:
                        raise TimeoutError(
                            f"Binder did not reach ready state within {args.build_timeout_seconds} seconds."
                        )

                    if raw_line is None:
                        continue
                    line = raw_line.strip()
                    if not line:
                        continue
                    if not line.startswith("data:"):
                        continue

                    payload_text = line[len("data:") :].strip()
                    if payload_text in ("", "null"):
                        continue

                    try:
                        payload = json.loads(payload_text)
                    except json.JSONDecodeError:
                        append_log(log_lines, f"Non-JSON event payload: {payload_text}")
                        continue

                    phase = payload.get("phase")
                    message = payload.get("message")
                    append_log(log_lines, f"phase={phase} message={message}")

                    if phase in {"failed", "error"}:
                        raise RuntimeError(f"Binder build failed for {args.target_repo}@{args.target_ref}: {message}")

                    if phase == "ready":
                        ready_payload = BinderReadyPayload(
                            base_url=str(payload.get("url", "")).strip(),
                            token=(str(payload.get("token")).strip() if payload.get("token") is not None else None),
                        )
                        if not ready_payload.base_url:
                            raise RuntimeError("Binder ready event did not include a launch URL.")
                        return ready_payload

                if not saw_event:
                    append_log(log_lines, "Binder event stream closed without events; retrying.")
                else:
                    append_log(log_lines, "Binder event stream closed before ready; retrying.")

        except requests.exceptions.RequestException as exc:
            last_error = str(exc)
            append_log(log_lines, f"Transient Binder stream error: {exc}. Retrying.")

        time.sleep(2)


def build_probe_url(base_url: str, urlpath: str, token: str | None) -> str:
    base = base_url if base_url.endswith("/") else base_url + "/"
    cleaned_urlpath = urlpath.lstrip("/")
    probe = urllib.parse.urljoin(base, cleaned_urlpath)
    if token:
        sep = "&" if "?" in probe else "?"
        probe = f"{probe}{sep}token={urllib.parse.quote(token, safe='')}"
    return probe


def verify_launch(ready: BinderReadyPayload, args: argparse.Namespace, log_lines: list[str]) -> None:
    probe_url = build_probe_url(ready.base_url, args.urlpath, ready.token)
    append_log(log_lines, f"Probing Binder URL: {probe_url}")

    resp = requests.get(
        probe_url,
        timeout=args.launch_timeout_seconds,
        allow_redirects=True,
    )

    append_log(log_lines, f"Probe status={resp.status_code} final_url={resp.url}")

    if resp.status_code >= 400:
        raise RuntimeError(
            f"Binder endpoint probe failed with status {resp.status_code} for {probe_url}"
        )

    content = resp.text.lower()
    if "jupyter" not in content and "lab" not in content:
        append_log(log_lines, "Warning: response did not contain typical Jupyter/Lab markers.")


def ensure_log_dir(path: str) -> None:
    parent = os.path.dirname(path)
    if parent:
        os.makedirs(parent, exist_ok=True)


def write_logs(path: str, log_lines: list[str]) -> None:
    ensure_log_dir(path)
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(log_lines) + "\n")


def main() -> None:
    args = parse_args()
    log_lines: list[str] = []

    append_log(log_lines, f"Starting Binder launch smoke for {args.target_repo}@{args.target_ref}")
    append_log(log_lines, f"Configured urlpath={args.urlpath}")

    try:
        ready = stream_until_ready(args, log_lines)
        append_log(log_lines, f"Binder ready URL received: {ready.base_url}")
        verify_launch(ready, args, log_lines)
        append_log(log_lines, "Binder launch smoke check passed.")
    except Exception as exc:
        append_log(log_lines, f"ERROR: {exc}")
        write_logs(args.log_file, log_lines)
        raise

    write_logs(args.log_file, log_lines)


if __name__ == "__main__":
    main()
