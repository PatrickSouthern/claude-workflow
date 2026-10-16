# Process log

Every change to the way we work, with how we'll know it worked. Retro items land here when they are
applied. The phase-end process review (`workflow:review-process`) fills in the last column: **kept**
(it works), **changed** (it needed adjusting; new row added), or **dropped** (it cost more than it
gave). A row with no evidence yet stays blank for the next review.

Mechanism, strongest first: hook · script/test · template · skill · runbook · CLAUDE.md rule ·
workflow plugin.

| Date | From | Change | Mechanism | How we'll know it worked | Review result |
|---|---|---|---|---|---|
| 2026-10-13 | setup | Task workflow added (`workflow` plugin 0.1.0) | plugin + templates | Tasks follow plan → approve → worktree → verify → retro | **kept** (004): 002 and 003 ran the full cycle through close |
| 2026-10-13 | 001 retro | Trial fixtures use only inert data; known trial failures recorded | runbook (`run-setup-trials.md`) | No trial failure traced to the fixture in later tasks | **kept** (004): trials in 002 and 003 had no fixture failures |
| 2026-10-13 | 001 retro | Setup warns about the `.claude/` write prompt and shows the content if declined; trials check the proposal | skill (`setup`) + script (`trial-setup.sh`) | Setup in a real project gets `settings.json` written after one approval | **changed** (004): superseded by the 002 row below; the prompt depends on the permission mode |
| 2026-10-13 | 001 | Setup trials as a script with 15 checks, run before every release | script + runbook | Every change to `setup` has a passing trial run in its task's Verification | **kept** (004): 002 and 003 Verification quote passing runs |
| 2026-10-13 | 002 | Corrects the 001-retro row above: `setup` and the README describe `.claude/` as a protected path whose prompt depends on the permission mode | skill (`setup`) + README | Users aren't surprised by a prompt, or by its absence | |
| 2026-10-13 | 002 | Version bump and CHANGELOG reviewed in the task branch; tag and push after merge | runbook (`release.md`) | Every release's version bump appears in a reviewed task diff | **kept** (004): 003's 0.1.2 bump was in the reviewed diff |
| 2026-10-13 | 002 retro | Trials run with output to a file and the exit code quoted, never piped | runbook (`run-setup-trials.md`) | Trial evidence in later tasks always quotes `exit=` | **changed** (004): 003 quoted `exit=`, but running the trials failed at the shell level again; now a script (row below) |
| 2026-10-15 | 003 (issue #1) | Retro fixes guard the condition that caused the failure, no broader than the evidence | skill (`finish-task`) + template + README | Later retro fixes name a condition; none is narrowed afterward as an overreach | |
| 2026-10-15 | 003 retro | In a worktree session, trials run as plain separate commands or from a script file | runbook (`run-setup-trials.md`) | No worktree-isolation refusal when running trials in later tasks | **changed** (004): replaced by `tools/run-trials.sh` (row below) |
| 2026-10-15 | 003 retro | A slow check that passed earlier in the session stands at hand-off if nothing it covers changed | skill (`finish-task`, 0.1.2) | Next hand-off reuses an unchanged result with `git diff --stat` evidence instead of re-running | |
| 2026-10-15 | 004 review | Trials run by `tools/run-trials.sh`: both kinds, each `exit=` printed, non-zero on any failure; one plain command | script + runbook | No trial-running failure (hidden exit code, isolation refusal) in later tasks | |
| 2026-10-15 | 004 review | Trivial changes and post-merge records go straight to `main` | `CLAUDE.md` rule + setup template (0.1.3) | Post-merge records land on `main` without a correction or a separate task | |
| 2026-10-15 | 004 review | One OK to push covers the rest of a task's close-out | `CLAUDE.md` rule + setup template + `close-task` (0.1.3) | A task's close-out asks to push at most once | |
| 2026-10-15 | 004 review | Hooks (B4) wait for a failure a hook would catch, not a date | backlog | B4 is picked up only with a named failure as its evidence | |
| 2026-10-15 | prompt audit | `merge-task` push rule aligned with the one-OK close-out rule | skill (`merge-task`, 0.1.4) | Merge close-outs ask to push at most once | |
| 2026-10-15 | 004 retro | After stopping a trial run, use a new scratch folder | runbook (`run-setup-trials.md`) | No trial failure from a reused scratch folder in later tasks | |
