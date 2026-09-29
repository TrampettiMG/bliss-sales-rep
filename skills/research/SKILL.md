---
name: research
description: >-
  Build a one-page "reason to call" dossier on a named person, company, or municipality, from public
  web sources — cross-referenced against QuickBase, with the public-role contacts tied to the lead.
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
   use those details instead of re-asking. If the target name is ambiguous (common name, multiple
   organizations with similar names), first try to settle it from the rep's territory in `PROFILE.md`
   (e.g., "Richmond parks" for a rep who covers Richmond city, VA): if exactly one match is in their
   territory, go with it and say so in one line ("I took this to mean … — tell me if you meant …").
   Only if the territory doesn't settle it, ask for a disambiguating detail before searching.
2. **Read `PROFILE.md`** for the rep's product focus, territory, Voice (if set), and QuickBase tables
   section — used for relevance framing, the suggested opener, and the cross-reference below.
3. **Research, within the usage budget**, gathering what's publicly available and relevant:
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
     For a **school district**, the equivalent is its facilities plan or bond program.
4. **For a municipality/agency or a named project, cross-reference QuickBase (F5)** — see the section
   below. Do this before presenting the brief, and read only.
5. **Find the public-role contacts tied to the lead (F6)** — see the section below.
6. **Present the brief** in the output shape below.

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
older jobs may be quote-only. Ignore records with `TEST` in the rep or customer name.

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
or quote), `lost before`, or `won before` — with the QuickBase record number the rep can open.

**Bliss already involved.** Public records sometimes name Bliss's own deal — a document that names "Bliss
Products" or "Play and Park Structures" (often as the distributor of a listed playground or shelter). When
that happens, label the target **BLISS INVOLVED** *ahead of* whatever the cross-reference returns, and tell
the rep to **check with the rep of record rather than pitch it**. It's still worth the brief — just not one
to walk into cold.

## Contact finder (F6)

For a municipality/agency lead, find the **public-role contacts tied to that lead** — the titles that
actually matter to Bliss's sales process, and only them:

- the **parks director** (or the parks/rec department head);
- the **purchasing agent** (or procurement officer);
- the **school facilities director** — for a school-district lead;
- the **city manager** (or county administrator) where that's the decision-maker for the lead;
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

## Output shape

One page, in this order:

- **Header** — name, title/role or type, organization, and any public contact info found (never inferred or
  guessed).
- **QuickBase cross-reference** — for a municipality/agency or named project, the one label (`BLISS
  INVOLVED` first when it applies, then `new` / `in pipeline` / `lost before` / `won before`) with the
  record number. If QuickBase isn't connected, this is just the single "QuickBase isn't connected" line.
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
rather than drafting those here — this tool's job stops at the research and the sourced contacts.
