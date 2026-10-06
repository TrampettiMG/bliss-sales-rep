# QuickBase cross-reference procedure

Read before the cross-reference step of any run, and again whenever a call fails because a table or field
moved. SKILL.md carries the cross-reference behavior; this file carries the procedure and the query rules.

The QuickBase IDs live in the QuickBase setup file (the `quickbase-usage` skill), not here. Tables are
referenced by **name**, never by ID: Opportunities, Quote Pipeline, Sales Reps, County Sales Reps. A record
link may carry table IDs inside its URL; never print a bare table or field ID.

## Queries

Use the QuickBase setup skill's recipes: they carry the table and field IDs, so there's nothing to look up
first. Never list all tables or dump a table's fields (Quote Pipeline has several hundred). Keep the
cross-reference to the bounded queries the recipes give, with `select`, `where` and `max_records` on every
call. Run the queries directly; with a subagent tool, only a large candidate pull is worth handing off.

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
customer. Park names repeat across states, so never match on a park name alone. Ignore test records: a customer,
quote or job name that is clearly a test ("TEST", "Test2", "Testing"). A real customer's quote entered under a
test rep account still counts, once; show its rep as "test account" and never attribute it to the rep. Every `$0`
row under a test rep collapses into one line, whatever its status. A test-account row with money in it is listed
and labelled "test account". The History count reads "N quotes since [year] (plus M test-account entries not shown)"; the
collapsed entries are not in N. This is the one counting rule for a buyer's quote history, shared with the Research Brief: count every quote for the buyer except those test records. If a count differs from one an earlier tool showed in
this conversation, use the newer one and say so in one line.

## Label scope

The label describes **this lead's project or site**. `in pipeline`, `won before`, `lost before` and `Close -
Multiple Alternative` apply only to a quote or opportunity for this project or site. Everything else — other
projects, old parts or furnishings orders with the same buyer — is `new`, followed (when QuickBase has any) by
one line: "Past orders with this buyer: N, last [year], [categories]." On a lead that gets a History line, the
History line carries that count instead; never both.

## Rules that always hold

- **Dates:** show fid 191 labelled "ordered" when the row has one; otherwise show Date Created (fid 1) labelled "quoted". The buyer-history select includes fid 191.
- **Nearby fallback:** when the county yields fewer than 3, keep the county's rows and add same-state rows up to 5, labelled "same state".
- **Find the customer id from a name:** use the setup skill's 'Find the customer id from a name' recipe, then pass the governing entity's fid 3 into the buyer-history query; do not improvise a whole-table name scan.
- Every call uses `select`, `where`, and `max_records`. One lead's slice is bounded — pull it directly, never
  scan the whole table.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round a rep's number to something else, and never invent one.
- A lead already open in QuickBase is labeled **in pipeline**, never presented as new.
- A Cancelled quote for this project or site is not a closed label. The label is `new`, with one line: "A Cancelled quote exists for this site ([year], [reason, or 'no reason on record'])." An open opportunity that can't be tied to this project by name or site is `new`, with a line naming it.

## Status before labeling

Read the status of the matching opportunity and every matching quote before choosing a label, and show
statuses verbatim as stored (e.g. "Close - Quick Close (no reason)"). A won quote
(`Order Submitted`, `Invoiced`, or `Commission Paid`) under an opportunity that still looks open is **won
before**. Use this precedence when statuses conflict: **won before** beats **in pipeline**, and **in pipeline**
beats the two closed labels. A fully closed match with no won quote gets one of two labels: **`Close -
Multiple Alternative`** (shown exactly like that) when that's how its quotes closed, or **lost before** when
QuickBase records it as lost. If both appear, use **lost before** and add the other status after it. Never
call `Close - Multiple Alternative` a loss. If the status says an alternative was chosen, check that
customer's other quotes from about the same time for a won one. A label for an open match names whose it is:
**in pipeline (yours)** or **in pipeline ([rep])**. If another rep has an open quote or opportunity for this
same project but a higher label wins (for example `won before` for an earlier phase), add it after the label
(`won before · open quote: [rep]`): the "check with another rep first" stop still applies.
