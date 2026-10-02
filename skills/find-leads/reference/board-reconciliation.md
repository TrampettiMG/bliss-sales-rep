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

**If the project can't hold a spreadsheet** (some setups, Cowork for one, only store text files), keep
the board as `lead-board.csv` in the project instead: the same header row and columns, plain comma-separated
text, written whole and read back the same way. That file is the board from then on, so the next run and the
morning check-in find it. Also hand the rep this run's board as a downloadable `lead-board.xlsx`, but never
treat that download as the board. Say nothing about file types to the rep; just "Saved your lead board." Look
for either name; if both exist, use the newer one and say so in one line.

## Columns — the header row is exactly these, in this order

| Column | Who owns it | What goes in it |
| --- | --- | --- |
| Agency | this skill | the public agency or jurisdiction the project belongs to |
| County | this skill | the rep's county for the lead |
| Project | this skill | the project or lead, short |
| Stage | this skill | the 0–7 stage from the ladder; blank if never staged |
| Score | this skill | the 0–100 score from the rubric; blank if never scored |
| QB Status | the QuickBase read (`my-new-leads`) — **never write it here** | the lead's status as the QuickBase read shows it; blank with no QuickBase record |
| Status | the row that created it, then only the moves in "Who may change Status" below | one of exactly: new, watching, contacted, in QB, dropped |
| Contact | `my-new-leads` / the Daily run contact card (blank only) / the rep — don't overwrite | the public-role contact, when there is one; blank otherwise |
| Next Action | `my-new-leads` / Update Logger / the rep — see below | the next step for this lead; blank when there isn't one |
| Source Link | this skill | the document link the lead came from |
| Doc Date | this skill | the document date; blank when there isn't one |
| Last Checked | this skill | the date of the run that last checked this lead |
| Phone | the Daily run contact card / the rep — fill blanks only | the contact's published work phone; blank otherwise |
| Email | the Daily run contact card / the rep — fill blanks only | the contact's published work email, never guessed; blank otherwise |
| Website | the Daily run contact card / the rep — fill blanks only | the buyer's website or the project page |
| Contact Source | the Daily run contact card | the public page the contact came from |
| Next Action Date | `my-new-leads` / Update Logger / the rep — don't overwrite | the date of the next step, when the rep named one; blank otherwise |
| Bid Due | this skill | the bid's due date exactly as the documents state it, for a stage-6 bid; blank otherwise |

**Older boards** may stop at Last Checked. On the next save, add the six newer columns at the end, blank,
and keep every existing value. Never reorder columns. One exception to "blank": if a row's `Next Action`
text names a date ("Call again Oct 1"), copy that date into `Next Action Date` so the follow-up isn't lost.
A save that only adds columns doesn't count as changed rows.

## Who may change Status, Contact and Next Action

One set of rules for every tool that writes the board (Lead Finder, New Leads, Update Logger, the Daily run):

- **`dropped`** is set only by the rep, and no tool ever changes it afterwards.
- **`new` → `watching`:** the next run that sees the row untouched (Lead Finder or New Leads).
- **→ `contacted`:** the Update Logger or New Leads, when the rep has reached out (their own notes or a logged
  update). Only from `new` or `watching`.
- **→ `in QB`:** when QuickBase has an opportunity or quote for this lead (the New Leads read or the Lead
  Finder's QuickBase check). From `new`, `watching` or `contacted`. Never move a row back from `in QB`.
- **Contact, Phone, Email, Website:** tools fill them only where blank. The rep may change them; no tool
  overwrites what's there.
- **Next Action and Next Action Date:** the Update Logger and New Leads may set them when the rep names the
  next step; never blank out what the rep wrote.
- **Last Checked** belongs to the Lead Finder alone: it uses the latest one to know where its last scan
  stopped, so no other tool changes it.

**`QB Status`, `Contact`, `Next Action`, and `Next Action Date` are not yours to rewrite, and `Status`
changes only as "Who may change Status" above allows**, and
`Phone`, `Email` and `Website` are filled only where blank. When you update a row that
already matches a lead, touch Agency, County, Project, Stage, Score, Source Link, Doc Date, Bid Due and Last
Checked, and Status only as "Who may change Status" allows — leave the QuickBase-origin fields exactly as they
are, so a `find-leads` update never clobbers what `my-new-leads` or the rep put there. On a **new** row, set
`Status` to `new` for a lead with no QuickBase record (`in QB` instead when the cross-reference finds an open
opportunity). Refuse to write a
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
