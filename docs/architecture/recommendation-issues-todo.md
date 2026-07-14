# Architecture Recommendations -> Issue Inventory and Priority TODO

Date: 2026-07-13
Repository: LuHoo/ada

## Scope scanned

All files in docs/architecture were scanned. Actionable recommendation sources were found mainly in:

- docs/architecture/canonical-notebook-generation-conformance.md
- docs/architecture/generation-publication-permissions-audit.md
- docs/architecture/recovery-and-regeneration.md
- docs/architecture/artifact-provenance-and-ownership.md

## Consolidated recommendation inventory

Duplicate recommendations across documents were deduplicated to one tracking issue.

| Recommendation (deduplicated) | Source docs | Issue status |
|---|---|---|
| Stabilize ADR path and cross-link implementation docs | canonical-notebook-generation-conformance.md | Existing: https://github.com/LuHoo/ada/issues/130 |
| Unify canonical source manifests into one authoritative registry | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/131 |
| Add pre-publication notebook hygiene gate (no outputs/execution counts) | canonical-notebook-generation-conformance.md; generation-publication-permissions-audit.md | Created: https://github.com/LuHoo/ada/issues/132 |
| Restrict export workflow permissions by job scope (least privilege) | generation-publication-permissions-audit.md | Created: https://github.com/LuHoo/ada/issues/133 |
| Consolidate shared validation logic across export/execution workflows | generation-publication-permissions-audit.md | Created: https://github.com/LuHoo/ada/issues/134 |
| Expand or formalize R execution coverage policy | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/135 |
| Add one canonical validation aggregator command/report | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/136 |
| Define deprecation criteria/timeline for legacy parser path | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/137 |
| Codify publication contract for workbooks and audit-data-analysis target(s) | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/138 |
| Decide authoritative Binder config owner and add drift detection | canonical-notebook-generation-conformance.md; generation-publication-permissions-audit.md | Created: https://github.com/LuHoo/ada/issues/139 |
| Implement IR-level semantic reference handling and validation | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/140 |
| Enforce no-manual-edit guardrail for generated notebook artifacts | generation-publication-permissions-audit.md | Created: https://github.com/LuHoo/ada/issues/141 |
| Align IR validation docs with supported schema versions | canonical-notebook-generation-conformance.md | Created: https://github.com/LuHoo/ada/issues/142 |
| Consolidate R generation on parse-once/render-many architecture | canonical-notebook-generation-conformance.md; generation-publication-permissions-audit.md; recovery-and-regeneration.md | Existing: https://github.com/LuHoo/ada/issues/90 |
| Remove chapter-specific Python-to-LaTeX fallback path by routing via generated notebooks | canonical-notebook-generation-conformance.md; generation-publication-permissions-audit.md; recovery-and-regeneration.md | Existing related: https://github.com/LuHoo/ada/issues/111 |

## Priority TODO (ordered with dependencies)

1. Foundation architecture references
   - https://github.com/LuHoo/ada/issues/130 done
   - Why first: provides stable architecture contract used by downstream implementation and validation issues.

2. Canonical source and producer authority
   - https://github.com/LuHoo/ada/issues/131 done 
   - https://github.com/LuHoo/ada/issues/90. done
   - Depends on: #130
   - Why now: removes producer ambiguity before adding stronger gates.

3. Remove transitional and fallback generation paths
   - https://github.com/LuHoo/ada/issues/111 done
   - https://github.com/LuHoo/ada/issues/137 done
   - Depends on: #131, #90
   - Why now: reduces divergence and clarifies single authoritative generation flow.

4. Add hard publication and edit-safety guardrails
   - https://github.com/LuHoo/ada/issues/132 done
   - https://github.com/LuHoo/ada/issues/141
   - https://github.com/LuHoo/ada/issues/133
   - Depends on: #131
   - Why now: prevents bad artifacts from being published and tightens repository integrity.

5. Execution and validation reliability
   - https://github.com/LuHoo/ada/issues/135
   - https://github.com/LuHoo/ada/issues/134
   - https://github.com/LuHoo/ada/issues/136
   - Depends on: #132, #133
   - Why now: builds dependable, consistent quality signals after guardrails exist.

6. Publication boundary and Binder ownership clarity
   - https://github.com/LuHoo/ada/issues/138
   - https://github.com/LuHoo/ada/issues/139
   - Depends on: #130
   - Why now: resolves ownership/drift ambiguity across repository boundaries.

7. Semantic-reference feature completion
   - https://github.com/LuHoo/ada/issues/140
   - Depends on: #131 and stable exporter/validation chain from #132, #136
   - Why later: relies on stabilized generation and validation contracts.

8. Documentation alignment cleanup
   - https://github.com/LuHoo/ada/issues/142
   - Depends on: none (can run anytime)
   - Why last: low risk/value compared with architecture and enforcement gaps.

## Notes

- Issue #108 remains a broad umbrella and can reference this list, but this TODO tracks actionable, reviewable work items.
- Artifact ownership YAML remains intentionally not implemented in current architecture docs unless a dedicated enforcing linter is introduced.