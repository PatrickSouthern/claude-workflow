# Changelog

All notable changes to the `workflow` plugin. Versions follow semver: a breaking change to skill
names, templates or `setup` output is a major version.

## 0.1.1 — 2026-10-13

- `setup` and the README no longer claim Claude Code always asks before writing `.claude/settings.json`.
  The project's `.claude/` is a protected path: Manual and `acceptEdits` modes ask, `auto` mode's
  classifier may write without asking, `dontAsk` refuses. Nothing to do for existing projects.
- American spelling throughout.

## 0.1.0 — 2026-10-13

First release, packaged from the workflow built in the SnowVibes project (its tasks 001–004).

- Skills: `setup`, `task`, `finish-task`, `merge-task`, `close-task`, `review-process`.
- `setup` writes `CLAUDE.md`'s "How we work" section, the roadmap, task template, backlog, process
  log, runbooks folder, worktree setting and read-deny rules; it adds to existing files and never
  overwrites them.
- Task template with a Retro section; process log with phase-end reviews.
