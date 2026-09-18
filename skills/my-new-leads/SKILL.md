---
name: my-new-leads
description: >-
  Show the rep their unworked "New" opportunities — the leads assigned to them that no one has touched
  yet — sorted so the ones going cold surface first, each with a suggested next step. Read-only from
  QuickBase; never writes. Use when the rep says "my new leads", "what leads do I have", "unworked leads",
  "new opportunities assigned to me", "what should I follow up on", or "leads going cold". For a full
  health check across all open opps use `my-pipeline`; to dig into or write to one of these leads use
  `research` or `draft-outreach`.
---

# My new leads

A read-only look at the rep's unworked "New" opportunities in QuickBase — the leads assigned to them that
haven't been worked yet — sorted so the ones going cold surface first, each with a suggested next step. It
reads; it never writes.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in
this project (your trainer sets this up for pilot reps). If they aren't available, say so in one plain
sentence — "This needs the QuickBase connection your trainer sets up; it isn't on your account yet." —
and stop. Never guess or fabricate lead data.

## The one rule: real data only, read-only
Every lead comes from a live QuickBase read. Never invent a lead, a date, or a source. Never write back to
QuickBase — a lead only leaves "New" when the rep logs an update or creates a quote, and that's the rep's
action, not this tool's.

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
**Sales Rep 1**, reading opportunity number, customer, status, date created, last-modified date, lead
source, and number of updates. A rep can have a big pile — page the full set (cap around 300; say so if
there are still more). One rep's slice is bounded — pull it directly; never scan the whole table.

## First use — confirm the rep's QuickBase name
Rep names must match QuickBase exactly or the query returns nothing, and a name mismatch looks identical to
an empty lead list. So:

1. If `PROFILE.md` has a "QuickBase Name" line, use it.
2. If it doesn't, or the query returns zero opportunities, tell the rep plainly and ask them to confirm
   their exact name as it appears in QuickBase (e.g. "Michael Smith," not "Mike"). Save the confirmed name
   to `PROFILE.md` as `QuickBase Name:` so this only happens once.

Never report "you have no new leads" without first checking the name this way.

## Reading the data
- **Lead source is free text and often blank** (~30% empty) — show it when present, put blanks under
  "(source not set)," and never guess a source.
- Exclude any test records (your trainer's test accounts).
- Timestamps are UTC — convert to the rep's local time (Eastern) before counting days.

## Present it — keep it scannable
- Lead with the split: "You have N fresh new leads and M from the bulk-import backlog."
- **Fresh leads**, oldest first (going cold first) — one line each: opportunity number, customer, days
  since it came in, lead source, and the suggested next step. If there are many, group them: cold (90+
  days), aging (30–90), recent (under 30).
- **Import backlog** — just the count and the one-line note; offer to list it if the rep wants to clean it up.
- If the rep has no fresh leads, say so plainly (and note the backlog if any). Never dress the backlog up as
  fresh intake.
- No "bottom line," no strategy wrap-up.

## The suggested next step — no fabrication
For each fresh lead, suggest a real next action without inventing anything about the account:
- "Start with `research` to build a reason to call, then `draft-outreach` for the intro."
- Keep it to which tool to use next. Never invent the account's situation, needs, or a sales strategy. And
  remember: a lead only leaves "New" once the rep logs an update or a quote in QuickBase — this tool
  drafts, the rep logs.

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment —
no stack traces, no QuickBase jargon.
