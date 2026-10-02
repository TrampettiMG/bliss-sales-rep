# Bliss Quickbase — table & field appendix

The durable schema map. Extend it whenever a subagent discovers new IDs — that's how the skill avoids re-exploring. All counts and names verified live 2026-06-24 unless noted.

## Connection

- Realm: `blissproducts.quickbase.com`
- App: `bgr44yubi` — "Bliss Sales & Projects Portal"
- Auth: read-only user token (env vars). `check_configuration` / `test_connection` confirm it.
- The app holds **113 tables** — which is why `list_tables` overflows (61,551 chars on the first call). You rarely need the whole list; the IDs below cover the bid pipeline.

> ⚠ The app ID `bgr44yubi` and the Activities table ID `bgr44yuic` differ by two trailing characters. Don't transpose them.

## A note on counts (read before trusting any number here)

Quickbase's `nextRecordId` / `nextFieldId` (what `list_tables` exposes) and the `totalRecords` in a query response are **ID ceilings / page caps, not live counts** — they overcount, sometimes massively. Example: `btiessw29` has a max Record ID# of 217,862 but only **92,168** live rows (~125K were deleted over its life). The build's original "~940 fields / ~81K records / 215K rows" figures came from those ceilings; the corrected counts below come from a skip-probe (page to where `hasMore` is false). Re-probe before trusting these later.

## Core tables

| table_id | name | role | size / notes |
|---|---|---|---|
| `bhp495xeb` | Quote Pipeline | the spine — one row per quote | ~700 fields (701), **54,909** records. Key field `3` = Record ID# (labeled "Quote #"). Child in 25 of its 26 relationships. |
| `bhq88xjum` | Quote Lines | line items per quote (incl. bond amounts) | 120 fields, **279,133** records. Child of Quote Pipeline; query it filtered by the quote. |
| `btiessw29` | Q/O Status Changes | every quote status transition | **92,168** rows (max RID 217,862 overcounts). Data starts 2023-08-18 only. Never pull whole — filter and page. |
| `btwte4vj4` | Permit Authorities | jurisdiction reference list | **only 124 rows**, 28 fields — small; a direct query is fine. NOT a QB relationship on QP (see field 633 below). Strongest cross-client replication asset. |
| `bgr44yuic` | Activities | activity log | 7,894 records, 74 fields. |

## Parent tables referenced by Quote Pipeline

From `get_relationships` on `bhp495xeb`; names resolved against `list_tables` 2026-06-24. QP is the **child**; each parent is looked up via the linking field ID(s) on QP.

| table_id | name | QP linking field id(s) |
|---|---|---|
| `bgr44yuh9` | Customers | 179 |
| `bvgbefp6g` | Sales Reps | 850 (Rep 1), 842 (Rep 2) |
| `bhqpcitdz` | Sales Team | 49, 152 |
| `bt93rndvw` | Opportunities | 697 |
| `bhtcjajy9` | Customer Contacts | 57 |
| `bq9thrd25` | Anchor Orders | 401 |
| `bt69n97gn` | Updates | 686 |
| `btbgb68pg` | Staff | 671, 674 |
| `bhtcnbyas` | Vendors | 75 |
| `bhvt7vged` | Financing Rates | 126 |
| `bhvzwkpay` | OPT Payment Terms | 158 |
| `brpwfit2c` | OPT Coop Contracts | 442 |
| `buraka5tm` | Customer Locations | 918 |
| `bv2ngu6jt` | OPT PlayCore Periods | 905, 927 |
| `bq9kufjg9` | Zip Codes | 424 |
| `btiessw29` | Q/O Status Changes (summary lookups) | 524, 754, 822 |
| `bhq88xjum` | Quote Lines (summary lookups) | 175, 176 |

QP also self-references via field `231` ("Quote # mirror"). Total relationships: 26. (Earlier drafts inferred several names from field labels — now confirmed; the previously-wrong guesses were "Contacts", "Order Updates", "Install/Construction Staff", "Payment Terms", "Cooperative Contracts", "Shipping Addresses", "Postal Codes".)

## Known Quote Pipeline field IDs

All verified 2026-06-24 (via `get_table_fields` / `get_field`).

| field id | label | type | notes |
|---|---|---|---|
| 3 | Quote # | recordid | the key (QB Record ID#), here labeled "Quote #" |
| 86 | Quote Status | text-multiple-choice | the workflow status — choice values below |
| 73 | Grand Total | currency | the quote's dollar total ("total bid amount") |
| 806 | Bid Award $ Value | currency | use if "bid amount" means the award, not the quote total |
| 169 | Bid Due Date | date | also 548 = Bid Due Date/Time display (timestamp), 377 = Bid Due Time |
| 750 | Bid QC | user | closest field to "bid coordinator"; 751 = Bid QC Override |
| 156 | Internal Quote # | rich-text | a separate internal number, not the key |
| 231 | Quote # mirror | numeric | QP self-reference |
| 633 | Permit Authority Requirements | dblink | embedded report link (source 628 → target 629), **not** a normal reference field — confirmed via `get_field` |
| 175 | Min Record ID# of Lines Flagged as Primary Vendor | numeric | Quote Lines summary lookup |
| 176 | Record ID of line for Primary Vendor | numeric | Quote Lines summary lookup |
| 524 | Order Submitted Max Record ID# | numeric | Q/O Status Changes summary lookup |
| 754 | Most Recent Status Change Record ID# | numeric | Q/O Status Changes summary lookup |
| 822 | Quoted to Customer Max Record ID# | numeric | Q/O Status Changes summary lookup |

**Quote Status (field 86) choice values:** Opportunity - New · Opportunity - Pending · Quoted to Customer · Order Submitted · Invoiced · Commission Paid · Lost - Close Quote · Close - Multiple Alternative · Close - Quick Close · Cancelled.

> ⚠ As of 2026-06-24 there is **no** field literally named "Bid Coordinator" (closest is 750 "Bid QC"), and **no** "AI Draft Ready" value anywhere in Quote Pipeline (checked every field label, choice list, and formula). If the bid agent is meant to set an "AI Draft Ready" status, that value/field must be created in QB first — a Gregg/admin task. Don't query for it expecting rows today.

## Additions discovered 2026-07-13 (bliss-sales-reports field verification)

All on Quote Pipeline `bhp495xeb`, verified live via `get_table_fields` + a 50-row population probe on Quoted-to-Customer rows:

- **Sales rep for grouping: 850 "Related Sales Rep 1"** (numeric reference → Sales Reps `bvgbefp6g`, 50/50 populated); 842 = Related Sales Rep 2. **155 "Sales Rep(s)"** is a formula display string — multi-rep quotes are newline-joined, so use it for labels only, never grouping.
- **36 — Confidence — percent, formula** (50/50 populated; decimals 0–0.75, zeros are real). Composed from **943 "xx.Opportunity - Confidence"** (lookup from the Opportunity — the live entry point since ~6/26/26) and **953 "xx.Confidence Pre-6/26/26 Entry"** (legacy user-entered). Report off 36.
- **101 — Forecast Close Date — date, formula** (label includes "Date").
- **191 — Date Order Submitted — date, user-entered.**
- **Revision/copy markers:** **785 "xx.Copy From Quote #" is EMPTY table-wide (7/13 probe — zero populated records; unusable as a revision signal despite being the designed copy-source pointer).** 787 xx.Copy To Quote # Most Recent (inverse, on the original); 1000 Copy Status Most Recent (text); 440 Copy This Quote for This Opp Date/Time (timestamp, on source); 727 Copy of Bid? (checkbox, narrower); 996/997 xx.Copy From/To Opp RID Most Recent; 183 Multiple Alternatives (checkbox, not a revision link); 439 is a URL button, not data. No reliable revision marker exists today — the Opportunity grouping (697) is the closest substitute.
- **Opportunity dedup trio confirmed:** 697 Related Opportunity (numeric reference), 702 Opp - Count Toward Value (text formula), 921 Opp - Count Toward Value Override (text-multiple-choice, user-entered).

## Additions discovered 2026-07-15 (invoicing / CX-complete / shipping reports)

All on Quote Pipeline `bhp495xeb`, verified via field probe + 50-row population check on Order Submitted rows:

- **515 Construction Complete Forecast Date** / **516 Construction Complete Actual Date** — date summaries rolled up from an Order Milestones child table. 516 stays empty while open, populates by Invoiced. 319 Install Complete Date = legacy manual twin of 516 (mostly agrees, occasional 1-day drift).
- **Product-only has NO dedicated flag** — derive it: **326 "# Install Vendor Quote Lines" = 0 (or empty) ⇒ product-only.** (690 Install Coordinator Not Required is a checkbox but ~2% populated — unusable.)
- **610 Latest Estimated Ship Date** — date summary from a Vendor Shipping Info child; the live ship-date field (Porsche Knox enters these for product-only orders). 560/561 Material Shipped Forecast/Actual are 0-populated (unused); 17 Approximate Ship Date is free text ("ASAP"). **No populated actual-ship-date field exists.**
- **Dollars: 66 Subtotal Price Before Freight & Tax** (currency summary) + **108 Total Customer Freight** (numeric summary; 255 = identical formula mirror). **213 Subtotal Sell incl. Freight** = 66+108 in one formula field. **71 Tax** (rate × taxable base; override fid 160). **Grand Total 73 = 66 + 108 + 71** — subtotal-incl-freight understates every taxed order; 73 is THE total column.
- **Invoicing: 645 Total Amount $ Invoiced** (summary from Invoice Headers `bty3hdi98`), **829 Invoice #s** (multitext). ⚠ **NEVER use 871 "Outstanding $ To Invoice"**: 645 returns NULL (not 0) on never-invoiced quotes, so the 871 formula (GT − 645) is blank exactly where the answer is "the full amount." Compute outstanding yourself as GT − invoiced-with-blank-as-zero. 519 Invoice & Financial Close Actual Date is 0-populated; 495 Invoice Date RETIRED 9/14/25.
- 513/514 Construction Start Forecast/Actual; 506 # Open Order Milestones (No Actual) — fully populated, useful open-milestone signal.
- **Customer name is NOT on QP** — 179 is a numeric FK; resolve names against Customers `bgr44yuh9` fid 6 "Customer Name".
- Data-quality: 610 carries stale past dates and placeholder values (e.g. 2027-01-01); invoiced-to-date can exceed subtotal (tax/freight in invoices).

## Additions discovered 2026-07-15b (Opportunities table probe)

**Opportunities `bt93rndvw`** — 118 fields, key fid 3. The pipeline-native grain since the ~6/26 Opportunity rollout:

- **68 Opportunity Status** — formula (New / Pending / Quoted to Customer / Ordered / Closed), derived from quote counts. **QP statuses "Opportunity - New/Pending" hold ZERO quotes now** — early pipeline exists only here; legacy quotes restamped "Opp Transition … For Ref Only".
- **76 Sales Rep 1** (text lookup; 77 = QB-user twin), 79 Sales Rep 2 (~10% populated), 99 add'l reps (multitext summary).
- **20 Confidence** — percent, user-entered (0/25/50/75/99), the entry point QP fid 943 looks up. Default-0 pollutes weighted values.
- **18 Forecast Close Date** — date, user-entered (~82% populated on recent rows).
- **34 Opp Value Count – Subtotal Sell incl. Freight** — SUM of QP fid 213 where {702='Yes'} — the dedup-respecting dollar rollup. **31 Opportunity Value $** = 34 × Confidence (weighted). ⚠ basis is Subtotal-incl-Freight (213), NOT Grand Total (73); 73 only feeds 29/28 Quote Grand Total Min/Max. ~Half of recent opps show blank 34 (no quote flagged Count Toward Value, even some at QTC).
- **27 # Quotes** (count), 54 # Quotes with Count-Toward-Value override set, 7 Customer (lookup), 1 Date Created.
- Linkage from quote side: only 1 open QTC quote of 600+ lacks fid 697.

## Additions discovered 2026-07-16b (Quote Lines product type)

Quote Lines `bhq88xjum`: **156 "Product Type"** (text, effective value — resolves override-else-vendor; loaded ~7/9, 100% filled by construction), 157 "Product Type Override" (manual multiple-choice), 155 "Vendor - Product Type" (vendor lookup). **14 Quote #** (FK → QP fid 3), **16 Extended Price** (currency; null on note/subtotal lines, negatives = discounts), 8 Description, 9 Qty. Observed type values: Play Equipment / Labor / Miscellaneous / Shade / Shelter / Surfacing / Mulch — "install" = Labor; **Miscellaneous is a catch-all vendor mapping** (freight, bonds, subcontract — $22.2M of the open book), treat as unclassified.

## Additions discovered 2026-07-16 (Invoices child table resolved)

- **Invoice Headers `bty3hdi98`** — the Invoices child table QP fid 645 summarizes (previously unresolved). Fields: **13 invoice date**, **63 Total Amount Due** (the amount fid 645 sums), **6 related quote FK**, **12 invoice #** (free text — carries annotations like "PAID IN FULL", credit memos), 23 Void (645's summary query is `{23.XEX.1}`), 55 Invoice Status.
- Siblings: **Invoice Lines `bty3hgd67`**, **Invoice Payments `bty3h3hpd`**.
- Data-quality: credit memos appear as negative amounts; duplicate-looking invoice pairs exist (e.g. quote 81537, two identical $10,350 on 6/25); invoices sit on Order Submitted / Invoiced / Commission Paid quotes alike.

## Additions 2026-07-17 (consolidated from the bliss-sales-reports workstream, probes 7/13–7/16)

Supporting tables mapped while building the sales reports:

- **Sales Reps `bvgbefp6g`** — key fid 9, name fid 6, status fid 10. 24 real active reps. ⚠ **Test reps pollute groupings:** "TEST Mike" (rep 19) and "Winnie TEST" (rep 40) carry live quotes — exclude both from every rep report, rows AND totals.
- **Rep grouping rule (Nick, 7/16):** group by QP fid **850** Related Sales Rep 1 (resolve names via `bvgbefp6g` 9→6). **Never group by QP fid 155** — it newline-joins secondary reps and creates phantom "X / Y" rows.
- **Sales Budget Monthly Snapshots `bp8vub4tu`** — one row per rep per month-end, 2019-12 → present (~1,452 rows). fid 28 Snapshot Date; 6 rep FK; 7 rep name; **8 sales-goal baseline** (9 = LY goal; 42 revised goal — null for all reps in the 2026-06-30 snapshot); Quoted YTD $ 22 / count 24 (LY 23/25); Sales YTD $ 12 / count 10 (LY 13/11); GP$ 16/18. Cumulative YTD attainment that resets annually — NOT an open-pipeline-value snapshot. The goal source for business-review reports, and a ready-made LY-YTD anchor.
- **Q/O Status Changes `btiessw29` field map** — FK fid 6 → QP fid 3; fid 1 Date Created = transition timestamp; **fid 11 Status = the NEW status only** (no previous-status field — infer prior from the preceding row); $ snapshots fid 18 Grand Total / 12 GP$ / 17 Total Cost / 20 Subtotal Sell copied at row creation but **often NULL on open-stage rows**. The 2023-08-18 start date is a one-time bulk load (one row per then-open quote), not real history — true per-transition logging only after that date.
- **Customers `bgr44yuh9` extras** — fid 6 Customer Name; 54 Sales Rep (lookup of 53 → Sales Team) = assigned rep; **116 Billing Postal Code State** is the live state field (102/111 retired 5/14/26); 115 Billing Postal Code County populated (county-level territory joins); 110 Billing City + 112 Billing Zip labeled RETIRED but are the only populated billing city/zip (composite 138 empty; 101/103 are shipping).
- **Opportunity-link coverage:** 335/417 (80%) of June-2026 quotes carry fid 697 — a count-once/dedup filter must admit no-Opportunity quotes or it silently drops ~20%. fid 702 "Count Toward Value" defaults to the lowest-$ option per Opportunity (manual override 921).
- **fid 191 is a clean order filter:** all June-2026 orders sat in WON statuses (Order Submitted / Invoiced / Commission Paid) — no extra status condition needed when filtering by Date Order Submitted.

## Additions 2026-09-23 (contact + activity fields on Opportunities, for the rep tools)

On Opportunities `bt93rndvw` (verified live):

- **9 Customer Contact** (text, the contact's name), **10 Customer Contact Block** (rich-text: name +
  phone + email, formatted), **11 Customer Contact - Email** (email). Use these to show the rep who to call
  or email on an opp, and to hand a contact to draft-outreach / prep-call / research. Single-record read of
  the rep's own account, so it stays data-light.
- **2 Date Modified** (timestamp, last activity), **88 Most Recent Update Date** (date, last logged update),
  **92 # Updates** (count). Use for a "last touched N days ago" line. Caveat: on the bulk-import New rows
  the modified date is an import artifact, so pair it with the original-date field for real recency.
- The actual update note text lives in the **Updates** child table `bt69n97gn` (filter by the related
  opportunity). Only read it when the rep wants the notes themselves; a recency line doesn't need it.

## Record links (for tools that list opps and want a click-through)

To link a rep straight to a record in QuickBase, build the URL from realm + app + table + the record's ID#:

- Edit the record: `https://blissproducts.quickbase.com/nav/app/bgr44yubi/table/<tableId>/action/er?rid=<RID>`
- View the record: same with `action/dr?rid=<RID>`

For Opportunities (`bt93rndvw`): `https://blissproducts.quickbase.com/nav/app/bgr44yubi/table/bt93rndvw/action/er?rid=<RID>`.
Verified from a live record edit URL 2026-09-23. The rid is the record's field 3. The rep-facing tool skills
reference this pattern here rather than hardcoding these IDs (the tool skills live in the PUBLIC repo).

## Saved reports (for run_report)

- `229` on Quote Pipeline `bhp495xeb` — Mike's link in ClickUp task 86ajhyn4n ("include total amount invoiced field in all exports"); contents unverified, presumably the to-be-invoiced view.

`run_report` needs a `report_id`; the above is the only one recorded. This matters more than it looks: because this MCP's `groupBy` does **not** return true aggregates, a saved report is the cleanest path to pipeline counts/sums. When you learn a report ID (from the table's Reports in QB, or from Winnie / Gregg), record it here as `report_id — what it returns`. Until then, treat the run_report recipe as "needs a report ID first."

## Caveats

- **Counts overcount at the source** — see the note above. `totalRecords`, `nextRecordId`, and `nextFieldId` are not live counts; skip-probe for the truth.
- `get_relationships` returns IDs, not names — the parent-table names above were resolved against `list_tables` on 2026-06-24.
- A parent→many-children relationship (QP → many lines, QP → many status changes) is defined on the **child** table's side, so it may not surface in QP's relationship list. To get a quote's lines or status history, query the **child** table filtered by the quote.
- This MCP's `groupBy` returns grouped *rows* (≤1000/page), not counts/sums — for true aggregates use a saved report or page-and-tally (see `recipes.md` / `tools.md`).
- Field / record counts are 2026-06-24 snapshots; they drift.
