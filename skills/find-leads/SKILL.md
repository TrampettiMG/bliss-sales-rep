---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals — park/playground/splash-pad projects, municipal
  budgets, grants, bond referendums, school/HOA construction news — and report what's new since the
  last run, ranked by how closely each matches the kind of work that actually closes. Use when the rep
  says "find leads for my county", "what's new in my territory", "scan for leads", "any new signals", or
  similar. Repeatable: each run only surfaces items not already logged.
---

# Lead Finder

Scan public sources for new, dated signals in the rep's territory that suggest a playground/site-amenity
opportunity is coming — not a generic list of categories, and not a per-contact brief (that's the
`research` tool, for once the rep has a specific target to dig into).

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. It never
invents a signal — if a search comes back thin for a category, say so plainly rather than padding the
list with generic possibilities. Every signal needs a real source link; if there's no real source, leave
it out. If the source is real but a specific detail (like the exact date) isn't visible in what you can
see of the page, include it anyway with an explicit flag ("date not visible — verify on the page") rather
than dropping an otherwise-good lead over one missing detail. That only covers a page you could
actually read. If a source wouldn't open at all, it isn't a signal yet. Leave it out of the tiers and,
if it looks relevant from its title, list it on one line under the coverage line: "Couldn't open: [title]
([link]) — check it yourself." Don't add it to the log, so the next run tries it again.

Also watch for wrong-location false positives — a search can easily return a same-named place in a
different state (a "Clark County" or "Las Vegas" elsewhere). Confirm the state/region matches the rep's
actual territory before including anything, and note what got excluded and why if it's not obvious.

## The log — what makes this repeatable

Keep a project file `find-leads-log.md` — one entry per signal ever surfaced, each with its date, county,
one-line description, stage (plan, design, funded, bid/RFP, awarded), tier, and source URL. On every run:

1. **Look for the log anywhere in the project first**, including a subfolder like `claude/` — some
   setups save files there. Use and update it where you find it; never start a second log. If
   `find-leads-log.md` truly doesn't exist yet, this is the rep's first run — search normally and treat
   everything found as new. Create the log with today's results.
2. If it exists, search normally, then **compare against the log by the underlying event, not just the
   literal URL** — a different article covering the same groundbreaking, budget vote, or grant award is
   still the same signal, not a new one. Only report items that are genuinely new.
   **Exception — the same project at a later stage is news.** If a result is a project already in the
   log but the source shows it has clearly moved forward (plan or design → money budgeted or awarded;
   funded → an RFP, bid, or purchase approval; bid → award), report it under a separate **"Moved up since
   your last scan"** heading above the tiers: one line each with the old stage, the new stage, date and
   source ("Tuckahoe District Park, Henrico: FY27 design money → construction RFP posted Oct 3"). Re-rank
   it in the tiers only if it now fits a higher one. Update its log entry with the new stage rather than
   adding a second entry (older entries with no stage: judge it from their description). This uses the normal searches — never spend extra searches re-checking old
   items. If nothing new turns
   up, say so plainly: "Nothing new since your last run on [date]" — don't re-surface old items or pad the
   list to look productive.
3. Append newly surfaced items to the log after reporting them, so the next run doesn't repeat them.
   **Verify the write actually happened — read the file back, or otherwise confirm it — before telling the
   rep it's saved.** Count the entries you just added in the file you read back, and put that count in
   the saved line ("Saved 10 new items to your lead log.") so it can be checked. If the count doesn't
   match what you reported, say the save didn't fully work instead. Never state the log was updated
   unless you've confirmed it. A false "saved" claim is
   worse than no log at all: it silently breaks every future run's ability to tell what's actually new.
4. **Keep the log from growing unbounded.** If entries older than ~90 days start making the log large
   enough to burn significant context just to check for dupes, collapse them to a compact one-line-per-item
   form (date + headline + URL, no extra detail) instead of dropping them — they're still needed for dedup,
   just don't need full detail once they're old.

## Usage budget — most reps are on a standard/basic Claude plan

Web searches count against the rep's own usage limits, and this tool can easily burn through a lot of them
in one run across five categories. Stay disciplined:

- **Cap it at roughly 2 searches per category per run** (about 10 total) — one broad search, one narrower
  follow-up only if the first looked promising. Don't chain additional searches chasing a thin lead.
- If the budget runs out before covering every category, **stop and report what you found**, and say
  plainly which categories weren't checked this run (e.g., "Didn't get to grants or bond referendums this
  time — ask again to pick those up.") rather than silently skipping them.
- **Check the log's last-run date first.** If the rep already ran this today, say so and ask if they still
  want to spend a fresh scan — most public sources don't change meaningfully within the same day, so a
  same-day re-run is usually not worth the usage. Still run it if they say yes.
- **Multiple counties don't multiply the budget.** If the rep covers more than one county, **combine them
  into one query per category** (e.g., "Clark County Nevada OR Washoe County Nevada new park playground
  2026") rather than running separate searches per county — this covers every county in the same ~10-search
  budget instead of splitting it thin or blowing past it. Only fall back to prioritizing one county over
  another if combined queries genuinely aren't working (e.g., too many counties for one query to stay
  specific). If you do have to prioritize or skip a county, say so plainly.

## Bliss Library connector — check it first

If the Bliss Library connector is available (tools `my_sources`, `lead_scan`, `read_source`), check it before
the web-search flow below. Otherwise use the current web-search flow unchanged.

- Use the same counties as this scan: Focus Counties if set; otherwise follow the existing rule for more
  than about 10 counties and ask which few to focus on. For each county, call `my_sources(county=…)`.
- For each `readable` `cip_url`, `budget_url`, or `master_plan_url`, call `read_source` with one literal
  term per call. Pick the 2–3 terms that best fit the rep's product focus; default to `playground`, then
  `shade`, then `splash pad`. Never combine terms with `OR`. Prioritize CIP, then budget, then master plan,
  and the most recent fiscal year first. Cap the run at about 12 `read_source` calls total; say plainly
  what wasn't reached.
- When a snippet looks like a named project (park name plus scope), use `pages` to read the 1–2 most
  promising pages. Keep real items only: capture the project name, fiscal year and amount when shown, and
  cite the document URL plus page number. Skip boilerplate and duplicate hits. Treat each real item as a
  signal and apply the normal freshness, log/dedup, stage, and tier rules.
- For agendas, call `lead_scan(county=…)` and follow every cursor. Treat hits as candidates for the normal
  date/source/tier treatment. If it returns 0 leads while most agendas were blocked or unreadable, report
  that the agendas were not checked, not that there was nothing new. Collapse relevant failures into the
  existing "Couldn't open" line only for a governing board or parks/rec board (council, commission, BOCC,
  parks advisory); drop irrelevant boards silently. If the output shows no "next cursor", the scan is
  complete. Keep one line per county with the count and at most about three example links, and never log
  failures.
- Library budget, CIP, and master-plan sources marked "open it yourself" or that fail to read also go on the
  county's "Couldn't open" line, in the same format and link cap. Do not log them.
- If a library source is clearly an old edition, such as a fiscal year two or more years behind, leave it out
  of the signals and add one line: "The library's link for [entity] [doc type] looks out of date. Tell your
  trainer." Do not treat it as a signal.
- Connector calls do not count against the web-search cap. After the connector pass, run the existing web
  searches for grants, school districts, bond referendums/HOAs, and governing-board agendas the connector
  could not read. End with a coverage line that says which county sources were checked through the library,
  so "nothing new" is honest.

## Search terms

Use these to build each category's query and to judge whether a result is relevant. **Never run one search
per term** — that blows the budget above. Pick the 3-5 terms that best fit the rep's product focus and
combine them with OR into the category's query (e.g., `"playground" OR "splash pad" OR "shade structure"`).

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

Traps to avoid:
- Never search on a bare broad word — "park" (matches parking), "site", "trash", "table", "courts" (matches
  court buildings), "seating". Always pair it: "park playground," "site furnishings," "picnic table,"
  "pickleball courts."
- Buying often shows up as a co-op purchase instead of an open bid — a council or board agenda approving
  a purchase "through Sourcewell / BuyBoard / TIPS / OMNIA" is a real signal. Count it under park projects.

## Ranking — how new signals are ordered

Sort every new signal into one of three tiers, based on what actually turns into orders in this business.
Show the tier and **the reason in a few words** for every item, so the rep can see why and overrule it.
This is an ordering by the criteria below, not a pursue/pass verdict — the rep decides what to chase.

**Strongest match** — has at least two of these, and none of the "lower it" flags:
- **Money is committed and the buyer can purchase directly** — a grant awarded, a bond passed, a budget
  line adopted for a named park or school playground, or a board/council item approving a purchase
  (including through a cooperative contract like Sourcewell, BuyBoard, TIPS, or OMNIA). Direct and
  co-op purchases close far more often than open public bids.
- **The scope is core work** — playground or play equipment (including inclusive/ADA), playground
  replacement or renovation, installation, surfacing (PIP, rubber tile, EWF), shade structures,
  shelters/pavilions, site furnishings.
- **The buyer is a core buyer type** — school or school district, city or county, parks & recreation
  department, or park district.
- **The rep has said this is an existing customer.** Repeat customers are where most business comes
  from. Count this if the rep said so in this conversation, or if the QuickBase check shows the entity is
  a past customer — never guess.
- **It's small-to-mid-sized or unpriced** — a single park or site rather than a large multi-site program.

**Good match** — anything with core scope or a core buyer and no "lower it" flags that isn't a Strongest
match. Typically an **open public bid/RFP** to the owner directly, with enough time left to get installer
pricing, or a specific project and year named but the money not committed yet.

**Early or weaker match** — any of these "lower it" flags:
- Early-stage only: a plan, study, or survey with no project, funding, or year attached.
- A general contractor's request for sub pricing rather than the owner buying directly.
- The work is mostly outside core scope: fitness-only, sports courts/turf/lighting-only, trails-only,
  splash-pad-only, or a building with no playground or site-amenity scope.
- Visible hard gates: another brand named with no "or approved equal," a mandatory pre-bid that has
  already passed, or a bid due in under about a week.
- A very large multi-site or multi-million-dollar program.
- Money planned 3 or more fiscal years out, counted from the current fiscal year to the earliest year with
  design or construction money (e.g. an FY2031 line when it is now FY2027), rather than near-term funding.

Rules: rank only on what the source actually shows — if a factor isn't visible (funding, size, due
date), don't assume it; rank on what's there and say what's unknown. Within a tier, list the soonest
deadline or most recent item first.

## Check QuickBase for each new lead

This optional check runs only if the read-only QuickBase connector and the `quickbase-usage` skill are set
up in this project. If they aren't available, skip it silently and rank as now. Follow the `quickbase-usage`
skill for the query (it holds the tables and fields; never guess them). Use the rep's `QuickBase Name` from
`PROFILE.md` when the query needs the rep identity. Never write to QuickBase or suggest creating an
opportunity automatically.

- Check each **new** signal after deduplication and before ranking. Look up a shared buyer entity once, even
  when several new signals point to it. Cap this at about 10 entity lookups per run and say which new leads
  were not checked if the cap is reached.
- Match the governing entity on the distinctive part of its name, contains-style and case-insensitive (for
  example, the city name rather than a longer Parks & Recreation label). The entity's own department record,
  such as its Parks & Recreation department, counts as the governing entity. Schools, property managers,
  architects, and contractors do not; mention a related one in a few words if relevant. A billing city by
  itself is not a match.
- Search quotes as well as opportunities, and search quote and opportunity names for the park or project name.
  Treat it as the same job only when the place also matches by city or county on the quote or customer; a park
  name alone is never enough. Older jobs may exist only as quotes, so never search opportunities alone. Ignore
  any test record with `TEST` in the rep or customer name.
- **Check whether a same-job match is closed before you tag or report it.** Read the status of the matching
  opportunity and of every matching quote (an opportunity can still look open while a quote under it is
  already won). Sort the job into one of three states, the way the Pipeline Check tool file does:
  - **Open**: an opportunity that is New, Pending, or Quoted to Customer, or a quote that is still open (not
    closed and not won).
  - **Ordered**: any matching quote already won (Order Submitted, Invoiced, or Commission Paid), or an
    opportunity marked Ordered.
  - **Closed, no order**: everything matching is closed (a Closed opportunity, or quote statuses starting
    with "Close", such as "Close - Multiple Alternative" or "Quick Close") and nothing was won.
  If the statuses conflict, Ordered beats Open, and Open beats Closed.
  A "matching quote" is any quote for this job at this place, even under another customer record (a
  contractor, or a duplicate record for the same city). If a quote's close status says another alternative
  was chosen (like "Close - Multiple Alternative"), also check that customer's other quotes from about the
  same time for a won one; if one is won and looks like this job, treat the job as Ordered.
- Tag every checked lead with exactly one short suffix:
  - **Already in QuickBase: open**: this same job has an open opportunity or quote. Show its opportunity or
    quote number, status exactly as QuickBase shows it, date, and whether the rep on it is "yours" or
    "another rep's" (never name another rep).
  - **Already in QuickBase: ordered**: this same job has already been won. Show the number, status, and
    date. It's not a new opportunity, so put it on one line under **Already ordered** after the tiers
    instead of ranking it.
  - **Quoted before: closed, no order**: this same job was quoted and closed without an order. Show the
    number, the close status exactly as QuickBase shows it, and the date. The public signal is new, so
    rank it like any other lead; the entity still counts as a past customer.
  - **Past customer, new job** — the entity is a customer but no matching job was found. Show the most recent
    job name and year and the number of past quotes in a few words. Count each entity's quotes with one
    bounded pull of its own (no paging); write "N+ quotes" only when that pull hit its cap, never because a
    combined pull for several entities did.
  - **Not in QuickBase** — no matching governing entity or job was found.
  Put the tag at the end of the lead line, such as "· QuickBase: past customer, last quote 2026 (Oak Park
  bleachers)". Report an ambiguous close reason exactly as QuickBase shows it; do not translate it to "lost".
- Do not hide leads tagged **Already in QuickBase: open**; list them so the rep can follow up. This is
  intentionally one easy-to-flip sentence until the business owner decides otherwise. If the rep has news on
  one, optionally offer the Update Logger by its friendly name.

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory and product focus. If a **Focus Counties** line
   is filled in, search **only those** — don't widen to neighboring counties or a metro/region, even ones
   in the rep's territory. If the rep wants a wider scan, they'll ask ("scan all my counties," "add
   Hanover"). If not and the rep has more than about 10 counties, ask once which few to
   focus on this run (and offer to save them as Focus Counties) rather than searching a long list thin.
   If territory is missing or too broad to search meaningfully (e.g., just a state name), ask for the
   specific county or counties.
2. **If the Bliss Library connector is available, run its county source, document, and agenda checks first**
   per **Bliss Library connector — check it first**. If it isn't available, skip this and use the current
   web-search flow unchanged.
3. **Search each category** for the rep's counties, recent activity only, within the usage budget above,
   using terms from **Search terms**. After the connector pass, search only what it doesn't cover: grants,
   school district construction, bond referendums/HOAs, and governing-board agendas the connector couldn't
   read:
   1. Park, playground, or splash-pad projects — new builds, renovations, RFPs, and purchase approvals.
   2. Grants awarded or applied for that touch parks/rec/playground equipment.
   3. School district construction, renovation, or bond programs that would include a playground.
   4. Municipal capital improvement budgets or plans that mention parks/rec.
   5. Bond referendums that include parks/rec funding, and HOA/community construction news.
   Search the categories in this order, so if the budget runs out the ones most likely to be strongest
   matches are already covered. In the park/playground search, include purchase approvals on
   council/board agendas (co-op or direct), not just RFPs.
   If the rep asks to narrow to one category ("just bond referendums"), do only that one.
4. **Check the log** per the rules above and keep only genuinely new items.
5. **Check QuickBase** for each new lead per **Check QuickBase for each new lead**. Skip this silently if
   the connection is not set up. Add the one-line QuickBase suffix before ranking and presentation.
6. **Apply freshness** after the QuickBase check. Drop anything whose most recent dated activity is more
   than about 12 months old unless a newer public source shows it's still moving. Before dropping a stale item,
   if its entity is being or has been looked up in QuickBase this run, an **open** same-job quote or
   opportunity dated within about 12 months also counts as a newer source: keep it and tag it **Already in
   QuickBase: open**. A closed or ordered match doesn't keep a stale item alive. Do not
   add lookups just for stale items beyond the existing cap; say which new leads were not checked.
7. **Rank the new signals** using **Ranking** above, then **present them grouped by tier** — Strongest
   match first, then Good match, then Early or weaker match — each as a short, dated, cited item. For an
   open bid or RFP, always include the due date (or "due date not visible — verify on the page") — reps
   often have only a few weeks. Give: what happened, when, the source link, and one line on why it's
   relevant to the rep's product focus (a factual connection — e.g., "new park construction typically includes a playground scope" — not a
   pursue/pass recommendation) — on **every** item, not just the first few — plus the tier reason in a few words (e.g., "grant awarded + playground
   scope + city buyer"). If a tier is empty, skip it rather than padding it. Every item carries a date.
   A budget or capital plan that names its fiscal year counts as dated. Write the fiscal year and what
   it covers ("FY27 budget, July 2026–June 2027") when the document shows the fiscal-year dates or the
   locality's fiscal year is stated on the page; otherwise just the fiscal-year label ("FY27 budget").
   Only if the source shows no date and no fiscal year, write "date not visible — verify on the page."
   A fiscal year also counts for the ~12-month freshness rule: a current or upcoming fiscal year is fresh.
   End with one coverage line naming **each** searched county and whether it had anything new (e.g.,
   "Chesterfield: 2 · Henrico: 2 · Richmond city: nothing new"), plus any categories that came back
   empty or weren't reached.
8. **Update the log** with what was just reported. Keep one log entry per reported lead; if one tier line
   covers two projects, split it into two lines or log it as one. The reported count, coverage-line count, and
   log-entry count must agree. Record the QuickBase tag in each entry, so a later run does not re-check it
   unless the item moves up a stage.
9. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
10. End with one line offering both next steps: "Want more on one of these? That's the Research Brief. Or
   an intro email built around one of them? That's the Email Writer." An email that mentions a specific,
   recent signal gets far more replies than a cold one, so when the rep picks one, pass the signal (what,
   when, source) to the Email Writer as known context. If the lead has a QuickBase tag, pass that state too:
   number, status, date, and "yours" or "another rep's" where shown.
