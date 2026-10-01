# QuickBase cross-reference procedure

Read before the cross-reference step of any run, and again whenever a call fails because a table or field
moved. SKILL.md carries the cross-reference behavior; this file carries the procedure and the query rules.

This skill file is public and carries no QuickBase IDs. Tables are referenced by **name**, never by ID:
Opportunities, Quote Pipeline, Sales Reps, County Sales Teams.

## First use — resolve and cache

- Resolve each table name to its table ID from the `quickbase-usage` skill's table list (never list all
  tables in QuickBase: the app is too large), and write the result
  into the rep's local `PROFILE.md` under a **QuickBase tables** section (table name → ID).
- Resolve the field IDs the same way, **by field label**, and cache those under the same section. Make **one
  targeted field lookup per table** — never a full field dump (Quote Pipeline has several hundred fields). The
  fields this tool needs are the opportunity's customer/jurisdiction, status, dates, owner link, and confidence.
- Later runs read the IDs from `PROFILE.md`; only re-resolve one if a call fails because it moved. If
  `PROFILE.md` has no such section yet, create it — never re-resolve on every run, and never write an ID
  anywhere except `PROFILE.md`.

## What to search

For each REAL lead: match the jurisdiction on its distinctive name, contains-style and case-insensitive
(QuickBase may store it as an all-caps `CITY OF …` name) first, then any **design firm or engineer named in
the public document**. The entity's own department record, such as its Parks & Recreation department, counts
as the jurisdiction. Schools, property managers, architects, and contractors do not count as the governing
entity; mention a related one briefly if relevant. A billing city alone is not a match. Match against
Opportunities and Quote Pipeline: opportunities only exist from about mid-2026, so older jobs may be
quote-only.

Jobs are sometimes quoted through a general contractor. Search quote and opportunity names for the park or
project name, but count it as the same job only when the place also matches by city or county on the quote or
customer. Park names repeat across states, so never match on a park name alone. Ignore test records: a customer, quote or job name that is
clearly a test ("TEST", "Test2", "Testing"). A real customer's quote entered under a test rep account still
counts; show its rep as "test account".

## Rules that always hold

- Every call uses `select`, `where`, and `max_records`. One lead's slice is bounded — pull it directly, never
  scan the whole table.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round a rep's number to something else, and never invent one.
- A lead already open in QuickBase is labeled **in pipeline**, never presented as new.

## Status before labeling

Read the status of the matching opportunity and every matching quote before choosing a label. A won quote
(`Order Submitted`, `Invoiced`, or `Commission Paid`) under an opportunity that still looks open is **won
before**. Use this precedence when statuses conflict: **won before** beats **in pipeline**, and **in pipeline**
beats **lost before**. Label a fully closed match with no won quote **lost before**, but show the raw QuickBase
status after the label when it is ambiguous (for example, `lost before — Close - Multiple Alternative`); never
assert "lost" merely from an ambiguous close status. If the status says an alternative was chosen, check that
customer's other quotes from about the same time for a won one.
