---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals — registry agendas and public PDFs first, then a web-search
  pass — grade each hit, stage it on the 0-7 ladder, score it 0-100, and cross-reference QuickBase. Reports
  what's new since the last run. Use when the rep says "find leads for my county", "what's new in my
  territory", "scan for leads", "any new signals", or similar. Repeatable: each run surfaces only items not
  already on the shared lead board (`lead-board.xlsx`).
---

# Lead Finder

Scan public sources for new, dated signals in the rep's territory that suggest a playground/site-amenity
opportunity is coming — not a generic list of categories, and not a per-contact brief (that's the `research`
tool, for a target the rep already has).

## Reference files — read these, don't re-derive them

Six files sit alongside this one. Never paraphrase them or restate them from memory.

- **`reference/stage-ladder-and-scoring.md`** — read at the **start of every run**, before you stage or score
  anything. Holds the F1 stage ladder (0–7) and the F2 Bliss rubric, marked **interim** pending the bid team's
  "what we look for" guide — say "interim" if the rep asks where the weights come from, and never present them
  as final.
- **`reference/lead-grading.md`** — read as soon as you have `lead_scan` hits in hand, and **before you report
  anything that came out of `lead_scan`**. Holds the REAL/ROUTINE definitions, examples, and edge cases.
- **`reference/qb-cross-reference.md`** — read **before the cross-reference step of any run**, and again when
  a call fails because a table or field moved. Holds the resolve-and-cache procedure, what to search, and the
  query rules that always hold.
- **`reference/pdf-fallback.md`** — read **when `read_source` returns the scanned-PDF or large-PDF string**,
  before that document goes on the closing list. Holds the download/extract/page-image ladder.
- **`reference/search-terms.md`** — read when you build the search pass in step 3, and when you judge whether
  a hit is relevant. Holds the grouped keyword list, the query traps, and the usage budget.
- **`reference/board-reconciliation.md`** — read before you check or update the lead board, every run. Holds the
  column-ownership map, the reconcile-by-lead rule, the stage-move heading, and write verification.

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. Never invent a
signal — if a scan comes back thin for a county, say so plainly rather than padding the list with generic
possibilities. Every signal needs a real source link; no real source, no lead. If the source is real but a
detail (like the exact date) isn't visible in what you can read of the page, include it anyway with an
explicit flag ("date not visible — verify on the page") rather than drop a good lead over one missing detail.
A source that wouldn't open at all isn't a signal yet: leave it out, and if its title looked relevant list it
on one line in the closing "Couldn't read these, open them yourself" list with its link — don't add it to the
board, so the next run tries it again. Watch for wrong-location false positives — a source can easily return a
same-named place in a different state (a "Clark County" or "Las Vegas" elsewhere). Confirm the state/region
matches the rep's actual territory and note what got excluded and why if it isn't obvious.

## Reading order — where leads come from

Work in this order, every run. Steps 1–2 are the registry connector (the tools `lead_scan`, `my_sources`, and
`read_source`). Before step 1, work out which of the three connector branches you're in:

- **Connector present** — run steps 1–4 as written.
- **Connector not installed** — skip steps 1–2, run the web search pass for **all** the rep's counties, and
  say once, in one sentence, that the registry connector would read the rep's own agendas, CIP, and budget
  directly instead of relying on search (and where setup covers it). Don't repeat that line elsewhere in the
  output, and don't pretend registry-sourced coverage you didn't have.
- **Territory still loading** — if `my_sources`, `read_source`, or `lead_scan` returns the literal
  `TERRITORY_PENDING` message ("Your territory isn't set up yet. Trampetti is loading it; your sources will
  appear here."), **stop the run**. Tell the rep plainly that their territory is still loading, that their
  sources will appear once Trampetti finishes, and to try again later today or tomorrow. Do **not** run the
  web-search pass, do **not** report an empty or thin result, and do **not** write the board.

1. **`lead_scan` first.** One call over the rep's agenda sources is the cheapest, broadest first pass — run it
   before anything else, with a `since:` about 60 days back (widen it if the rep asks for a longer look). Page
   with the returned `cursor` while there's more, as budget allows. These hits are a **first-pass filter, not
   a lead list** — grade every one (see **Grade every hit** below). Note any sources the footer lists as "Open
   it yourself", "Fetch failed", or "Couldn't read" — they feed the closing list in step 4.
2. **`my_sources`, then `read_source`.** Call `my_sources` for the rep's counties (again with a county name if
   the response pages them), then read the sources it marks **readable**, in this order: **agendas first, then
   the CIP, then the adopted budget**. Pass `read_source` a `query` (a couple of the rep's keyword groups,
   e.g. `playground`, `splash pad`, `pavilion`) for the matching lines instead of a whole document, and add
   `pages` only for a section the hit points to. A document you couldn't read follows the PDF-fallback rules
   before the closing list.
3. **Web search pass — only for counties with no readable source.** If `my_sources` shows every county in the
   rep's territory with at least one readable source, skip the search pass entirely and say so in one line.
   Run it only for counties the registry can't cover (no rows, or every row "open it yourself" / failed),
   inside the usage budget in `reference/search-terms.md`. A county the registry covers with agendas gets its
   agendas read, not searched — that's the point of the registry.
4. **Close with the "Couldn't read these, open them yourself" list** — every manual source, robots refusal,
   fetch failure, and unreadable document from steps 1–3, one line each: title, county, link, reason in a few
   words. Never route around a source that blocks automated reads — that refusal is expected behavior, not a
   bug.

### Dates and currency

Every lead carries its document date. Drop anything whose most recent dated activity is before 2025-09-01, or
whose item is more than ~12 months old — a stale plan or old project page is not a lead unless a newer source
shows it still moving. A budget or CIP counts as dated when it names its fiscal year, and a current or
upcoming fiscal year counts as fresh. Write the fiscal year and what it covers ("FY27 budget, July 2026–June
2027") when the document shows the fiscal-year dates or the locality's fiscal year is stated; otherwise the
label alone ("FY27 budget"). Only if a source shows no date and no fiscal year, write "date not visible —
verify on the page."

## Grade every hit before it goes any further

`lead_scan` matches a keyword list against whole agenda documents, so most hits are ordinary business that
happens to contain one of the words. Server precision is roughly 30%. **Grade every hit yourself**, using
`reference/lead-grading.md` for the full definitions and edge cases: **REAL** is a specific project,
procurement, grant, bond, CIP, or budget line that could buy what Bliss sells (playground, shade structure or
canopy, splash pad, surfacing, site furnishings, pavilion, bleachers, courts, fitness, trail amenities) at
planning, funding, design, or bid stage; **ROUTINE** is minutes approvals, maintenance or repair of existing
items, road resurfacing, judicial courts, legal "exercise", generic park mentions, or staff/HR items.

**Only REAL hits get staged, scored, or cross-referenced.** A ROUTINE hit is set aside silently — it never
appears as a lead, never gets a score, and never reaches QuickBase.

End every output with **one count-only line** for what was set aside, e.g. "Set aside 11 routine items." Count
only — no list, no links, no detail, and no category, reason, or parenthetical after the number. When nothing
was set aside, say "Set aside 0 routine items."

## Stage and score

Read `reference/stage-ladder-and-scoring.md` before this step, every run.

- **Stage (F1):** give every REAL lead a stage number 0–7 from the ladder, on what the source actually shows —
  don't promote a lead on a guess. **Stage 7 is excluded automatically**: a lead that's already awarded, under
  construction, or complete never appears in the output. Stages 2–5 are the target band. Stage 6 (bid or RFP
  posted) is a different play — an act-now price response — and still gets shown.
- **Score (F2):** score every staged lead 0–100 with a **one-line reason**, using the rubric's factors in
  their order of weight (stage fit heaviest, then project dollar size, product fit by which keyword groups
  matched, funding certainty, cooperative-contract path, existing relationship on file). The rubric file marks
  the weights **interim**. Say what a factor rests on only if the source shows it — never assume funding,
  size, or a due date that isn't visible; call it "not stated" instead. Score only REAL leads that survived
  the stage-7 exclusion.
- Rank the output by score, highest first, and open the list with the summary line the rubric asks for:
  **"Found N, call these X now"** — not a flat list. X is the leads in the top band (roughly the top three
  scoring leads); name them.

## QuickBase cross-reference (F5)

Every REAL lead is checked against QuickBase **before** it's shown as new. Tables are referenced by **name**,
never by ID (this public skill file carries no QuickBase IDs): Opportunities, Quote Pipeline, Sales Reps,
County Sales Teams. Read `reference/qb-cross-reference.md` before the cross-reference step of any run — it
holds the resolve-and-cache procedure (IDs cached in the rep's `PROFILE.md` under a **QuickBase tables**
section, nowhere else), what to search (the jurisdiction first, then any design firm or engineer named in the
public document), and the query rules that always hold (`select`/`where`/`max_records`; group by the **Sales
Rep** link, never "Record Owner"; UTC → **Eastern Time**; Confidence only ever 0%, 25%, 50%, 75%, or 99%; an
already-open lead is **in pipeline**, never new).

**Labels on each lead:** `new` (nothing on file), `in pipeline` (open opportunity or quote), `lost before`, or
`won before`, plus the QuickBase record number the rep can open. If the extension isn't connected, say
**"QuickBase isn't connected"** once, leave the label off every lead, and never guess a status.

**Bliss already involved.** A public document that names "Bliss Products" or "Play and Park Structures" (often as the
distributor of a listed playground or shelter) means label the lead **BLISS INVOLVED** *ahead of* whatever the
cross-reference returns, and tell the rep to **check with the rep of record rather than pitch it**. It's still
worth surfacing — just not one to walk into cold.

## The lead board — what makes this repeatable

The tracker is `lead-board.xlsx` — the shared spreadsheet `my-new-leads` also keeps: one row per lead the rep
has seen, the same columns, in the project folder. It replaces the old markdown log: never keep, start, or
append to `find-leads-log.md`, and never start a second board. Read `reference/board-reconciliation.md` before
you check or update it, and follow it: look for the board anywhere in the project first, including a subfolder
like `claude/`; reconcile by the underlying lead (same agency, project, and county — not the literal URL),
never re-adding a known lead as new; update a stage move in place; refresh the current check date on the rows
you actually checked; and verify the spreadsheet write by reading it back before you tell the rep anything is
saved. A legacy `find-leads-log.md`, if the rep has one, is imported once and then left untouched.

## Output shape — in this order

1. **"Moved up since your last scan"** — tracked leads that advanced (skip the heading if there are none).
2. **"Found N, call these X now"** — the ranked REAL leads, highest score first. Each: county and
   jurisdiction, what happened, the document date, the stage number, the score with its one-line reason, the
   QuickBase label (`BLISS INVOLVED` / `new` / `in pipeline` / `lost before` / `won before`) with the record
   number, and the source link. For an open bid or RFP, include the due date (or "due date not visible —
   verify on the page").
3. **Coverage line** — every county in the run, with what it produced ("Chesterfield: 2 · Henrico: 2 ·
   Richmond city: nothing new"), plus any categories not reached and any county covered only by search.
4. **"Couldn't read these, open them yourself"** — one line per source: title, county, link, reason. Mention
   the download cap if it was hit.
5. **"Saved your lead board — N leads, M rows changed."** — only after the write is read back and verified.
6. One closing line offering both next steps: "Want more on one of these? That's the Research Brief. Or an
   intro email built around one of them? That's the Email Writer." When the rep picks one, pass that lead
   (what, when, stage, source) to the Email Writer as known context.
7. **The last line of the output** is the ROUTINE count, and it is count-only — no list, no links, and no
   category, reason, or parenthetical after the number: "Set aside 11 routine items." When nothing was set
   aside, "Set aside 0 routine items." Nothing follows it.

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory, product focus, and QuickBase tables section. If a
   **Focus Counties** line is filled in, scan **only those** — don't widen to neighboring counties or a
   metro/region, even ones in the rep's territory. If the rep wants a wider scan, they'll ask ("scan all my
   counties," "add Hanover"). With no Focus Counties line and more than ~10 counties, ask once which few to
   focus on this run (and offer to save them). If territory is missing or too broad (just a state name), ask
   for the county or counties — with the connector present, `my_sources` lists the counties the rep actually
   has.
2. **Run the reading order** (steps 1–4 above) for those counties.
3. **Grade** every `lead_scan` hit REAL/ROUTINE, then **drop** anything that fails the stage-7 exclusion or
   the currency rule.
4. **Check the board** and keep only genuinely new items, marking stage moves separately.
5. **Stage and score** the survivors, and **cross-reference** each one against QuickBase.
6. **Present** in the output shape above.
7. **Update the board** and verify the spreadsheet write.
8. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
