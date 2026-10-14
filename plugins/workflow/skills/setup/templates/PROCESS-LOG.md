# Process log

Every change to the way we work, with how we'll know it worked. Retro items land here when they are
applied. The phase-end process review (`workflow:review-process`) fills in the last column: **kept**
(it works), **changed** (it needed adjusting; new row added), or **dropped** (it cost more than it
gave).

Mechanism, strongest first: hook · script/test · template · skill · runbook · CLAUDE.md rule ·
workflow plugin.

| Date | From | Change | Mechanism | How we'll know it worked | Review result |
|---|---|---|---|---|---|
| {{DATE}} | setup | Task workflow added (`workflow` plugin {{PLUGIN_VERSION}}) | plugin + templates | Tasks follow plan → approve → worktree → verify → retro | |
