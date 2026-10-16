# 003 — 0.1.2: retro fixes guard the cause

**Status:** In progress — worktree 003-retro-guards-cause
**Last updated:** 2026-10-15
**Next step:** Plan step 2: edit `finish-task` step 5, the templates and the README
**Blockers:** none
**Worktree:** `.claude/worktrees/003-retro-guards-cause`, branch `worktree-003-retro-guards-cause`

## Goal
Retro fixes target the condition that caused a failure instead of banning the whole action, so the
process doesn't collect rules broader than their evidence. Proposed from SnowVibes task 006 as
[issue #1](https://github.com/PatrickSouthern/claude-workflow/issues/1); released as 0.1.2.

## Touches
- `plugins/workflow/skills/finish-task/SKILL.md` (step 5)
- `plugins/workflow/skills/setup/templates/task-template.md` (Retro intro)
- `README.md` ("Fix with the strongest mechanism")
- `plugins/workflow/.claude-plugin/plugin.json` (version), `CHANGELOG.md`
- This repo's own `docs/tasks/_TEMPLATE.md` (kept in step with the setup template)

## Success criteria
- [ ] 1. Skill says it — *`finish-task` step 5 says each fix names the condition it guards and is no
      broader than the evidence; an action is banned outright only when the condition can't be
      checked (diff)*
- [ ] 2. Template and README say it — *the setup task template's Retro intro and the README's "Fix with
      the strongest mechanism" each carry the same rule in one line; this repo's `_TEMPLATE.md`
      matches the setup template's Retro intro (diff)*
- [ ] 3. Released as 0.1.2 — *`plugin.json` version `0.1.2`; `CHANGELOG.md` entry says what changed and
      that existing projects can add the line to their own task template (diff);
      `claude plugin validate ./plugins/workflow` and `claude plugin validate .` → `✔ Validation
      passed` twice; both setup trials exit 0 (`run-setup-trials.md`)*
- [ ] 4. Reaches SnowVibes — *after merge, tag `v0.1.2` pushed (user's OK); in SnowVibes,
      `claude plugin update workflow@claude-workflow` → "updated from 0.1.1 to 0.1.2"; issue #1
      closed with a link to the commit*

## Plan
- [x] 1. Commit this plan and the roadmap row to `main`; create the worktree `003-retro-guards-cause`.
- [ ] 2. Edit `finish-task` step 5, the setup task template, this repo's `_TEMPLATE.md`, and the README.
- [ ] 3. Bump to 0.1.2 and add the CHANGELOG entry (release runbook steps 1–3).
- [ ] 4. Validate and run the setup trials (runbook steps 4–5).
- [ ] 5. Hand off with `workflow:finish-task`; after "merge": tag, push (user's OK), update the plugin in
      SnowVibes, close issue #1.

## Decisions
- **2026-10-15 — Patch release (0.1.2).** Alternatives: minor. Why: it refines guidance in an existing
  step and adds one line to a template; no skill names, steps or `setup` output structure change
  (release runbook: "fixes and wording → patch").
- **2026-10-15 — Wording.** Proposed for `finish-task` step 5, after "how we'll know it worked":
  "The fix guards the condition that caused the failure and is no broader than the evidence: rather
  than banning an action, make it safe (check the condition first, or ask). Ban it outright only when
  the condition can't be checked."
  Why: SnowVibes 006 applied "never run tests through an open Editor" when the cause was unsaved
  scene changes; the user called it an overreach and it was narrowed the same day.
- **2026-10-15 — Plan approved** by the user as written, no changes.

## Log

## Verification

| Criterion | Result | Evidence |
|---|---|---|
| | | |

**Needs manual check:**
- none expected

## Backlog items covered
- none (issue #1)

## Retro

| Lesson | Fix | Lives in | How we'll know it worked | Status |
|---|---|---|---|---|

## Follow-ups
