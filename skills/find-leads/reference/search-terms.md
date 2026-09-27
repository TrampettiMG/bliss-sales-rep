# Search terms, grouping, and the usage budget

Read when you build the search pass (reading-order step 3) and when you judge whether a `lead_scan` hit or a
search result is relevant. SKILL.md carries the flow; this file carries the keyword list, the query traps,
and the search budget.

## The grouped keyword list

The same grouped list is what the connector matches on — a hit that matched one of these groups is a keyword
hit, not a graded lead until you grade it.

Use these to build each category's query and to judge relevance. **Never run one search per term** — that
blows the budget below. Pick the 3-5 terms that best fit the rep's product focus and combine them with OR
(e.g., `"playground" OR "splash pad" OR "shade structure"`).

- **Play:** playground, inclusive playground, accessible / ADA playground, play structure, swings, splash
  pad, spray park, spray ground, dog park, skate park
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

## Usage budget — most reps are on a standard/basic Claude plan

Web searches count against the rep's own usage limits. The registry steps cost no search budget, so on a
connector run the pass is small; on the connector-missing route it's the whole scan. Stay disciplined:

- **Cap it at roughly 2 searches per category per run** (about 10 total) — one broad search, one narrower
  follow-up only if the first looked promising. Don't chain searches chasing a thin lead.
- **Multiple counties don't multiply the budget.** Combine counties into one query per category (e.g.,
  "Clark County Nevada OR Washoe County Nevada new park playground 2026"), not separate searches per county.
  If you have to prioritize or skip a county, say so plainly.
- **Check the log's last-run date first.** If the rep already ran this today, say so and ask if they still
  want to spend a fresh scan. Still run it if they say yes.
- If the budget runs out before covering every county, **stop and report what you found**, and say plainly
  which counties weren't checked ("Didn't get to Columbia County this time — ask again to pick it up.")
  rather than silently skipping them.

## Traps to avoid

- Never search on a bare broad word — "park" (matches parking), "site", "trash", "table", "courts" (matches
  court buildings), "seating". Always pair it: "park playground," "site furnishings," "picnic table,"
  "pickleball courts."
- Buying often shows up as a co-op purchase instead of an open bid — a council or board agenda approving a
  purchase "through Sourcewell / BuyBoard / TIPS / OMNIA" is a real signal, and it scores on the
  cooperative-contract factor.
