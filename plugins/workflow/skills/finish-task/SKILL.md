---
name: finish-task
description: Hand off a tracked task for review. Verifies every success criterion with evidence, completes the task's Retro, checks runbooks and follow-ups, sets the status to Awaiting review, and commits on the task branch. Use when the implementation of a task in docs/tasks/ is believed complete.
---

# Hand off a task for review

Work in the task's worktree, on its task branch. The task file there is the live copy.

1. **Re-read the task file** from the top: goal, criteria, plan, decisions. Tick finished plan steps.
2. **Verify each criterion** by running its stated check now, not from memory of an earlier run.
   A slow check (a long build or test run) that already passed in this session needn't run again
   if its output is still on hand to quote and `git status` and `git diff --stat` show no file it
   covers changed since; say so in the evidence. Fill in the Verification table: ✅ / ❌ / ⚠️ and the evidence (command and its output, test
   summary, log lines). No evidence, no ✅. A criterion that can only be checked after merge is ⚠️
   with "after merge" and how it will be checked. What can't be checked from here goes under
   "Needs manual check", phrased as an instruction the user can follow. Run multi-command checks
   from a script file in the session's scratchpad, not as one long inline command: worktree
   isolation refuses compound commands it can't verify. Export anything needed from `main` first
   with a single plain `git show main:<path>`.
3. **Fix or report failures.** A ❌ is either fixed and re-verified, or reported plainly in the
   hand-off. Never soften it.
4. **Runbooks.** If the task worked out a procedure someone will repeat, its runbook in
   `docs/runbooks/` is written or updated, and listed in `docs/runbooks/README.md`.
5. **Complete the Retro.** Look back over the task: where did the user correct how you worked? What
   failed twice? What in the workflow or tools surprised you or cost time? Keep at most 3 items. Each
   names the fix, where it lives (prefer, in order: hook, script/test, template, skill, runbook,
   `CLAUDE.md` rule, workflow plugin), and how we'll know it worked. The fix guards the condition
   that caused the failure and is no broader than the evidence: rather than banning an action, make
   it safe (check the condition first, or ask). Ban it outright only when the condition can't be
   checked. A lesson about the workflow
   itself (it would help every project) lives in the workflow plugin: the fix is to propose it there.
   Status `proposed`. "Nothing to change" is a valid retro. Don't apply the fixes yet: the user
   approves them with the task.
6. **Follow-ups.** Everything found but out of scope is listed under Follow-ups with when it should
   be picked up.
7. **Status block.** `**Status:** Awaiting review — <one-line result>`, today's date, next step
   ("User review; on 'merge', run workflow:merge-task"), blockers.
8. **Commit** the task branch.
9. **Report to the user**: criteria results (with any ❌ or ⚠️ called out), manual checks, the
   proposed retro items for approval, and follow-ups. Then stop.
