# 001 — Workflow plugin v0.1

**Status:** In progress — branch task-001-plugin-v0-1
**Last updated:** 2026-10-13
**Next step:** Plan step 1 (layout and manifests)
**Blockers:** none (Claude Code CLI 2.1.296 on PATH since 2026-10-13)
**Worktree:** none (bootstrap task: branch `task-001-plugin-v0-1`; see Decisions)

## Goal
Package the task workflow built in SnowVibes (tasks 001–004) as a Claude Code plugin in this repo,
installable on any machine with two commands, plus a setup skill that adds the workflow to a new or
existing project. The repo also becomes the home of the pattern: its README is the guide, and lessons
about the pattern land here.

## Touches
- Everything (new repo).

## Backlog items covered
- none (new repo). Source: SnowVibes roadmap note "workflow plugin", task 004 decisions.

## Success criteria
- [ ] 1. Valid plugin and marketplace — *`claude plugin validate ./plugins/workflow` and
      `claude plugin validate .` both print `✔ Validation passed`*
- [ ] 2. Installs from the local marketplace — *`claude plugin marketplace add <repo path>` then
      `claude plugin install workflow@claude-workflow` succeed; `claude plugin details workflow`
      lists 6 skills: `setup`, `task`, `finish-task`, `merge-task`, `close-task`, `review-process`*
- [ ] 3. Skills are stack-neutral and namespaced — *grep finds no Unity / SnowVibes references in
      `plugins/workflow/`; every cross-reference between skills uses `workflow:<name>`*
- [ ] 4. Setup works on a fresh project — *in a scratch git repo, `/workflow:setup` (answers given as
      arguments) creates `CLAUDE.md` "How we work", `docs/ROADMAP.md`, `docs/tasks/_TEMPLATE.md`,
      `docs/tasks/BACKLOG.md`, `docs/PROCESS-LOG.md`, `docs/runbooks/README.md` and `_TEMPLATE.md`,
      `.claude/settings.json` (deny rules + `worktree.baseRef`), and the `.gitignore` line; checked by
      listing and diffing against the templates*
- [ ] 5. Setup is safe on an existing project — *run against a scratch repo that already has a
      `CLAUDE.md`, `.claude/settings.json` and `.gitignore`: nothing is overwritten; the workflow parts
      are added and existing content is kept (diff shows additions only)*
- [ ] 6. The repo uses its own workflow — *this repo has `CLAUDE.md`, roadmap, backlog, process log
      and task files produced by its own setup skill, and this task file follows the template*
- [ ] 7. README is the guide — *README covers install (personal and work account), setup, the
      lifecycle, how the process improves itself, updating, and the gotchas; content matches the
      skills and templates in the repo*
- [ ] 8. Published — *after review: pushed to GitHub, `v0.1.0` tag; on this machine,
      `claude plugin marketplace add PatrickSouthern/claude-workflow` and install succeed from GitHub*

## Plan
- [x] 0. Prerequisite (user): install the Claude Code CLI so `claude` is on PATH. Done: 2.1.296.
- [ ] 1. Layout: one repo that is both the marketplace and the plugin's home:
      ```
      .claude-plugin/marketplace.json     marketplace "claude-workflow", lists ./plugins/workflow
      plugins/workflow/
        .claude-plugin/plugin.json        name "workflow", version 0.1.0
        skills/setup/SKILL.md             + templates/ (all files setup writes)
        skills/task/ finish-task/ merge-task/ close-task/ review-process/
      README.md  CHANGELOG.md  LICENSE
      docs/ (this repo's own roadmap, tasks, backlog, process log)
      ```
- [ ] 2. Port the five skills from SnowVibes `main`: namespace cross-references
      (`workflow:finish-task`), make "the shared workflow guide" point to this repo, and route pattern
      lessons from `review-process` to this repo (an issue or a task here).
- [ ] 3. Write `setup` (`disable-model-invocation: true`, it writes files): ask for, or take as
      arguments, the project description, shared files for Touches, generated folders to read-deny,
      and the build/test commands; write the templates from `${CLAUDE_SKILL_DIR}/templates/`; merge
      into existing files instead of overwriting; finish by suggesting `/workflow:task` for a first
      task.
- [ ] 4. Run setup on this repo itself (criterion 6), on a branch.
- [ ] 5. Write README (the guide, moved from the claude.ai doc and updated), CHANGELOG, LICENSE.
- [ ] 6. Validate, install locally, and run the setup trials in scratch repos (criteria 1–5).
- [ ] 7. Hand off following `finish-task`; after "merge", push, tag `v0.1.0`, install from GitHub
      (criterion 8), and delete the claude.ai guide doc (the README replaces it).

## Decisions
- **2026-10-13 — One repo is both marketplace and plugin home**, plugin under `plugins/workflow/`.
  Alternatives: plugin at the repo root with no marketplace (installs only by folder or zip). Why: a
  marketplace gives a two-command install and updates; the docs' `--plugin-dir` note says a
  marketplace root and a plugin root should be separate folders.
  Sources: [Create a plugin](https://code.claude.com/docs/en/plugins/create),
  [Create a marketplace](https://code.claude.com/docs/en/plugins/create-marketplace).
- **2026-10-13 — Plugin name `workflow`**, so skills read `/workflow:task`, `/workflow:setup`.
  The marketplace and plugin entry names follow the docs' rule that entry name = manifest name.
- **2026-10-13 — Templates ship inside the `setup` skill** and are read through
  `${CLAUDE_SKILL_DIR}` ([Skills](https://code.claude.com/docs/en/skills), path variables).
- **2026-10-13 — `setup` is manual-only** (`disable-model-invocation: true`); the other five stay
  model-invocable as in SnowVibes task 004.
- **2026-10-13 — Bootstrap task runs on a branch, not a worktree.** This session started in
  SnowVibes, and worktree tooling works on the session's own repo. Future tasks here follow the
  full workflow from a session started in this repo.
- **2026-10-13 — Version pinned in `plugin.json`** (0.1.0), bumped per release with a CHANGELOG
  entry, so users stay on a version until it changes.
- **2026-10-13 — Plan approved by the user**, with: MIT license; the README is the guide; the
  claude.ai guide doc is deleted once the README replaces it (it was never shared); bootstrap on a
  plain branch.

## Log

## Verification

| Criterion | Result | Evidence |
|---|---|---|
| | | |

**Needs manual check:**
- none yet

## Retro

| Lesson | Fix | Lives in | How we'll know it worked | Status |
|---|---|---|---|---|

## Follow-ups
