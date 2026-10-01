---
name: research
description: >-
  Build a one-page "reason to call" dossier on a named person, company, or municipality, from public
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
as research. Every finding needs a real source and, where relevant, a real date.

## Usage budget — most reps are on a standard/basic Claude plan

Cap this at roughly 6-8 searches total for one brief. Go broad first (recent news, official
site/announcements), then one or two follow-ups only on the most promising thread. Don't chase every
tangent. If the budget runs out, present what was found and say plainly what wasn't checked, rather than
silently stopping partway through. The QuickBase cross-reference below is a read of the rep's own data, not
a web search — it doesn't spend this budget.

## Flow

1. **Identify the target and type** — person, company, or municipality/agency — from the rep's request. If
   the rep just got this from a `find-leads` result or another tool's output earlier in the conversation,
   use the lead's buyer, project, scope, budget, stage, source, and QuickBase label instead of re-asking.
   "Research #2" means the second Lead Finder result. If the target name is ambiguous (common name, multiple
   organizations with similar names), first try to settle it from the rep's territory in `PROFILE.md`
   (e.g., "Richmond parks" for a rep who covers Richmond city, VA): if exactly one match is in their
   territory, go with it and say so in one line ("I took this to mean … — tell me if you meant …").
   Only if the territory doesn't settle it, ask for a disambiguating detail before searching.
2. **Read `PROFILE.md`** for the rep's product focus, territory, Voice (if set), and QuickBase tables
   section — used for relevance framing, the suggested opener, and the cross-reference below.
3. **Research, within the usage budget**, gathering what's publicly available and relevant. For a
   municipality/agency target in the rep's counties, if the Bliss Library connector is available, call
   `my_sources(county=…)` for that entity and read its rows first: its CIP, budget, master plan, and parks page.
   Use `read_source` for about 6 reads, one literal term per call and never `OR`, before spending web searches.
   These connector reads do not spend the 6–8 web-search budget. If the connector is unavailable or the target
   is outside the rep's counties, continue with the web flow below.
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
   bounded: one page of buyer history, about 30 similar-job candidates in the last 24 months, and one nearby
   query. If QuickBase isn't connected, each section gets its own one-line skip notice.
6. **Find the public-role contacts tied to the lead (F6)** — see the section below.
7. **Present the brief** in the output shape below.

## QuickBase cross-reference (F5)

When the target is a **municipality/agency** or a **specific named project**, check it against QuickBase
before it goes into the brief. This is read-only — never write to QuickBase. Tables are referenced by
**name**, never by ID: Opportunities, Quote Pipeline, Sales Reps, County Sales Teams.

**Search order:** the **jurisdiction** name first, then any **design firm or engineer named in the public
record** (a project can surface through its firm when the city alone would not have). Match against
Opportunities and Quote Pipeline.

Match the jurisdiction on its distinctive name, contains-style and case-insensitive; the entity's own
department record counts, but a billing city alone does not, and schools, property managers, architects, and
contractors are only related notes. Search quote and opportunity names for the project too, but require a
matching city or county — never match on a park name alone. Opportunities only exist from about mid-2026, so
older jobs may be quote-only. Ignore test records: a customer, quote or job name that is
clearly a test ("TEST", "Test2", "Testing"). A real customer's quote entered under a test rep account still
counts; show its rep as "test account".

Before choosing `in pipeline`, `lost before`, or `won before`, read the matching opportunity and every matching
quote. A won quote (`Order Submitted`, `Invoiced`, or `Commission Paid`) means `won before` even under an
opportunity that still looks open. For a closed match with no won quote, use `lost before` and show an ambiguous
raw status after the label instead of asserting "lost"; check nearby quotes if the status says an alternative
was chosen.

**First use — resolve and cache.** This skill file is public and carries no QuickBase IDs.

- Resolve each table name to its table ID with the QuickBase extension's table listing, and write the
  result into the rep's local `PROFILE.md` under a **QuickBase tables** section (table name → ID).
- Resolve the field IDs the same way, **by field label**, and cache those under the same section. Make
  **one targeted field lookup per table** — never a full field dump (Quote Pipeline has several hundred
  fields). The fields this tool needs are the opportunity's customer/jurisdiction, status, dates, owner
  link, and confidence.
- Later runs read the IDs from `PROFILE.md`; only re-resolve one if a call fails because it moved. If
  `PROFILE.md` has no such section yet, create it — never re-resolve on every run, and never write an ID
  anywhere except `PROFILE.md`.

**Rules that always hold:**

- Every QuickBase call uses `select`, `where`, and `max_records` — bounded to the target, never a whole
  table scan.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round or invent one.
- If the QuickBase extension isn't connected, say **"QuickBase isn't connected"** once, leave the
  cross-reference out of the brief, and never guess a status.

**What the rep sees:** one label for the target — `new` (nothing on file), `in pipeline` (open opportunity
or quote), `lost before`, or `won before` — with the QuickBase record number the rep can open. When there's an open
quote on a project Bliss already won an earlier phase of, show both: `in pipeline · won before (2022)`.

**Bliss already involved.** Public records sometimes name Bliss's own deal — a document that names "Bliss
Products" or "Play and Park Structures" (often as the distributor of a listed playground or shelter). When
that happens, label the target **BLISS INVOLVED** *ahead of* whatever the cross-reference returns, and tell
the rep to **check with the rep of record rather than pitch it**. It's still worth the brief — just not one
to walk into cold.

## Bliss history and bid context

These sections come after the QuickBase label and before Contacts / Why call now. They are read-only. Follow
the `quickbase-usage` skill for the actual queries — it holds the tables and fields; never guess them. Show
what QuickBase has, including other reps' names, prices, and recorded lost reasons. Money always includes its
basis: **Grand Total incl. tax**. Status is shown exactly as QuickBase stores it; never translate `Close -
Multiple Alternative` into "lost".

**Bliss history with this buyer** — for the matched buyer entity, show up to 8 Bliss quotes or bids, newest
first. Use the same distinctive-name, own-department, quote-only, and TEST-exclusion rules as F5. Each line
has: date · job name · total (Grand Total incl. tax) · status exactly as shown · recorded reason lost, if any ·
co-op contract, if any · rep. End with one factual pattern line, such as "8 quotes since 2019 · 2 won ($96K
Grand Total incl. tax) · last win 2023." If QuickBase isn't connected, say: "Bliss history with this buyer:
QuickBase isn't connected." If no matching buyer history exists, say so plainly.

**Similar jobs elsewhere** — check at most 30 candidates (a hard cap) from the last 24 months, then show up to 5 that
match all three filters: the same product categories as the lead's scope from the quote line items; the same
buyer type; and a total from half to double the lead's budget. Use **Grand Total incl. tax** for every total.
The budget is the Bliss-relevant scope estimate when the source states one (e.g. the playground line item),
otherwise the whole project budget; name which one you used. If the lead has no known budget, skip the size
filter and say so in this section. Look at won jobs first
and add still-open quotes only if fewer than 5 match. If nothing matches all three filters, you may list up
to 3 near misses (right size and buyer type, but only some of the product categories), each labeled "near
miss: [what differs]"; never present a near miss as a match. Two limits to say plainly when they apply:
QuickBase files site furnishings under play equipment, so a job only counts as a playground when it has
real playground equipment, not just benches, tables or bleachers (the QuickBase skill says how to tell); and many
customers have no buyer type recorded, so a buyer with none is matched on product and size only. Each line has: buyer · state ·
date · product categories · total (Grand Total incl. tax) · status · rep. Add one factual pattern line, such as
"Bliss won 9 of 14 similar jobs; winning totals $180K–$420K (Grand Total incl. tax)." This lookup will move to
a faster Bliss Library lookup later. If QuickBase isn't connected, say: "Similar jobs elsewhere: QuickBase
isn't connected."

**Past customers nearby** — find up to 5 won jobs for other customers in the lead's county, at most 2 per
customer, won in the last 5 years. Won means exactly
`Order Submitted`, `Invoiced`, or `Commission Paid`. If the county has none, fall back to the same state and say
"fallback: same state." Never use the lead's own buyer. The county is the customer's billing county, so
leave out contractors (their billing county isn't the job site). Skip parts and small orders (Grand Total incl.
tax under $10K). Don't repeat a job already listed under Similar jobs elsewhere; add "(also listed above)" to
the count instead. Each line has: customer · product categories · year · total (Grand Total incl. tax) · rep. If QuickBase isn't connected, say: "Past customers nearby: QuickBase isn't connected."

**Who won their past bids** — first show Bliss's own lost bids to this buyer with the recorded reason lost, then
use 1–2 web searches for the agency's published bid tabs or award minutes for playground or park bids. Each
line has: date · project · winner · amount if published (Grand Total incl. tax when it is Bliss's amount) ·
source link. Add a factual pattern line when one is supported, such as "One repeat vendor won 2 of their last 3
playground bids." Web searches count toward the existing 6–8 search budget. If QuickBase isn't connected, say:
"Who won their past bids: QuickBase isn't connected." You may still use the web-search portion only when the
agency and its public bid source are identified. Skip the web part for a private buyer and say "not a public
bidder."

## Contact finder (F6)

For a municipality/agency lead, find the **public-role contacts tied to that lead** — the titles that
actually matter to Bliss's sales process, and only them:

- the **parks director** (or the parks/rec department head);
- the **purchasing agent** (or procurement officer);
- the **school facilities director** — for a school-district lead;
- the **city manager** (or county administrator) where that's the decision-maker for the lead;
- for a **private buyer**: the head of school or administrator, the facilities or business manager, the
  pastor or church administrator, or the HOA board president or property manager, from the buyer's own site;
- the **landscape architect / project lead** — **only** when a council minute or a contract-approval record
  identifies them by name, never inferred from a staff directory, a firm's team page, or a project listing.

Rules:

- **Source every contact.** Each one carries the public page it came from — a government staff directory,
  an agenda or staff report, the firm's own site, a council minute or contract approval, or a public search
  result that names the person in the role. If no public page ties a person to the role for this lead,
  don't list the role.
- **Public-role contact only.** No home address, no personal phone number, no personal email, and nothing
  that isn't tied to the public role. If a public page publishes a work phone or work email tied to the
  role, it's fine to include; otherwise leave contact details off.
- **Never guess or construct an email address** — not even an obvious first.last@ pattern. A guessed
  address is worse than none.
- **No LinkedIn scraping.** A public search result that names the person in the role is fine to cite;
  don't scrape LinkedIn (or any login-walled/social profile) for details.

This is the F6 job: the named public decision-maker tied to the lead, with the page it came from. It is
know-how, not a data source — the point is knowing which titles matter and that the architect of record
shows up in contract-approval minutes rather than a staff directory.

## Contact card mode — the Daily run

The Daily run (see **Daily run** in CLAUDE.md) asks for a short contact card on up to 3 leads, instead of
a full brief. For each lead:

- **Skip** any lead the Lead Finder flagged to check with another rep first (`BLISS INVOLVED`, or another
  rep's open quotes with that buyer): one line, "[Project]: check with [rep] first," and no card.
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
- End the section with one line: "Say 'research #N' for the full brief, or 'draft an intro for #N'." Leave
  it out when every lead was skipped.

## Output shape

One page, in this order:

- **Header** — name, title/role or type, organization, and any public contact info found (never inferred or
  guessed).
- **QuickBase cross-reference** — for a municipality/agency or named project, the one label (`BLISS
  INVOLVED` first when it applies, then `new` / `in pipeline` / `lost before` / `won before`) with the
  record number. If QuickBase isn't connected, this is just the single "QuickBase isn't connected" line.
- **Bliss history with this buyer** — up to 8 matching quotes/bids, newest first, then one factual pattern
  line. If QuickBase isn't connected, include its one-line skip notice.
- **Similar jobs elsewhere** — up to 5 matches from the bounded last-24-month candidate pull, with the size
  filter or the explicit no-budget note, then one factual pattern line. Include the one-line QuickBase skip
  notice when needed.
- **Past customers nearby** — up to 5 other-customer wins in the lead's county, or the same-state fallback
  when the county has none, with the fallback named. Include the one-line QuickBase skip notice when needed.
- **Who won their past bids** — Bliss's own lost bids first, then the limited public bid-tab/award search, with
  each source cited and a factual pattern line only when supported. Include the one-line QuickBase skip notice
  when needed.
- **Contacts** — the public-role contacts found (F6), one line each: role → name → the source page. When
  none could be sourced, say so plainly rather than inventing a title or a name.
- **Why call now** — a dated, cited bullet list of the most relevant findings, each with one line on
  why it connects to the rep's product focus (a factual connection, not a pursue/pass verdict or
  timing advice — "design is still open" is a fact; "a good time to pitch" is advice).
- **Suggested opener** — one short, natural conversation-starter line referencing the findings above,
  written in the rep's Voice from `PROFILE.md` if set.

If research comes back thin, keep the same structure but say so honestly in "Why call now" rather than
inventing content to fill it. **End after the suggested opener — no added "bottom line," recommended
framing, or strategic take.** If a pattern is genuinely worth naming (e.g., "these two awards both
skipped playground scope"), it belongs as a factual note inside "Why call now," not as a separate
verdict on how the rep should approach the account.

## Hand off, don't overreach

If the rep wants to act on this brief next (an email, a call), hand off to `draft-outreach` or `prep-call`
rather than drafting those here — Call Prep may run this tool silently first and uses its output as the source of truth.
