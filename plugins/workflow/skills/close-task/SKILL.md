---
name: close-task
description: Close a merged task when the user marks it Done. Moves open follow-ups and unapplied retro items to the backlog, closes the backlog entries it covered, and updates the roadmap. Use only when the user explicitly says a task is Done.
---

# Close a task

Run only when the user says the task is Done. Work in the main checkout on `main`.

1. **Status block:** `**Status:** Done — approved by user <date>; open follow-ups moved to
   BACKLOG.md`, next step "none".
2. **Follow-ups:** each open one becomes a backlog entry in `docs/tasks/BACKLOG.md`:
   `**Bn — title** · from NNN · when: <condition or task>` plus one or two lines. Mark it
   `→ backlog Bn` in the task file. A data point for an existing entry is added to that entry.
3. **Retro items** not yet applied (`proposed`, or deferred) become backlog entries the same way.
4. **Backlog items covered** by this task move to Closed with `closed by NNN`.
5. **Roadmap:** the task's row becomes `Done`. Rows for future work that now covers a backlog
   entry name it, e.g. "(B5)". If this was the last task of a phase, remind the user that the
   phase ends with a process review (`workflow:review-process`).
6. **Commit** on `main`. Pushing needs the user's OK.
