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
