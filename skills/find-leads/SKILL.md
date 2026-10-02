---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals from the Bliss Library connector — curated agendas and public
  registry documents — then grade each hit, stage it on the 0-7 ladder, score it 0-100, and cross-reference QuickBase. Reports
  what's new since the last run. Use when the rep says "find leads for my county", "what's new in my
  territory", "scan for leads", "any new signals", or similar ("run my daily run" / "run my morning leads" is the
  Daily run in CLAUDE.md, which uses this tool's morning digest mode as its first step). Repeatable: each run surfaces only items not
  already on the shared lead board (`lead-board.xlsx`).
---

# Lead Finder

The Bliss Library connector is the source of truth for new leads. Leads come only from its `lead_scan` hits
and from projects found in the registry's own CIP, budget, and master-plan documents through `my_sources` and
`read_source`. Web search can enrich an existing connector lead, but never creates one. This surfaces new,
dated signals in the rep's territory that suggest a playground/site-amenity opportunity is coming — not a
generic list of categories, and not a per-contact brief (that's the `research` tool, for a target the rep
already has).

## Reference files — read these, don't re-derive them

Read these saved project files at the stated step. Their repo paths remain the `reference/...` paths shown below.

- **`Lead Finder - Stages and Scoring.md`** (`reference/stage-ladder-and-scoring.md`) — at the **start of every run**, before staging or scoring; F1 ladder and interim F2 rubric.
- **`Lead Finder - Lead Grading.md`** (`reference/lead-grading.md`) — as soon as `lead_scan` returns hits, before reporting them; REAL/ROUTINE definitions and edge cases.
- **`Lead Finder - QuickBase Check.md`** (`reference/qb-cross-reference.md`) — before cross-reference, and when a table or field moved; resolve/cache procedure and query rules.
- **`Lead Finder - PDF Fallback.md`** (`reference/pdf-fallback.md`) — when `read_source` returns a scanned-PDF, large-PDF, or unreadable-PDF fallback; download/extract/page-image ladder.
- **`Lead Finder - Search Terms.md`** (`reference/search-terms.md`) — when choosing literal `read_source` terms, judging relevance, or enriching a lead; keyword groups, query traps, and budget.
- **`Lead Finder - Lead Board.md`** (`reference/board-reconciliation.md`) — before checking or updating the board; ownership, reconciliation, stage moves, and write verification.

If a named file is not in the project, look in subfolders. If still missing, fetch `https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/find-leads/reference/<file>.md`, save it under its named project-file name, then continue.

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. Never invent a
signal — if the connector comes back thin for a county, say so plainly rather than padding the list with generic
possibilities. Every signal needs a real library source link; no library source, no lead. If the source is real but a
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
- **Connector not installed** — say once: "Lead Finder needs the Bliss Library connection; your trainer sets
  it up." Stop there: do not web-search, write the board, or pretend registry-sourced coverage you didn't have.
- **Territory still loading** — if `my_sources`, `read_source`, or `lead_scan` returns the literal
  `TERRITORY_PENDING` message ("Your territory isn't set up yet. Trampetti is loading it; your sources will
  appear here."), **stop the run**. Tell the rep plainly that their territory is still loading, that their
  sources will appear once Trampetti finishes, and to try again later today or tomorrow. Do **not** run the
  web-search, do **not** report an empty or thin result, and do **not** write the board.

1. **`lead_scan` first.** One call over the rep's agenda sources is the cheapest, broadest first pass — run it
   before anything else, with a `since:` about 60 days back (widen it if the rep asks for a longer look). Page
   with the returned `cursor` while there's more, as budget allows; if the output shows no "next cursor", the
   scan is complete. If the county filter fails and the scan comes back for every county on the account,
   keep only hits from the counties you're scanning this run. These hits are the connector's daily agenda
   signals: grade each one (see **Grade every hit** below) and order the REAL projects ahead of routine
   agenda items. If it returns 0 leads while most agendas were blocked or unreadable, say the agendas were
   **not checked**, never "nothing new on agendas." It may pick the latest meeting of any board, so only
   governing-board and parks/rec-board failures belong in the closing list; drop irrelevant boards silently.
   Note any sources the footer lists as "Open it yourself", "Fetch failed", or "Couldn't read" — they feed the
   closing list in step 4.
2. **`my_sources`, then `read_source`.** Call `my_sources` for the rep's counties (again with a county name if
   the response pages them), then read the sources it marks **readable**. After the agenda pass, prioritize
   **CIP, then budget, then master plan**, most recent fiscal year first. For each, choose the 2–3 terms that
   best fit the rep's product focus — default `playground`, then `shade`, then `splash pad` — and pass
   `read_source` one literal `query` phrase per call (never combine terms with `OR`). Each call returns at most
   12 page-numbered hits; skip boilerplate and duplicate hits, and cap the successful `read_source` calls at
   about 12 per run (a `pages` read counts; a failed call you retry once doesn't). Add `pages` only for a section the hit points to. A document you couldn't read follows the
   PDF-fallback rules before the closing list. If a library source is clearly an old edition, such as a fiscal
   year two or more years behind, leave it out of the signals and add: "The library's link for [entity] [doc
   type] looks out of date. Tell your trainer."
3. **Enrich only existing connector leads.** After a lead exists, use web search only for a missing contact or
   buyer name, bid due date or bid page, pre-bid information, or newer news on that same project. Search only
   the top-scored leads, about 1–2 searches per lead and roughly 6 per run. Never add a lead from web search or
   replace a library fact with a web fact; if they disagree, show both and say so. Cite the web source separately.
   Skip enrichment when nothing is missing. Report it as "added details from the web for N leads."
4. **Close with the "Couldn't read these, open them yourself" list** — keep it compact and include governing or
   parks/rec agenda failures, "open it yourself" documents, stale library links, counties with no library
   sources ("no library sources for [county] yet — tell your trainer"), and connector errors. Retry a connector
   error once, then give one plain line. Keep irrelevant-board failures out of the list.

### Dates and currency

Every lead carries its document date. Drop anything whose most recent dated activity is before 2025-09-01, or
whose item is more than ~12 months old — a stale plan or old project page is not a lead unless a newer source
shows it still moving. A budget or CIP counts as dated when it names its fiscal year, and a current or
upcoming fiscal year counts as fresh. Write the fiscal year and what it covers ("FY27 budget, July 2026–June
2027") when the document shows the fiscal-year dates or the locality's fiscal year is stated; otherwise the
label alone ("FY27 budget"). Only if a source shows no date and no fiscal year, write "date not visible —
verify on the page."

## Grade every hit before it goes any further

The connector supplies a curated daily source list. **Grade every hit yourself**, using
`Lead Finder - Lead Grading.md` (`reference/lead-grading.md`) for the full definitions and edge cases: **REAL** is a specific project,
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

Read `Lead Finder - Stages and Scoring.md` (`reference/stage-ladder-and-scoring.md`) before this step, every run.

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
  scoring leads); name them. Leave out of the "call now" names any lead that says to check with another rep
  first (`BLISS INVOLVED`, or another rep's open quote or opportunity for this same project); it stays in the
  list at its score. Another rep's open quotes with the same buyer on other projects get one line on the lead
  ("[Rep] has other open quotes with this buyer"), and the lead stays callable.

## QuickBase cross-reference (F5)

Every REAL lead is checked against QuickBase **before** it's shown as new. Tables are referenced by **name**,
never by ID (this public skill file carries no QuickBase IDs): Opportunities, Quote Pipeline, Sales Reps,
County Sales Teams. Read `Lead Finder - QuickBase Check.md` (`reference/qb-cross-reference.md`) before the cross-reference step of any run — it
holds the resolve-and-cache procedure (IDs cached in the rep's `PROFILE.md` under a **QuickBase tables**
section, nowhere else), what to search (the jurisdiction first, then any design firm or engineer named in the
public document), and the query rules that always hold (`select`/`where`/`max_records`; group by the **Sales
Rep** link, never "Record Owner"; UTC → **Eastern Time**; Confidence only ever 0%, 25%, 50%, 75%, or 99%; an
already-open lead is **in pipeline**, never new).

**Labels on each lead:** `new` (nothing on file), `in pipeline (yours)` / `in pipeline ([rep])` (open
opportunity or quote), `Close - Multiple Alternative`, `lost before`, or `won before`, chosen by the precedence
in `Lead Finder - QuickBase Check.md`, plus the QuickBase record number the rep can open. Labels describe **this job**; the
jurisdiction's history is a separate note. When the jurisdiction is on file as a customer, add its history
after any label, including `new`, e.g. "`new` · past customer: 6 quotes, last 2026 (bleachers), none won"
(most recent job name and year, quote count, and whether any was won). Nothing on file at all: just `new`.
If the extension isn't connected, say
**"QuickBase isn't connected"** once, leave the label off every lead, and never guess a status.

**Bliss already involved.** A public document that names "Bliss Products" or "Play and Park Structures" (often as the
distributor of a listed playground or shelter) means label the lead **BLISS INVOLVED** *ahead of* whatever the
cross-reference returns, and tell the rep to **check with the rep of record rather than pitch it**. It's still
worth surfacing — just not one to walk into cold.

## History line on the top leads

For the top 5 leads in a normal run, add one line immediately after the QuickBase label. Build it from the
QuickBase lookup already done for that lead — no web searches — plus at most one bounded nearby lookup per
county. Use this form: "History: 6 quotes since 2019, 1 won (2023 shade, $48K Grand Total incl. tax), last
closed 2026 'Close - Multiple Alternative' · Nearby: [customer] bought a playground in 2025 ([rep])".
History counts the buyer's matching quotes, includes the latest win and last closed status exactly as stored,
and never calls `Close - Multiple Alternative` a loss. Nearby means the most recent project-sized won job
for another customer in the same county: skip parts, replacement-part and small orders (Grand Total incl. tax
under $10K, or a job name like "parts," "replacement," "hardware"). If there is none, use the same state and
say "in [state]". Never use the lead's
own buyer. If no buyer history exists, write "History: none on file." If QuickBase isn't connected, write
"History: unavailable — QuickBase isn't connected." Keep it to one line.

## The lead board — what makes this repeatable

The tracker is `lead-board.xlsx` — the shared spreadsheet `my-new-leads` also keeps: one row per lead the rep
has seen, the same columns, in the project folder. It replaces the old markdown log: never keep, start, or
append to `find-leads-log.md`, and never start a second board. Read `Lead Finder - Lead Board.md` (`reference/board-reconciliation.md`) before
you check or update it, and follow it: look for the board anywhere in the project first, including a subfolder
like `claude/` (and as `lead-board.csv` where the project only holds text files); reconcile by the underlying lead (same agency, project, and county — not the literal URL),
never re-adding a known lead as new; update a stage move in place; refresh the current check date on the rows
you actually checked; and verify the spreadsheet write by reading it back before you tell the rep anything is
saved. A legacy `find-leads-log.md`, if the rep has one, is imported once and then left untouched. For a
stage-6 bid lead, put the due date exactly as the documents state it in `Bid Due`.

## Output shape — in this order

1. **"Moved up since your last scan"** — tracked leads that advanced (skip the heading if there are none).
2. **"Found N, call these X now"** — the ranked REAL leads, highest score first. Each: county and
   jurisdiction, what happened, the document date, the stage number, the score with its one-line reason, the
   QuickBase label (`BLISS INVOLVED` / `new` / `in pipeline (yours)` or `in pipeline ([rep])` / `lost
   before` / `Close - Multiple Alternative` / `won before`) with the record number, and the source link. For an open bid or RFP, include the due date (or "due date not visible —
   verify on the page"). For the top 5, add the one-line History entry immediately after the QuickBase label.
   A detail added by web enrichment goes on the same lead, marked "Web:" with its own link, after the library
   source; never in place of it.
3. **Coverage line** — every county in the run, with what the library produced ("Chesterfield: 2 · Henrico: 2
   · Richmond city: nothing new"), plus any source types not reached and any county with no library sources.
   If any enrichment ran, add "Added details from the web for N leads."
4. **"Couldn't read these, open them yourself"** — compact lines for blocked governing/parks agendas,
   "open it yourself" documents, stale links, counties with no library sources, and connector errors. Include
   title, county, link, and reason when there is a source; mention the download cap if it was hit.
5. **"Saved your lead board — N leads, M rows changed."** — only after the write is read back and verified.
6. One closing line offering both next steps: "Want more on one of these? Ask for the Research Brief — for
   example, 'research #2' for the full history. Or an intro email built around one of them? That's the Email
   Writer." When the rep picks one, pass that lead (what, when, stage, source) and its QuickBase label plus
   record number to the Email Writer as known context.
7. **The last line of the output** is the ROUTINE count, and it is count-only — no list, no links, and no
   category, reason, or parenthetical after the number: "Set aside 11 routine items." When nothing was set
   aside, "Set aside 0 routine items." Nothing follows it.

## Morning digest mode — the automatic check-in

The **Daily run** (see **Daily run** in CLAUDE.md) runs this mode as its first step every weekday, and the
rep can start it any time with "run my daily run" or "run my morning leads." It is the same tool with a
smaller, cheaper run. In the Daily run, skip this mode's "Good morning … Here are your morning leads" opening
line and its closing "Want more on one of these?" line: the Daily run opens the message, and the contact
cards follow. Everything above still applies (the connector is the only source of leads; grading, stages,
scores, QuickBase labels and the lead board all work the same), except:

1. **Counties:** Focus Counties if the profile has them; otherwise all of the rep's counties. Never stop to
   ask which counties. If there are more than about 10 and no Focus Counties, add one line at the end:
   *"Tip: pick a few focus counties to keep this quick. Say 'change my focus counties'."*
2. **Only what's new:** run `lead_scan` with `since:` set to the latest **Last Checked** date on the lead
   board (no board yet: 7 days back). Mondays catch up on the weekend automatically this way.
3. **Library documents once a week:** read CIPs, budgets and master plans (the normal `read_source` step,
   same cap) only on Mondays, or when no row on the board was checked in the last 7 days. Other days, skip
   them. Budgets and plans rarely change day to day.
4. **No web enrichment** in this mode. If a lead is missing a due date or contact, say "due date not
   visible — verify on the page" as usual. The rep can ask for more on any lead afterward.
5. **Already ran today?** Don't ask. Reply with one line and stop: *"Already checked this morning. Nothing
   new since then."* (Inside the Daily run this only ends step 1; the Daily run carries on.)
6. **Short output:**
   - Start with: *"Good morning, [First name]. Here are your morning leads."*
   - "Moved up since your last scan", then up to the **top 5** new leads (number them all in one list,
     moved-up first, so "#2" works for either), one line each, in the normal
     format, including the one-line History entry after the QuickBase label. If there are more: *"…and N more
     on your lead board."*
   - The couldn't-read list as a single count line: *"Couldn't read 4 sources. Say 'show what you
     couldn't read' for the list."*
   - The saved-board line and the Set-aside line, as usual.
   - Nothing new at all: one line, *"Nothing new in your counties since [date]."* ([date] is the `since:`
     date from step 2, the last check, never today), then the saved-board line if any row changed, and skip
     the step 7 line.
   - **Inside the Daily run:** a nothing-new step 1 is an empty section, so leave out the "Nothing new" line
     and the Tip line (keep the saved-board line only if rows changed), and the Set-aside line isn't the last
     line of the message: the Daily run's other sections follow it.
7. When at least one lead was shown, end with one line: *"Want more on one of these? Ask for the Research Brief — for example, 'research #2' —
   or the Email Writer."*

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory, product focus, and QuickBase tables section. If a
   **Focus Counties** line is filled in, scan **only those** — don't widen to neighboring counties or a
   metro/region, even ones in the rep's territory. If the rep wants a wider scan, they'll ask ("scan all my
   counties," "add Hanover"). With no Focus Counties line and more than ~10 counties, ask once which few to
   focus on this run (and offer to save them). If territory is missing or too broad (just a state name), ask
   for the county or counties — with the connector present, `my_sources` lists the counties the rep actually
   has.
2. **Check the board's last-checked dates.** If the rep already ran this today, say so and ask if they
   still want a fresh scan; library sources rarely change within a day. Still run it if they say yes.
   Then **run the reading order** (steps 1–4 above) for those counties. Web enrichment is only for existing leads.
3. **Grade** every `lead_scan` hit and every `read_source` finding REAL/ROUTINE (both count toward the
   closing "Set aside" line), then **drop** anything that fails the stage-7 exclusion.
   Defer the currency rule for stale candidates until after the QuickBase cross-reference, so an open same-job
   match can keep one alive.
4. **Check the board** and keep only genuinely new items, marking stage moves separately.
5. **Stage and score** the survivors, and **cross-reference** each one against QuickBase. A lead more than
   about 12 months old stays only when QuickBase finds an open (`in pipeline`) same-job opportunity or quote;
   `lost before`, `Close - Multiple Alternative` and `won before` do not keep it alive. Do not add a lookup just for a stale item beyond the
   normal bounded cross-reference pass.
6. **Present** in the output shape above.
7. **Update the board** and verify the spreadsheet write.
8. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
