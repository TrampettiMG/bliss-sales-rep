---
name: find-leads
description: >-
  Scan the rep's counties for new lead signals — park/playground/splash-pad projects, municipal
  budgets, grants, bond referendums, school/HOA construction news — and report what's new since the
  last run, ranked by how closely each matches the kind of work that actually closes. Use when the rep
  says "find leads for my county", "what's new in my territory", "scan for leads", "any new signals", or
  similar. Repeatable: each run only surfaces items not already logged.
---

# Find leads

Scan public sources for new, dated signals in the rep's territory that suggest a playground/site-amenity
opportunity is coming — not a generic list of categories, and not a per-contact brief (that's the
`research` tool, for once the rep has a specific target to dig into).

## What this is not

This surfaces **signals** (a dated, cited, specific event or item), not accounts or contacts. It never
invents a signal — if a search comes back thin for a category, say so plainly rather than padding the
list with generic possibilities. Every signal needs a real source link; if there's no real source, leave
it out. If the source is real but a specific detail (like the exact date) isn't visible in what you can
see of the page, include it anyway with an explicit flag ("date not visible — verify on the page") rather
than dropping an otherwise-good lead over one missing detail.

Also watch for wrong-location false positives — a search can easily return a same-named place in a
different state (a "Clark County" or "Las Vegas" elsewhere). Confirm the state/region matches the rep's
actual territory before including anything, and note what got excluded and why if it's not obvious.

## The log — what makes this repeatable

Keep a project file `find-leads-log.md` — one entry per signal ever surfaced, each with its date, county,
one-line description, tier, and source URL. On every run:

1. If `find-leads-log.md` doesn't exist yet, this is the rep's first run — search normally and treat
   everything found as new. Create the log with today's results.
2. If it exists, search normally, then **compare against the log by the underlying event, not just the
   literal URL** — a different article covering the same groundbreaking, budget vote, or grant award is
   still the same signal, not a new one. Only report items that are genuinely new. If nothing new turns
   up, say so plainly: "Nothing new since your last run on [date]" — don't re-surface old items or pad the
   list to look productive.
3. Append newly surfaced items to the log after reporting them, so the next run doesn't repeat them.
   **Verify the write actually happened — read the file back, or otherwise confirm it — before telling the
   rep it's saved.** Never state the log was updated unless you've confirmed it. A false "saved" claim is
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
  from. Only count this if the rep said so in this conversation — never guess.
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

Rules: rank only on what the source actually shows — if a factor isn't visible (funding, size, due
date), don't assume it; rank on what's there and say what's unknown. Within a tier, list the soonest
deadline or most recent item first.

## Flow

1. **Read `PROFILE.md`** for the rep's counties/territory and product focus. If a **Focus Counties** line
   is filled in, search those. If not and the rep has more than about 10 counties, ask once which few to
   focus on this run (and offer to save them as Focus Counties) rather than searching a long list thin.
   If territory is missing or too broad to search meaningfully (e.g., just a state name), ask for the
   specific county or counties.
2. **Search each category** for the rep's counties, recent activity only, within the usage budget above,
   using terms from **Search terms**:
   1. Park, playground, or splash-pad projects — new builds, renovations, RFPs, and purchase approvals.
   2. Grants awarded or applied for that touch parks/rec/playground equipment.
   3. School district construction, renovation, or bond programs that would include a playground.
   4. Municipal capital improvement budgets or plans that mention parks/rec.
   5. Bond referendums that include parks/rec funding, and HOA/community construction news.
   Search the categories in this order, so if the budget runs out the ones most likely to be strongest
   matches are already covered. In the park/playground search, include purchase approvals on
   council/board agendas (co-op or direct), not just RFPs.
   If the rep asks to narrow to one category ("just bond referendums"), do only that one.
3. **Check the log** per the rules above and keep only genuinely new items.
4. **Rank the new signals** using **Ranking** above, then **present them grouped by tier** — Strongest
   match first, then Good match, then Early or weaker match — each as a short, dated, cited item. For an
   open bid or RFP, always include the due date (or "due date not visible — verify on the page") — reps
   often have only a few weeks. Give: what happened, when, the source link, and one line on why it's
   relevant to the rep's product focus (a factual connection — e.g., "new park construction typically includes a playground scope" — not a
   pursue/pass recommendation), plus the tier reason in a few words (e.g., "grant awarded + playground
   scope + city buyer"). If a tier is empty, skip it rather than padding it.
5. **Update the log** with what was just reported.
6. If the rep wants more on a specific signal (a named municipality, a named project), hand off to the
   `research` tool instead of digging deeper here — that's its job.
