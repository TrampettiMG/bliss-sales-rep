# Quickbase recipes — common Bliss jobs

Each is the shortest path that keeps table-sized payloads out of the main context. The `SKILL.md` rules still hold: `select` always, bound the rows, push work server-side, delegate exploration and bulk. Field IDs written `<…>` aren't mapped yet — discover them once via a subagent (see `subagents.md`), then record them in `field-map.md`.

## "Who am I and what counties do I cover?" (rep setup / profile)

Used by the sales-rep setup to fill `PROFILE.md` without asking. Small, bounded reads — direct is fine.
Verified 2026-09-24 (the `_curuser_` match returns 0 rows on an admin token, as it should — a rep's own
token returns their record).

1. **Rep by login:** `query_records {table_id: "bvgbefp6g", where: "{11.EX._curuser_}AND{10.EX.'Active'}", select: ["9","6","7","25","24"], max_records: 2}`
   → fid 9 rep key, 6 name (exact — save as `QuickBase Name`), 7 email, 25 cell, 24 office. Cell/office are
   often blank — don't treat blank as an error.
2. **No match** (admin/shared token, or rep has no QB User set) → ask the rep only for their name as it
   appears in QuickBase — never suggest or list other reps' names, and don't scan the rep list to guess — then `where: "{6.EX.'<name>'}AND{10.EX.'Active'}"`. If that also returns
   nothing, return "not found" so setup asks the full questions. **Never pick a different rep**, and
   exclude test reps (any rep whose name contains "TEST") unless the trainer is deliberately testing
   as one.
3. **Counties:** `query_records {table_id: "buq6z9c6j", where: "{9.EX.<rep key>}AND{12.EX.'Active'}", select: ["7","8"], max_records: 200}`
   → fid 7 county, 8 state. **Page with `skip`** until `hasMore` is false — some reps have 100+ rows.
   Group by state; dedupe.
4. **No assignment rows** → fall back to the rep's customers: Customers `bgr44yuh9` where
   `{53.EX.<rep key>}`, select `["115","116"]`, page and tally county+state, most frequent first; ~12% of
   customers have a blank county — skip those. Label the result "based on your customers."

Return only: name, email, cell (if any), and the county list (or count + states if long).

## "Who covers this county?" (Research Brief outside-county header)

`query_records {table_id: "buq6z9c6j", where: "{7.SW.'<county base name>'}AND{8.EX.'<ST>'}AND{12.EX.'Active'}", select: ["7","8","10"], max_records: 5}`
→ 10 = the covering rep's name. Skip test reps (name contains "TEST"). No row: say nothing about who covers it.

## "My open opportunities, with contact and last activity" (Pipeline Check, New Leads, Forecast Helper)

Direct — one rep's slice. Rep filter: `{77.EX._curuser_}` on a rep token, else `{76.EX.'<QuickBase Name>'}`.

`query_records {table_id: "bt93rndvw", where: "<rep filter>AND({68.EX.'New'}OR{68.EX.'Pending'}OR{68.EX.'Quoted to Customer'})", select: ["3","23","7","68","18","20","34","27","1","2","88","9","11","10","17"], max_records: 300}`
→ 3 opp # (also the record-link rid), 23 name, 7 customer, 68 status, 18 forecast close, 20 confidence,
34 value, 27 # quotes, 1 created, 2 modified, 88 most recent update date, 9 contact name, 11 contact email,
10 contact block (phone lives here), 17 lead source. New Leads: status `New` only. Page with `skip` past 300.
Link each opp: `https://blissproducts.quickbase.com/nav/app/bgr44yubi/table/bt93rndvw/action/dr?rid=<fid 3>`.

**Ordered-quote check (Pipeline Check, Email Writer — added 9/25):** for opps with 27 > 0, one call:
`query_records {table_id: "bhp495xeb", where: "({697.EX.<opp1>}OR{697.EX.<opp2>}…)AND({86.EX.'Order Submitted'}OR{86.EX.'Invoiced'}OR{86.EX.'Commission Paid'})", select: ["3","697","86"], max_records: 300}`
(batch ≤ 20 opps per OR group). Any hit = opp has ordered quotes; its 68 status is likely stale (seen live: Opp
with 3 of 5 quotes Order Submitted still at Quoted to Customer).

## "Find the rep's quote/opportunity for customer X" (Call Prep, Email Writer, Bid Breakdown duplicate check)

Same query as above with the rep filter; for the Bid Breakdown duplicate check drop the status filter
(include Ordered/Closed). Match customer (7) / name (23) in the returned rows, not with a `CT` scan of the
whole table. Return only the matching rows (up to 3) — opp #, name, status, created, contact.

## "What's in the quote(s) on opportunity <opp #>" (Quote Details)

1. Quotes: `query_records {table_id: "bhp495xeb", where: "{697.EX.<opp #>}", select: ["3","86","73","1"], max_records: 20}`
   → 3 quote #, 86 status, 73 grand total, 1 created. Skip "For Ref Only" statuses. **Several quotes =
   likely options — never sum their totals.**
2. Lines per quote: the line-items recipe above (`{14.EX.<quote #>}`).
Link each quote: `…/table/bhp495xeb/action/dr?rid=<quote #>`.

**Find the customer id from a name** — Customers `bgr44yuh9`: `query_records {table_id: "bgr44yuh9", where: "{6.CT.'<distinctive name>'}AND{116.EX.'<ST>'}", select: ["3","6","68","115","116"], max_records: 10}`; 3 is the id for `{179.EX.<id>}`. Several records: take the governing entity, and name the record used in the brief.

## "Past customers with nothing open" (Pipeline Check check-in list)

Delegate to a subagent if the rep has a big book; return only the final list.

1. Won quotes in ~3 years for this rep: Quote Pipeline, `where: "{850.EX.<rep key>}AND({86.EX.'Order Submitted'}OR{86.EX.'Invoiced'}OR{86.EX.'Commission Paid'})AND{191.OAF.'<today minus 3 years>'}"`,
   `select: ["3","179","191","697"]`, page with `skip`. (850 = Related Sales Rep 1 — the rep grouping rule;
   quote history covers pre-rollout wins that Opportunities don't.) Keep the latest 191 per customer (179).
1b. Assigned customers too (approved 9/25 — assigned rep alone missed customers the rep sells to; rep-on-order
   alone misses assigned ones): Customers `bgr44yuh9` `{54.EX.'<QuickBase Name>'}` select ["3"] (54 = assigned
   Sales Rep lookup; verify the value format on first run), then their won quotes with step 1's status/date
   filter but `{179.EX.<customer id>}` in place of the 850 filter. Union with step 1. Drop customers whose
   latest won 191 is within ~6 months (recent buyers aren't check-ins).
2. Open opps for the same rep: the "my open opportunities" query, `select: ["6"]` → customer keys with
   something open. Drop those customers.
3. Names: Customers `bgr44yuh9` `{3.EX.<id>}` → fid 6 Customer Name (batch with OR, ≤ 20 per call).
   Project name: Opportunities fid 23 via 697 when present, else omit.
Return: customer, last won date, project name if any — sorted longest-ago first. Exclude test reps (name contains "TEST").

## "Pull the QC / bid fields for quote <#>"

Have the field IDs (`field-map.md`) → direct:

1. `query_records {table_id: "bhp495xeb", where: "{3.EX.<#>}", select: ["750","751","385","387"], max_records: 1}`

Don't have them yet → delegate schema discovery first (it returns a field map), store it in `field-map.md`, then run the direct call above.

## "All line items / bond amounts for quote <#>"

Bond amounts live on **Quote Lines (`bhq88xjum`)**, the child table — not on Quote Pipeline. The quote→lines one-to-many is defined on the line side, so query the lines table filtered to the quote:

1. `query_records {table_id: "bhq88xjum", where: "{14.EX.<#>}", select: ["8","9","16","156"], max_records: 100}`
   → 8 description, 9 qty, 16 extended price (null on note/subtotal lines, negative = discount), 156 product
   type. There's no bond field: bond lines are usually "Miscellaneous" (156) with "bond" in 8 — identify by
   text and say so.

## "Status history of quote <#>" / "pipeline counts by status"

Q/O Status Changes (`btiessw29`) is ~92K rows (verified 2026-06-24) — **never pull it whole**. Data starts 2023-08-18 only.

- One quote's history → `query_records {table_id: "btiessw29", where: "{6.EX.<#>}", select: ["6","1","11"], orderBy: [{"fieldId": 1, "order": "ASC"}], max_records: 50}`. A handful of rows is fine direct. (6 = Quote #, 1 = Date Created, 11 = Status. `orderBy` takes field-id *objects*, not bare IDs.)
- Counts across the pipeline → this MCP's `groupBy` does **not** return counts (it returns grouped rows, ≤1000/page). Run a saved report (`run_report`) that aggregates, or delegate a subagent to page through with `skip` and tally — never trust `totalRecords` as the total.

## "Permit history for jurisdiction <X>"

Permit Authorities (`btwte4vj4`) is the jurisdiction reference table — small (124 rows, verified 2026-06-24), so a direct query is fine; no subagent needed. It is **not** a QB relationship on Quote Pipeline; QP's field `633` ("Permit Authority Requirements", a `dblink` field — confirmed via `get_field` 2026-06-24) is an embedded report link, not a normal reference you can filter a parent through. Query `btwte4vj4` directly, filtered to the jurisdiction, returning only the fields you need.

## "How many quotes / what's in the pipeline" (any aggregate)

This MCP can't return a true server-side count — its `groupBy` returns grouped rows (≤1000/page), not totals, and `totalRecords` caps at the page size. Two real options: (1) `run_report` on a saved report that already aggregates; (2) delegate a subagent to page through with `select` + `skip` and tally in its own context, returning only the breakdown. Either way the main agent never holds the rows.

## "Run the pipeline report" (or any saved report)

`run_report {report_id: "<id>"}` — pre-shaped output, no query to build. Get the `report_id` from the table's Reports in QB, or from the sales ops team. If the report itself is large, delegate the run and have the subagent return the summary.

## "What tables / fields exist here?"

Never `list_tables` / `get_table_fields` in the main agent — they overflow. Delegate (see `subagents.md`), have the subagent return a compact map, and write any new IDs into `field-map.md` so the next session skips this.

## Research Brief / Lead Finder: bid history lookups (verified live 2026-09-30)

Used by the Research Brief's "Bliss history", "Similar jobs elsewhere", "Past customers nearby" and "Who won
their past bids" sections, and by the Lead Finder's one-line History. All read-only, all bounded.

**Budget:** these recipes carry every table and field ID the brief needs, so there is no discovery step and
no `get_table_fields` dump. Whole brief: about 16 bounded QuickBase queries. Run them directly. The one step worth a subagent, when the session has one, is Similar jobs step a; with no subagent tool, run it directly with max 60.
On a non-Lost status a blank 210 is normal; say nothing. On a Lost row read 210, then 807, and write "no reason on record" only when both are blank; any narrower pull of a Lost row re-selects both.

**Buyer history** — Quote Pipeline `bhp495xeb`
- select `[3,1,171,73,86,149,191,210,807,443,851,179,44]` (3 is only returned if selected).
- where `{179.EX.<customer id>}`; to catch department/duplicate records also run `{44.CT.'<distinctive name>'}`
  and keep only records that are the governing entity (contains-match also hits schools, churches,
  foundations; duplicate records often have a blank customer type). orderBy `[{fieldId:1,order:DESC}]`.
  **Two pulls so department records aren't crowded out:** main customer id max 20, then the name match
  excluding the main id (`{179.XEX.<main id>}`) max 10. If a pull hits its cap, say "N+ quotes".
- Test records: drop quotes whose customer or job name (44 / 171) is a test ("TEST", "Test2", "Testing").
  A real customer's quote under a test rep (851 name contains "TEST") stays in buyer history; show
  the rep as "test account". (Rep *reports* still exclude test reps entirely.)
- **Reason lost = 210 "Reason(s) for Loss"** (populated on Lost quotes). 807 "Bid Lost - Reason" is bid notes
  only, mostly empty. On a `Lost - Close Quote` row, show 210 Reason(s) for Loss when it has text; if 210 is blank, show 807 Bid Lost - Reason; write "no reason on record" only when both are blank. Any narrower pull of a Lost row re-selects both.
- 443 Cooperative Contract ("N/A" or a contract name; blank before ~2022). 149 Bid Type (Bid / GC Quote).
  851 "Sales Rep 1" = rep name directly (no join). 73 Grand Total (incl. tax; often 0 on closed alternatives).
- Opportunity close reason (Opp 104/106) is a picklist link/flag, not the reason text — don't use it.
- Cost: ~2.5K tokens for a small buyer; a big buyer (25+ quotes) ~7K — keep max_records 25.

**Product categories for a quote** — Quote Lines `bhq88xjum`
- select `[14,156,134,19,8]`, where `{14.EX.<quote #>}AND{35.EX.false}AND{40.EX.false}` (drops vendor notes and
  freight). For many quotes: `({14.EX.a}OR{14.EX.b}…)` in chunks of ≤30.
- **156 Product Type** has exactly 8 values: Play Equipment, Shade, Surfacing, Mulch, Shelter, Water, Labor,
  Miscellaneous. Map: Play Equipment → play; Shade → shade; Surfacing + Mulch → surfacing; Shelter → shelters;
  Water → water/splash; Labor (or 134 Install Line = true) → installation; Miscellaneous → other (mostly permit
  fees / estimate placeholders — ignore for matching).
- **No site-furnishings type:** furnishings and bleachers are filed as Play Equipment. Select 19 Vendor Name
  and 8 Description (strip control characters) with 156. Equipment test: a quote counts as **play** only if a Play Equipment
  line looks like playground equipment: a playground maker as vendor (e.g. GameTime, Playworld, Landscape
  Structures, BCI Burke, Kompan, PlayPower brands) or a description with play structure / playground /
  swing / slide / climber. Lines from furnishings or bleacher vendors, or descriptions like bench, table,
  receptacle, bike rack, bleacher, count as **site furnishings**. Say which rule decided it when unsure.
- `groupBy` does not dedupe or aggregate — pull `[14,156,19,8]` and dedupe/tally per quote with a script.

**Buyer type** — Customers `bgr44yuh9` fid 68 (lookup of 67 → OPT Customer Types `bhx2kxaad` fid 6, 33 values).
- City/parks set: City, County or City Government, Parks and Recreation, Park, Municipality.
- School set: School, College, PTA/PTO/PTSO. HOA set: Home Owner's Association, Property Management,
  Apartment. Church: Church (two ids).
- ~64% of customers have a blank type — a blank-type buyer can't be type-matched; say so and match on
  product + size only (see the blank buyer type rule in step b).

**Similar jobs elsewhere** (6 calls; ~8K tokens if step a is kept out of context)

Size window: half to double the Bliss-relevant scope line if the source states one, otherwise the first-year amount of a multi-year or recurring line, otherwise the whole project budget; name which one you used. A line spread over years where the whole line is the scope: use the whole line. Approved against requested: use approved and say so. Two lines: use the larger and say so.

- a) QP select `[3,179,73,86,191]`, where `{179.XEX.<lead customer id>}AND{191.OAF.'<today − 24 months>'}AND{73.GTE.<0.5×budget>}AND{73.LTE.<2×budget>}AND({86.EX.'Order Submitted'}OR{86.EX.'Invoiced'}OR{86.EX.'Commission Paid'})`, orderBy `[{fieldId:191,order:DESC}]`, max 150. **Won-only first**
  (about 100 rows for a mid-size window); add `{86.EX.'Quoted to Customer'}` only if fewer than 5 matches come back. Widening rows use fid 1 (`{1.OAF.'<today − 24 months>'}`), show fid 1 labelled "quoted", and label each "open quote"; an open-quote row is never a reference or proof line.
  **Loaded directly, 150 rows cost ~20K tokens** — in the main agent use max 60 (select only `[3,179,73,191]`),
  or hand steps a–c to a subagent that returns just the ≤5 survivors.
  Large results save to a file — tally with a script, don't
  load them. Sort the won-only pull on Date Order Submitted (191), newest first, filter the 24-month window on 191, and keep the first 30 that pass the size and buyer-type filters. **No budget known:** replace the 73 range with `{73.GTE.50000}` (skips parts / small orders, which otherwise fill all 60 slots within ~3 months), keep the lead-customer clause, last 24 months, max 60; the open-quote widening still applies if fewer than 5 won matches. Always state the date span the returned rows actually cover.
- **Hard cap: 30 candidates reach step c** — after step b, keep the 30 most recent (won first) and stop.
- b) Customers select `[3,68]`, where `(≤46 {3.EX.id} ORs)AND(<buyer-type set ORs>)` — chunk to stay under the
  **HTTP 413 "Too many criteria" limit (~50 criteria per where)**. Blank buyer type: lead's buyer blank: match candidates on product and size and drop names that look like a contractor or church; lead's buyer typed: drop blank-type candidates.
- c) QL select `[14,156,19,8]`, where `(≤30 {14.EX.q} ORs)AND{156.EX.'<category>'}AND{35.EX.false}` per required
  category, intersecting as you go (e.g. Shade, then Play Equipment on the survivors). Apply the equipment test to every survivor before counting it as play.
- Then read `[3,1,191,44,171,73,86,851,432]` for the ≤5 survivors to present them (191 = the order date shown; 432 = the state shown; blank means "state not recorded").

**Quote terms (deadlines in the rep's own quote)** — Quote Lines `bhq88xjum`
- select `[14,8]`, where `{14.EX.<quote #>}AND{35.EX.true}` (vendor-note lines carry terms), max 20; also scan
  8 on regular lines for "Valid Through", "expires", "free freight", "pricing good until". Strip control
  characters. Report the phrase and date exactly; don't compute a new date.

**Past customers nearby** (1 call, ~1.5K tokens)
- QP select `[3,191,44,171,73,851,431,432,179]`, where `{431.SW.'<county base name>'}AND{432.EX.'<ST>'}AND
  ({86.EX.'Order Submitted'}OR{86.EX.'Invoiced'}OR{86.EX.'Commission Paid'})AND{179.XEX.<own id>}`,
  orderBy `[{fieldId:191,order:DESC}]`, max 15. If fewer than 3 county rows survive the customer-type and equipment filters, rerun the same query with the county clause removed (`{432.EX.'<ST>'}` only), same select, orderBy and max_records; skip rows already kept and add rows up to 5 in all, each labelled "same state".
- Then one Customers call `select [3,68] where (<the returned 179 ids>)` to drop Contractor (and Architect /
  Landscape Company) customers, and one Quote Lines call `select [14,156,19,8]` for the survivors' product categories (same rules as
  above). Apply the equipment test to every survivor. Keep at most 2 jobs per customer. Test reps are excluded; say so in the opening line.
- 431/432 = the customer's **billing** county/state (lookups on QP). County naming varies ("Miami-Dade";
  "Virginia Beach" and "Virginia Beach City" both exist) — use `{431.SW.'<county base name>'}`. For
  contractors (GCs) the billing county isn't the job site — skip contractor customers or say so.
- Exclude test reps (851 name contains "TEST").

## Bid Breakdown: permits, bid checklist, bid timeline (verified live 2026-09-30)

All read-only, small, direct queries are fine (no subagent).

**Permit requirements for a jurisdiction** (2 calls, ~1.5K tokens)
- Step 1, Permit Authorities `btwte4vj4`: select `[3,30,26,7,29]`, where `{26.CT.'<name>'}AND{29.EX.'<ST>'}`,
  max 10. 26 = bare entity name ("Atlanta"), 7 = Authority Type (Federal/State/County/City/Township/Schools/
  Other), 29 = state (2-letter), 30 = full label ("City - Atlanta GA"). Use CT, not EX: names have trailing
  spaces, "City of …" prefixes, repeated states. Several matches (city vs county) → show the choices.
- **NEVER select 16/17/18 (Login URL / User Name / Password).** Also skip 8/9/10/11/14 (URL/report formulas).
- Step 2, Permit Authority Reqts `btwtfi5wb`: select `[17,18,20,14,11,13]`, where
  `{6.EX.<authority rid>}AND{12.EX.'Active'}`, orderBy `[{fieldId:18,order:ASC}]`, max 10. 6 = authority FK,
  17 = requirement type name (lookup, no join needed), 18 = type sort, **20 = Required This Authority
  (Yes/No/Pending)**, 14 = fee type (Flat/Percentage/TBD/N/A), 11 = fee description, 13 = # days to issue.
- **Every authority gets 7 auto-created rows, mostly "Pending" and blank.** Only `20 = Yes` is a real
  requirement; report Pending as "not confirmed," never "required." Fid 12 "# Active Requirements" on the
  authority is 7 almost everywhere — meaningless.
- **Leave 10 Notes/Timeline out** by default (long append-only log with staff names and third-party emails).
  If needed, fetch for the Yes rows only and summarize without names or emails. Skip 21 ALERT and retired 8.
- Type names (OPT Permit Requirement Types `btx8hq5tw`, 7 rows): Permitting · Zoning · Outside CPSI or ENG
  Inspection · Environmental · Permit Management Fee · Contractor Registration · Business Tax License.

**Bliss bid checklist item names** (OPT Bid Checklist Items `btknvxkvy`, 28 rows, static — map document
requirements to these without a query): Scope of work · Bid Instructions · Manufacturers Spec'd ·
Alternative/Substitutes · Factory certified installer required · MWBE Requirements · Bond Requested · Bid Bond
· Payment Bond · Performance Bond · Maintenance Bond · Bond Amount · Bond Issued · Bond Closed · Davis Bacon
required · Everify required · Sub Contractor pre-approval · Liquidated Damages · Permit Required · CPSI
Inspection · Special Inspection · Temporary fencing · Insurance Requirements · Progress Payments allowed ·
Vendors who require deposits · Addendum Acknowledgement · License Requirements · Other.

**A quote's bid checklist** — Bid Checklist `btknw7tjd` (only when the bid already has a Bliss quote)
- select `[7,8,9,10]`, where `{11.EX.<quote #>}AND({8.EX.'Yes'}OR{9.XEX.''})`, orderBy 10 ASC, max 25.
  11 = Quote #, 7 = item name (lookup), 8 = Required (Yes/No), 9 = Details, 10 = sort. No status field.
- Details is often filled with Required blank — hence "Yes OR has details". Every quote has 28 rows. Details
  can run ~2K characters (pasted insurance clauses) — summarize. ~800 tokens without 9, ~4K with.

**Bliss bid timeline item names** (OPT Bid Timeline Items `buea3c8jx`, 18 rows, static): Alternate/Substitute
Request Deadline · Bid Pre-Submittal Meeting · Bid Pre-Approval Deadline · Bid Questions Deadline · Bid Bond
Requested Date · Bid Bond Issued Date · Bid Bond Closed Date · Substitution Deadline · Drawing Request ·
Drawing Received · Vendor Pricing Requested · Pricing Received · Bid Compiled · Mandatory Pre-Bid · QC
Check/Approval · Sales Team Bid Review/Approval · Executive Bid Review · Bid Submitted.

**A quote's bid timeline** — Bid Timeline `buea4c7p8`
- select `[10,11,12,36,13,22]`, where `{6.EX.<quote #>}`, orderBy 11 ASC, max 25 (~1.5K tokens, ~18 rows).
  10 = item name, 12 = Due Date (formula: override if set, else computed from bid due / created date, weekends
  moved to Friday), 36 = time of day, 13 = Actual Date, 22 = Override (set = entered by hand).
- A computed 12 is not a confirmed date — the documents' dates win; say which is which. Actual Date is often
  blank even on old quotes. Skip 14 Comments and 27 RYG (HTML images).

## Pipeline Check today mode: quote terms and bid timeline

The Daily run's "Today's follow-ups" and "Bid deadlines this week" use two lookups that live under other
headings above. Use them as written:
- **First, the rep's open quotes** (one call): Quote Pipeline `bhp495xeb`, select `[3,171,86,149,169,697]`,
  where `{851.EX.'<QuickBase Name>'}AND{86.EX.'Quoted to Customer'}`, max 50. 3 = quote #, 149 = Bid Type
  (Bid / GC Quote), 169 = Bid Due Date, 697 = its opportunity.
- **Quote terms:** the "Quote terms (deadlines in the rep's own quote)" lookup in the Research Brief section,
  once per open quote from that call (at most 5, newest first). Quote the phrase and date exactly.
- **Bid timeline:** the "A quote's bid timeline" lookup in the Bid Breakdown section, once per open quote
  whose 149 is Bid (at most 10). Keep items with a Due Date in the next 7 days and no
  Actual Date; a Due Date without an Override is calculated, so say "calculated in QuickBase, confirm the real
  date."
- Nothing found is an empty section, not an error.

## Pagination & bounding

- Always set `max_records`. Page with `skip` + `paginate` only when you must read past the first bound.
- If a result still overflows to a saved file, don't read it whole — re-run narrowed, or have a subagent `jq` / `grep` the file for the slice.
