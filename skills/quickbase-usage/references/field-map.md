# Bliss Quickbase field map (compact)

Live schema pulled 2026-09-29 via the read-only QB MCP; history through 2026-09-29. App `bgr44yubi` (Sales & Projects Portal, blissproducts.quickbase.com), 118 tables, 3,844 fields. The full dictionary (every field, relationships, picklists, reports, bugs) lives in the trainer's `Bliss Quickbase Table & Field Map 2026-09-29.xlsx`; it is not shipped with this skill.

Trust: live schema = what exists; history = meaning and rules; transcripts = intent (speaker labels unreliable). Where sources disagree see Conflicts below. Credential caveat: Permit Authorities (`btwte4vj4`) fields 16/17/18 (Login URL / User Name / Password) and Quote Permits (`bsce9f3yv`) 44/45/46 hold credentials. Never select or export them.

## Table groups (dbid)

**Spine (12):** Opportunities `bt93rndvw`; Quote Pipeline (QP) `bhp495xeb`; Quote Lines (QL) `bhq88xjum`; Quote Line Revisions `bthutcwpu`; Q/O Status Changes `btiessw29`; Quote Locations `busynng3c`; Quote Notes `bhx2rxfw7`; Quote Documents `bhx2tpadd`; Quote/Opp Addl Reps `bvgbtgwsq`; Opp Changes `bua3a3nb9`; Updates `bt69n97gn`; Activities `bgr44yuic`.
**Customers (5):** Customers `bgr44yuh9`; Customer Contacts `bhtcjajy9`; Customer Locations `buraka5tm`; Customer Documents `bjcunhh29`; Anchor Orders `bq9thrd25`.
**Sales & Territory (8):** Sales Team `bhqpcitdz`; Sales Reps `bvgbefp6g`; County Sales Reps `buq6z9c6j`; Sales Territories `bnxpf938y`; Sales Budget Monthly Snapshots `bp8vub4tu`; Sales Goal Revisions `buu8swhpc`; Sales Team Activities `bvqtydfku`; Current Sales Team Record Record ID# `bhuv4qfsg`.
**Bids & Permits (7):** Bid Checklist `btknw7tjd`; Bid Timeline `buea4c7p8`; High Risk Approvals `bue6ccnce`; Quote Permits `bsce9f3yv`; Permit Authorities `btwte4vj4`; Permit Authority Reqts `btwtfi5wb`; Permit Authority Contacts `btwtfvuny`.
**Installation & Projects (24):** Order Milestones `btdwpuzde`; Scheduled Installations `bj6zbvv8k`; Sch Installation Notes `bp5rkhd94`; Installers `bj6zbqkqe`; Installer Contacts `bta5rkjsf`; Installer Documents `bpcmyx677`; Installer Reviews `bt6k8umse`; Installer Updates/Files `bs9bac2qk`; Installer Closeout Photos `btk8w5wzn`; Quote Docs for Installers `bta5y7xih`; Locates `btpg2n3vg`; Issues `bpbrbcq9j`; Tracking Sheet `bpbq5mk7n`; Tracking Sheet Notes `bp5hhdmgu`; Project Structures `btwq2umsr`; Project Site Walks `btwuee5w8`; Project Site Walk Items `btwuezfnf`; Project Site Walk Files `btxxg89rp`; (CRs) Constructability Reviews `bt4pz9nb5`; CR Items `bt4vtinyi`; CR Item Photos `bt5c6zzk2`; FastField Submittals `btu2z59m8`; Colors `bj6zc5wdr`; Staff `btbgb68pg`.
**Invoicing & Commissions (7):** Invoice Headers `bty3hdi98`; Invoice Lines `bty3hgd67`; Invoice Payments `bty3h3hpd`; Commission Dates `bu2665n9v`; Commission Reps `bu267fm6t`; Commission Details `bu2k7immd`; Sales/Change Orders `but4q9da8`.
**Vendors & Purchasing (6):** Vendors `bhtcnbyas`; Vendor Shipping info `bhtrddih6`; Vendor Contacts `biitz5eer`; Vendor Documents `bim89kz4c`; Vendor PO Headers `bwdza4crn`; Vendor PO Lines `bwdzc3e2c` (last two new, near empty).
**Pricing & Geography (5):** Price List `bqemyhcuv`; Price List Revisions `bq9ksmtmr`; Financing Rates `bhvt7vged`; Zip Codes `bq9kufjg9`; Counties `bq9xqa5ch`.
**OPT lookup (20):** OPT PlayCore Periods `bv2ngu6jt`; OPT Coop Contracts `brpwfit2c`; Coop Contract Documents `bu8w3hhc4`; OPT Payment Terms `bhvzwkpay`; OPT Lead Sources `bt93sv2tg`; OPT Promo Codes `bv6f4s5qj`; OPT Close Reasons `bv6femet7`; OPT Customer Types `bhx2kxaad`; OPT Bid Checklist Items `btknvxkvy`; OPT Bid Timeline Items `buea3c8jx`; OPT Permit Requirement Types `btx8hq5tw`; OPT Milestone Types `btdvczmd2`; OPT Handoff Categories `btj4wzu6c`; OPT Handoff Items `btj4vxyff`; OPT Structures `btwubsexz`; OPT Site Walk Categories `btwt8zehf`; OPT Site Walk Items `btwt84zp7`; OPT States `btx92t3dk`; OPT SharePoint Folders `bt3vkfcfs`; OPT Constructability Review Items `bt2mss8pa`.
**Docs/Proposals (8):** Quote Proposals `bpzgxbg9x`; Quote Proposal Components `bpzgk5px4`; Proposal Contacts `bp7hmdadd`; Proposal Revisions `bp4fka56i`; Proposal Boilerplate Content `bpzgkj3s2`; Document Templates `bj36gb2cv`; Document Subtables `bj36gb8cn`; Document Users `bp4fka3di`.
**System/Staging/zz (16):** QB App Updates `bu657y8dp`; QB Feedback `bv6nruc7e`; Messages of the Day `bnanmriuf`; Batch Processing Errors `btqmc7b8c`; STAGING Park Structures `btk69n5sk`; STAGING Upload Runs `btk7njgxz`; Price List Staging `bq9kvk4yv`; Query Generator `bsye4vnr2`; Documentation Topics `bufcbmgab`; Documentation Details `bufcbqyvy`; Revision Tracking `bufmix5v5`; Images `bnumea8tt`; zzFiles `bhd8p436x`; zzInstallation Updates `bs9a9xeuf`; zzOpportunity Updates `bv325jv7a`; zzPayment Schedule `bty3g445b`.

## Key fields (fid: label. rule; gotcha)

### Quote Pipeline `bhp495xeb` (751 fields; quote = order, no Orders table)
- 3 Quote #: record id and quote number; child FK target.
- 1 Date Created: timestamp, UTC. Convert to America/New_York before bucketing.
- 73 Grand Total: 66 + 108 + 71, current value only, includes tax.
- 213 Subtotal Sell incl. Freight: 66 + 108, excludes tax; basis of Opp value (34/31).
- 66 Subtotal Price Before Freight & Tax (SUM lines 16); 67 Total Cost (SUM lines 25); 68 Total GP $; 108 Total Customer Freight (lines where 40 = 1); 71 Tax.
- 86 Quote Status: 12 choices (below).
- 191 Date Order Submitted: clean order filter (100% in Won statuses). 1030 Quoted to Customer Date (formula, current QTC date); 824 is the timestamp lookup.
- 101 Forecast Close Date, 36 Confidence %, 149 Bid Type: legacy-sync formulas (Opportunity value when 697 > 0, else pre-6/26/26 entry). Never write.
- 697 Related Opportunity: FK to Opportunities. Only 11% of won 2024-09+ quotes carry it.
- 702 Opp - Count Toward Value (Yes/No formula, already resolves override 921). Filter Yes on every pipeline report.
- 923 Opportunity Name; 208 Customer - State; 210 Reason(s) for Loss; 431 Billing Postal Code - County; 432 Billing Postal Code - State; 239 Promo Code.
- 850 Related Sales Rep 1: FK to Sales Reps key fid 9 (not fid 3). The rep grouping field. 842 = rep 2. 851 = name lookup (labels only). Never group by 155 or Record Owner (4).
- 179 Customer ID#: FK to Customers; 44 Customer Name lookup exists.
- 169 Bid Due Date: bid population selector (100% on Bid quotes). 385 Bid Submission Status (Submitted / No Bid / Other). 387 Bid Outcome (about 35% filled, never a denominator). 806 Bid Award $ Value: unusable (rarely filled, mostly on lost bids). 807 Bid Lost - Reason.
- 645 Total Amount $ Invoiced: SUM of non-void Invoice Headers 63; NULL not 0. Outstanding = 73 - Nz(645). 871 Outstanding $ To Invoice: NEVER use (blank when nothing invoiced).
- 326 # Install Vendor Quote Lines: 0 or empty means product-only.
- 515 / 516 Construction Complete Forecast / Actual; 610 Vendor Latest Estimated Ship Date (stale placeholders); 1025 Vendor Latest Actual Ship Date (about 42% filled).
- 927 / 928 PlayCore Order Submitted Period (FK / name, keyed to 191). Quotes have no live created-date period (905 retired 7/10/26; 910 = PlayCore Quote Date, not the Quoted to Customer date).
- 443 Cooperative Contract is a text formula with 18 values; do not write it. 442 FK; real co-op orders are a small share of orders.
- 633 Permit Authority Requirements: embedded report link (target is QP itself), not a link to btwte4vj4.
- 1024 To Be Invoiced Category; 749 Opportunity Value formula; 762 PPS List Price.
- 28 Quote Identifier (free text, "-Option N"/"Rev"); 171 Opportunity/Quote Name (display); 156 Internal Quote # is NOT a solicitation number.
- 878 Status - Final/Close Date (closed-set formula); 750/751 Bid QC / override (no "Bid Coordinator" field).
- Not in live: QP 1044 (Vendor PO records link); Sales Team 152; Opportunities fid 942 (an older Bid Type cite).

### Opportunities `bt93rndvw` (141 fields; history from 2026-06-01; 2,128 max rid)
- 68 Opportunity Status (formula), 46 Opportunity ID, 23 Opportunity Name, 6 Related Customer; 7 Customer; 127 Customer - Sales Rep.
- 18 Forecast Close Date (DATE, no tz, 94% filled); 143/144 forecast-close PlayCore period FK/name.
- 20 Confidence % (choices 0/25/50/75/99; returns fraction).
- 31 Opportunity Value $ = 34 x 20; 34 Subtotal Sell incl. Freight - Opp Value Count=Yes (SUM QP 213 where 702 = Yes). Both $0 for New/Pending/Closed.
- 27 # Quotes; 54 # Quotes - Count Toward Value Override<>Blank; 67 # Quoted to Customer; 93 # Order Submitted/Invoiced; 28/29 Quote Grand Total Max/Min.
- 75/76 Related Sales Rep 1 / name (FK to Sales Reps key fid 9); 78 rep 2.
- 64 TODAY Opp Update (body only; nightly about 8:15 PM stamps date and owner into Updates then clears it); 65 owner; 165 Most Recent Update w/Date & Owner; 87/88/90/92 latest update id/date/owner/count.
- 72 Bid Type (Bid / GC Quote). 129 Revision Needed (report label "Update needed"). 108 Close Opportunity - New/Pending. 116 Offer Financing, 117 Payment Terms, 120 Related Cooperative Contract (required once a quote is added). 104/106 close reason.

### Quote Lines `bhq88xjum` (137 fields)
- 14 Quote # (FK to QP 3): THE filter for a quote's lines. 3 line id. 18 Related Vendor, 19 name, 148 PlayCore Vendor (lookup of Vendors 46).
- 16 Extended Price (sell, excludes freight; freight lines read 0); 169 Extended Price+Freight; 25 Extended Cost; 12 GP$; 56 Date Order Submitted lookup (server-side order filter).
- 134 Install Line (also on furnish+install); 35 Flag as Vendor Note (cost without sell; exclude from $ tallies); 40 Customer Freight; 8 Description (control chars, strip); 156 Product Type (override 157, else vendor product type); 153 Quote - Opp - Count Toward Value.
- Bond amounts live here, found by description (a bond pseudo-vendor).

### Sales, territory, customers
- Sales Reps `bvgbefp6g`: 6 name, 9 Record ID# from Sales Team (the key QP 850 / Opp 75 point at), 10 Status (text), 3 record id, 11 QB user, 32 email. 45 max rid; exclude test reps by name (names contain "TEST").
- Sales Team `bhqpcitdz`: 6 Name, 93 Status (Active/Inactive picklist), 36 Related Sales Territory, 37 Sales Territory, 100 dblink to County Sales Reps. Distinct table from Sales Reps.
- County Sales Reps `buq6z9c6j`: 7 County, 8 State, 10 Sales Rep - Name (free-text lookup), 9 Related Sales Rep (FK to Sales Team), 6 Related County. Pull select [7,8,10], top 1000, no where. 925 non-blank rows, 13 states.
- Customers `bgr44yuh9`: 3 key, 6 name, 68 Customer Type (end-market segment, not a channel), 53/54 assigned rep (Sales Team), 115 Billing Postal Code County, 116 Billing Postal Code State (live state), 110 City / 112 Postal Code (labels still read 'RETIRED 5/14/26' but both are populated; 160 'Related Billing Address - Address: City' also holds the city), 121 Internal Bliss Customer.

### Child tables (FK to QP 3)
- Q/O Status Changes `btiessw29`: 6 Quote #; 1 Date Created (transition time, UTC); 11 Status (NEW status only); 12 GP $; 17 Total Cost; 18 Grand Total Revenue; 20 Subtotal Sell incl. Freight (snapshots often NULL on open rows).
- Bid Checklist `btknw7tjd`: 11 Quote #; 8 Required; 9 Details.
- Bid Timeline `buea4c7p8`: 6 Quote #; 9 item FK; 12 Due Date; 13 Actual Date; 22 Override.
- Quote Permits `bsce9f3yv`: 6 Quote #.
- Invoice Headers `bty3hdi98`: 6 Quote #; 63 Total Amount Due; 23 Void.
- Vendor Shipping info `bhtrddih6`: 10 Quote #; 24 Estmated (sic) Ship Date; 7 Actual Ship Date; 11 vendor.
- Updates `bt69n97gn`: 36 Related Opportunity; 9 Update; 10 Owner; 11 Date.
- Order Milestones `btdwpuzde`: 6 Quote #.

### Other
- OPT PlayCore Periods `bv2ngu6jt`: 3 key; 6 Period #; 9 start; 10 end; 11 Period Name (e.g. 2026-07; 4-4-5, Mon-Sun; a period ending Aug 3 is still "2026 July").
- Vendors `bhtcnbyas`: 6 name; 42 status (Active / CAUTION / DO NOT USE / Inactive); 45 summary grouping (PPS / Cedar Forest); 46 PlayCore Vendor; 48 Product Type.
- Sales Budget Monthly Snapshots `bp8vub4tu`: 28 date; 12 Grand Total Sales YTD; 22 Total Quoted YTD; 8 goal baseline (cumulative YTD, resets annually).

### Saved report ids (run_report cannot run them; replicate with query_records)
- QP report 229 (include Total Amount $ Invoiced in exports; contents unverified).
- QP report 233 (order submitted present, status not Commission Paid / Invoiced / Cancelled / Lost).
- QP report 355 ("QuickBase Source" for To Be Invoiced V3 = Order Submitted rows).
- Opportunities qid=56 "Rep Forecast Current Period (or Before)" (rep-scoped, grid-editable).

## Status values

**Quote Pipeline 86 Quote Status (12):** Opportunity - New; Opportunity - Pending; Quoted to Customer; Order Submitted; Invoiced; Commission Paid; Lost - Close Quote; Close - Multiple Alternative; Close - Quick Close (no reason); Cancelled; Opp Transition New - For Ref Only; Opp Transition Pending - For Ref Only.
- Won set: Order Submitted, Invoiced, Commission Paid. Open: Quoted to Customer. Closed (fid 878): Commission Paid, Lost - Close Quote, Close - Multiple Alternative, Close - Quick Close (no reason), Cancelled.
- Opportunity - New has no live quotes; Opportunity - Pending has at least one stray, not counted toward value. Opp Transition pair are legacy restamps. "Expired" and "AI Draft Ready" do not exist anywhere in QB.
- 24-month census (to 2026-09-24), largest first: Multiple Alternative, Commission Paid, Quoted to Customer, Quick Close, Cancelled, Lost, Opp Transition New, Order Submitted, Opp Transition Pending, Invoiced.

**Opportunities 68 Opportunity Status (formula, first match wins):** Quoted to Customer if # QTC >= 1; Ordered if # Order Submitted/Invoiced >= 1; Closed if close flag set or all quotes Commission Paid/Lost/Cancelled; Pending if # Updates > 0 or a quote is Opp Transition Pending or TODAY Opp Update is non-empty; New if # Quotes = 0.

**Confidence (Opp 20):** 0 / 25 / 50 / 75 / 99 (live choices, matches history). Transcripts only say "one of five valid values" and never list them; an early transcript said 95.

**Bid:** Bid Type Bid / GC Quote; 385 Submitted / No Bid / Other; 387 Won / Lost / Under Evaluation / Cancelled/Not Submitted / All Bids Rejected. Offer Financing Yes / No.

## Query rules (short)

1. Always select and max_records; where is server-side `{fid.OP.'value'}` with fids only, uppercase ops (EX XEX CT XCT SW GT GTE LT LTE BF OBF AF OAF IR).
2. HTTP 413 at about 260 OR terms; batch 50. Server pages max 1,000: loop skip until hasMore is false; skip-probe for true counts. maxRid and nextRecordId are ceilings, not counts.
3. groupBy does not aggregate; orderBy/groupBy take objects. run_report is broken (HTTP 400 since 2026-08-13): replicate reports with query_records.
4. list_tables and QP get_table_fields overflow context (about 61K chars / 700 KB). Save and parse, or delegate to a subagent told "you ARE the subagent".
5. Timestamps are UTC (fids 1, 2): convert to America/New_York. Forecast Close Date is a DATE. Percent fields come back as fractions.
6. Group reps on QP 850 via Sales Reps fid 9 to name fid 6; on Opportunities 75/76. Exclude test reps by name, never by record id.
7. Use Grand Total 73 or Subtotal Sell incl. Freight 213 (say which); never 871; 645 is NULL not 0 (Nz); 806 unusable; 387 never a denominator.
8. Every pipeline report filters 702 = Yes. Dedup via 697/702; admit no-Opportunity quotes (pre-cutover 2026-06-26 quotes never got one; about 89% of won 2024-09+ quotes lack 697).
9. Bond amounts are on Quote Lines (by description). Product-only = 326 empty or 0; install = QL 134. Freight lines read 0 on QL 16: use 169 for totals with freight.
10. Bid population: `{169.XEX.''}`; submitted via 385; exclude Close - Multiple Alternative; use the exact string 'Close - Quick Close (no reason)'.
11. Q/O Status Changes: filter by quote; 11 is the new status only; many quiet closes never logged; snapshots often NULL.
12. Formula fields are live values only; QP 36/101/125/149/239 are legacy-sync formulas.
13. Customer names via 179 to Customers 3 to 6 (or QP 44); state from Customers 116; never select Permit Authority login fields; strip control characters from QB descriptions.

## Conflicts (short; full list in the xlsx)

- **Test-rep record ids:** older notes give two different id pairs for the two test reps, and one pair belongs to real reps. Sales Reps and Sales Team are two tables with separate record ids, the likely explanation (19/40 are Sales Team ids or Sales Reps fid 9 values; 37/41 are Sales Reps fid 3 ids). UNVERIFIED. Exclude by name.
- **QP 152:** cited as a second Sales Team link; does not exist. Use 49 or 850.
- **QP 44 Customer Name:** tables.md said absent; it exists.
- **QP 86:** older doc has 10 values and "Close - Quick Close"; live has 12 with "(no reason)".
- **QP 633:** not a link into Permit Authorities; it is an embedded report (target QP).
- **Revenue basis:** pipeline reporting chose Subtotal Sell incl. Freight (213) in July 2026; KPIs use Grand Total (73). State the basis in every deliverable.
- **Confidence:** transcripts never enumerate the five values; live is 0/25/50/75/99.
- **Vendor PO tables:** history says proposed, not built; Vendor PO Headers/Lines exist live (near empty).
- **Invoice Payments:** transcripts say payments not captured in QB; live table Invoice Payments has max rid 543.
- **Permit Authorities size:** 124 rows (6/24) vs 156 jurisdictions (5/11); live max rid 160.
- **County Sales Reps** is the live name (history: County Sales Teams). **Updates** (bt69n97gn) is the live name (not "Order Updates").
- **Bid Type:** Opportunities fid 72 (fid 942 never existed). **Quoted-to-Customer date:** 1030 (date formula) vs 824 (timestamp lookup).
- **Sales Budget Monthly Snapshots 18** is GP% YTD, not a GP count. **Sales Reps 10** Status is plain text; the Active/Inactive picklist is Sales Team 93.
- **Vendors 45/42:** live adds Cedar Forest as a summary group and CAUTION / DO NOT USE statuses.
