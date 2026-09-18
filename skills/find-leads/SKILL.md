---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals — park/playground/splash-pad projects, municipal
  budgets, grants, bond referendums, school/HOA construction news — and report what's new since the
  last run. Use when the rep says "find leads for my county", "what's new in my territory", "scan for
  leads", "any new signals", or similar. Repeatable: each run only surfaces items not already logged.
---

# Find leads

Scan public sources for new, dated signals in the rep's territory that suggest a playground/site-amenity
opportunity is coming — not a generic list of categories, and not a per-contact brief (that's the
`research` tool, for once the rep has a specific target to dig into).

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. It never
invents a signal — if a search comes back thin for a category, say so plainly rather than padding the
list with generic possibilities. Every signal needs a real source link and a real date; if either is
missing, leave it out.

## The log — what makes this repeatable

Keep a project file `find-leads-log.md` — one entry per signal ever surfaced, each with its date, county,
one-line description, and source URL. On every run:

1. If `find-leads-log.md` doesn't exist yet, this is the rep's first run — search normally and treat
   everything found as new. Create the log with today's results.
2. If it exists, search normally, then **compare against the log** by source URL (or by date + headline if
   the URL isn't a stable identifier). Only report items not already in the log. If nothing new turns up,
   say so plainly: "Nothing new since your last run on [date]" — don't re-surface old items or pad the
   list to look productive.
3. Append newly surfaced items to the log after reporting them, so the next run doesn't repeat them.

## Usage budget — most reps are on a standard/basic Claude plan

Web searches count against the rep's own usage limits, and this tool can easily burn through a lot of them
in one run across five categories. Stay disciplined:

- **Cap it at roughly 2 searches per category per run** (about 10 total) — one broad search, one narrower
  follow-up only if the first looked promising. Don't chain additional searches chasing a thin lead.
- If the budget runs out before covering every category, **stop and report what you found**, and say
  plainly which categories weren't checked this run (e.g., "Didn't get to grants or bond referendums this
  time — ask again to pick those up.") rather than silently skipping them.
- **Check the log's last-run date first.** If the rep already ran this today, say so and ask if they still
  want to spend a fresh scan — most public sources don't change meaningfully within the same day, so a
  same-day re-run is usually not worth the usage. Still run it if they say yes.

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory and product focus. If territory is missing or
   too broad to search meaningfully (e.g., just a state name), ask for the specific county or counties.
2. **Search each category** for the rep's counties, recent activity only, within the usage budget above:
   - Park, playground, or splash-pad projects (new builds, renovations, RFPs, ribbon-cuttings).
   - Municipal capital improvement budgets or plans that mention parks/rec.
   - Grants awarded or applied for that touch parks/rec/playground equipment.
   - Bond referendums that include parks/rec funding.
   - School district or HOA construction news that would include a playground.
   If the rep asks to narrow to one category ("just bond referendums"), do only that one.
3. **Check the log** per the rules above and keep only genuinely new items.
4. **Present each new signal** as a short, dated, cited item: what happened, when, the source link, and
   one line on why it's relevant to the rep's product focus (a factual connection — e.g., "new park
   construction typically includes a playground scope" — not a pursue/pass recommendation).
5. **Update the log** with what was just reported.
6. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
