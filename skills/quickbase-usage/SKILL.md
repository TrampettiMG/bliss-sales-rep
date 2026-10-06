---
name: quickbase-usage
description: >
  Use the read-only Quickbase MCP (mcp__quickbase__*, Bliss's "Sales & Projects Portal"
  app) without blowing out the main agent's context. Bliss QB tables are huge: Quote
  Pipeline alone has ~700 fields and tens of thousands of records, so one careless query,
  or even list_tables, overflows the context limit. The fix: hand exploration and bulk
  reads to a subagent that returns a compact digest; use select / where / max_records on
  every call. Use whenever a task touches Quickbase: reading a quote, QC or bid fields,
  line items or bond amounts, quote status history, permit / jurisdiction history, running
  a QB report, or exploring tables and fields. Trigger phrases: "Quickbase", "QB", "set yourself up", "who am I", "my counties", "my territory",
  "my pipeline", "my new leads", "quote details", "what's in this quote", "past customers", "check in with",
  "mcp__quickbase__", "query_records", "run_report", "get_table_fields", "Quote Pipeline",
  "Q/O Status Changes", "Quote Lines", "Permit Authority", "bond amount", "bhp495xeb",
  "blissproducts.quickbase.com".
---

# Quickbase MCP usage (Bliss)

The `mcp__quickbase__*` tools (in Cowork they may show under the QuickBase read-only extension's own prefix; same tools) are a read-only MCP wired to Bliss's Quickbase — realm `blissproducts.quickbase.com`, app `bgr44yubi` ("Bliss Sales & Projects Portal"). Ten tools that query records, run reports, read schema, and download field files. Nothing here writes, so there is no destructive step to gate.

The problem this skill solves is not *how* to call the tools — it's that the tables are enormous and the payloads are merciless. Quote Pipeline (`bhp495xeb`) carries ~700 fields and ~55K records; Q/O Status Changes (`btiessw29`) holds ~92K rows (counts verified 2026-06-24). A `query_records` with no `select` returns every field on every row. `list_tables` returned 61,551 characters across the app's 118 tables and overflowed the token limit on the first call of this session. Drag one of those into the main agent and the context the user's actual ask needs is gone.

So the discipline is: **keep table-sized payloads out of the main agent's context.** Two moves do almost all the work — delegate the heavy reads to a subagent, and narrow every call with the server-side levers.

## The rule — delegate exploration and bulk

The main agent stays clean. A subagent does the heavy reads in *its* context and hands back only the answer.

- **Schema exploration** (`list_tables`, `get_table_fields`, broad `get_relationships`) → subagent. These overflow; they do not belong in the main context.
- **Any broad or multi-record pull, any aggregate, any scan** → subagent.
- The subagent returns **only a compact digest** — the answer, a count, the specific rows/fields asked for, or a field map. Never raw records, never a full field list.
- The main agent **may** make a small, bounded direct call: a known table, an explicit `select` of field IDs you already have, a `where` that targets a handful of records, a small `max_records`. See the decision below.
- **When in doubt, delegate if you have a subagent tool; otherwise make a bounded direct call.** An extra subagent is cheap; an overflowed context is not. (Proof: mapping the Quote Pipeline relationships this session cost one subagent ~65K tokens and returned ~250 words.)

→ How to brief a subagent and what a good return looks like: **read `references/subagents.md`** before dispatching one.

## Step 0 — is Quickbase even the right surface?

- **Read Bliss quotes, lines, statuses, permit history, activities** → Quickbase (this skill). Read-only.
- **Writing to QB** — drafting QC fields, updating a quote — is **not** this MCP. That path is n8n / the Quickbase API / a human typing. See the `bliss-bid-automation` project. This skill never writes.
- **Tasks / sprints** → ClickUp. **Meetings / what was said** → Krisp. Don't reach into QB for those.

## The one decision

**Are you exploring / pulling at volume, or do you have a known, narrow target?**

- **Exploring or bulk** — you don't know the table or field IDs, you need many rows, you need a count or aggregate, or you're scanning → **spawn a subagent** with a tight brief and read its digest.
- **Known and narrow** — a specific table, field IDs you already have (from `references/field-map.md`), a `where` that hits a few records → **call `query_records` directly** with explicit `select` + `where` + small `max_records`.
- **Unsure** → delegate if you have a subagent tool; otherwise make a bounded direct call.

## The context levers — on every call, yours or the subagent's

1. **`select` always.** `query_records` with no `select` returns every field (~700 on Quote Pipeline). Pass the field IDs you need and nothing else.
2. **Bound the rows.** Set `max_records`. Page with `skip` / `paginate` only when you must. Never pull a whole table to answer a narrow question.
3. **Push work to the server where the tool supports it.** `where` filters server-side — use it. But on this MCP **`groupBy` does *not* return counts or sums** — it returns grouped *rows*, capped at ~1000 per page, and the response's `totalRecords` is *not* a table total. So you cannot get a true "count by status" from one `query_records` call. For a real aggregate, delegate a subagent to page through and tally (`run_report` has returned HTTP 400 since 2026-08-13). Never treat one `groupBy` page or `totalRecords` as a full count.
4. **Don't explore in the main agent.** `list_tables` and `get_table_fields` overflow. Delegate, then store the IDs you learn in `references/field-map.md` so you never re-explore.

## Tool map (read-only)

| Tool | Use it for | Context note |
|---|---|---|
| `query_records` | The workhorse — rows from a table by `where` | **Always `select`.** Always `max_records`. `groupBy` returns grouped *rows* (≤1000/page), **not** server-side counts — see lever 3. |
| `run_report` | Execute a saved QB report by `report_id` | ⚠ Broken since 2026-08-13 (HTTP 400). Replicate with `query_records`. |
| `get_relationships` | Map a table's parents / children | Returns IDs, not names. Broad ones → subagent. |
| `get_table_fields` | The field list for a table | **Huge** (~700 on Quote Pipeline) → subagent; store the map. |
| `get_field` | Detail on one field by ID | Cheap. Fine direct. |
| `list_tables` | Every table in the app | **Overflows** — delegate, or narrow with `filter`. |
| `download_file` | Pull a file from a file-attachment field | Writes to `output_path`, returns a reference. Parsing the file → subagent. |
| `test_connection` / `check_configuration` | Health / config checks | Cheap. Fine direct. |
| `configure_cache` | Cache repeated reads (`enabled`, `ttl`, `clear`) | Use when re-reading the same data in a run. |

→ Per-tool parameters, response shapes, the Quickbase query language (operators, `{fid.OP.'value'}`), and the overflow / error catalog: **read `references/tools.md`**.
→ **Scheduled and repeat runs (the Daily run, pipeline checks, the setup check): read only this page and
`references/recipes.md`.** The recipes carry the table and field IDs they need. Open `field-map.md`,
`tables.md`, `tools.md` or `subagents.md` only if a call errors or no recipe covers the job — they cost
~15K tokens together.
→ Sequenced flows for the real Bliss jobs — rep setup (who am I + my counties), who covers a county, the rep's open opps with contact / last activity / record links, finding a rep's opp for a customer, quote details for an opp, past customers with nothing open, a quote's QC fields, line items / bond amounts, status history, permit lookup, the Research Brief bid-history lookups (buyer history, similar jobs, nearby customers), the Bid Breakdown lookups, and the Pipeline Check today-mode lookups (quote terms, bid timeline): **read `references/recipes.md`**.
→ Known Bliss table IDs and field IDs (so you skip exploration): **read `references/field-map.md` first**, then **`references/tables.md`** for anything the field map doesn't cover (the field map has the full 9/29 map: all 118 tables by group, key fields per table, every status value, query rules, conflicts).
→ ⚠ **Never select or export credential fields:** Permit Authorities `btwte4vj4` fids 16/17/18 and Quote Permits `bsce9f3yv` fids 44/45/46 hold logins and passwords.

## Reference files

- `references/subagents.md` — the delegation playbook: when to delegate, which agent type, the brief template, what to forbid the subagent from returning, example briefs. Read before dispatching a Quickbase subagent.
- `references/tools.md` — every tool: parameters, response shape, the Quickbase query-language operators, and the error / overflow catalog (the "exceeds maximum allowed tokens, saved to file" behavior and how to triage it). Read for any non-trivial call or when a call errors.
- `references/recipes.md` — copy-paste flows for the common Bliss jobs, each routed to the right path (direct vs. subagent). Read when doing one of those jobs.
- `references/field-map.md` — the compact live field map (2026-09-29): table groups with dbids, key fields and gotchas, status values, query rules, and source conflicts. Where it and tables.md disagree, field-map.md is newer.
- `references/tables.md` — the Bliss app appendix: realm, app ID, known table IDs, and the field IDs mapped so far. Read when you need a table or field ID; extend `field-map.md` whenever a subagent discovers new IDs.
