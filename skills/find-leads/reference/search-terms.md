# Search terms, grouping, and the usage budget

Read when choosing literal `read_source` terms, judging whether a connector result is relevant, or enriching
an existing lead. SKILL.md carries the flow; this file carries the keyword list, the query traps, and the
small web-enrichment budget.

## The grouped keyword list

The same grouped list is what the connector matches on. A hit that matched one of these groups is a connector
signal to grade, not a finished lead until you confirm a specific project and stage.

Use these to choose the 2–3 single terms that best fit the rep's product focus for `read_source`. **One
literal phrase per call; never use `OR`.** The connector's query trap is real: `playground OR shade
structure` is not an OR search.

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

## Web enrichment budget

Web search is enrichment only: it can fill a missing contact or buyer name, bid due date or bid page,
pre-bid information, or newer news on the same connector lead. It never creates or replaces a lead.

- Search only the top-scored leads that have a missing detail, about 1–2 searches per lead and roughly 6 total
  per run.
- Skip enrichment when nothing is missing. If library and web facts disagree, show both and say so; cite the
  web source separately from the library source.
- If the budget runs out, stop and say which lead details were not checked. Never use the budget to hunt for
  another county or a separate lead.

## Traps to avoid

- Never search on a bare broad word — "park" (matches parking), "site", "trash", "table", "courts" (matches
  court buildings), "seating". Always pair it: "park playground," "site furnishings," "picnic table,"
  "pickleball courts."
- Buying often shows up as a co-op purchase instead of an open bid — a council or board agenda approving a
  purchase "through Sourcewell / BuyBoard / TIPS / OMNIA" is a real signal, and it scores on the
  cooperative-contract factor.
