# Release a new plugin version

**Use when:** a merged change to `plugins/workflow/` should reach installed users
**Last verified:** 2026-10-15 (task 003, v0.1.2)

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
- `claude plugin marketplace update claude-workflow`, then `claude plugin update workflow@claude-workflow`
  — expect: `Plugin "workflow" updated from <old> to <new>`. `claude plugin details workflow` shows
  the new version. Restart Claude Code to use it.

## Known problems
| Symptom | Cause | Fix |
|---|---|---|
| Installed plugin stays on the old version | `marketplace update` only refreshes the catalog | Also run `claude plugin update workflow@claude-workflow` |
| `plugin update` updates one install but `claude plugin list` still shows others on the old version | One install per scope, and a project's worktrees can have their own project-scope entries; auto-detect picks one (task 003 picked a SnowVibes worktree) | Check `claude plugin list` after updating; run `--scope user` too. For a stale entry that `--scope project` won't reach: in task 003 it was updated outside the session within minutes (likely from that checkout); confirm with `claude plugin list` |
