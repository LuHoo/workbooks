# Book Versioning

Each volume has its own version file in the repository root:

- `VERSION_VOLUME1`
- `VERSION_VOLUME2`

This lets the two volumes move independently while keeping a single source of
truth per volume. Versions follow the `Edition.Print.Iteration` convention.

Examples:

- `1.0.0`: first print or release of the first edition.
- `1.0.1`: first internal author/reviewer iteration after `1.0.0`.
- `1.0.2`: second internal author/reviewer iteration.
- `1.1.0`: new print or release with reader-facing changes documented in
  `WHATS_NEW.md`.
- `2.0.0`: second edition.

Increment the first number for a new edition. Increment the second number for a
new print or reader-facing release. Increment the third number for internal
author/reviewer iterations between releases.

When the second number changes, summarize reader-facing changes in
`WHATS_NEW.md`. Internal-only changes can stay in `CHANGELOG.md` or the PR
description, depending on their scope.

The LaTeX master files read their corresponding version files directly and
display the version with the build date on the title and copyright pages.
Volume 1 no longer uses a draft watermark; the visible version number
identifies review PDFs instead.
