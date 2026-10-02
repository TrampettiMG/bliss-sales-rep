# Quickbase tools — reference

Confirmed against the Bliss app (realm `blissproducts.quickbase.com`, app `bgr44yubi`, "Bliss Sales & Projects Portal") on 2026-06-24. Counts and IDs are workspace **state**; the query language and the overflow behavior are tool **behavior** and hold regardless.

## Field IDs, not names

Quickbase addresses every field by a numeric **field ID** (fid), not its label. `select`, `where`, `orderBy`, and `groupBy` all take field IDs — you cannot query by label. So before you can query a table meaningfully you need its field map: get it once (via a subagent), store it in `tables.md`, and reuse it. Field `3` is the key (Record ID#) on every table — though its *label* can differ (on Quote Pipeline, field 3 is labeled "Quote #").

## The Quickbase query language (the `where` string)

Format: `{fid.OPERATOR.'value'}` — one clause per brace, combined with `AND` / `OR` between braces.

- Operators are **uppercase**; lowercase misbehaves.
- Single-quote values that contain spaces. Bare numbers and single words don't need quotes.

Common operators:

| Op | Means | Op | Means |
|---|---|---|---|
| `EX` | equals (exact) | `GT` / `GTE` | greater than / or equal |
| `XEX` | not equals | `LT` / `LTE` | less than / or equal |
| `CT` | contains | `BF` / `OBF` | before / on or before (date) |
| `XCT` | does not contain | `AF` / `OAF` | after / on or after (date) |
| `SW` | starts with | `IR` | in range (date) |

Examples (Bliss, field IDs illustrative — confirm against `tables.md`):

- One quote by Record ID: `{3.EX.79632}` on `bhp495xeb`.
- Quotes in a status: `{86.EX.'Quoted to Customer'}` (field 86 = Quote Status; see `tables.md` for its real choice values — note "AI Draft Ready" is **not** one of them today).
- Combine: `{<statusFid>.EX.'Bidding'}AND{<dateFid>.OAF.'2026-01-01'}`.

Dates: QB accepts `MM-DD-YYYY` and ISO `YYYY-MM-DD` in queries; results return ISO. Keep date handling explicit.

## query_records — the workhorse

Params: `table_id` (req), `select` (array of field-ID strings), `where` (query string), `orderBy` (array of objects — `[{"fieldId": N, "order": "ASC"|"DESC"}]`), `groupBy` (array of objects — `[{"fieldId": N, "grouping": "equal-values"}]`), `max_records` (number), `skip` (number), `paginate` (bool), `options` (object). The `orderBy` / `groupBy` entries are field-id **objects**, not bare IDs — shapes verified live 2026-06-24.

- **`select` is the single most important param.** No `select` → every field (~700 on Quote Pipeline). Pass only the field IDs you need.
- **`groupBy` does NOT aggregate on this MCP.** It returns the individual *rows*, grouped/sorted, capped at ~1000 per page (`hasMore: true` beyond that) — it does *not* return counts or sums. You can't answer "how many quotes per status" from one call. For a true aggregate, run a saved report (`run_report`), or delegate a subagent to page through with `skip` and tally.
- **`max_records` + `skip`** bound and page the result; set `max_records` on every call. Each page caps at ~1000 rows and **`paginate: true` does not auto-page** — to read past 1000 you issue successive calls with `skip`. The response's `totalRecords` is *not* the table's row count (it caps at the page size / your `max_records`); to get a true count, skip-probe to where `hasMore` is false (note: the max Record ID# overcounts — `btiessw29`'s max RID is 217,862 but it holds only 92,168 live rows).
- Response: rows keyed by field ID (each value wrapped as `{"value": ...}` — verified 2026-06-24), plus field metadata. Large results auto-save to a file — see the overflow catalog.

## run_report

Params: `report_id` (req), `options` (object). Executes a saved Quickbase report and returns its pre-shaped output. When the question matches a report someone already built (e.g. Winnie's monthly pipeline snapshots), this beats rebuilding the query. You need the report ID — get it from the table's Reports in QB, or from Winnie / Gregg.

## get_table_fields

Params: `table_id` (req), `field_type` (filter), `include_system` (bool). Returns the field list — id, label, fieldType, properties. On Quote Pipeline that's ~700 fields and it will overflow. **Delegate it.** Narrow with `field_type` or `include_system: false` where you can, and still return only the subset you mapped.

## get_field

Params: `table_id` (req), `field_id` (req). Detail on one field. Cheap — fine to call directly when you need a single field's type or properties.

## get_relationships

Params: `table_id` (req), `skip` (pagination). Returns the table's relationships in both directions — where it's the child (reference fields point to parents) and where it's the parent. **Returns IDs, not names** — table names must be inferred from field labels or a separate lookup. A one-to-many (parent → many children) is defined on the *child* table's side, so a parent's call may not list its children explicitly. Broad maps → subagent.

## list_tables

Params: `app_id` (optional — defaults to the configured app), `filter`, `include_hidden`. Returns every table's metadata (id, name, record/field counts, sizes, key field). **This overflowed at 61,551 characters on the first call this session.** Delegate it, or narrow with `filter`. Better still: you rarely need the whole list — you need a few table IDs, and those live in `tables.md`.

## download_file

Params: `table_id`, `record_id`, `field_id`, `output_path` (req), `version`. Downloads a file from a file-attachment field to `output_path` and returns a reference, not the bytes — so the call itself is light. Reading / parsing the downloaded file is the heavy step; hand that to a subagent that returns the extracted answer.

## test_connection / check_configuration

No params. `test_connection` confirms the realm/app and returns the connected app name; `check_configuration` confirms the env vars are set. Cheap health checks.

## configure_cache

Params: `enabled` (bool), `ttl` (number), `clear` (bool). Turns on caching for repeated reads within a run, or clears it. Useful when a job re-reads the same schema or records; don't rely on it for freshness-sensitive reads.

## Overflow / error catalog

| Symptom | Cause | Fix |
|---|---|---|
| `result (N characters) exceeds maximum allowed tokens. Output has been saved to …txt` | A call returned more than the context budget — `list_tables`, an unbounded query, a full field list | Don't read the saved file whole. Re-run the call narrowed (`select`, `where`, `max_records`, `filter`), **or** have a subagent `jq` / `grep` the saved file and return only the slice you need. |
| Query returns far more than expected | `query_records` with no `select`, or no `max_records` | Add `select` (field IDs) and `max_records`. |
| `where` matches nothing or errors | label used instead of field ID, lowercase operator, or unquoted spaced value | Use numeric field IDs, uppercase operators, single-quote spaced values. |
| Need a field ID you don't have | querying by label | Get the field map once via a subagent; store it in `tables.md`. |

The saved-to-file behavior is a safety net, not a workflow. If you hit it in the main agent you've already paid the context — next time, delegate or narrow up front.
