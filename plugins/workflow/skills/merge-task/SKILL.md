---
name: merge-task
description: Merge a reviewed task branch into main and clean up its worktree. Applies the approved retro items, merges, runs the post-merge checks, and removes the worktree and branch. Use only when the user explicitly says to merge a task that is Awaiting review.
---

# Merge a reviewed task

Run only on the user's explicit word ("merge"). The task must be `Awaiting review`.

1. **Apply the approved retro items** on the task branch: each one the user approved (as is or
   changed) is applied and marked `applied`; each rejected one is marked `dropped` with the reason;
   each too big for now becomes a follow-up. An item that belongs in the workflow plugin becomes a
   follow-up to propose there (github.com/PatrickSouthern/claude-workflow). Add a row to
   `docs/PROCESS-LOG.md` for every applied item. Commit.
2. **Go to the main checkout.** Leave the worktree (`ExitWorktree` with `keep` if this session
   created it; otherwise run git with `-C <main checkout>`). Check `git status` there is clean and
   it is on `main`. If not, stop and tell the user.
3. **Merge** with `git merge --no-ff worktree-NNN-short-name`, message
   `Merge task NNN: <title>`.
4. **Post-merge checks.** Verify every criterion marked "after merge" and record the evidence in the
   task file on `main`. Settings changes take effect only in a session started after the merge; if
   one can't be checked in this session, say so and leave it ⚠️ for the next one.
5. **Remove the worktree and branch.** `git worktree remove`, then `git branch -d`. If the worktree
   is `locked` by a process that no longer exists (a crashed session), the lock is stale: use
   `git worktree remove -f -f` once the branch is merged. An empty folder left behind is held by a
   shell or another program (for example an editor) that still has it open; remove it once it is
   released.
6. **Status block** on `main`: `**Status:** Awaiting review — merged to main (<commit>); <checks>`,
   next step "User marks Done". Commit on `main`.
7. **Ask before anything outward:** pushing `main` and deleting the remote branch need the user's
   OK; an OK given earlier in this task's close-out covers them.
