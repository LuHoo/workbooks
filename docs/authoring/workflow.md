# Notebook Validation Workflow

This workflow is written for a non-expert operator.

It assumes:

- two separate local repositories;
- two separate VS Code windows;
- two separate Safari tabs for two PRs.

Do not improvise this process. Follow each step in order.

## 0) Required Setup (Before Any Notebook Publication Work)

### 0.1 Local folders

You must have two different folders on disk:

- ADA repo folder (private): this repository.
- Workbooks repo folder (public): a separate clone of `https://github.com/LuHoo/workbooks.git`.

The two folders must be different paths.

### 0.2 VS Code windows

Open exactly two VS Code windows:

- Window A: ADA repo root.
- Window B: workbooks repo root.

### 0.3 Terminal identity check (mandatory)

Run this in Window A terminal:

```bash
pwd
git rev-parse --show-toplevel
git remote -v
```

Expected:

- path is ADA repo path;
- remote includes ADA repository remote(s).

Run this in Window B terminal:

```bash
pwd
git rev-parse --show-toplevel
git remote -v
```

Expected:

- path is workbooks repo path;
- remote is `https://github.com/LuHoo/workbooks.git`.

If either window points to the wrong repo, stop and fix that first.

## 1) Scripts Used In ADA (Window A Only)

These scripts are run only in ADA (Window A):

- validate (fast, pre-push):
  - `scripts/ci/validate-notebook-narrow-chain.sh`
- validate (full, safer and broader):
  - `scripts/ci/validate-notebook-full-gate.sh`
- moving-parts synchronization:
  - `scripts/ci/sync-notebook-moving-parts.sh`
- ADA to workbooks publication wrapper:
  - `scripts/ci/publish-workbooks-from-ada.sh`

Never run these in Window B.

Legacy script names still exist and are used under the aliases above.

## 2) When To Run Each Script

### 2.1 Run fast validation before every relevant push

In Window A, run:

```bash
bash scripts/ci/validate-notebook-narrow-chain.sh
```

Use timeout override only if needed:

```bash
NOTEBOOK_EXEC_TIMEOUT=900 bash scripts/ci/validate-notebook-narrow-chain.sh
```

Run this before pushing any branch that changes notebook generation, notebook validation, binder install behavior, or the submodule pointer.

### 2.2 Is narrow validation too narrow?

Short answer: sometimes yes.

Use this rule:

- Use fast validation (`validate-notebook-narrow-chain.sh`) during normal iterative development.
- Use full validation (`validate-notebook-full-gate.sh`) before publication work or when CI failures are unclear.

In Window A, full validation command:

```bash
bash scripts/ci/validate-notebook-full-gate.sh
```

### 2.3 Run sync when publication parity may be stale

In Window A, run:

```bash
bash scripts/ci/sync-notebook-moving-parts.sh
```

Run this after canonical source changes and immediately after any CI complaint about generated notebook artifacts.

### 2.4 Re-run validation after sync

In Window A, run again:

```bash
bash scripts/ci/validate-notebook-narrow-chain.sh
```

Before publication, prefer one full run:

```bash
bash scripts/ci/validate-notebook-full-gate.sh
```

Only continue to publication after validations pass.

## 3) Remote and Push Setup (One-Time, To Keep Daily Usage Simple)

You want to use `git push` without always writing remote names. That is fine.

Do this once per branch, in each repo:

In Window A (ADA branch):

```bash
git push -u ada-origin <your-ada-branch>
```

In Window B (workbooks branch):

```bash
git push -u origin <your-workbooks-branch>
```

After upstream is set, normal pushes are just:

```bash
git push
```

You do not need to force this workflow into complicated remote commands every time.

## 4) Publish Generated Notebooks To LuHoo/workbooks (Step-by-Step)

This is the critical section.

### 4.1 Create a publication branch in workbooks first (Window B)

In Window B:

```bash
git fetch origin --prune
git switch main
git pull --ff-only origin main
git switch -c publish/notebooks-YYYYMMDD-HHMM
```

Replace `YYYYMMDD-HHMM` with current date/time.

### 4.2 Sync files from ADA to workbooks using wrapper (Window A)

In Window A, run:

```bash
bash scripts/ci/publish-workbooks-from-ada.sh --workbooks-repo '/Users/lucashoogduin/Documents/6. Mental/Workbooks LuHoo (git)'
```

Important:

- Path must match the repo opened in Window B.
- The wrapper performs file synchronization only.
- The wrapper prints suggested commit and push commands for workbooks.

### 4.3 Review changes in workbooks (Window B)

In Window B:

```bash
git status -sb
git rev-list --left-right --count origin/main...HEAD
git ls-tree --name-only HEAD
```

You should see:

- branch ahead of `origin/main` by local publication changes;
- only workbooks-style top-level content.

If you see ADA project tree content, stop immediately.

### 4.4 Commit and push workbooks publication branch (Window B)

In Window B:

```bash
git add -A
git commit -m "Publish generated notebooks from ADA"
git push
```

### 4.5 Open PR 1 in Safari (workbooks PR)

In Safari tab 1:

- open a PR in `LuHoo/workbooks` from `publish/notebooks-...` to `main`;
- review file list;
- confirm it is only publication artifacts;
- merge after checks pass.

## 5) Update ADA Pointer After Workbooks PR Merge

Do this only after workbooks PR is merged.

### 5.1 Update ADA submodule pointer (Window A)

In Window A:

```bash
cd notebooks/workshops
git fetch origin --prune
git switch main
git pull --ff-only origin main
cd ../..
git add notebooks/workshops
git commit -m "Update workbooks submodule pointer after notebook publication"
git push
```

### 5.2 Open PR 2 in Safari (ADA PR)

In Safari tab 2:

- open ADA PR for the pointer update branch;
- review that only `notebooks/workshops` pointer changed;
- merge per normal process.

## 6) Strict Do-Not-Do Rules (With Examples)

Never do any of the following:

- never run `git pull` from ADA remote inside workbooks repo;
- never run `git merge` from ADA branch into workbooks branch;
- never publish from detached HEAD;
- never use one mixed folder for both repos;
- never skip `pwd` and `git rev-parse --show-toplevel` checks when switching tasks.

How to detect wrong pull target before damage:

In Window B, run:

```bash
pwd
git remote -v
```

Safe result example:

- `pwd` ends in `Workbooks LuHoo (git)`.
- `git remote -v` shows `github.com/LuHoo/workbooks.git`.

Unsafe result example:

- remote output includes `github.com/LuHoo/ada` in Window B.
- or `pwd` points to ADA path while you think you are in workbooks.

Concrete wrong-command examples (do not run in Window B):

- `git pull ada-origin main`
- `git merge ada-origin/main`

How to detect detached HEAD before publish:

```bash
git branch --show-current
```

Unsafe result:

- empty output or message indicating detached HEAD.

Fix:

```bash
git switch -c publish/notebooks-YYYYMMDD-HHMM
```

## 7) Fast Recovery Checklist (If Something Looks Wrong)

If workbooks suddenly shows ADA files/folders:

1. Stop committing.
2. In Window B, run:

```bash
git status -sb
git branch --show-current
git log --oneline --max-count=10
git remote -v
```

3. Verify current branch base against `origin/main`:

```bash
git rev-list --left-right --count origin/main...HEAD
```

4. If history or tree is contaminated, create a fresh publication branch from `origin/main` and re-run Section 4.

## 8) Recommended Daily Pattern (ADA Changes Only)

1. Work on canonical notebook/source changes in Window A.
2. Run fast validation in Window A.
3. Run sync in Window A when needed.
4. Re-run fast validation in Window A.
5. Before opening ADA PR, run full validation in Window A.
6. Open ADA PR and merge.

## 9) Recommended Publication Pattern (Less Frequent)

Use this when you actually publish generated notebooks to workbooks.

1. In Window A (ADA), run sync and then full validation.
2. In Window B (workbooks), create fresh publish branch from `origin/main`.
3. In Window A, run `publish-workbooks-from-ada.sh` with the exact workbooks path.
4. In Window B, review diff and run sanity checks.
5. In Window B, commit and `git push`.
6. In Safari tab 1, merge workbooks PR.
7. In Window A, update submodule pointer commit and `git push`.
8. In Safari tab 2, merge ADA pointer PR.

## Why This Works

This process keeps three moving parts synchronized without cross-repo history mixing:

1. canonical generation in ADA;
2. published notebook artifacts in workbooks;
3. ADA pointer update back to the published workbooks state.

The key safety property is file synchronization across two separate clones, not git history merging across repositories.
