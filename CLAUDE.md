# claude-workflow

A Claude Code plugin and marketplace that packages a self-improving task workflow (roadmap, task
files, backlog, runbooks, process log, worktrees).

**Start of each session:** read [docs/ROADMAP.md](docs/ROADMAP.md) for where the project stands.
Changes to direction (adding, removing, or reordering tasks or phases) need the user's agreement.

## How we work

Non-trivial work (more than one step, a design choice, or more than a couple of files changed; when
in doubt, ask) is tracked in a task file under `docs/tasks/`. The task file is the source of truth
over conversation memory: read it first to resume. Each step has a skill in the `workflow` plugin:

| When | Skill |
|---|---|
| Starting non-trivial work; the user approves a plan | `workflow:task` |
| The implementation is believed complete | `workflow:finish-task` |
| The user says "merge" | `workflow:merge-task` |
| The user says the task is Done | `workflow:close-task` |
| A roadmap phase ends, or the user asks | `workflow:review-process` |

Always:
- No changes before the user approves the plan; a material change to the plan needs approval again.
- Implement in the task's own worktree, never on `main`; its task file is the live copy. Never edit
  another task's files or branch. Only the main checkout creates task files. Trivial changes and
  post-merge records (release evidence, runbook rows) go straight to `main`.
- Keep the status block current (step changes, blocked, before ending a turn) so a fresh session can
  resume from it alone. Format exactly `**Status:** <value> — <detail>`; values `Planned`,
  `In progress`, `Blocked`, `Awaiting review`, `Done`, `Abandoned` (with the reason).
- Log decisions as they are made: date, decision, alternatives, why. Keep the roadmap row in step.
- Never mark a criterion passed without evidence.
- Out-of-scope work goes under Follow-ups, never into the open task.
- Only the user merges or marks a task Done. Pushing needs the user's OK; one OK covers the rest of
  that task's close-out (through Done), not later tasks.

**Capture lessons when they happen.** When the user corrects how you work, the same kind of failure
happens twice, or the workflow or tools surprise you, add a Retro item to the current task right away
(no task open: a backlog entry). Fix the cause, not the instance. Process changes are logged in
`docs/PROCESS-LOG.md`.

**Runbooks.** Before a routine operation (release a new plugin version, run the setup trials), check
[docs/runbooks/README.md](docs/runbooks/README.md) and follow the runbook. Write or update one when a
task works out a repeatable procedure; when a step fails, fix it and add the failure to Known
problems; update `Last verified` after a successful run. Never put secrets in a runbook.

**This project's workflow specifics:**
- Shared files for a task's Touches: `plugins/workflow/.claude-plugin/plugin.json` (version),
  `.claude-plugin/marketplace.json`, the setup templates in `plugins/workflow/skills/setup/templates/`,
  `README.md`, `CHANGELOG.md`.
- How to check work: `claude plugin validate ./plugins/workflow`, `claude plugin validate .`, and,
  when `setup` or its templates change, `sh tools/run-trials.sh <scratch dir>`.
  Load the working copy with `claude --plugin-dir ./plugins/workflow`.
- Skills and templates stay stack-neutral: examples go in tables or the README, never as the only
  option.
- `.claude/settings.json` changes made in a worktree apply only after merge (a session keeps the
  settings of the checkout it started in), so verify them after merge.
