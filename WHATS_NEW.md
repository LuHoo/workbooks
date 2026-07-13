## Unreleased

### Content corrections
- Fixed missing references throughout the text

### Methodological improvements
- Tightened and refined the level of assurance standards used in the book
- Revised the annual evaluation in the regression chapter by using a covariance-aware prediction interval and aligning the audit workflow with professional practice
- Revised the Regression Analysis chapter learning objectives so they emphasize audit judgement, evidential evaluation, and professional interpretation rather than section-by-section statistical procedure execution

### Clarifications
- Made various minor edits and updates to improve clarity
- Refined the US SteamCo case study by incorporating the investigation of the March 2014 winter storm before the annual evaluation
- Clarified the winsorization procedure in the regression chapter. The text now correctly explains that the workshop winsorizes regression residuals before reconstructing the adjusted response, matching the accompanying R code and examples.

### Layout and readability
- Improved spacing of figures and tables to avoid overfull/underfull text warnings
- Adjusted paper layout for print-on-demand publishing
- Added missing graphics and improved overall visual presentation
- Reformatted learning objectives for better readability
- Consolidated the Regression Analysis chapter learning objectives into one chapter-level section and removed repeated section-level objective blocks

### New material
- Added comprehensive coverage of uniform distribution (Section 6.4)
- Completed the goodness of fit chapter with full treatment and applications
- Extended chapter content through the workshop section with review questions
- Integrated cross-references to Volume 2 throughout the text

### Architecture and workflow
- Issue #111: Completed Python workshop export parity in the book flow, including embedded Workshop Python sections in the correct chapter files and consistent generated include wiring.
- Issue #137: Added explicit legacy parser deprecation governance with checkpoint-based criteria, documented transition hold conditions, and preserved explicit rollback mode (`--parser-engine legacy`) during transition.
