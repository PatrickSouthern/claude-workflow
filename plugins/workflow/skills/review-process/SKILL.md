---
name: review-process
description: Review whether the way we work is working. Checks each process change in docs/PROCESS-LOG.md against what actually happened, prunes CLAUDE.md, questions rules that cost more than they give, and proposes changes to the workflow plugin. Use at the end of every roadmap phase, or when the user asks to review the process.
---

# Process review

A process review is a tracked task like any other: plan it with the `workflow:task` skill, and use
this checklist as its plan. Findings are proposals; the user approves each one.

1. **Did each change work?** For every row in `docs/PROCESS-LOG.md` without a review result, look
   for evidence in the task files since that date (Log, Decisions, Retro, Verification) and in the
   user's corrections. Did the problem it targeted come back? Was the mechanism actually used? Set
   the result to **kept**, **changed** (add a new row for the new version) or **dropped**, with one
   line of evidence each.
2. **Repeated lessons.** Read every Retro since the last review. A lesson that appears twice means
   its fix was too weak: propose a stronger mechanism (a rule becomes a template or a check, a check
   becomes a hook).
3. **Prune the instructions.**
   - `CLAUDE.md`: under 100 lines is the target, 200 the limit. For each line ask: would removing it
     cause a mistake? Anything only needed at certain moments belongs in a skill or a runbook.
   - Look for contradictions between `CLAUDE.md`, templates and runbooks, and for references to
     files, commands or tools that no longer exist. Ask the user to run `/doctor prompt-audit` for a
     second opinion.
   - Runbooks whose `Last verified` is old: re-verify or mark them as stale.
4. **Question the rules themselves.** For each workflow rule, what did it cost this phase (steps,
   waiting, friction) and what did it prevent? Propose simplifying or dropping rules that cost more
   than they gave. Keeping everything is not the default.
5. **Pattern lessons.** Which findings would help every project, not just this one? Those are
   changes to the workflow plugin (github.com/PatrickSouthern/claude-workflow): list them so the user
   can raise them there (an issue, or a task in that repo).
6. **Report** the findings as a short table (finding, evidence, proposal) and stop for approval.
   Approved changes are applied in this task and logged in `docs/PROCESS-LOG.md`.
