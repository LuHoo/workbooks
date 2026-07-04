## Unreleased

### Content corrections
- Fixes missing references
- Corrects the regression chapter by expressing the noncentrality parameter as a standardized quantity, refining the terminology for decision bounds, and removing ambiguity in the audit hypothesis test.
- Corrects the worked 99% confidence interval for the mean response in the regression chapter and standardizes the confidence and prediction interval formulas to use the upper-tail critical value \(t_{1-\alpha/2}\).
- Corrects the description of winsorization in the regression chapter to match the implemented residual winsorization procedure, including the mathematical definition and the October 2012 example.

### Methodology
- Improves the annual regression evaluation by incorporating the covariance between monthly predictions.
- Replaces the root-sum-of-squares approximation for combining monthly prediction intervals with a covariance-aware annual prediction interval.
- Refines the annual evaluation workflow by incorporating corroborated adjustments to monthly expectations before assessing annual revenue.
- Aligns the evaluation stage of the regression chapter with the audit assurance framework used throughout the sampling chapters by distinguishing statistical model validation from audit evaluation and consistently interpreting prediction intervals, hypothesis tests, and audit assurance.

### Clarifications
- Tightens the Level of Assurance section.
- Revises Section 5.10 to present the worked annual evaluation in the main text.
- Refines the US SteamCo case study by incorporating the March 2014 winter storm investigation into the audit workflow.
- Minor updates and edits.

### Layout
- Adjusts spacing of floats to avoid underfull warnings.
- Adjusts paper layout for POD printing and adds author contracts.
- Adds missing PNG graphics, changes book format, replaces `\hlblue` with `\textbf`.
- Reformats learning objectives.

### New material
- Adds Section 6.4 Uniform Distribution.
- Completes the Goodness of Fit chapter.
- Completes the chapter through the Workshop section and adds review questions.
- Adds references to Volume 2.

### Internal
- Revises the pull request template for clarity and structure.
- Adds the book change issue template (`.github/ISSUE_TEMPLATE/book_change.md`).
- Splits ADA into two separate volumes.
- Merges infrastructure updates.
- Hides auxiliary files.
- Fixes graphics paths.
- Removes obsolete PNG files.
- Removes LaTeX auxiliary files.
