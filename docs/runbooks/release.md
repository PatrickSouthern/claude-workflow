# Release a new plugin version

**Use when:** a merged change to `plugins/workflow/` should reach installed users
**Last verified:** 2026-10-13 (task 001, v0.1.0)

## Prerequisites
- Claude Code CLI on PATH; push access to github.com/PatrickSouthern/claude-workflow
- The user has agreed to release

## Steps
Steps 1–5 belong in the task that makes the change, on its branch, so the version bump and
CHANGELOG entry are reviewed with the change. Step 6 runs on `main` after the merge.

1. Pick the version (semver): breaking change to skill names, templates or `setup` output → major;
   new skill or behavior → minor; fixes and wording → patch.
2. Set `"version"` in `plugins/workflow/.claude-plugin/plugin.json`.
3. Add a `CHANGELOG.md` entry: version, date, what changed and what users must do (if anything).
4. `claude plugin validate ./plugins/workflow` and `claude plugin validate .` — expect:
   `✔ Validation passed` twice.
5. Run the setup trials (`run-setup-trials.md`) — expect: both exit 0.
6. After the merge, on `main`: tag `v<version>`; push `main` and the tag (user's OK).

## Check it worked
- `claude plugin marketplace update claude-workflow`, then `claude plugin details workflow` shows the
  new version.

## Known problems
| Symptom | Cause | Fix |
|---|---|---|
| | | |
