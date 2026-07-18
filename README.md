# Workbooks for Audit Data Analysis

Interactive workshop notebooks accompanying Volume 1 of the book.

## Launch on Binder

Choose the interface that matches your workshop type:

- R workshops (R Markdown): [Open Binder in RStudio](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=rstudio)
- Python workshops (Jupyter notebooks): [Open Binder in JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/)

If you start in RStudio and want Python notebooks, open the JupyterLab link above.
If you start in JupyterLab and want R workshops, open the RStudio link above.

## R Workshops (R Markdown)

- [Chapter 1: Probability distributions](Probability%20distributions%20workshop.Rmd)
- [Chapter 2: Estimating the population mean and proportion](Estimating%20the%20population%20mean%20and%20proportion%20workshop.Rmd)
- [Chapter 3: Estimation with auxiliary variables and stratification](Estimation%20with%20auxiliary%20variables%20and%20stratification%20workshop.Rmd)
- [Chapter 4: Hypothesis testing](Hypothesis%20testing%20workshop.Rmd)
- [Chapter 5: Regression analysis](Regression%20analysis%20workshop.Rmd)
- [Chapter 6: Goodness of fit](Goodness%20of%20fit%20workshop.Rmd)

## Python Workshops (Jupyter Notebooks)

- [Chapter 1 notebook: Workshop 1 (Python)](Workshop%201%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%201%20%28Python%29.ipynb)
- [Chapter 2 notebook: Workshop 2 (Python)](Workshop%202%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%202%20%28Python%29.ipynb)
- [Chapter 3 notebook: Workshop 3 (Python)](Workshop%203%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%203%20%28Python%29.ipynb)
- [Chapter 4 notebook: Workshop 4 (Python)](Workshop%204%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%204%20%28Python%29.ipynb)
- [Chapter 5 notebook: Workshop 5 (Python)](Workshop%205%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%205%20%28Python%29.ipynb)
- [Chapter 6 notebook: Workshop 6 (Python)](Workshop%206%20(Python).ipynb) - [Launch in Binder JupyterLab](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/Workshop%206%20%28Python%29.ipynb)

These R workbooks are generated from canonical support notebooks in the
private `ada` repository. Do not edit them directly; changes are made in
`ada` and exported here so that the book-support notebooks and Binder
workbooks cannot drift apart.

## Publication Guardrail

When `notebooks/support/**/support.Rmd` changes in the private `ada` workflow,
the regenerated files under `notebooks/workshops/` must be committed and pushed
to this public repository before the change is considered complete.

Use this check from the repository root:

```bash
scripts/ci/enforce_workshops_publication.sh origin/main HEAD
```

The check fails if:

- support notebooks changed but no workshop outputs changed;
- `notebooks/workshops/` has uncommitted changes in its nested repo;
- the nested `notebooks/workshops` repo has local commits not yet pushed to its upstream.

[![Binder (RStudio)](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=rstudio)
[![Binder (JupyterLab)](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/LuHoo/workbooks/HEAD?urlpath=lab/tree/)
