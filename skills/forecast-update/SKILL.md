---
name: forecast-update
description: >-
  Month-end walkthrough of the rep's open opportunities that produces paste-ready forecast values —
  forecast close date and confidence — formatted for QuickBase's bulk-edit forecast grid.
  Read-only; never writes, and never invents a forecast (the rep sets the values). Use when the rep says
  "forecast update", "month-end forecast", "update my forecast", "get my opps grid-ready", "clean up my
  forecast", or "help me update my pipeline for the month". To just see what needs fixing first, use
  `my-pipeline`.
---

# Forecast update

A month-end walkthrough of the rep's open opportunities that turns their decisions into paste-ready values
for QuickBase's bulk-edit forecast grid — forecast close date and confidence. It reads
QuickBase and formats the output; it never writes, and it never decides the forecast for the rep.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in
this project (your trainer sets this up for pilot reps). If they aren't available, say so in one plain
sentence — "This needs the QuickBase connection your trainer sets up; it isn't on your account yet." —
and stop.

## The one rule: the rep sets the forecast, never you
Confidence and forecast close date are the rep's commitment — their judgment about their own deals. This
tool **never invents, guesses, or auto-fills them.** It shows the current values, flags the gaps, captures
what the **rep** decides, checks it's valid, and formats it. If the rep explicitly asks for a suggestion,
you may offer one clearly labeled as a suggestion to confirm — never stated as the answer. And it never
writes to QuickBase: the rep pastes the values into the grid themselves. An opp appears in the output only
once the rep has given or confirmed its values.

## What it produces
A paste-ready table of forecast values — opportunity number, forecast close date, and confidence — that the
rep copies into QuickBase's bulk-edit forecast grid. This tool doesn't handle notes at all; the note field
(what happened on an opp, and what's next) is `log-update`'s job, not this one's. Match the column order and
date format to the rep's actual forecast grid (see the bulk-update video; if unsure, tell the rep to check
with their trainer rather than guessing the format).

## Whose opps, and how to pull them
Follow the `quickbase-usage` skill for the query — it holds the Opportunities table and field IDs and the
query discipline. In business terms: pull the rep's **open** opportunities (status New, Pending, or Quoted to Customer only — Ordered
is excluded because it's already won, and Closed is excluded) where
the rep is **Sales Rep 1**, reading opportunity number, customer, status, current forecast close date,
current confidence, and number of quotes. Page the rep's full open set (cap around 300; say so if there's
more). One rep's slice is bounded — pull it directly; never scan the whole table.

## First use — confirm the rep's QuickBase name
Rep names must match QuickBase exactly or the query returns nothing. If `PROFILE.md` has a "QuickBase Name"
line, use it. If not, or the query returns zero rows, ask the rep to confirm their exact name as it appears
in QuickBase and save it to `PROFILE.md` as `QuickBase Name:`. Never report "you have no opportunities"
without checking this first.

## Valid values — enforce these
- **Confidence must be one of five values: 0%, 25%, 50%, 75%, or 99%** (QuickBase stores them as 0, 0.25,
  0.5, 0.75, 0.99). If the rep gives anything else (say, 40%), ask them to pick one of the five — never
  round it silently.
- **Forecast close date** must be a real calendar date. It's a plain date field, not a timestamp — compare
  it to today's date from the current session (reps aren't all in one time zone; don't assume or convert to
  Eastern). If the rep sets a date already in the past, flag it ("that's already past — did you mean a
  later date?") instead of accepting it silently, and watch for obvious typos (a wrong year).

## The walkthrough — practical, not 60 rows one at a time
A rep can have dozens to hundreds of open opps, and most are stale import backlog. Don't force a slog:

1. **Start with what actually needs it** — the opps with overdue or missing close dates and blank or zero
   confidence (the same gaps `my-pipeline` flags). Handle those first.
2. **Let the rep decide in bulk where it fits** — "push all of these to end of Q4 at 25%." Apply the
   decision to that group, then show the result for them to confirm before it goes in the output.
3. **Don't walk the import backlog individually.** Those dozens of untouched bulk-import "New" opps usually
   aren't real month-end forecast — offer to skip them or handle them as one batch.
4. Keep moving in small confirmable chunks; don't dump 60 questions at once.

## Present it — the grid-ready output
- Lead with a one-line summary: "Ready to paste: N opportunities updated."
- Then the table, one row per updated opp: opportunity number, customer, forecast close date, confidence
  (%). No note column — if the rep wants to log what happened on an opp, point them to `log-update`.
- Offer a tab-separated version for a direct paste into the grid.
- Remind the rep plainly: this is a draft — they paste it into the QuickBase forecast grid themselves;
  nothing is written automatically.
- No strategy wrap-up, no "bottom line."

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment —
no stack traces, no QuickBase jargon.
