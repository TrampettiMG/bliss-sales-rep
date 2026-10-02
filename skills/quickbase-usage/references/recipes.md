# Quickbase recipes — common Bliss jobs

Each is the shortest path that keeps table-sized payloads out of the main context. The `SKILL.md` rules still hold: `select` always, bound the rows, push work server-side, delegate exploration and bulk. Field IDs written `<…>` aren't mapped yet — discover them once via a subagent (see `subagents.md`), then record them in `tables.md`.

## "Resolve the rep's QuickBase name" (run once, on first use of any sales tool)

The sales tools filter a rep's opportunities by their **Sales Rep 1** name, which must match QuickBase
exactly or the query silently returns nothing. Do NOT ask the rep to type their exact name; they often
don't know the exact spelling. Look it up and confirm:

1. Take whatever the rep gives — first name, last name, or partial (e.g. "Mike").
2. Query the Sales Reps table:
   `query_records {table_id: "bvgbefp6g", where: "{6.CT.'<what they typed>'}AND{10.EX.'Active'}", select: ["6","9"], max_records: 25}`
   Field 6 = Sales Rep name, 10 = Status, 9 = key. `CT` (contains) matches a first name, last name, or partial.
3. Drop the test records: "TEST Mike" and "Winnie TEST".
4. Then:
   - **One match** → confirm it: "I found Mike Schmidt in QuickBase. Is that you?" On yes, use it.
   - **Several matches** → list them and let the rep pick: "I found a few: Mike Schmidt, Mike Jones. Which one is you?"
   - **No match** → widen (try just the first few letters, or ask for the last name) and repeat. If still nothing, say so plainly and ask them to confirm the exact spelling with their trainer.
5. Save the confirmed exact name to `PROFILE.md` under `QuickBase Name:` so this only runs once. Every later
   tool uses that saved name.

Notes: the Sales Reps directory is readable by any token that can read the app, so this does not need an
admin token. If `{10.EX.'Active'}` ever filters out a valid rep (a status quirk), drop the status filter and
rely on excluding the two test records.

## "Pull the QC / bid fields for quote <#>"

Have the field IDs (`tables.md`) → direct:

1. `query_records {table_id: "bhp495xeb", where: "{3.EX.<#>}", select: ["<qc/bid field ids>"], max_records: 1}`

Don't have them yet → delegate schema discovery first (it returns a field map), store in `tables.md`, then run the direct call above.

## "All line items / bond amounts for quote <#>"

Bond amounts live on **Quote Lines (`bhq88xjum`)**, the child table — not on Quote Pipeline. The quote→lines one-to-many is defined on the line side, so query the lines table filtered to the quote:

1. `query_records {table_id: "bhq88xjum", where: "{<quoteRefFid>.EX.<#>}", select: ["<line desc>","<bond amount>", …], max_records: 100}`

No line-table field IDs yet → delegate discovery on `bhq88xjum` first.

## "Status history of quote <#>" / "pipeline counts by status"

Q/O Status Changes (`btiessw29`) is ~92K rows (verified 2026-06-24) — **never pull it whole**. Data starts 2023-08-18 only.

- One quote's history → `query_records {table_id: "btiessw29", where: "{<quoteRefFid>.EX.<#>}", select: ["<date>","<new status>"], orderBy: [{"fieldId": <date>, "order": "ASC"}], max_records: 50}`. A handful of rows is fine direct. (`orderBy` takes field-id *objects*, not bare IDs.)
- Counts across the pipeline → this MCP's `groupBy` does **not** return counts (it returns grouped rows, ≤1000/page). Run a saved report (`run_report`) that aggregates, or delegate a subagent to page through with `skip` and tally — never trust `totalRecords` as the total.

## "Permit history for jurisdiction <X>"

Permit Authorities (`btwte4vj4`) is the jurisdiction reference table — small (124 rows, verified 2026-06-24), so a direct query is fine; no subagent needed. It is **not** a QB relationship on Quote Pipeline; QP's field `633` ("Permit Authority Requirements", a `dblink` field — confirmed via `get_field` 2026-06-24) is an embedded report link, not a normal reference you can filter a parent through. Query `btwte4vj4` directly, filtered to the jurisdiction, returning only the fields you need.

## "How many quotes / what's in the pipeline" (any aggregate)

This MCP can't return a true server-side count — its `groupBy` returns grouped rows (≤1000/page), not totals, and `totalRecords` caps at the page size. Two real options: (1) `run_report` on a saved report that already aggregates; (2) delegate a subagent to page through with `select` + `skip` and tally in its own context, returning only the breakdown. Either way the main agent never holds the rows.

## "Run Winnie's pipeline report" (or any saved report)

`run_report {report_id: "<id>"}` — pre-shaped output, no query to build. Get the `report_id` from the table's Reports in QB, or from Winnie / Gregg. If the report itself is large, delegate the run and have the subagent return the summary.

## "What tables / fields exist here?"

Never `list_tables` / `get_table_fields` in the main agent — they overflow. Delegate (see `subagents.md`), have the subagent return a compact map, and write any new IDs into `tables.md` so the next session skips this.

## Pagination & bounding

- Always set `max_records`. Page with `skip` + `paginate` only when you must read past the first bound.
- If a result still overflows to a saved file, don't read it whole — re-run narrowed, or have a subagent `jq` / `grep` the file for the slice.
