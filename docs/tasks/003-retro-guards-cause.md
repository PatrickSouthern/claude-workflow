# 003 — 0.1.2: retro fixes guard the cause

**Status:** Awaiting review — criteria 1–3 pass; 4 runs after merge
**Last updated:** 2026-10-15
**Next step:** User review; on "merge", run workflow:merge-task, then tag, push (user's OK), update SnowVibes, close issue #1
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
- [x] 2. Edit `finish-task` step 5, the setup task template, this repo's `_TEMPLATE.md`, and the README.
- [x] 3. Bump to 0.1.2 and add the CHANGELOG entry (release runbook steps 1–3).
- [x] 4. Validate and run the setup trials (runbook steps 4–5).
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
- 2026-10-15 — Edits made as planned; template and README use the one-line form of the rule.
  Validation passed twice; both setup trials exit 0. The worktree-isolation guard refused a single
  compound Bash command (mkdir + both trials + cat); split into plain commands, which ran.

## Verification

| Criterion | Result | Evidence |
|---|---|---|
| 1. Skill says it | ✅ | `git diff main -- …/finish-task/SKILL.md`: step 5 adds "The fix guards the condition that caused the failure and is no broader than the evidence: rather than banning an action, make it safe (check the condition first, or ask). Ban it outright only when the condition can't be checked." |
| 2. Template and README say it | ✅ | `git diff main`: setup `task-template.md` Retro intro and README "Fix with the strongest mechanism" each add "Guard the condition that caused the failure, not the whole action: ban an action only when the condition can't be checked."; Retro intro of `docs/tasks/_TEMPLATE.md` vs setup template → `retro intro: identical` |
| 3. Released as 0.1.2 | ✅ | `plugin.json` `"version": "0.1.2"`; CHANGELOG 0.1.2 entry names the change and the line existing projects add; `claude plugin validate` → `✔ Validation passed` twice; trials `fresh exit=0`, `existing exit=0`, every summary line `ok` (besides the `CLAUDE.md: N lines` info line) |
| 4. Reaches SnowVibes | ⚠️ after merge | Tag `v0.1.2` and push (user's OK); in SnowVibes `claude plugin update workflow@claude-workflow` → "updated from 0.1.1 to 0.1.2"; close issue #1 with a link to the commit |

**Needs manual check:**
- none (criterion 4 runs after merge)

## Backlog items covered
- none (issue #1)

## Retro

| Lesson | Fix | Lives in | How we'll know it worked | Status |
|---|---|---|---|---|
| Worktree isolation refused the setup trials run as one compound command during implementation; `finish-task` step 2 says to use a script file, but trials also run before hand-off | Add a step note and a Known problems row: in a worktree session, run the trials as separate plain commands or from a script file | `docs/runbooks/run-setup-trials.md` | Next task that runs trials from a worktree gets no isolation refusal | proposed |
| At hand-off both trials ran again (about 5 min, the user noticed) though no file they cover changed since they passed earlier in the session | `finish-task` step 2: a check run earlier may stand as evidence when no file it covers has changed since (show `git diff --stat` since that run); otherwise re-run it | Workflow plugin (`finish-task`), as a backlog entry for the next release | Next hand-off reuses an unchanged earlier result instead of re-running it | proposed |

## Follow-ups
