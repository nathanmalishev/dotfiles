---
name: plan-to-queue
description: Generate a pi message-queue batch file from a plan's remaining tasks, one task
  per fresh session (via forced /new separators). Audits the plan for open questions, design
  decisions, and blocked rows before generating, and gates on unresolved items. Use after
  /skill:phx-plan when you want to run a plan unattended through the message queue. Output
  must be loaded with /queue import.
---

# Plan → Queue Batch

Convert a plan file's **remaining (unchecked) tasks** into a `batch.txt` that the pi
message-queue extension imports. Each task runs in its own fresh session: the batch
alternates a forced `/new` (restart context) with one `phx-work` invocation per task, so
context never exceeds one task and every task starts clean.

**Because the run is unattended, gate on unresolved items first.** A task that needs a
decision the user never made will make the agent ask (or guess) in a session nobody is
watching.

## Input

`/skill:plan-to-queue <plan.md>` — path relative to the pi session cwd, e.g.
`.claude/plans/bulk-edit-queued-flow/plan.md`

Optional trailer commands are appended (each in its own fresh session, matching the task
pattern):

`/skill:plan-to-queue <plan.md> /test_coverage /verify_complete`

## Step 1 — Audit the plan (MANDATORY, before anything else)

Read the **plan file and its `scratchpad.md`** (same directory). Identify anything that
affects the tasks you are about to queue:

1. **Unresolved design decisions / open questions.** Look in the plan header
   ("Source", decisions notes), task text, and the scratchpad (D-notes, dead-ends,
   "open question", "TBD", "needs decision", "confirm", "ask the user"). Judge whether any
   still-open item bears on a remaining task — a done task's old decision matters only if a
   remaining task depends on it.
2. **`[BLOCKED]` rows.** Any row tagged `[BLOCKED]` anywhere before the remaining tasks —
   later `phx-work` sessions stop by default when an unresolved blocker precedes them.
3. **Ambiguous remaining tasks.** Rows whose description reads as unclear, underspecified,
   or dependent on an open decision.

### Gate — stop and ask

If the audit finds anything affecting remaining tasks, **STOP. Do not write the batch
file.** Present the findings as a short task-id → issue list and ask the user to choose:

1. **Resolve first** — answer the open questions / make the decisions now, then re-run
   this skill.
2. **Exclude** — drop the affected tasks from this batch (queue only the clean remainder).
3. **Run anyway** — write the batch including the affected tasks, with the findings noted
   as `#` comment lines at the top of the file.

Continue to Step 2 only once the audit is clean or the user explicitly chose an option.

## Step 2 — Select tasks

If you reached this step, the plan is cleared to run. Select the tasks: top-level rows
shaped `- [ ] **6.2** Task description` (a `- [ ]` checkbox whose bold id matches `N.M` —
digits, dot, digits). Take **only unchecked** rows, in file order (minus any excluded by
the user). Ignore sub-item ids with letters (`6.2a`), `[x]` done rows, `[BLOCKED]`-tagged
rows, and all prose.

## Step 3 — Write `batch.txt`

Resolve the plan path exactly as the pi session will see it (the same relative path you
were given, e.g. `.claude/plans/<slug>/plan.md`). Keep it identical on every line — do not
rewrite or absolutize it.

Write `batch.txt` in the plan's own directory (`.claude/plans/<slug>/batch.txt`),
containing **exactly one queued item per line**, repeating once per selected task:

```
! /new
/skill:phx-work <plan-path> <N.M> only
```

Then, for each trailer command given as an argument, append:

```
! /new
<trailer-command>
```

### HARD RULES (a violation breaks the queue)

- Every line of `batch.txt` is **exactly one of these forms and nothing else**:
  - `! /new` — the forced session-restart marker (bang, space, `/new`). Exactly.
  - `/skill:phx-work <plan-path> <N.M> only` — the task command.
  - `<trailer-command>` — a trailer you were explicitly asked to append.
  - a `#` comment line (only for the user-approved "run anyway" findings), or a blank line.
- **Never** paste plan prose, task descriptions, bullet lists, or markdown into the file.
  A queued item is a single command line — not a paragraph. If a description would wrap
  across lines, it does not belong in the file.
- Do not line-wrap anything. No trailing spaces. No other formatting.
- Do not prefix task commands with `!` — only the `/new` separators are forced.

## Step 4 — Verify (mandatory, before reporting done)

Re-read `batch.txt` and check:
- every non-blank, non-comment line starts with `! ` or `/`;
- the count of `/skill:phx-work` lines equals the number of selected tasks;
- `/new` lines and task lines strictly alternate, starting with `! /new`.

If any check fails, fix the file and re-verify.

## Step 5 — Report to the user

State: the file path, the number of tasks queued, any tasks excluded or run with findings,
and these two commands to run in pi:

```
/queue import .claude/plans/<slug>/batch.txt
/queue list
```

## Example

For `.claude/plans/my-plan/plan.md` with unchecked tasks `6.2`, `6.3`, `6.4` and trailer
`/verify_complete`, `batch.txt` is exactly:

```
# my-plan remaining tasks — one per fresh session
! /new
/skill:phx-work .claude/plans/my-plan/plan.md 6.2 only
! /new
/skill:phx-work .claude/plans/my-plan/plan.md 6.3 only
! /new
/skill:phx-work .claude/plans/my-plan/plan.md 6.4 only
! /new
/verify_complete
```

## Notes

- The audit catches what is unresolved **at import time**. A task can still raise a
  question or hit a blocker while it runs — an unattended batch is never a guarantee.
  Review the transcript when it finishes, and check whether your per-task invocation
  suppresses `phx-work`'s ">3 tasks" research question; if not, that stalls every session.
- The queue dispatches items only when Pi is idle, one per session, in order. The forced
  `/new` items restart context automatically (no `/queue resume` needed).
- If the queue is paused, tell the user to run `/queue resume` after importing.
