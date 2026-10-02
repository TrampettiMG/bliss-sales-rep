# Delegating Quickbase work to subagents

The point: a subagent has its own context window. Let it absorb the table-sized payload and take back only the answer. This is the same orchestrator + retrieval-subagent pattern the `daily-eod-report` project uses for Krisp and Teams, pointed at Quickbase.

## When to delegate

- Any schema exploration — `list_tables`, `get_table_fields`, a broad `get_relationships` map.
- Any multi-record pull, any aggregate / count, any scan ("find which records…").
- Parsing a downloaded file (`download_file` returns a path; reading it is the heavy step).
- Triaging a result that already overflowed into a saved `.txt`.

Keep it direct (no subagent) only for: a single record or a handful by known IDs with an explicit `select`; one `get_field`; `test_connection` / `check_configuration`.

## Which agent type

- **`general-purpose`** — the default. It has the `mcp__quickbase__*` tools and can run bash (for `jq` / `grep` on saved files). Matches the EOD retrieval-subagent pattern.
- **`Explore`** — read-only; fine for pure lookups. Quickbase is read-only anyway, so either works — default to `general-purpose` for flexibility.
- **Parallelize independent pulls.** Spawn several in one batch (one per quote, one per table). There's no global-account constraint here the way there is on `ms365`, so concurrency is safe.

## The brief — every subagent gets all five

1. **Context:** "You have `mcp__quickbase__*` (read-only) on the Bliss app — realm `blissproducts.quickbase.com`, app `bgr44yubi`."
2. **The exact job:** table ID(s), the `where` clause (field IDs + operators), the field IDs to `select`, what to compute. Hand it the IDs from `tables.md` so it doesn't re-explore.
3. **The levers:** "Use `select` (only these fields), `max_records`, and `where` to keep it server-side. Do not pull the whole table. Note: this MCP's `groupBy` returns grouped *rows*, not counts — to tally, page with `skip` and count in your own context."
4. **Exactly what to return, plus a cap:** "Return only <the digest: these counts / these rows / this field map>. Keep your reply under ~300 words."
5. **The prohibition:** "Do NOT paste raw records, full field lists, or the full tool output. Summarize in your own context and hand back only the answer."

Without #4 and #5 the subagent dumps the payload into *its* reply — which lands right back in your context and defeats the point.

## What a good return looks like

- A count / aggregate: "By status — Quoted to Customer 412, Order Submitted 38, Invoiced 1,204 …" (tallied by paging through — this MCP's `groupBy` doesn't return counts)
- The specific rows asked for, trimmed to the requested fields.
- A field map: "Quote Pipeline field IDs — 3 Record ID#, 633 Permit Authority link, …"
- A short structural digest (like the relationship map in `tables.md`).

Never a wall of JSON.

## Example briefs

**Schema discovery — you don't have the field IDs:**
> You have `mcp__quickbase__*` (read-only, Bliss app `bgr44yubi`). On table `bhp495xeb` (Quote Pipeline, ~700 fields), find the field IDs for the fields you need. Use `get_table_fields`; absorb the full list yourself. Return ONLY a markdown list of `field_id — label — type` for those fields. Under 200 words. (The common ones — quote #, status, bid amount, due date, Bid QC — are already mapped in `tables.md`; use this brief shape when you hit genuinely new fields.)

**Aggregate — count without pulling rows:**
> You have `mcp__quickbase__*` (read-only). On `bhp495xeb`, count quotes by current status (field `86`) created on or after 2026-01-01 (field `<dateFid>`). This MCP's `groupBy` doesn't return counts, so page through with `select: ["86"]` + a `where` on the date + `skip` (≤1000 rows/page), tallying by status in your own context. Return ONLY the status→count list. Under 150 words.

**Targeted extract — a few quotes, a few fields:**
> You have `mcp__quickbase__*` (read-only). On `bhp495xeb`, pull three quotes by number (`{3.EX.<q1>}OR{3.EX.<q2>}OR{3.EX.<q3>}`). `select` only fields `<a,b,c>`. `max_records` 10. Return ONLY a compact table of those fields per quote. Under 200 words.

**Triage an overflowed file:**
> A `list_tables` result overflowed and was saved to `<path>`. Using bash (`jq` / `grep`), extract only the `table_id` and `name` for tables whose name contains "Quote" or "Permit". Return ONLY that list. Do not print the file.

## The proof

Mapping the Quote Pipeline relationships this session: one `general-purpose` subagent absorbed ~65K tokens of relationship JSON and handed back a ~250-word table. That ratio is the whole reason to delegate.
