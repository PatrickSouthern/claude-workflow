# 001 — Workflow plugin v0.1

**Status:** Awaiting review — merged (`5908420`), released as v0.1.0, installed from GitHub; all 8 criteria verified
**Last updated:** 2026-10-13
**Next step:** User marks Done; Retro item 4 (wrong claim about `.claude/` prompts) goes to a 0.1.1 patch task
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
- [x] 2. Port the five skills from SnowVibes `main`: namespace cross-references
      (`workflow:finish-task`), make "the shared workflow guide" point to this repo, and route pattern
      lessons from `review-process` to this repo (an issue or a task here).
- [x] 3. Write `setup` (`disable-model-invocation: true`, it writes files): ask for, or take as
      arguments, the project description, shared files for Touches, generated folders to read-deny,
      and the build/test commands; write the templates from `${CLAUDE_SKILL_DIR}/templates/`; merge
      into existing files instead of overwriting; finish by suggesting `/workflow:task` for a first
      task.
- [x] 4. Run setup on this repo itself (criterion 6), on a branch.
- [x] 5. Write README (the guide, moved from the claude.ai doc and updated), CHANGELOG, LICENSE.
- [x] 6. Validate, install locally, and run the setup trials in scratch repos (criteria 1–5).
- [x] 7. Hand off following `finish-task`; after "merge", push, tag `v0.1.0`, install from GitHub
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
- **2026-10-13 — Plan step 1 included a `.gitattributes`** (`* text=auto eol=lf`) after git warned
  about CRLF conversion on the first commit, so skills and templates are byte-identical everywhere.
- **2026-10-13 — The setup trial became a script in the repo** (`tools/trial-setup.sh`, 15 checks)
  instead of a one-off in the session scratchpad. Why: a check that runs beats a described one, and
  every future change to `setup` needs it (runbook `run-setup-trials.md`).
- **2026-10-13 — Setup is tested headless with `claude -p`.** Claude Code asks a human before writes
  under `.claude/`, so a headless run proposes the `settings.json` content instead of writing it; the
  trial checks the proposal. The skill now tells the user that prompt is coming. The interactive
  write is a manual check.

## Log
- Bootstrap: `main` has the task file (`1a3547c`); work on branch `task-001-plugin-v0-1`.
- First validation passed for plugin and marketplace right after the skills were written.
- Trial 1 (fresh): everything written except `.claude/settings.json`; the session reported the
  permission prompt was not granted and printed the intended content (correctly did not work around
  it). Pre-approving with `--allowedTools` did not change that.
- Trial 2 (existing) first failed in my fixture: a fake `"model": "keep-me"` key in the trial's
  `settings.json` is a real setting and broke the session. Fixture changed to an `env` key; the CLI
  also said only `Edit(path)` rules apply to writes. Both recorded in the trials runbook.
- Self-setup on this repo through the skill (headless): wrote `CLAUDE.md`, roadmap (it replaced the
  template's generic first row with task 001), template, backlog, process log, runbooks, `.gitignore`;
  `.claude/settings.json` written by this session from the content it proposed.
- Local install: marketplace added from the repo path; `workflow@claude-workflow` installed at user
  scope. Side effect: SnowVibes now sees its local workflow skills and the plugin's (see Follow-ups).
- Merge (following `merge-task`): retro items logged in `PROCESS-LOG.md`; `--no-ff` merge
  `5908420`; release runbook followed for the first time (tag, push); marketplace switched to the
  GitHub source and the plugin reinstalled; task branch deleted; the claude.ai guide doc deleted
  (the README replaces it).

## Verification

| Criterion | Result | Evidence |
|---|---|---|
| 1. Valid plugin and marketplace | ✅ | `claude plugin validate --strict ./plugins/workflow` and `--strict .`: `✔ Validation passed`, exit 0, both |
| 2. Installs from the local marketplace | ✅ | `✔ Successfully added marketplace: claude-workflow (declared in user settings)`; `✔ Successfully installed plugin: workflow@claude-workflow (scope: user)`; `claude plugin details workflow`: `workflow 0.1.0`, `Skills (6)  close-task, finish-task, merge-task, review-process, setup, task`; always-on cost about 600 tokens |
| 3. Stack-neutral and namespaced | ✅ | `grep -i "unity\|snowvibes" plugins/workflow`: one hit, the Unity row of setup's defaults table (one example among four stacks). Bare backticked skill names: only setup's list of local `.claude/skills/` folder names to look for; every cross-reference is `workflow:<name>` |
| 4. Setup works on a fresh project | ✅ | Manual check passed: interactive `/workflow:setup` wrote `.claude/settings.json` (user, 2026-10-13). Headless trial: | `tools/trial-setup.sh … fresh`: 12/12 `ok`, exit 0 (four files identical to templates, roadmap, process-log setup row, How we work, 49 lines, no placeholders, worktrees ignored, nothing committed). `.claude/settings.json` is proposed, not written, in a headless run: see Needs manual check |
| 5. Safe on an existing project | ✅ | `tools/trial-setup.sh … existing`: 15/15 `ok`, exit 0: tracked files additions only (`git diff --numstat` has no deletions), `## Conventions` and "Keep this line." kept, existing `settings.json` untouched; proposed merge kept `allow`, `env`, the existing `bin` deny, and added `obj`, `node_modules`, `baseRef` |
| 6. Repo uses its own workflow | ✅ | `CLAUDE.md` (How we work + this repo's specifics), `docs/ROADMAP.md`, `docs/tasks/_TEMPLATE.md`, `BACKLOG.md`, `docs/PROCESS-LOG.md` (setup row), `docs/runbooks/` written by `/workflow:setup` run on this repo; two runbooks added (trials, release) |
| 7. README is the guide | ✅ | Sections: install (incl. work accounts), set up a project, the skills, lifecycle (mermaid), status block, criteria, roadmap and backlog, runbooks, how the process improves itself (with sources), worktrees, gotchas, personal rules, developing, license. Skill names, setup's file list and the template content match the files in `plugins/workflow/` |
| 8. Published | ✅ | `main` and tag `v0.1.0` pushed (`refs/tags/v0.1.0^{}` = `5908420`). Local marketplace removed, then `claude plugin marketplace add PatrickSouthern/claude-workflow`: "Cloning via HTTPS … ✔ Successfully added marketplace"; `✔ Successfully installed plugin: workflow@claude-workflow (scope: user)`; `marketplace list`: `Source: GitHub (PatrickSouthern/claude-workflow)`; `details`: `workflow 0.1.0`, Skills (6) |

**Needs manual check:**
- ✅ 2026-10-13, by the user: `/workflow:setup` in a real interactive session wrote
  `.claude/settings.json`. It did **not** ask for permission first (see Retro item 4: the docs claim
  a prompt always comes).

## Retro

| Lesson | Fix | Lives in | How we'll know it worked | Status |
|---|---|---|---|---|
| Two trial runs failed because of my test fixture (a real settings key used as a fake marker; a `Write(...)` allow rule that isn't honoured), not because of the plugin | Trial fixtures use only inert data; the known failures are recorded | runbook (`run-setup-trials.md` Known problems) | No trial failure traced to the fixture in later tasks | applied |
| Writes under `.claude/` need a human even with allow rules, which headless tests can't give | `setup` warns the user the prompt is coming and shows the content if declined; the trial checks the proposal; README gotcha | skill (`setup` step 3) + script (`trial-setup.sh`) | Setup in a real project gets `settings.json` written after one approval | applied |
| The trial script has no negative test: it has never been shown to fail on a broken `setup` | Add a check-only mode and a deliberate-failure run | script | A run against a deliberately broken template prints `FAIL` and exits 1 | → follow-up |
| I generalised from one headless run (`acceptEdits`) to "Claude Code always asks before writes under `.claude/`"; the user's interactive run wrote without asking. Claims about tool behaviour need evidence from each mode they cover | Reword in `setup` step 3, README (setup table and gotcha), `trial-setup.sh` comment: whether a prompt appears depends on the permission mode; headless `acceptEdits` runs can't write there. Release as 0.1.1 | skill + README + script | Docs state only observed behaviour, with the mode named | proposed (found after merge: a patch task) |

## Follow-ups
- Trial script negative test (Retro item 3): a `--check-only` mode, and a deliberate-failure run.
  When: next change to `setup`.
- Plugin evals: `claude plugin eval` can score whether the skills change Claude's behaviour (for
  example, that `finish-task` never marks ✅ without evidence). When: after a few real tasks give
  cases to test.
- Hooks: candidates for the top of the mechanism ladder, such as a check that every task file's
  status line keeps the grep-able format. When: the first process review.
- SnowVibes switch (tracked in SnowVibes' roadmap): install the plugin there and remove its local
  copies of the workflow skills, which now run alongside the plugin's.
