# Run the setup trials

**Use when:** a change touches the `setup` skill or its templates, and before every release
**Last verified:** 2026-10-13 (task 001)

## Prerequisites
- Claude Code CLI on PATH (`claude --version`)
- Git Bash (or any POSIX `sh`)

## Steps
1. `sh tools/trial-setup.sh <scratch dir> fresh` — expect: every line `ok`, exit 0
2. `sh tools/trial-setup.sh <scratch dir> existing` — expect: every line `ok`, exit 0
   Use a scratch directory outside the repo (for example the session scratchpad). Each run takes
   about a minute and uses a headless Claude session.

## Check it worked
- Both runs exit 0. On a failure, read `<scratch dir>/claude-<kind>.txt` for what the session did,
  and `git -C <scratch dir>/trial-<kind> diff` for what it changed.

## Known problems
| Symptom | Cause | Fix |
|---|---|---|
| `.claude/settings.json` not written | `.claude/` is a protected path: in `acceptEdits` mode its writes need a prompt, which a headless run can't show; allow rules don't help ([docs](https://code.claude.com/docs/en/permission-modes#protected-paths)) | Expected. The script checks the session proposed the content instead |
| Trial session fails with a model error | A trial `settings.json` set a real key (`model`) to a fake value | Use only harmless keys (`env`) in trial fixtures |
| `--allowedTools Write(...)` ignored | Only `Edit(path)` rules apply to file writes | Use `Edit(path)` |
