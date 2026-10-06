---
name: research
description: >-
  Build a short "reason to call" dossier on a named person, company, or municipality, from public
  web sources — cross-referenced against QuickBase, with Bliss bid history and the public-role contacts tied to the lead.
  Use when the rep says "research...", "give me a dossier on...", "look into...", "reason to call brief
  for...", or wants to dig into a specific signal or contact by name. For a broad scan of the rep's
  territory instead of one named target, use `find-leads` instead.
---

# Research Brief

Build a short, cited "reason to call" brief on one specific, named target — a person, a company, or a
municipality/agency. This is the deep-dive tool for something specific; scanning a whole territory for
signals is `find-leads`'s job.

## What this is not

It never invents facts about the target. If public search comes back thin, the brief should look thin and
say so ("Limited public information found on [target]") rather than padding with generic filler dressed up
as research. Every finding needs a real source and, where relevant, a real date. A search result is not a
source: open the page before you cite it. A fetch tool may return a summary, not the page. Ask it for the
exact sentence that names the person, role, awardee, scope or figure, and write only what that sentence says.
If it can't quote one, the detail is unconfirmed and does not go in the brief. Don't widen a source: an agenda item that names a
contract, an awardee and an amount supports those three things. What a contract covers needs a page that says
so; fencing, bleachers and amenities are not playground scope unless it does. A negative (not an open bid, not
a co-op) needs a source too, or the answer is "not found."

## Usage budget — most reps are on a standard/basic Claude plan

Cap this at roughly 6–8 web searches for one brief. Only web searches count here; opening a page (a page
fetch) is counted separately, so open the pages you'll cite and not every result. Go broad first (recent
news, official site/announcements), then one or two follow-ups only on the most promising thread. Don't
chase every tangent. If the budget runs out, present what was found and name what wasn't checked in the one
"Not checked:" line after the opener, rather than silently stopping partway through. Bliss Library reads
(about 6 per document) and the QuickBase sections (about 16 bounded QuickBase queries for the whole brief) don't spend the web-search cap.

## Flow

1. **Identify the target and type** — person, company, or municipality/agency — from the rep's request. If
   the rep just got this from a `find-leads` result or another tool's output earlier in the conversation,
   use the lead's buyer, project, scope, budget, stage, source, and QuickBase label instead of re-asking.
   "Research #2" means the second Lead Finder result. If the target name is ambiguous (common name, multiple
   organizations with similar names), first try to settle it from the rep's territory in `PROFILE.md`
   (e.g., "Richmond parks" for a rep who covers Richmond city, VA): if exactly one match is in their
   territory, go with it and say so in one line ("I took this to mean … — tell me if you meant …").
   Only if the territory doesn't settle it, ask for a disambiguating detail before searching.
2. **Read `PROFILE.md`** for the rep's product focus, territory, and Voice (if set) — used for relevance
   framing, the suggested opener, and the cross-reference below.
3. **Research, within the usage budget**, gathering what's publicly available and relevant. For a
   municipality/agency target in the rep's counties, if the Bliss Library connector is available, call
   `my_sources(county=…)` for that entity and read its rows first: its CIP, budget, master plan, and parks page.
   Use `read_source` for about 6 reads per document, one literal term per call and never `OR`, before spending
   web searches. These connector reads do not spend the 6–8 web-search budget. For any PDF, registry row or
   not, use `read_source` with a query first, then pages; if it returns no text, follow `Lead Finder - PDF
   Fallback.md`. If WebFetch returns binary, "can't parse" or a
   saved-file note for a PDF, run the same URL through `read_source` with a query. If the host is refused, say
   "PDF not readable here" in the "Not checked:" line; don't use local tools unless the rep has code execution.
   If the target is outside the rep's counties, say so in the header: "This one's in [county], which isn't one
   of your counties. QuickBase lists [rep] for it: check with [rep] or your manager before reaching out." When
   no rep is named: "This one's in [county], which isn't one of your counties. Check with your manager before
   reaching out." Then continue with
   the web flow below. If the connector is unavailable, continue with the web flow below.
   - **Person:** current role/title, organization, and any recent public professional activity (news
     mentions, public statements, project involvement) — not personal/private information.
   - **Company:** what they do, recent news, projects, or public activity relevant to the rep's product
     focus.
   - **Municipality/agency:** recent capital projects, budgets, procurement activity, or public meeting
     items relevant to parks/rec/playground work — similar territory to `find-leads` but focused on one
     specific place instead of scanning broadly. The most useful public items, in rough order:
     - the parks master plan or capital improvement plan (named parks and planned years/amounts);
     - grants awarded or applied for (e.g., LWCF, CDBG, state recreation grants) and their match deadlines;
     - bond referendums or budget adoptions that fund parks/rec, and when the agency's fiscal year ends;
     - council/board agenda items approving park purchases, including purchases through a cooperative
       contract (Sourcewell, BuyBoard, TIPS, OMNIA, etc.);
     - open or recent bids on the agency's own bid page, and published bid tabulations/awards (who won
       a past playground or park bid, if public).
     For a **school district**, the equivalent is its facilities plan or bond program. For a **private buyer**
     (a private school, church, HOA or property manager), skip the Bliss Library and bid-tab searches (they
     don't publish agendas or bids); use its own website and any news, and still run the QuickBase sections.
4. **For a municipality/agency or a named project, cross-reference QuickBase (F5)** — see the section
   below. Do this before presenting the brief, and read only.
5. **Build the Bliss history sections** below after the QuickBase label and before contacts. Keep each lookup
   bounded, inside the QuickBase budget (see **Rules for the QuickBase sections**). If QuickBase isn't
   connected, each section gets its own one-line skip notice.
6. **Find the public-role contacts tied to the lead (F6)** — see the section below.
7. **Present the brief** in the output shape below.

## QuickBase cross-reference (F5)

When the target is a **municipality/agency** or a **specific named project**, check it against QuickBase
before it goes into the brief. This is read-only — never write to QuickBase. Tables are referenced by
**name**: Opportunities, Quote Pipeline, Sales Reps, County Sales Reps.

**Search order:** the **jurisdiction** name first, then any **design firm or engineer named in the public
record** (a project can surface through its firm when the city alone would not have). Match against
Opportunities and Quote Pipeline.

Match the jurisdiction on its distinctive name, contains-style and case-insensitive; the entity's own
department record counts, but a billing city alone does not, and schools, property managers, architects, and
contractors are only related notes. Search quote and opportunity names for the project too, but require a
matching city or county — never match on a park name alone. Opportunities only exist from about mid-2026, so
older jobs may be quote-only. Count every quote for the buyer except obvious test records (a customer or job
name "TEST", "Test2", "Testing"). A real customer's quote entered under a test rep account still counts; show
its rep as "test account". Every `$0` row under a test rep collapses into the one line, whatever its status.
Collapsed entries are not counted; they show in the Bliss history count line's "(plus T test-account entries not shown)" note. A test-account row with money in it is
listed and labelled "test account". If a count differs from one an earlier
tool showed in this conversation, use the newer one and say so in one line.

Before choosing a label, read the matching opportunity and every matching quote, and label exactly as
`Lead Finder - QuickBase Check.md` ("Status before labeling") says: `won before` beats `in pipeline (yours)` /
`in pipeline ([rep])`, which beat the two closed labels, `Close - Multiple Alternative` (shown exactly) and
`lost before`. Never call `Close - Multiple Alternative` a loss; check nearby quotes if the status says an
alternative was chosen.

**Queries.** The QuickBase IDs live in the QuickBase setup skill (`quickbase-usage`), not in this file. Use
its recipes; they carry the table and field IDs, so there's nothing to look up first. Never list all tables
or dump a table's fields (Quote Pipeline has several hundred). Budget: **about 16 bounded QuickBase queries**
for the whole brief, cross-reference and history sections together. Run the QuickBase queries directly. The
one step worth a subagent, when the session has one, is Similar jobs step a (the 60 to 150 row pull in the
setup skill's Similar jobs recipe, step a). With no subagent tool, run it directly with max 60. A section that runs out says
"not run (query budget)" in its "Not checked:" line.

**Rules that always hold:**

- Every QuickBase call uses `select`, `where`, and `max_records` — bounded to the target, never a whole
  table scan.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- Statuses are shown verbatim as stored (e.g. "Close - Quick Close (no reason)").
- A record link may contain table IDs inside its URL; never print a bare table or field ID.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round or invent one.
- If the QuickBase extension isn't connected, say **"QuickBase isn't connected"** once, leave the
  cross-reference out of the brief, and never guess a status.

**What the rep sees:** one label for **this lead's project or site** — `in pipeline (yours)` /
`in pipeline ([rep])` (open opportunity or quote), `Close - Multiple Alternative`, `lost before`, or `won
before` — with the QuickBase record number the rep can open. These four apply only to a quote or opportunity for
this project or site. A Cancelled quote for this project or site is not a closed label. The label is `new`, with
one line: "A Cancelled quote exists for this site ([year], [reason, or 'no reason on record'])." An open opportunity that can't be tied to this project by name or site is `new`, with one line naming it. Everything else
is `new`. When there's also an open quote on a project Bliss already
won an earlier phase of, the label stays `won before` and one more line names the open quote.

**Bliss already involved.** Public records sometimes name Bliss's own deal — a public document that names
Bliss (or Play and Park Structures) in connection with this lead's project (often as the distributor of a
listed playground or shelter). When that happens, label the target **BLISS INVOLVED** *ahead of* whatever
the cross-reference returns, and tell the rep to **check with the rep of record rather than pitch it**. It's
still worth the brief — just not one to walk into cold. If the match resolves in QuickBase to a record whose
rep is the rep in `PROFILE.md`, and no other rep has an open record on this project, say "This one is
yours." and use the QuickBase label instead of the stop.

## Bliss history and bid context

These sections come after the QuickBase label and before Contacts / Why call now. They are read-only. Follow
the `quickbase-usage` skill's recipes for the actual queries — it holds the tables and fields; never guess
them. Show what QuickBase has, including other reps' names, prices, and recorded lost reasons. Money always
includes its basis: **Grand Total incl. tax**, quoted as stored. Status is shown exactly as QuickBase stores
it; never translate `Close - Multiple Alternative` into "lost". A pattern line counts only the rows listed
above it and says so ("of the 5 shown, 4 won"). No figures from outside the rows shown (no "biggest past win" from older quotes). No win rate when only won jobs were pulled, and no derived
dollar math (sums, shares, or ranges across line items).

**Rules for the QuickBase sections:**

- **Size window and blank Customer Type:** use the QuickBase setup skill's size-window and blank-type rules here; they cover
  a line spread over years where the whole line is the scope, approved against requested, two lines, and blank buyer type.
- **Cap:** sort the won-only pull on Date Order Submitted (191), newest first, filter the 24-month window on 191,
  and keep the first 30 that pass the size and buyer-type filters. The section shows the date span of those 30.
- **Equipment test:** A job is listed as play, splash or shade only if it passes the equipment test;
  otherwise list it as 'furnishings' or 'parts', or leave it out. The equipment test itself lives in the
  QuickBase setup skill.
- **Nearby fallback:** when the county yields fewer than 3, keep the county's rows and add same-state rows up
  to 5, labelled "same state".
- **Dates:** show 191 labelled "ordered" when the row has one, otherwise Date Created (1) labelled "quoted".

**Bliss history with this buyer** — for the matched buyer entity, show up to 8 Bliss quotes or bids, newest
first. Use the same distinctive-name, own-department, quote-only, and test-record rules as F5. Open the section
with: "N quotes since [year], M of them orders (Order Submitted, Invoiced or Commission Paid; last [year]: [categories]); the K newest shown." Amounts are Grand Total incl. tax, as stored.
Each line has: ordered or quoted date · job name · total ·
status exactly as shown · recorded reason lost, if any · co-op contract, if any · rep. A job is listed as play,
splash or shade only if it passes the equipment test; otherwise list it as 'furnishings' or 'parts', or leave it
out. Collapsed test-account entries are not counted in N; they appear only in the "(plus T test-account entries
not shown)" note. Add "(plus T test-account entries not shown)" when applicable. End with one factual pattern line, such as "Of the 8 shown:
2 won, last win 2023." If QuickBase isn't connected, say: "Bliss history with this buyer: QuickBase isn't connected." If no
matching buyer history exists, say so plainly.

**Similar jobs elsewhere** — check at most 30 candidates (a hard cap, per the rules above), then show up to 5
that match all three filters: the same product categories as the lead's scope from
the quote line items; the same buyer type; and a total inside the size window above. Open the section with:
"amounts are Grand Total incl. tax, as stored." If the lead has no known budget, skip the size filter and say so
in this section. Look at won jobs first
and add still-open quotes only if fewer than 5 match. If nothing matches all three filters, you may list up
to 3 near misses (right size and buyer type, but only some of the product categories), each labeled "near
miss: [what differs]"; never present a near miss as a match. Two limits to say plainly when they apply:
QuickBase files site furnishings under play equipment, so a job only counts as a playground when it has
real playground equipment (the Research Brief's equipment test); and many customers have no buyer type
recorded, so use the blank-type rule above. Each line has: buyer · state · ordered or quoted date · product categories ·
total · status · rep. Add one factual pattern line, such as
"Of the 5 shown, 4 won." (or, when only won jobs were pulled, just "5 won jobs shown"). This lookup will move to
a faster Bliss Library lookup later. If QuickBase isn't connected, say: "Similar jobs elsewhere: QuickBase
isn't connected."

**Past customers nearby** — find up to 5 won jobs for other customers in the lead's county, at most 2 per
customer, won in the last 5 years. Won means exactly
`Order Submitted`, `Invoiced`, or `Commission Paid`. When the county yields fewer than 3, keep the county's rows
and add same-state rows up to 5, each labelled "same state". Never use the lead's own buyer. The county is the customer's billing county, so
leave out contractors (their billing county isn't the job site). Skip parts and small orders (Grand Total incl.
tax under $10K). Open the section with: amounts are Grand Total incl. tax, as stored. A job is listed as play,
splash or shade only if it passes the equipment test; otherwise list it as 'furnishings' or 'parts', or leave it out.
Test reps are excluded; say so in the opening line. Don't repeat a job already listed under Similar jobs elsewhere; add "(also listed above)" to
the count instead. Each line has: customer · product categories · order year · total · rep. If QuickBase isn't connected, say: "Past customers nearby: QuickBase isn't connected."

**Who won their past bids** — first show every `Lost - Close Quote` row for the buyer, or say "N shown of M";
show a reason as stored, and don't call a duplicate a lost bid. Then use 1–2 web searches for the agency's
published bid tabs or award minutes for playground or park bids. Searches for awards, minutes or bid tabs total
two, whichever section asks. Each
line has: date · project · winner · amount if published (Grand Total incl. tax when it is Bliss's amount) ·
source link. Add a factual pattern line when one is supported, such as "Of the 3 shown, one repeat vendor won
2." Web searches count toward the existing 6–8 search budget. If QuickBase isn't connected, say:
"Who won their past bids: QuickBase isn't connected." You may still use the web-search portion only when the
agency and its public bid source are identified. Skip the web part for a private buyer and say "not a public
bidder."

## Contact finder (F6)

For a municipality/agency lead, find the **public-role contacts tied to that lead** — start with these; add any
other staff a page ties to this project (design, construction, engineering), one line each, four contacts at most:

- the **parks director** (or the parks/rec department head);
- the **purchasing agent** (or procurement officer);
- the **school facilities director** — for a school-district lead;
- the **city manager** (or county administrator) where that's the decision-maker for the lead;
- for a **private buyer**: the head of school or administrator, the facilities or business manager, the
  pastor or church administrator, or the HOA board president or property manager, from the buyer's own site;
- the **landscape architect / project lead** — **only** when a council minute or a contract-approval record
  identifies them by name, never inferred from a staff directory, a firm's team page, or a project listing.
  Scan the cited meeting record or packet for a design firm, engineer, or project lead before saying none was
  named.

Rules:

- **Source every contact.** Each one carries the public page it came from — a government staff directory,
  an agenda or staff report, the firm's own site, a council minute or contract approval, or another public
  page that names the person in the role. If no public page ties a person to the role for this lead,
  don't list the role.
- **A search result is not a source.** Open the page before you cite it. If it can't be opened, the detail does
  not go in the brief. For a contact, write the role as "not confirmed" with no name, phone or email, and name
  the unopened page in the one "Not checked:" line. Use the same rule for a figure, date or award from a summary.
- **Public-role contact only.** No home address, no personal phone number, no personal email, and nothing
  that isn't tied to the public role. If a public page publishes a work phone or work email tied to the
  role, it's fine to include; otherwise leave contact details off.
- **Never guess or construct an email address** — not even an obvious first.last@ pattern. A guessed
  address is worse than none.
- **No LinkedIn scraping.** A public page that names the person in the role is fine to cite once opened;
  don't scrape LinkedIn (or any login-walled/social profile) for details.

This is the F6 job: the named public decision-maker tied to the lead, with the page it came from. It is
know-how, not a data source — the point is knowing which titles matter and that the architect of record
shows up in contract-approval minutes rather than a staff directory.

## Contact card mode — the Daily run

The Daily run (see **Daily run** in CLAUDE.md) asks for a short contact card on up to 3 leads, instead of
a full brief. For each lead:

- **Skip** any lead the Lead Finder flagged to check with another rep first (`BLISS INVOLVED`, or another
  rep's open quote or opportunity for this same project): one line, "[Project]: check with [rep] first," and
  no card. If no rep is named (a `BLISS INVOLVED` lead from a public document), say "check with the rep of
  record first."
- Use the contact finder rules above (F6) exactly: public-role contacts only, every item sourced, **never
  guess or construct an email**, no LinkedIn scraping. Pick the one best contact for the lead (parks
  director or purchasing for a city or county, facilities for a school district, the owner's role for a
  private buyer); a second only if the first is a general office line.
- **At most 3 web searches per lead.** No QuickBase lookups beyond what the Lead Finder already did, and no
  history, similar-jobs, nearby or who-won sections.
- **The card, one block per lead:** "#N [Project] · [Buyer]", then: who to call (name, title) · phone ·
  email (only if published) · website · purchasing or bid page link (if found) · one "Why call now" line from
  the lead itself. Each detail carries its source link. A detail not found is left out, not guessed.
- No contact found: one line, "#N [Project]: no public contact found — [the page you checked]."
- **Save to the lead board:** put the contact in `Contact` (name, title) and fill `Phone`, `Email`,
  `Website` and `Contact Source`, **only where those cells are blank**. Never overwrite what the rep typed.
- End the section with one line: "Say 'research #N' for the full brief, or 'draft an email for #N'." Leave
  it out when every lead was skipped.

## Output shape

Keep it tight, in this order:

- **Header** — name, title/role or type, organization, and any public contact info found (never inferred or
  guessed). When the county is outside the rep's counties, say so here (with the owning rep if QuickBase's county
  assignment shows one); when a BLISS INVOLVED match is the rep's own, "This one is yours."
- **Project** — four lines right under the name line. "Not found" is fine on any line; a guess is not.
  - Amount and fiscal year (page) — an amount from a multi-year plan carries its span ("$2.5M, FY27–28"). Cite the page
    `read_source` opens and add the printed number when they differ: "p. 40 (printed 38)." Open the page before citing it.
  - Stage check — "Stage: [Lead Finder stage] · sources say: [budgeted / design / bid open (date) / awarded to (vendors,
    date or 'date not stated', source) / built (source) / not in budget (source) / partly built (what, source; what not
    confirmed) / proposed or draft book (adoption: date or not confirmed)]." Before writing "budgeted", search the
    budget message and CIP for "not included" and "conditional funding" next to the project name and give the page
    if found. A stage read only from a column position is "budgeted (column; not confirmed)". Never silently overwrite
    the Lead Finder stage; show both. A standing contract held by several vendors is a way to buy, not an award: put it
    on the Procurement path line, not here. For partly built, use: "The brief shows [built part] built ([source]);
    [other part] isn't confirmed. Want an email about [other part] instead?"
  - Procurement path: open bid / co-op (name) / standing contract ([vendors], through [year], [source]) / sole source / not found.
  - Product fit, as the source states it.
- **QuickBase cross-reference** — for a municipality/agency or named project, the one label (`BLISS
  INVOLVED` first when it applies, then `new` / `in pipeline (yours)` / `in pipeline ([rep])` / `Close -
  Multiple Alternative` / `lost before` / `won before`) with the
  record number, describing this lead's project or site; a `new` label needs no extra line here; the buyer's past
  orders are in the Bliss history count line below. If QuickBase isn't connected, this is just the single "QuickBase isn't connected" line.
- **Bliss history with this buyer** — the total count, then up to 8 matching quotes/bids, newest first, then
  one factual pattern line. If QuickBase isn't connected, include its one-line skip notice.
- **Similar jobs elsewhere** — up to 5 matches from the bounded candidate pull, with the date span shown, the size
  filter or the explicit no-budget note, then one factual pattern line. Include the one-line QuickBase skip
  notice when needed.
- **Past customers nearby** — up to 5 other-customer wins in the lead's county, or the same-state fallback
  when the county yields fewer than 3, with the fallback named. Include the one-line QuickBase skip notice when needed.
- **Who won their past bids** — Bliss's own lost bids first, then the limited public bid-tab/award search, with
  each source cited and a factual pattern line only when supported. Include the one-line QuickBase skip notice
  when needed.
- **Contacts** — the public-role contacts found (F6), one line each: role → name → the source page. When
  none could be sourced, say so plainly rather than inventing a title or a name.
- **Why call now** — a dated, cited bullet list of the most relevant findings, each bullet one line, with one line on
  why it connects to the rep's product focus (a factual connection, not a pursue/pass verdict or
  timing advice — "design is still open" is a fact; "a good time to pitch" is advice).
- **Suggested opener** — one short, natural conversation-starter line referencing the findings above,
  written in the rep's Voice from `PROFILE.md` if set. Under a territory or another-rep stop, replace the Suggested opener with
  "Opener and ask held until you've checked." Under an awarded or built stop, make it about the open item the stop line names and say which.

If research comes back thin, keep the same structure but say so honestly in "Why call now" rather than
inventing content to fill it. **End after the suggested opener.** After it, allow at most one "Not checked:"
line and the one next-tool line (it names the next tool, not an email type, and doesn't suggest checking
with another rep unless the chain stops), nothing else: no separate Sources list (links go inline), no notes to a
trainer or admin, no narration of how the brief was built, and no added "bottom line," recommended framing,
or strategic take. If a pattern is genuinely worth naming (e.g., "these two awards both
skipped playground scope"), it belongs as a factual note inside "Why call now," not as a separate
verdict on how the rep should approach the account.

## Hand off, don't overreach

If the rep wants to act on this brief next (an email, a call), hand off to `draft-outreach` or `prep-call`
rather than drafting those here — Call Prep may run this tool silently first and uses its output as the source of truth.
