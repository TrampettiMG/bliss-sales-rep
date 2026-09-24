---
name: my-pipeline
description: >-
  Show the rep their own open opportunities and flag what a sales manager would call about — overdue or
  missing forecast close dates, blank or zero confidence, and stale opps. The "what your manager sees
  before he calls you" health check. Read-only from QuickBase; never writes. Use when the rep says "my
  pipeline", "what's in my pipeline", "what needs attention", "what would my manager flag", "check my
  opportunities", or "my open opps". To turn the fixes into paste-ready QuickBase values use
  `forecast-update`; to see only unworked New leads use `my-new-leads`.
---

# Pipeline Check

A read-only health check on the rep's own open opportunities in QuickBase. It surfaces the data gaps a
sales manager would call about — overdue or missing forecast close dates, blank or zero confidence, and
stale items — so the rep can fix them first. It reads; it never writes. To produce the actual paste-ready
values that fix these gaps, hand off to `forecast-update`.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in
this project (your trainer sets this up). If they aren't available, say so in one plain
sentence — "This needs the QuickBase connection your trainer sets up; it isn't on your account yet." —
and stop. Never guess or fabricate pipeline data.

## The one rule: real data only, read-only
Every number comes from a live QuickBase read. Never invent an opportunity, a date, a dollar value, or a
confidence figure. If a field is blank, report it as blank — that is the whole point of this tool. Never
write back to QuickBase; fixing the gaps is `forecast-update`'s job (draft-to-paste), not this one's.

## Whose opportunities, and how to pull them
Follow the `quickbase-usage` skill for the actual query — it holds the Opportunities table and field IDs
and the query discipline (select specific fields, bound the rows, don't explore in the main context). In
business terms:

- Pull the rep's **open** opportunities — status New, Pending, or Quoted to Customer only — where the rep
  is **Sales Rep 1**. Ordered is excluded (it's already won, so it shouldn't be flagged for an overdue
  forecast close), and so is Closed.
- For each, read: opportunity number, customer, customer contact (name, phone, email), status, forecast
  close date, confidence, opportunity value, number of quotes, date created, and last activity (the
  last-modified date and the most-recent-update date). The contact and activity fields live in the
  `quickbase-usage` skill; do not hardcode field IDs here.
- A rep can have a large book — dozens to a few hundred open opps (the 2026 Opportunity rollout left many
  reps with a big backlog of untouched "New" opps). Page through the rep's full open set with an explicit
  field list and a sane cap (around 300); if there are still more, say so. This is one rep's slice —
  bounded and fine to pull directly; never scan the whole table.

## First use — confirm the rep's QuickBase name
Rep names must match QuickBase exactly or the query returns nothing, and a name mismatch looks identical
to an empty pipeline. So:

1. If `PROFILE.md` has a "QuickBase Name" line, use it.
2. If it doesn't, or the query returns zero opportunities, tell the rep plainly and ask them to confirm
   their exact name as it appears in QuickBase (e.g. "Michael Smith," not "Mike"). Save the confirmed name
   to `PROFILE.md` as `QuickBase Name:` so this only happens once.

Never report "you have no opportunities" without first checking the name this way.

## Reading the data — handle these exactly
- **Confidence is stored as a fraction** — 0.25 means 25%. Always display it as a percentage.
- **Confidence has two distinct blank states:** truly blank (never set) and 0 (explicitly zero). Flag both
  as needing attention, but say which — "no confidence set" vs "confidence set to 0%."
- **Forecast close date is often blank or in the past, and some are outright typos** (real data has years
  like 0226 or 2003). Treat any blank or past date as a gap. If a date is clearly impossible (a year far
  in the past, or an implausible year), call it out as a likely typo — not just "overdue."
- **Forecast close date is a plain date field, not a timestamp — there's no time zone to convert.** Compare
  it to today's date from the current session (reps aren't all in one time zone; don't assume or convert to
  Eastern). Use the same session-date basis for any "stale N days" or aging logic below.
- **Opportunity value is a confidence-weighted rollup, not a number the rep types.** It only populates once
  the opp has a quote flagged to count toward value, so it's blank for New opps and even for some quoted
  ones. Show it when present, as information only. Never flag a blank value as a gap (the rep can't set it
  directly), and never add field values into a headline "total pipeline value" unprompted.
  **If the rep asks for a total,** give it — but always say how many open opps have a value vs. blank
  ("5 of 5 have a value" or "12 of 30 have a value — this total leaves out the 18 blank ones"), label a
  total with any blanks as partial, and say what the value is based on (subtotal incl. freight before
  tax; one option per opp counts; weighted = value × confidence).
- **Customer contact and last activity** come from the fields the `quickbase-usage` skill maps. Show the
  contact so the rep can act; use last activity for a plain "last touched N days ago." Never invent either.
- If any test records appear (your trainer's test accounts), exclude them.

## What to flag — the health buckets
Group the rep's open opps into three buckets:

- 🔴 **Needs attention now** — forecast close date is in the past (overdue) or clearly a typo, and the opp
  is still open; or a Quoted to Customer opp has no close date at all.
- 🟡 **Worth a look** — confidence is blank or 0; or a New opp older than ~30 days still has no forecast
  close date; or a **Quoted to Customer opp created more than ~90 days ago** that's still open (label it
  "quoted 90+ days ago, still open"). This one goes in 🟡 even if its close date and confidence are clean:
  most quotes that turn into orders do so within a couple of months, so an old open quote usually needs a
  follow-up or a close-out. Age is measured from the opp's date created — say "created N days ago," not
  "quoted N days ago," since the quote-sent date isn't in this read.
- 🟢 **Clean** — a future close date and a confidence above 0 (and not an old open quote).

The overdue window and the ~30-day and ~90-day aging thresholds are starting defaults — your trainer can
adjust them.

## Present it — keep it scannable even with 50+ opps
- Lead with one summary line and the bucket counts: "You have N open opportunities — X 🔴 need attention
  now, Y 🟡 worth a look, Z 🟢 clean."
- Then a "your numbers" line: the total value across the rep's quoted deals and the weighted forecast
  (value × confidence), plus a count by stage (New / Pending / Quoted to Customer). Follow the totals rule
  above — say how many opps have a value vs. blank, label a total with blanks as partial, and never present
  it as the rep's whole book when most of it is unvalued.
- List the 🔴 items in full, one line each: the opportunity number as a clickable link to its QuickBase
  record (build the link from the record-URL pattern in the `quickbase-usage` skill; do not hardcode the
  realm/app/table IDs), then customer, status, close date (or "no close date," or "date looks wrong:
  <value>"), confidence as a %, and last activity ("last touched N days ago"). Put the customer contact
  (name, phone, email) with each item so the rep can act without opening QuickBase. These are what to fix
  first.
- For 🟡, give the count and the top few examples, then offer to list them all rather than dumping every
  one.
- For 🟢, just the count (offer the list if they want it).
- This is a status list, not a strategy memo — no recommended approach, no "bottom line," no invented
  totals. If everything is clean, say so plainly.
- Offer the next steps as offers only: "Want these turned into paste-ready QuickBase values? That's the
  Forecast Helper." and "Want a follow-up drafted to one of these contacts? That's the Email Writer." (For
  "quoted 90+ days ago" items especially, an email nudge is the natural move.)

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment —
no stack traces, no QuickBase jargon.
