# 004 — Phase 0 process review

**Status:** Awaiting review — merged (f4ed42c), v0.1.3 tagged and pushed; all criteria pass
**Last updated:** 2026-10-15
**Next step:** User marks Done (ends Phase 0)
**Blockers:** none
**Worktree:** removed after merge

## Goal
Close Phase 0 with a process review (`workflow:review-process`): judge each process change since
setup on evidence from tasks 001–003, strengthen fixes for repeated lessons, and drop or simplify
rules that cost more than they give.

## Touches
- `docs/PROCESS-LOG.md` (review results, new rows)
- `CLAUDE.md` ("How we work"), and the setup template `CLAUDE-workflow.md` if a finding applies to
  every project
- `docs/runbooks/run-setup-trials.md`, `tools/` (finding F2)
- `docs/tasks/BACKLOG.md` (B4)
- If a plugin file changes: `plugin.json` (version), `CHANGELOG.md`

## Success criteria
- [ ] 1. Every process-log row has a review result — *each of the 10 rows without one gets kept /
      changed / dropped / "too early" with one line of evidence (diff of `PROCESS-LOG.md`)*
- [ ] 2. Approved findings applied, rejected ones recorded — *each finding in the table below is
      marked approved / rejected in Decisions; each approved one is in the diff and has a
      `PROCESS-LOG.md` row*
- [ ] 3. Checks pass — *`CLAUDE.md` under 100 lines (`wc -l`); if a plugin file changed,
      `claude plugin validate` twice → `✔ Validation passed`; if F2 applies, the new trials script
      runs both trials and exits 0 (quoted)*
- [ ] 4. Plugin-wide findings reach the plugin — *any finding that helps every project is either
      released in this repo (it is the plugin's home) or listed as a follow-up with its version*

## Plan
- [x] 1. Commit this plan and the roadmap row; create the worktree.
- [x] 2. Fill in review results for every process-log row (table below).
- [x] 3. Apply each approved finding; log each in `PROCESS-LOG.md`.
- [x] 4. Ask the user to run `/doctor prompt-audit` for a second opinion on `CLAUDE.md`.
- [ ] 5. Verify, hand off with `workflow:finish-task`.

### Process-log review (step 1 of the checklist)

| Row | Proposed result | Evidence |
|---|---|---|
| Task workflow added (0.1.0) | kept | 002 and 003 both ran plan → approve → worktree → verify → retro → merge → close |
| Trial fixtures inert (001 retro) | kept | Trials in 002 and 003 ran with no fixture failures |
| Setup warns about `.claude/` prompt (001 retro) | changed | Superseded by the 002 row: the prompt depends on the permission mode |
| Setup trials script, run before every release | kept | 002 and 003 Verification both quote passing trial runs |
| `.claude/` described as protected path (002) | too early | No `setup` run in a new real project since |
| Version bump reviewed in task branch (002) | kept | 003's 0.1.2 bump was in the reviewed diff |
| Trials quote `exit=`, never piped (002 retro) | kept, then changed by F2 | 003 quoted `exit=0`; but the same step failed in a new way (see F2) |
| Retro fixes guard the cause (003) | too early | Made today |
| Trials as plain commands in a worktree (003 retro) | too early, replaced by F2 if approved | Made today |
| Reuse unchanged slow checks at hand-off (003 retro) | too early | Made today |

### Findings for approval

| # | Finding | Evidence | Proposal |
|---|---|---|---|
| F1 | `CLAUDE.md` says "implement in the task's own worktree, never on `main`", but small approved changes and post-merge records go straight to `main` | 002 and 003 both committed release records and runbook rows on `main` after merge; the user said in 003 "you can do quick changes like that straight to main" | Add to "How we work": "Trivial changes (outside the non-trivial definition above) and post-merge records go straight to `main`." Same line in the setup template → 0.1.3 |
| F2 | Running the trials has failed at the shell level twice, each patched in the runbook: piped output hid the exit code (002), then a compound command was refused in a worktree (003). Repeated lesson → the runbook fix was too weak | 002 Retro row 1, 003 Retro row 1 | Script: `tools/run-trials.sh <scratch dir>` runs both kinds, writes the summaries, prints `fresh exit=` / `existing exit=` and exits non-zero if either fails. The runbook becomes one plain command |
| F3 | Pushing needs a separate OK for every push; in 003 the user OK'd four pushes in a row during close-out (tag, release record, evidence, close) | 003 conversation | An OK to push covers the rest of that task's close-out (through Done), not later tasks. Same line in the setup template → 0.1.3 |
| F4 | B4 (hooks) is due "at the first process review", but no failure it would prevent has happened: every status line kept the format | Status blocks in 001–004 all match `**Status:** <value> — <detail>` | Per the new "no broader than the evidence" rule: keep B4 open, trigger changed to "a status line breaks the format, or another failure a hook would catch" |
| F5 | No contradictions or stale references found by hand; `CLAUDE.md` is 55 lines; both runbooks verified today | `wc -l CLAUDE.md` → 55; `Last verified` 2026-10-15 | No pruning. User runs `/doctor prompt-audit` for a second opinion |

**Rules questioned (checklist step 4):** the worktree for a one-line change (003) cost little and
kept `main` clean until review; the per-criterion evidence rule caught the stale SnowVibes install in
003; the re-run at hand-off was the only real waste and is already fixed. No rule proposed for
dropping beyond F1 and F3.

**Pattern lessons for the plugin (checklist step 5):** F1 and F3 change the setup template's "How we
work", so they help every project; this repo is the plugin's home, so they ship here as 0.1.3.

## Decisions
- **2026-10-15 — Plan approved; F1–F5 all approved** by the user ("approve all go ahead"), with
  leave to commit and push when done.
- **2026-10-15 — F1 and F3 ship as plugin 0.1.3 (patch).** Alternatives: minor. Why: wording in the
  setup template's "How we work"; no skill names, steps or `setup` output structure change.

## Log
- 2026-10-15 — F2: `tools/run-trials.sh` written; README, `CLAUDE.md` and the trials runbook point
  to it. F1/F3: one sentence each in `CLAUDE.md` and the setup template; `close-task` step 6 matches
  F3. F4: B4 trigger changed. 0.1.3 bump and CHANGELOG entry.
- Rows with no evidence yet stay blank in `PROCESS-LOG.md` (header says so) so the next review picks
  them up; "too early" is recorded in this task's table only.
- First trial run started before the setup-template edit; stopped it. The next run into the same
  scratch folder failed at once (`rm: … Device or resource busy`, then cascading errors): the stopped
  run's leftovers. A run in a new folder passed. See Retro.

## Verification

Validation and trials ran after the last plugin or template edit; only this task file and the trials
runbook's `Last verified` line changed since (`git status`).

| Criterion | Result | Evidence |
|---|---|---|
| 1. Every process-log row has a review result | ✅ | `PROCESS-LOG.md` diff: 6 of 10 rows **kept**/**changed** with one line of evidence each; the 4 "too early" rows (002 `.claude/` wording, 003 ×2, issue #1 rule) are left blank by design, listed as too early in this task's table |
| 2. Approved findings applied, rejected ones recorded | ✅ | Decisions: F1–F5 all approved. Diff: F1 and F3 in `CLAUDE.md` + setup `CLAUDE-workflow.md` (+ `close-task` step 6), F2 `tools/run-trials.sh` + runbook + README + `CLAUDE.md`, F4 `BACKLOG.md` B4; four new `PROCESS-LOG.md` rows. F5: no change |
| 3. Checks pass | ✅ | `wc -l CLAUDE.md` → `57`; `claude plugin validate` → `✔ Validation passed` twice; `sh tools/run-trials.sh <scratch>/trials004b` → `fresh exit=0`, `existing exit=0`, every line `ok`, exit code 0; generated `CLAUDE.md` 51 / 55 lines (was 49 / 53: the two new sentences) |
| 4. Plugin-wide findings reach the plugin | ✅ | F1 and F3 are in 0.1.3 (`plugin.json` `0.1.3`, CHANGELOG entry with what existing projects add). Merge `f4ed42c`; `* [new tag] v0.1.3 -> v0.1.3`; `main` `44fb002..f4ed42c`. In SnowVibes: `updated from 0.1.2 to 0.1.3 for scope user` and `… for scope project (…\worktrees\006-unity-mcp)`; the main-checkout project entry still 0.1.2 (same as with 0.1.2; release runbook Known problems) |

**Needs manual check:**
- Run `/doctor prompt-audit` for a second opinion on `CLAUDE.md` (F5)

## Backlog items covered
- B4 — trigger revised (F4), entry stays open

## Retro

| Lesson | Fix | Lives in | How we'll know it worked | Status |
|---|---|---|---|---|
| Stopping a background trial run left its scratch folder busy; the next run into the same folder failed with misleading cascading errors | Known problems row: after stopping a run, use a new scratch folder | `docs/runbooks/run-setup-trials.md` | No trial failure from a reused scratch folder in later tasks | applied |

## Follow-ups
