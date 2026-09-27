---
name: my-new-leads
description: >-
  Show the rep their unworked "New" QuickBase opportunities and keep their local lead board
  (lead-board.xlsx) current — one row per lead, stage changes flagged before anything new. Read-only from
  QuickBase; the board is a local file and nothing is ever written back to QuickBase. Use when the rep says
  "my new leads", "what leads do I have", "unworked leads", "update my lead board", "what's on my board",
  "new opportunities assigned to me", or "leads going cold". To scan for new signals use `find-leads`; for a
  health check across all open opps use `my-pipeline`; to dig into or write to one lead use `research` or
  `draft-outreach`.
---

# New Leads + the Lead Board

Two jobs, one tool. It reads the rep's unworked "New" opportunities in QuickBase — sorted so the ones going
cold surface first, each with a suggested next step — and it keeps the rep's lead board, a local spreadsheet
`lead-board.xlsx`, which tracks every lead the rep has seen. It reads QuickBase; it never writes to
QuickBase. The board is a local file.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in
this project (your trainer sets this up). If they aren't available, say so in one plain
sentence — "This needs the QuickBase connection your trainer sets up; it isn't on your account yet." —
and stop. Never guess or fabricate lead data, and don't rewrite the board off a QuickBase read that didn't
happen.

## The one rule: real data only, read-only
Every row comes from a live QuickBase read or from a `find-leads` run the rep already has. Never invent a
lead, a stage, a score, a contact, a date, or a source link — a blank cell is correct where the data isn't
there. Never write back to QuickBase — a lead only leaves "New" when the rep logs an update or creates a
quote, and that's the rep's action, not this tool's. The board is the rep's own file; write it, and nothing
else.

## What "New" means here
An opportunity's status is automatic, not something a rep sets by hand. **New = zero quotes and no update
logged yet** — an untouched lead. The rep moves a lead out of New by logging an update on it or creating a
quote. So every "New" opp is unworked by definition; this tool is the rep's list of leads still waiting on
a first touch.

## Fresh leads vs. import backlog — the split that matters
Many reps carry a large pile of "New" opportunities from a mid-2026 bulk import, not from real intake.
Those are not fresh leads, and "days since created" is meaningless for them (they all show the same import
date). Follow the `quickbase-usage` skill to identify the import backlog — it knows the import dates and
which date field to age each group by. Then split the rep's New opps into:

- **Fresh leads** — New opps from normal intake (not the import). Age them by their created date. These are
  the ones to chase.
- **Import backlog** — New opps from the bulk import. Show these as a count with a one-line note ("X leads
  from the bulk import, still untouched — a cleanup pile, not fresh intake") and offer to list them
  separately. Don't lean on their dates for age — the import stamped both the created and last-modified
  dates in bulk (whole batches share one timestamp), so neither reflects real activity.

If you genuinely can't tell the two apart, say so plainly rather than mixing them.

## Whose leads, and how to pull them
Follow the `quickbase-usage` skill for the query — it holds the Opportunities table and field IDs and the
query discipline. In business terms: pull the rep's opportunities where status is **New** and the rep is
**Sales Rep 1**, reading opportunity number, customer, customer contact (name, phone, email), status, date
created, last-modified date, lead source, and number of updates. The contact fields live in the
`quickbase-usage` skill; do not hardcode field IDs here. A rep can have a big pile — page the full set
(cap around 300; say so if there are still more). One rep's slice is bounded — pull it directly; never
scan the whole table.

## First use — confirm the rep's QuickBase name
Rep names must match QuickBase exactly or the query returns nothing, and a name mismatch looks identical to
an empty lead list. So:

1. If `PROFILE.md` has a "QuickBase Name" line, use it.
2. If it doesn't, or the query returns zero opportunities, tell the rep plainly and ask them to confirm
   their exact name as it appears in QuickBase (e.g. "Michael Smith," not "Mike"). Save the confirmed name
   to `PROFILE.md` as `QuickBase Name:` so this only happens once.

Never report "you have no new leads" without first checking the name this way.

## The lead board — `lead-board.xlsx`
`lead-board.xlsx` is the rep's tracker: one row per lead the rep has seen, QuickBase and `find-leads` alike.
It replaces the markdown log as the tracker. Keep leads in the board — never keep, start, or append to a
`find-leads-log.md` from this tool, and never keep a second copy of the board.

**Where it lives:** in the rep's project folder. **Look for it anywhere in the project first, including a
subfolder like `claude/`** — some setups keep files there. If it's there, use it where it is and update it
there. If it truly isn't anywhere, this is the rep's first board run: create it, run the QuickBase read, and
fill it with today's leads. Never create a second board "to be safe."

**If a `find-leads-log.md` (or another lead list) is lying around:** it's a list of leads the rep has
already seen. Bring any lead it holds that the board doesn't have on as a row with status `watching` — never
as new — then leave the log alone. Don't append to it, don't rewrite it.

**Columns — the header row is exactly these, in this order, one row per lead:**

| Column | What goes in it |
| --- | --- |
| Agency | the public agency or jurisdiction the project belongs to |
| County | the rep's county for the lead |
| Project | the project or lead, short |
| Stage | the 0–7 stage from the `find-leads` ladder; blank if the lead was never staged |
| Score | the 0–100 score from the `find-leads` rubric; blank if it was never scored |
| QB Status | the lead's status as the QuickBase read shows it; blank when there's no QuickBase record |
| Status | the rep's work state — one of exactly five values (below) |
| Contact | the public-role contact tied to the lead, when there is one; blank otherwise |
| Next Action | the next step for this lead; blank when there isn't one |
| Source Link | the document link the lead came from; blank for a QuickBase-only lead |
| Doc Date | the document date from `find-leads`; blank when there isn't one |
| Last Checked | the date of the run that last checked this lead |

Column definitions and field ownership are the responsibility of `find-leads`' board reference —
`Lead Finder - Lead Board.md` (`reference/board-reconciliation.md`) — this table must match it exactly.

**Don't overwrite the fields `find-leads` owns.** Agency, County, Project, Stage, Score, Source Link, and
Doc Date are `find-leads`' fields. When this tool updates a row that already exists, touch only QB Status,
Status, Contact, Next Action, and Last Checked — leave `find-leads`' fields as they are, except to fill one
in that's blank. Never invent a value to fill a blank; leave it blank if you don't have a real one.

**Status values are limited to these five, exactly — never a free-text status:**

- **new** — the lead appeared on the board for the first time on this run and has no QuickBase record. It
  doesn't stay `new` across runs: next run, an untouched row carries over as `watching`.
- **watching** — tracked, nothing to act on yet (including a row carried over from `new` with no movement).
- **contacted** — the rep has reached out; in QuickBase terms, they've logged an update.
- **in QB** — an opportunity or quote for the lead already exists in QuickBase. This is what the rep's own
  New opps are (they're opportunities on file), whatever the `find-leads` cross-reference found, or
  whatever the rep tells you they've added.
- **dropped** — the rep ruled it out. The row stays on the board, so the lead never comes back as new.

**Where the rows come from, every run:**

1. **The rep's QuickBase New opps** — the read above, one row per opp. `QB Status` is what the read shows
   (New, when it's untouched); `Status` is `in QB`. Fresh-vs-backlog still decides what you show in chat,
   not what goes on the board — the backlog is on the board too, so it isn't re-litigated every run.
2. **The latest `find-leads` results** — the most recent run, taken from this conversation or its local
   artifacts. Those runs are authoritative for agency, county, project, stage, score, source link and doc
   date. **This tool never runs its own territory scan** — finding signals is `find-leads`' job. If there's
   no `find-leads` result in the conversation and none on disk, don't invent rows: reconcile what you have
   and say that find-leads results are what fill the rest.

**Reconcile, never duplicate.** Match a lead against existing rows **by the underlying lead** — same agency
and project, same county — not by the literal URL. A different article on the same project is the same row.
The same project at a later stage is the same row, updated in place. Never re-add a known lead as new, and
never re-open a row the rep has `dropped`.

**Re-check every tracked lead, every run — stage changes first.** Each run re-checks the tracked rows: the
QuickBase ones from the read, and the `find-leads` ones against what the latest `find-leads` run says about
them. Anything that moved **stage** is reported ahead of anything newly found. Refresh `Last Checked` on
every row you actually checked — and only on rows you checked.

**Write it, then read it back.** Build the board in code execution with a spreadsheet library (openpyxl is
the usual one in this setup) and write the **whole** board each run: header row, then one row per lead,
plain text values, no formulas, merged cells, or formatting tricks — so the rep can open it in Excel or
Google Sheets, edit any cell, and paste rows wherever they're going. Before you tell the rep anything is
saved, **read the file back**, confirm the row count, and check the rows you changed are the ones you wrote.
If the readback doesn't match, say the save didn't fully work — never claim a save you haven't confirmed.
Only then: "Saved your lead board — N leads, M rows changed."

## Output shape — in this order
1. **"Moved up since your last check"** — tracked leads that changed stage, ahead of everything else, one
   line each with old stage → new stage, the date, and the link. Skip the heading if there are none.
2. **The QuickBase New leads** — the fresh/backlog split as before: "You have N fresh new leads and M from
   the bulk-import backlog," then the fresh leads oldest first (going cold first), one line each:
   opportunity number linked to its QuickBase record (built from the record-URL pattern in the
   `quickbase-usage` skill — never hardcode realm/app/table IDs), customer, customer contact, days since it
   came in, lead source, and the suggested next step. Group them cold (90+ days), aging (30–90), recent
   (under 30) when there are many. New leads that reached the board from a `find-leads` run get one line
   each too: county and agency, what happened, doc date, stage, score, source link. Add a one-line source
   cut across the fresh leads: how many came from each lead source (Park, PLAYCORE, Website, and so on),
   with blanks under "(source not set)." Skip this if there are only a couple of fresh leads.
3. **The board, when the rep asks to see it** — the same rows as a plain table, paste-ready.
4. **"Saved your lead board — N leads, M rows changed."** — only after the readback above.
5. No "bottom line," no strategy wrap-up.

If the rep has no fresh leads, say so plainly (and note the backlog if any). Never dress the backlog up as
fresh intake. If nothing moved and nothing is new, say that in one line rather than re-listing the board.

## Reading the data
- **Lead source is free text and often blank** (~30% empty) — show it when present, put blanks under
  "(source not set)," and never guess a source. The same source is often typed several ways ("Current
  Client," "EXISTING CUSTOMER," "Referral"/"REFERAL") — show each as written; if you group by source,
  treat obvious spelling/case variants as one group and say you did.
- **Customer contact** (name, phone, email) comes from the fields the `quickbase-usage` skill maps. Show it
  with each fresh lead so the rep can act; never invent it. The board's Contact column carries the
  public-role contact for a lead, not personal contact data.
- Exclude any test records (your trainer's test accounts).
- Count "days since" off **today's date from the current session** — reps aren't all in one time zone, so
  don't convert to or assume Eastern. A few hours' offset never changes a day count that matters here. Use
  the same session date for `Last Checked`.

## The suggested next step — no fabrication
For each fresh lead, suggest a real next action without inventing anything about the account:
- "Start with the Research Brief to build a reason to call, then the Email Writer for the intro."
- Keep it to which tool to use next, and write it into `Next Action` when it's for a lead on the board.
  Never invent the account's situation, needs, or a sales strategy. And remember: a lead only leaves "New"
  once the rep logs an update or a quote in QuickBase — this tool drafts, the rep logs.

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment —
no stack traces, no QuickBase jargon. Don't rewrite the board off a partial or failed read; leave the
existing rows as they are and say which rows you couldn't check this run.
