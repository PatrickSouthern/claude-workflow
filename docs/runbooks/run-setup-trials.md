# Run the setup trials

**Use when:** a change touches the `setup` skill or its templates, and before every release
**Last verified:** 2026-10-15 (task 004, `run-trials.sh`)

## Prerequisites
- Claude Code CLI on PATH (`claude --version`)
- Git Bash (or any POSIX `sh`)

## Steps
1. `sh tools/run-trials.sh <scratch dir>` — expect: `fresh exit=0` and `existing exit=0`, every
   summary line `ok` (plus a `CLAUDE.md: N lines` info line each), and the script exits 0.
   Use a scratch directory outside the repo (for example the session scratchpad). It takes a few
   minutes (two headless Claude sessions); run it in the background. Run it as one plain command,
   not piped or chained. Quote both `exit=` lines in the evidence. For one trial only:
   `sh tools/trial-setup.sh <dir> fresh|existing`.

## Check it worked
- Both runs exit 0. On a failure, read `<scratch dir>/claude-<kind>.txt` for what the session did,
  and `git -C <scratch dir>/trial-<kind> diff` for what it changed.

## Known problems
| Symptom | Cause | Fix |
|---|---|---|
| `.claude/settings.json` not written | `.claude/` is a protected path: in `acceptEdits` mode its writes need a prompt, which a headless run can't show; allow rules don't help ([docs](https://code.claude.com/docs/en/permission-modes#protected-paths)) | Expected. The script checks the session proposed the content instead |
| Trial session fails with a model error | A trial `settings.json` set a real key (`model`) to a fake value | Use only harmless keys (`env`) in trial fixtures |
| "Refusing to run it — a worktree-isolated session's git operations must target its own worktree" | Worktree isolation can't verify a compound command that runs `sh` (the script runs git) | Use `tools/run-trials.sh` as one plain command |
| A failing trial looked like a pass | Output piped through `tail` or `grep` hides the exit code | Use `tools/run-trials.sh`, unpiped |
| `--allowedTools Write(...)` ignored | Only `Edit(path)` rules apply to file writes | Use `Edit(path)` |
