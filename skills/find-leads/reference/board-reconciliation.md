# The lead board — reconciliation, stage moves, and write verification

Read before you check or update `lead-board.xlsx` — every run. SKILL.md carries the flow; this file carries
the board rules.

The tracker is a local spreadsheet, `lead-board.xlsx` — one row per lead the rep has ever seen, whether it
came from this scan or from a QuickBase read. It **replaces the old markdown log**: never keep, start, or
append to `find-leads-log.md`, and never keep a second copy of the board. This skill and `my-new-leads` share
the one file.

## Where it lives

Look for `lead-board.xlsx` anywhere in the project first, including a subfolder like `claude/` — some setups
save files there. Use and update it where it is. If it truly isn't anywhere, this is the rep's first board
run: create it with the header row below and this run's rows. Never start a second board "to be safe."

## Columns — the header row is exactly these, in this order

| Column | Who owns it | What goes in it |
| --- | --- | --- |
| Agency | this skill | the public agency or jurisdiction the project belongs to |
| County | this skill | the rep's county for the lead |
| Project | this skill | the project or lead, short |
| Stage | this skill | the 0–7 stage from the ladder; blank if never staged |
| Score | this skill | the 0–100 score from the rubric; blank if never scored |
| QB Status | the QuickBase read (`my-new-leads`) — **never write it here** | the lead's status as the QuickBase read shows it; blank with no QuickBase record |
| Status | the rep / the row that created it — **don't overwrite it on an existing row** | one of exactly: new, watching, contacted, in QB, dropped |
| Contact | `my-new-leads` / the rep — don't overwrite | the public-role contact, when there is one; blank otherwise |
| Next Action | `my-new-leads` / the rep — don't overwrite | the next step for this lead; blank when there isn't one |
| Source Link | this skill | the document link the lead came from |
| Doc Date | this skill | the document date; blank when there isn't one |
| Last Checked | this skill | the date of the run that last checked this lead |

**`QB Status`, `Status`, `Contact`, and `Next Action` are not yours to rewrite.** When you update a row that
already matches a lead, touch only Agency, County, Project, Stage, Score, Source Link, Doc Date, and Last
Checked — leave the QuickBase-origin fields exactly as they are, so a `find-leads` update never clobbers what
`my-new-leads` or the rep put there. Set `Status` only when you **create** a new row: `new` for a lead with no
QuickBase record (`in QB` instead when the cross-reference finds an open opportunity). Refuse to write a
status outside the five above, and never invent a Contact or Next Action — a blank cell is correct when the
data isn't there.

## Reconcile, never duplicate

Match a lead against existing rows **by the underlying lead — same agency and project, same county — not by
the literal URL.** A different article on the same project is the same row. The same project at a later stage
is the same row, updated in place. Never re-add a known lead as new, and never re-open a row the rep has set
to `dropped` — `dropped` stays `dropped` however the lead resurfaces.

## Stage moves come first

Re-check every tracked row this run against what the sources show now. Anything that moved **stage** is
reported under **"Moved up since your last scan"** ahead of anything newly found, one line each with old stage
→ new stage, the date, and the source. Update that row in place rather than adding a second one. Never spend
extra searches re-checking old rows. If nothing moved and nothing new turned up, say so plainly: "Nothing new
since your last run on [date]" — don't re-surface old leads or pad the list.

## The legacy log — one-time import, then leave it alone

A `find-leads-log.md` the rep already has is a list of leads they've already seen. If the board doesn't
already hold a lead the log lists, add it as a row with `Status` = `watching` — **never** as new. Leave the
log file exactly as it is: don't append to it, don't rewrite it, don't delete it. This is a one-time seed, not
a source you keep reading, and the imported rows are **not** reported as newly found just because they moved
across.

## Write it, then read it back

Build the board in code execution with a spreadsheet library (openpyxl is the usual one) and write the
**whole** board each run: header row, then one row per lead, plain text values, no formulas, merged cells, or
formatting tricks — so the rep can open it in Excel or Google Sheets, edit any cell, and paste rows wherever
they're going. Refresh `Last Checked` only on rows you actually checked this run, using the same session date.
Before you tell the rep anything is saved, **read the file back**, confirm the row count, and check the rows
you changed are the ones you wrote. If the readback doesn't match, say the save didn't fully work — never
claim a save you haven't confirmed.
