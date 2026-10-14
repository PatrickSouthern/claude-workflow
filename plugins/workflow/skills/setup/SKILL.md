---
name: setup
description: Add the task workflow to the current project. Writes CLAUDE.md's "How we work" section, the roadmap, task template, backlog, process log, runbooks folder, and the worktree and read-deny settings, adding to existing files without overwriting them.
disable-model-invocation: true
argument-hint: "[project description; shared files; generated folders; check commands]"
---

# Set up the task workflow

Templates are in `${CLAUDE_SKILL_DIR}/templates/`. The plugin version is in
`${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json`.

## 1. Check the starting point

- The current directory must be the root of a git repository (`git rev-parse --show-toplevel`). If
  not, stop and say so; offer `git init` only if the user asks.
- Note the default branch and whether the working tree is clean. Setup writes files on the current
  branch; if the tree has unrelated changes, tell the user and ask before going on.
- Look for an existing setup: `docs/tasks/_TEMPLATE.md`, a "## How we work" heading in `CLAUDE.md`,
  `docs/ROADMAP.md`. If some exist, list what is there and fill only the gaps.
- Look for local copies of the workflow skills in `.claude/skills/` (`task`, `finish-task`,
  `merge-task`, `close-task`, `review-process`). They would run alongside the plugin's. Report them
  and suggest removing them in a tracked task; don't delete them here.

## 2. Gather the project specifics

Take answers from the arguments (`$ARGUMENTS`) where given; ask for the rest in one message. Propose
defaults from what the repository contains:

| Found | Generated folders to read-deny | Typical shared files (Touches) | Typical check commands |
|---|---|---|---|
| `*.csproj` / `*.sln` | `bin/`, `obj/` | EF Core migrations and model snapshot, `appsettings*.json`, `Directory.Packages.props` | `dotnet build`, `dotnet test` |
| `package.json` | `node_modules/`, `dist/`, `build/`, `coverage/` | `package-lock.json` / `pnpm-lock.yaml`, shared API types | `npm run build`, `npm test` |
| `ProjectSettings/` (Unity) | `Library/`, `Temp/`, `obj/`, `UserSettings/` | scenes, `ProjectSettings/`, `Packages/manifest.json` | Unity batch-mode scripts |
| `pyproject.toml` | `.venv/`, `__pycache__/`, `.pytest_cache/` | `pyproject.toml`, lockfile, migrations | `pytest` |

Ask for:
1. A one-line project description (only if `CLAUDE.md` doesn't exist).
2. Shared files for Touches.
3. Generated folders to read-deny.
4. How to check work: build and test commands.
5. Typical routine operations for runbooks (for example "deploy to the test environment, run
   database migrations").

## 3. Write the files

Replace `{{DATE}}` with today's date, `{{PLUGIN_VERSION}}` with the plugin's version, and the other
`{{...}}` placeholders with the answers. Never overwrite an existing file or section.

| Target | From | If it already exists |
|---|---|---|
| `CLAUDE.md` | `# <Project>` + description, then `CLAUDE-workflow.md` | Insert `CLAUDE-workflow.md` after the title and opening paragraph, before the first `##` section. Skip if a "## How we work" heading exists |
| `docs/ROADMAP.md` | `ROADMAP.md` | Skip; suggest adding the process-review line and rows by hand |
| `docs/tasks/_TEMPLATE.md` | `task-template.md` | Skip; report differences from the template |
| `docs/tasks/BACKLOG.md` | `BACKLOG.md` | Skip |
| `docs/PROCESS-LOG.md` | `PROCESS-LOG.md` | Add the setup row only |
| `docs/runbooks/README.md` | `runbooks-README.md` | Skip |
| `docs/runbooks/_TEMPLATE.md` | `runbook-template.md` | Skip |
| `.claude/settings.json` | — | Merge as JSON: add `Read(**/<folder>/**)` to `permissions.deny` for each generated folder not already listed; set `worktree.baseRef` to `"head"` if absent (if set to something else, ask). Keep every other key |
| `.gitignore` | — | Append `/.claude/worktrees/` under a `# Claude Code worktrees` comment if not already ignored |

Use the `**/<folder>/**` form for deny rules so they also match inside worktrees, and warn that no
folder in the project may share a denied folder's name.

The project's `.claude/` folder is a protected path: whether Claude Code asks before writing
`settings.json` depends on the permission mode. Manual (`default`) and `acceptEdits` ask the user;
`auto` lets its classifier decide, so it may go ahead without asking; `dontAsk` refuses. Allow rules
don't change this. Say what you are about to write and why; if the write is refused or declined,
show the intended `settings.json` content and leave it for the user.

## 4. Check and report

- Show `git status` and `git diff --stat`, and the merged `.claude/settings.json`.
- Check `CLAUDE.md` is under 200 lines (`wc -l`); if over, say so.
- Ask whether to commit as `Add task workflow (workflow plugin <version>)` on the current branch.
  This first commit is the one change made outside a task.
- Tell the user the next steps: start a new session so the settings apply, then plan the first task
  with `/workflow:task`.
