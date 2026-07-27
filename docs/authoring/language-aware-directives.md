# Authoring Language-Aware Directives in support.Rmd

This guide shows how to author Python-specific narrative and code in shared
`support.Rmd` files without maintaining separate notebooks.

## Quick reference

- Begin region:
  - `<!-- ADA:BEGIN lang=python mode=only kind=narrative -->`
- End region:
  - `<!-- ADA:END -->`
- Capability annotation for next code block:
  - `<!-- ADA:REQUIRES capability=fsaudit -->`

## Example 1: Python-specific narrative addition

```markdown
Shared explanation visible in all tracks.

<!-- ADA:BEGIN lang=python mode=only kind=narrative -->
Python-specific interpretation for the same concept.
<!-- ADA:END -->
```

## Example 2: Python narrative override

```markdown
Shared wording oriented to R users.

<!-- ADA:BEGIN lang=python mode=override kind=narrative -->
Equivalent wording oriented to Python users.
<!-- ADA:END -->
```

## Example 3: Python code override

```markdown
```{r}
mean(x)
```

<!-- ADA:BEGIN lang=python mode=override kind=code -->
```{r}
np.mean(x)
```
<!-- ADA:END -->
```
```

## Example 4: FSAudit capability annotation

```markdown
<!-- ADA:REQUIRES capability=fsaudit -->
```{r}
# sample-size/evaluation logic requiring FSAudit bridge
```
```

## Common mistakes

- Opening a directive region and forgetting `ADA:END`.
- Nesting one `ADA:BEGIN` inside another.
- Using unsupported language ids.
- Using `mode=override` when no prior shared block exists.
- Repeating multiple overrides for the same target block/language.

## Semantic references

When you need to create an explicit semantic cross-reference to another chapter,
exercise, or block entity, use this inline token format:

```markdown
[[ADA:REF target=<semantic-id>]]
```

Examples:

```markdown
See [[ADA:REF target=EX-5.12]] for the prior exercise setup.
```

```markdown
This step reuses context from [[ADA:REF target=BL-EX-5.12-002]].
```

Validation behavior:

- unresolved target ids fail IR validation;
- references to missing source block ids fail IR validation;
- duplicated semantic target declarations fail IR validation.

## Migration note

Notebooks without directives continue to parse and render as before.
