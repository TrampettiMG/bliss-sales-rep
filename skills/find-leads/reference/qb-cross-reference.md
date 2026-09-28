# QuickBase cross-reference procedure

Read before the cross-reference step of any run, and again whenever a call fails because a table or field
moved. SKILL.md carries the cross-reference behavior; this file carries the procedure and the query rules.

This skill file is public and carries no QuickBase IDs. Tables are referenced by **name**, never by ID:
Opportunities, Quote Pipeline, Sales Reps, County Sales Teams.

## First use — resolve and cache

- Resolve each table name to its table ID with the QuickBase extension's table listing, and write the result
  into the rep's local `PROFILE.md` under a **QuickBase tables** section (table name → ID).
- Resolve the field IDs the same way, **by field label**, and cache those under the same section. Make **one
  targeted field lookup per table** — never a full field dump (Quote Pipeline has several hundred fields). The
  fields this tool needs are the opportunity's customer/jurisdiction, status, dates, owner link, and confidence.
- Later runs read the IDs from `PROFILE.md`; only re-resolve one if a call fails because it moved. If
  `PROFILE.md` has no such section yet, create it — never re-resolve on every run, and never write an ID
  anywhere except `PROFILE.md`.

## What to search

For each REAL lead: the **jurisdiction** name first, then any **design firm or engineer named in the public
document** — a project can surface through its firm when the city alone wouldn't have. Match against
Opportunities and Quote Pipeline.

## Rules that always hold

- Every call uses `select`, `where`, and `max_records`. One lead's slice is bounded — pull it directly, never
  scan the whole table.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round a rep's number to something else, and never invent one.
- A lead already open in QuickBase is labeled **in pipeline**, never presented as new.
