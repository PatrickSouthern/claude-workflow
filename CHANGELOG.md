# Changelog

All notable changes to the `workflow` plugin. Versions follow semver: a breaking change to skill
names, templates or `setup` output is a major version.

## 0.1.5 — 2026-10-15

From the SnowVibes Phase 0 review ([#2](https://github.com/PatrickSouthern/claude-workflow/issues/2)).

- `finish-task` step 2: a task that adds or changes a check runs it once against a deliberate
  failure and quotes that output. Manual checks are marked "before merge" unless they need the merge.
- `finish-task` step 9: the hand-off asks the user to run the "before merge" manual checks now, so
  they don't cost a round trip after the merge.
- `merge-task` step 5: an empty worktree folder may be held by a shell or another program, such as
  an editor. Nothing to do for existing projects.

## 0.1.4 — 2026-10-15

- `merge-task` step 7 matches `close-task` and "How we work": an OK to push given earlier in a
  task's close-out covers the merge's pushes too (found by `/doctor prompt-audit`).
- `finish-task`: line wrapping only. Nothing to do for existing projects.

## 0.1.3 — 2026-10-15

From the first process review (task 004).

- "How we work" (written by `setup`): trivial changes and post-merge records (release evidence,
  runbook rows) go straight to `main`; one OK to push covers the rest of that task's close-out.
  `close-task` says the same about pushing.
- Existing projects: `setup` never overwrites `CLAUDE.md`, so add the two sentences to your "How we
  work" section yourself, after "Only the main checkout creates task files." and after "Pushing
  needs the user's OK" respectively.

## 0.1.2 — 2026-10-15

- Retro fixes guard the condition that caused a failure instead of banning the whole action, and are
  no broader than the evidence; an action is banned outright only when the condition can't be
  checked. Said in `finish-task` step 5, the task template's Retro intro and the README
  ([#1](https://github.com/PatrickSouthern/claude-workflow/issues/1)).
- `finish-task` step 2: a slow check that already passed in the session needn't run again at hand-off
  when its output is on hand and no file it covers has changed since.
- Existing projects: `setup` never overwrites your task template, so add the line to the Retro intro
  of your `docs/tasks/_TEMPLATE.md` yourself: "Guard the condition that caused the failure, not the
  whole action: ban an action only when the condition can't be checked."

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
