---
name: task
description: Start a new tracked task for this project. Creates a numbered task file in docs/tasks/ from the template, drafts the goal, success criteria and plan, then stops for user approval; after approval, starts the task in its own git worktree. Use when the user runs /workflow:task or asks to start non-trivial work, and when the user approves a planned task.
---

# Start a tracked task

## Plan

0. Work in the main checkout on `main`. If the current directory is a task worktree, stop and tell the
   user that new tasks are created from the main checkout (only it assigns task numbers).
1. Find the next number: list `docs/tasks/`, take the highest `NNN-*.md` number and add 1
   (start at `001`). Ignore `_TEMPLATE.md`.
2. Copy `docs/tasks/_TEMPLATE.md` to `docs/tasks/NNN-short-kebab-name.md`, named after the task the
   user described (from the arguments, or ask if none were given). Keep the name short: `NNN-` plus
   two or three words (it becomes the worktree folder, and deep paths break on Windows).
3. Investigate as needed to plan well: read relevant files, check tools and versions. For a design
   choice where established practice exists (process, architecture, tooling), check the official
   docs and known practice before proposing, and cite the sources in Decisions. Make no changes
   outside the task file and the roadmap row.
4. Fill in Goal, Touches, Success criteria (each with how it will be verified), and Plan. Touches
   lists the shared files the task expects to change (see `CLAUDE.md` for this project's list). If the
   task produces a procedure someone will repeat, a criterion covers its runbook. If the task changes
   the workflow itself (the task template, the "How we work" section of `CLAUDE.md`), note whether
   the change would help every project; if so, a follow-up proposes it to the workflow plugin
   (github.com/PatrickSouthern/claude-workflow). Record any decisions already made while planning.
   Set today's date and status `Planned — awaiting approval`.
5. Check for overlap: grep `**Status:**` and the Touches sections across `docs/tasks/` and note any
   in-progress task that touches the same shared files; overlapping tasks run one after another.
   Read `docs/tasks/BACKLOG.md` and list any open entries this task should cover under "Backlog items
   covered" (and in the plan and criteria). Read `docs/PROCESS-LOG.md` for unreviewed changes whose
   "how we'll know" this task can check, and note them in the plan.
6. Add or update the task's roadmap row (number, link, `Planned`).
7. Present a short summary of the plan, criteria, backlog items covered, and any overlap to the user,
   list open questions, and stop. Do not begin implementation until the user approves.

## Start (after the user approves)

8. Set the status to `In progress — worktree NNN-short-name`, fill in the **Worktree** line
   (`.claude/worktrees/NNN-short-name`, branch `worktree-NNN-short-name`), log the approval and any
   changes the user asked for under Decisions, and set the roadmap row to `In progress`.
9. Commit the task file and roadmap to `main`.
10. Create the worktree with Claude Code's built-in support, named exactly `NNN-short-name`: the
    `EnterWorktree` tool, or the user runs `claude --worktree NNN-short-name`. It branches from the
    current `main` commit (`worktree.baseRef: "head"` in `.claude/settings.json`).
11. Implement in the worktree, following `CLAUDE.md`. When the work is believed complete, hand off
    with the `workflow:finish-task` skill.
