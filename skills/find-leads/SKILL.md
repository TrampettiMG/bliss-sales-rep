---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals — registry agendas and public PDFs first, then a web-search
  pass — grade each hit, stage it on the 0-7 ladder, score it 0-100, and cross-reference QuickBase. Reports
  what's new since the last run. Use when the rep says "find leads for my county", "what's new in my
  territory", "scan for leads", "any new signals", or similar. Repeatable: each run only surfaces items not
  already logged.
---

# Lead Finder

Scan public sources for new, dated signals in the rep's territory that suggest a playground/site-amenity
opportunity is coming — not a generic list of categories, and not a per-contact brief (that's the
`research` tool, for once the rep has a specific target to dig into).

## Reference files — read these, don't re-derive them

Two files sit alongside this one. Both are copied word for word from the PRD; never paraphrase them,
never restate them from memory.

- **`reference/stage-ladder-and-scoring.md`** — read at the **start of every run**, before you stage or
  score anything. It holds the F1 lead-scan stage ladder (0–7) and the F2 Bliss scoring rubric. The
  rubric is marked **interim**, pending the bid team's "what we look for" guide — say "interim" out loud
  if the rep asks where the weights come from, and never present the weights as final.
- **`reference/lead-grading.md`** — read as soon as you have `lead_scan` hits in hand, and **before you
  report anything that came out of `lead_scan`**. It holds the REAL/ROUTINE grading definitions and
  examples.

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. It never
invents a signal — if a scan comes back thin for a county, say so plainly rather than padding the list
with generic possibilities. Every signal needs a real source link; if there's no real source, leave it
out. If the source is real but a specific detail (like the exact date) isn't visible in what you can see
of the page, include it anyway with an explicit flag ("date not visible — verify on the page") rather
than dropping an otherwise-good lead over one missing detail. That only covers a page you could actually
read. If a source wouldn't open at all, it isn't a signal yet: leave it out and, if it looked relevant
from its title, list it on one line in the closing "Couldn't read these, open them yourself" list with
its link. Don't add it to the log, so the next run tries it again.

Also watch for wrong-location false positives — a source can easily return a same-named place in a
different state (a "Clark County" or "Las Vegas" elsewhere). Confirm the state/region matches the rep's
actual territory before including anything, and note what got excluded and why if it's not obvious.

## Reading order — where leads come from

Work in this order, every run. Steps 1–2 are the registry connector (the tools `lead_scan`, `my_sources`,
and `read_source`).

1. **`lead_scan` first.** One call over the rep's agenda sources is the cheapest, broadest first pass —
   run it before anything else, using a `since:` about 60 days back on a normal run (widen it if the rep
   asks for a longer look). Page with the returned `cursor` while there's more, as budget allows. These
   hits are a **first-pass filter, not a lead list** — grade every one (see **Grade every hit** below)
   before it goes any further. Note any sources the footer lists as "Open it yourself", "Fetch failed",
   or "Couldn't read" — they feed the closing list in step 4.
2. **`my_sources`, then `read_source`.** Call `my_sources` for the rep's counties (call it again with a
   county name if the response pages them), then read the sources it marks **readable**, in this order:
   **agendas first, then the capital improvement plan / CIP, then the adopted budget**. Use `read_source`
   with a `query` (a couple of the rep's keyword groups, e.g. `playground`, `splash pad`, `pavilion`) so
   you get the matching lines instead of a whole document, and add `pages` only when you need a section
   the hit points to. Anything that comes back as a document you couldn't read follows the fallback
   rules below before it goes on the closing list.
3. **Web search pass — only for counties with no readable source.** If `my_sources` shows every county in
   the rep's territory with at least one readable source, skip the search pass entirely and say so in one
   line. Run it only for the counties the registry can't cover (no rows, or every row "open it yourself"
   / failed), using the **Search terms** below inside the **Usage budget** below. A county the registry
   covers with agendas gets its agendas read, not searched — that's the point of the registry.
4. **Close with the "Couldn't read these, open them yourself" list** — every manual source, robots
   refusal, fetch failure, and unreadable document from steps 1–3, one line each: title, county, link,
   and the reason in a few words. These are sources the rep can open in a browser; you do not route
   around a source that blocks automated reads — that refusal is expected behavior, not a bug.

**If the connector isn't installed:** skip steps 1–2, run the web search pass for **all** of the rep's
counties, and say once, in one sentence, that the registry connector would read the rep's own agendas,
CIP, and budget directly instead of relying on search (and where setup covers it). Don't repeat that
line elsewhere in the output, and don't pretend registry-sourced coverage you didn't have.

### PDFs the connector hands back

Two literal strings from `read_source` mean "the server can't parse this one, you try":

- `scanned PDF: download it and read the page images`
- `large PDF: open it yourself`

For either, before giving up:

1. **Download the PDF and extract its text** (CoWork code execution). Many of these have a text layer
   the server can't parse, and the extraction works fine.
2. **If the extracted text is empty, read the page images** instead — render the pages and read them.
3. **Only then** put it on the closing "Couldn't read these, open them yourself" list.

**Cap it at 3 downloads per run** so one big territory doesn't stall the scan. Anything past the third
download goes straight to the closing list, no attempt — and say that the cap was hit, so the rep knows
the list is longer for that reason.

### Dates and currency

Every lead carries its document date. Drop anything whose most recent dated activity is before
2025-09-01, or whose item is more than about 12 months old — a stale plan or an old project page is not
a lead unless a newer source shows it still moving. A budget or CIP counts as dated when it names its
fiscal year, and a current or upcoming fiscal year counts as fresh. Write the fiscal year and what it
covers ("FY27 budget, July 2026–June 2027") when the document shows the fiscal-year dates or the
locality's fiscal year is stated; otherwise the label alone ("FY27 budget"). Only if a source shows no
date and no fiscal year, write "date not visible — verify on the page."

## Grade every hit before it goes any further

`lead_scan` matches a keyword list against whole agenda documents, so most hits are ordinary business
that happens to contain one of the words. Server precision is roughly 30%. **Grade every hit yourself**
using `reference/lead-grading.md`:

- **REAL** — a specific project, procurement, grant, bond, CIP, or budget line that could buy what Bliss
  sells (playground, shade structure or canopy, splash pad, surfacing, site furnishings, pavilion,
  bleachers, courts, fitness, trail amenities) at planning, funding, design, or bid stage.
- **ROUTINE** — minutes approvals, maintenance or repair of existing items, road resurfacing, judicial
  courts, legal "exercise", generic park mentions, staff or HR items.

**Only REAL hits get staged, scored, or cross-referenced.** A ROUTINE hit is set aside silently — it
never appears as a lead, never gets a score, and never reaches QuickBase.

End every output with **one count-only line** for what was set aside, e.g.
"Set aside 11 routine items." Count only — no list, no links, no detail, and no category, reason, or
parenthetical after the number. When nothing was set aside, say "Set aside 0 routine items."

## Stage and score

Read `reference/stage-ladder-and-scoring.md` before this step, every run.

- **Stage (F1):** give every REAL lead a stage number 0–7 from the ladder, on what the source actually
  shows — don't promote a lead on a guess. **Stage 7 is excluded automatically**: a lead that's already
  awarded, under construction, or complete never appears in the output. Stages 2–5 are the target band.
  Stage 6 (bid or RFP posted) is a different play — an act-now price response — and still gets shown.
- **Score (F2):** score every staged lead 0–100 with a **one-line reason**, using the rubric's factors in
  their order of weight (stage fit heaviest, then project dollar size, product fit by which keyword
  groups matched, funding certainty, cooperative-contract path, existing relationship on file). The
  rubric file marks the weights **interim**. Say what a factor rests on only if the source shows it —
  never assume funding, size, or a due date that isn't visible; call it "not stated" instead. Score only
  REAL leads that survived the stage-7 exclusion.
- Rank the output by score, highest first, and open the list with the summary line the rubric asks for:
  **"Found N, call these X now"** — not a flat list. X is the leads in the top band (roughly the top
  three scoring leads); name them.

## QuickBase cross-reference (F5)

Every REAL lead is checked against QuickBase **before** it's shown as new. Tables are referenced by
**name**, never by ID: Opportunities, Quote Pipeline, Sales Reps, County Sales Teams.

**First use — resolve and cache.** This skill file is public and carries no QuickBase IDs.

- Resolve each table name to its table ID with the QuickBase extension's table listing, and write the
  result into the rep's local `PROFILE.md` under a **QuickBase tables** section (table name → ID).
- Resolve the field IDs the same way, **by field label**, and cache those under the same section. Make
  **one targeted field lookup per table** — never a full field dump (Quote Pipeline has several hundred
  fields). The fields this tool needs are the opportunity's customer/jurisdiction, status, dates,
  owner link, and confidence.
- Later runs read the IDs from `PROFILE.md`; only re-resolve one if a call fails because it moved. If
  `PROFILE.md` has no such section yet, create it — never re-resolve on every run, and never write an ID
  anywhere except `PROFILE.md`.

**What to search.** For each REAL lead: the **jurisdiction** name first, then any **design firm or
engineer named in the public document**. A project can surface through its firm when the city alone
wouldn't have. Match against Opportunities and Quote Pipeline.

**Rules that always hold:**

- Every QuickBase call uses `select`, `where`, and `max_records`. One lead's slice is bounded — pull it
  directly, never scan the whole table.
- Group reps by the **Sales Rep** link — never "Record Owner".
- Convert any UTC timestamp to **Eastern Time** before showing it.
- **Confidence is only ever one of the five values** the QuickBase field accepts: 0%, 25%, 50%, 75%, 99%
  (stored 0, 0.25, 0.5, 0.75, 0.99). Never round a rep's number to something else, and never invent one.
- A lead already open in QuickBase is labeled **in pipeline**, never presented as new.

**Labels on each lead:** `new` (nothing on file), `in pipeline` (open opportunity or quote), `lost
before`, or `won before`, plus the QuickBase record number the rep can open. If the extension isn't
connected, say **"QuickBase isn't connected"** once, leave the label off every lead, and never guess a
status.

**Bliss already involved.** Public documents sometimes name Bliss's own deal — a document that names
"Bliss Products" or "Play and Park Structures" (often as the distributor of a listed playground or
shelter). When that happens, label the lead **BLISS INVOLVED** *ahead of* whatever the cross-reference
returns, and tell the rep to **check with the rep of record rather than pitch it**. It's still a lead
worth surfacing — just not one to walk into cold.

## The log — what makes this repeatable

Keep a project file `find-leads-log.md` — one entry per signal ever surfaced, each with its date, county,
one-line description, stage, score, QuickBase label, and source URL. On every run:

1. **Look for the log anywhere in the project first**, including a subfolder like `claude/` — some setups
   save files there. Use and update it where you find it; never start a second log. If
   `find-leads-log.md` truly doesn't exist yet, this is the rep's first run — scan normally and treat
   everything found as new. Create the log with today's results.
2. If it exists, compare against the log **by the underlying event, not just the literal URL** — a
   different article covering the same groundbreaking, budget vote, or grant award is still the same
   signal, not a new one. Only report items that are genuinely new.
   **Exception — the same project at a later stage is news.** If a result is a project already in the log
   but the source shows it has clearly moved forward, report it under a separate **"Moved up since your
   last scan"** heading above everything else: one line each with the old stage, the new stage, date and
   source ("Tuckahoe District Park, Henrico: FY27 design money → construction RFP posted Oct 3"). Update
   its log entry with the new stage rather than adding a second entry. Never spend extra searches
   re-checking old items. If nothing new turned up, say so plainly: "Nothing new since your last run on
   [date]" — don't re-surface old items or pad the list to look productive.
3. Append newly surfaced items to the log after reporting them. **Verify the write actually happened —
   read the file back, or otherwise confirm it — before telling the rep it's saved.** Count the entries
   you just added in the file you read back, and put that count in the saved line ("Saved 10 new items to
   your lead log.") so it can be checked. If the count doesn't match what you reported, say the save
   didn't fully work instead. Never state the log was updated unless you've confirmed it.
4. **Keep the log from growing unbounded.** If entries older than ~90 days start making the log large
   enough to burn significant context just to check for dupes, collapse them to a compact
   one-line-per-item form (date + headline + URL) instead of dropping them — they're still needed for
   dedup.

## Usage budget — most reps are on a standard/basic Claude plan

Web searches count against the rep's own usage limits. The registry steps above cost no search budget, so
on a connector run the pass is small; on the connector-missing route it's the whole scan. Stay
disciplined:

- **Cap it at roughly 2 searches per category per run** (about 10 total) — one broad search, one narrower
  follow-up only if the first looked promising. Don't chain additional searches chasing a thin lead.
- If the budget runs out before covering every county, **stop and report what you found**, and say
  plainly which counties weren't checked (e.g., "Didn't get to Columbia County this time — ask again to
  pick it up.") rather than silently skipping them.
- **Check the log's last-run date first.** If the rep already ran this today, say so and ask if they
  still want to spend a fresh scan. Still run it if they say yes.
- **Multiple counties don't multiply the budget.** Combine counties into one query per category
  (e.g., "Clark County Nevada OR Washoe County Nevada new park playground 2026") rather than running
  separate searches per county. If you do have to prioritize or skip a county, say so plainly.

## Search terms

Use these to build each category's query and to judge whether a result is relevant. **Never run one
search per term** — that blows the budget above. Pick the 3-5 terms that best fit the rep's product focus
and combine them with OR (e.g., `"playground" OR "splash pad" OR "shade structure"`).

- **Play:** playground, inclusive playground, accessible / ADA playground, play structure, swings,
  splash pad, spray park, spray ground, dog park, skate park
- **Surfacing:** poured-in-place (PIP), rubber surfacing, rubber tile, engineered wood fiber (EWF),
  playground mulch, synthetic turf, resurfacing
- **Shade & structures:** shade structure, shade canopy, pavilion, shelter, gazebo, pole barn,
  prefabricated / metal building, restroom building
- **Site furnishings:** site furnishings, park benches, picnic tables, trash receptacles, bleachers,
  grandstand, seating, drinking fountains, bike racks
- **Sports & fitness:** athletic equipment, outdoor fitness, basketball / tennis / pickleball courts,
  track & field equipment, walking track
- **Parks & trails:** park improvements, park renovation, park amenities, trail, pedestrian bridge,
  campground, pier

The same grouped list is what the connector matches on — a hit that matched one of these groups is a
keyword hit, not a graded lead until you grade it.

Traps to avoid:
- Never search on a bare broad word — "park" (matches parking), "site", "trash", "table", "courts"
  (matches court buildings), "seating". Always pair it: "park playground," "site furnishings," "picnic
  table," "pickleball courts."
- Buying often shows up as a co-op purchase instead of an open bid — a council or board agenda approving
  a purchase "through Sourcewell / BuyBoard / TIPS / OMNIA" is a real signal, and it scores on the
  cooperative-contract factor.

## Output shape

In this order:

1. **"Moved up since your last scan"** — tracked leads that advanced (skip the heading if there are none).
2. **"Found N, call these X now"** — the ranked REAL leads, highest score first. Each: county and
   jurisdiction, what happened, the document date, the stage number, the score with its one-line reason,
   the QuickBase label (`BLISS INVOLVED` / `new` / `in pipeline` / `lost before` / `won before`) with the
   record number, and the source link. For an open bid or RFP, always include the due date (or "due date
   not visible — verify on the page").
3. **Coverage line** — every county in the run, with what it produced ("Chesterfield: 2 · Henrico: 2 ·
   Richmond city: nothing new"), plus any categories not reached and any county covered only by search.
4. **"Couldn't read these, open them yourself"** — one line per source: title, county, link, reason.
   Mention the download cap if it was hit.
5. **"Saved N new items to your lead log."** — only after the write is verified.
6. One closing line offering both next steps: "Want more on one of these? That's the Research Brief. Or
   an intro email built around one of them? That's the Email Writer." When the rep picks one, pass that
   lead (what, when, stage, source) to the Email Writer as known context.
7. **The last line of the output** is the ROUTINE count, and it is count-only — no list, no links, and no
   category, reason, or parenthetical after the number: "Set aside 11 routine items." When nothing was set
   aside, "Set aside 0 routine items." Nothing follows it.

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory, product focus, and QuickBase tables section.
   If a **Focus Counties** line is filled in, scan **only those** — don't widen to neighboring counties
   or a metro/region, even ones in the rep's territory. If the rep wants a wider scan, they'll ask
   ("scan all my counties," "add Hanover"). If there's no Focus Counties line and the rep has more than
   about 10 counties, ask once which few to focus on this run (and offer to save them). If territory is
   missing or too broad (just a state name), ask for the county or counties — and if the connector is
   present, `my_sources` will list the counties the rep actually has.
2. **Run the reading order** (steps 1–4 above) for those counties.
3. **Grade** every `lead_scan` hit REAL/ROUTINE, then **drop** anything that fails the stage-7 exclusion
   or the currency rule.
4. **Check the log** and keep only genuinely new items, marking moved-up leads separately.
5. **Stage and score** the survivors, and **cross-reference** each one against QuickBase.
6. **Present** in the output shape above.
7. **Update the log** and verify the write.
8. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
