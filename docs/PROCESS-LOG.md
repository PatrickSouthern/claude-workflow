# Process log

Every change to the way we work, with how we'll know it worked. Retro items land here when they are
applied. The phase-end process review (`workflow:review-process`) fills in the last column: **kept**
(it works), **changed** (it needed adjusting; new row added), or **dropped** (it cost more than it
gave).

Mechanism, strongest first: hook · script/test · template · skill · runbook · CLAUDE.md rule ·
workflow plugin.

| Date | From | Change | Mechanism | How we'll know it worked | Review result |
|---|---|---|---|---|---|
| 2026-10-13 | setup | Task workflow added (`workflow` plugin 0.1.0) | plugin + templates | Tasks follow plan → approve → worktree → verify → retro | |
| 2026-10-13 | 001 retro | Trial fixtures use only inert data; known trial failures recorded | runbook (`run-setup-trials.md`) | No trial failure traced to the fixture in later tasks | |
| 2026-10-13 | 001 retro | Setup warns about the `.claude/` write prompt and shows the content if declined; trials check the proposal | skill (`setup`) + script (`trial-setup.sh`) | Setup in a real project gets `settings.json` written after one approval | |
| 2026-10-13 | 001 | Setup trials as a script with 15 checks, run before every release | script + runbook | Every change to `setup` has a passing trial run in its task's Verification | |
| 2026-10-13 | 002 | Corrects the 001-retro row above: `setup` and the README describe `.claude/` as a protected path whose prompt depends on the permission mode | skill (`setup`) + README | Users aren't surprised by a prompt, or by its absence | |
| 2026-10-13 | 002 | Version bump and CHANGELOG reviewed in the task branch; tag and push after merge | runbook (`release.md`) | Every release's version bump appears in a reviewed task diff | |
| 2026-10-13 | 002 retro | Trials run with output to a file and the exit code quoted, never piped | runbook (`run-setup-trials.md`) | Trial evidence in later tasks always quotes `exit=` | |
| 2026-10-15 | 003 (issue #1) | Retro fixes guard the condition that caused the failure, no broader than the evidence | skill (`finish-task`) + template + README | Later retro fixes name a condition; none is narrowed afterward as an overreach | |
| 2026-10-15 | 003 retro | In a worktree session, trials run as plain separate commands or from a script file | runbook (`run-setup-trials.md`) | No worktree-isolation refusal when running trials in later tasks | |
| 2026-10-15 | 003 retro | A slow check that passed earlier in the session stands at hand-off if nothing it covers changed | skill (`finish-task`, 0.1.2) | Next hand-off reuses an unchanged result with `git diff --stat` evidence instead of re-running | |
