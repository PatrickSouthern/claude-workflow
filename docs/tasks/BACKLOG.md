# Backlog

Open follow-ups discovered during tasks. Each entry says which task found it and when it should be
picked up. When planning a task, pull in any entries it covers; when that task completes them, move
them to Closed with the task number.

## Open

- [ ] **B2 — Negative test for the setup trials** · from 001 retro · when: the next change to `setup`'s behavior
  Add a `--check-only` mode to `tools/trial-setup.sh` and a deliberate-failure run that must print
  `FAIL` and exit 1.
- [ ] **B3 — Plugin evals** · from 001 · when: a few real tasks have given cases to test
  `claude plugin eval` scores whether the skills change Claude's behavior, for example that
  `finish-task` never marks ✅ without evidence.
- [ ] **B4 — Hooks for the workflow** · from 001 · when: the first process review
  Candidates for the top of the mechanism ladder, such as a check that every task file's status line
  keeps the grep-able format.

## Closed

- [x] **B1 — Correct the `.claude/` permission-prompt claim (0.1.1)** · from 001 retro · closed by 002
  The `.claude/` folder is described as a protected path whose prompt depends on the permission mode.
