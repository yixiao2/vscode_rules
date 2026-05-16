# Cline rules for remote NERSC workflow

## Environment assumptions
- This workspace is often used through a remote NERSC connection.
- In this environment, Python commands, Bash commands, and notebook execution may fail, hang, or be unreliable.
- Do not assume local-interactive tooling works.
- Prefer file inspection and direct text/code reasoning over runtime execution.

## Command execution policy
- Avoid using Python or Bash commands unless they are absolutely necessary.
- Do not use Python or Bash just to inspect, transform, or validate notebook content if the task can be completed by reading/editing files directly.
- If a command is truly necessary, ask first and explain why it is needed.
- Never repeatedly retry failing Python/Bash commands in this environment.
- If command execution appears unreliable, stop using commands and switch to a no-execution workflow.

## Jupyter notebook policy
- Do not configure, install, switch, or troubleshoot Jupyter kernels unless the user explicitly requests it.
- Do not run notebooks or notebook cells unless the user explicitly asks for execution.
- Assume the user will run the notebook manually.
- When working on `.ipynb` files, prefer one of these approaches in order:
  1. provide paste-ready cell content for the user to insert manually,
  2. make minimal targeted notebook edits only if the notebook structure is clear and the change is small,
  3. avoid large fragile JSON rewrites of notebook files.
- If editing a notebook directly is likely to be brittle, do not force the edit. Instead, provide the exact replacement cell(s) for manual paste.
- When proposing notebook changes, keep cells modular and easy to paste, e.g. separate processing, plotting, and helper cells.

## Preferred notebook editing style
- Prefer adding reusable helper cells/functions rather than duplicating plotting or analysis logic.
- Prefer small, self-contained notebook cells.
- When revising notebook logic, preserve the user’s existing workflow and variable naming unless there is a strong reason to change it.
- When adding plotting logic, provide options that the user can easily comment/uncomment.
- For large raster visualizations, prefer efficient image overlays over many patch objects unless the user specifically wants outlined geometry.

## Communication style for notebook tasks
- For notebook tasks, default to returning:
  - what cell to replace or add,
  - the exact code to paste,
  - a short explanation of what changed.
- If direct notebook patching is risky, say so clearly and switch to paste-ready code.
- Do not get stuck attempting repeated notebook JSON patches.
- If a tool action fails once due to environment limitations, adapt the strategy instead of repeating the same action.

## Remote-HPC safety rules
- Do not assume package installation is allowed or desirable.
- Do not modify environment modules, kernels, conda environments, or system configuration unless explicitly requested.
- Do not start long-running jobs, servers, or notebook sessions unless explicitly requested.
- Treat the environment as execution-constrained and user-managed.

## Decision rule when working with notebooks
- If the task is primarily about notebook code content, prefer manual-paste solutions.
- If the user explicitly asks for direct notebook editing, keep edits minimal and localized.
- If direct notebook editing fails or is likely to fail, stop and provide exact replacement cell content instead.

## What to avoid by default
- Avoid kernel setup.
- Avoid notebook execution.
- Avoid large `.ipynb` rewrites.
- Avoid repeated command retries.
- Avoid assuming Python/Bash are reliable in this remote environment.

