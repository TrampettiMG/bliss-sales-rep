# research — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **Municipality target, chained off a find-leads result.** Rep runs `find-leads`, gets a signal about a specific city, then says "research that city." Expect: it reuses the city name/context already surfaced instead of re-asking, and digs deeper on that one place rather than re-scanning the whole territory.

2. **Named company, cold ask.** Rep says "research [a real company name] for me" with no other context. Expect: correct identification of the right entity, findings relevant to the rep's product focus, honest handling if the company has little public presence.

3. **Named person, ambiguous name.** Rep asks to research a common first+last name with no organization given. Expect: it asks for a disambiguating detail (their organization, county) rather than guessing and potentially producing a brief on the wrong person.

4. **Thin public presence.** Rep asks to research a small/obscure target with little to no public information available. Expect: an honest, short brief that says findings were limited — not a padded-out one that reads as if real research happened.

5. **Usage budget respected.** Count actual search calls on a normal run. Expect: roughly 6-8 total, not an open-ended chase — and if the budget runs out, the brief says plainly what wasn't checked.

6. **Agency with a master plan and a grant.** Research a city whose parks master plan names a playground renovation and which recently won a recreation grant. Expect: both appear in "Why call now," dated and cited, with the grant's match or deadline if public — no invented amounts or timelines.

7. **Ambiguous name settled by territory.** A rep covering Richmond city, VA asks "research Richmond parks." Expect: goes with the City of Richmond, says so in one line, and offers the alternative (Richmond County) — no other-state Richmond mixed in, no extra round-trip question.

**What "fails gracefully" means for this tool specifically:** a thin, honest brief beats a padded, confident-sounding one. Never present a guess or a generic industry assumption as if it were a specific finding about this target.

8. **Bliss Library connector with a CIP hit.** Connector is available and the target is in the rep's county.
`my_sources` returns the entity's readable CIP, and a single-term `read_source` query finds the Coral Gables
Capital Improvement Program 2026-2030, p.104-105: Betsy Adams Park playground expansion/additional play
structures and playground shade. Expect: it reads the promising pages, cites URL plus page number, and puts
the dated finding in "Why call now".

9. **Connector absent.** The Bliss Library tools are unavailable. Expect: the existing web-search flow runs
unchanged and the brief does not fail or claim the connector is missing.

10. **Single-term query trap.** A `read_source` query with `OR` is unsupported. Expect: the skill uses 1–2
separate literal terms, not `playground OR shade`, and stays within the roughly 6-call connector cap.

11. **QuickBase past customer, new job.** Research a fictional Mapleford municipality with a new named park
project. QuickBase has the governing city as a past customer with closed quotes but no matching job. Expect:
one factual line with the latest job name and year and quote count, using distinctive-name matching rather than
a Parks & Recreation label or shared billing city.

12. **Same job through a GC.** A fictional city park project appears in a quote or opportunity name whose
customer is a general contractor, and the city/county also matches. Expect: one factual line saying it already
has an opportunity or quote on this project, with QuickBase's status as shown; do not match on park name alone.

13. **Same park name in another state.** The target's park name repeats in QuickBase in another state. Expect:
no match unless the city or county also matches.

14. **QuickBase unavailable or test record.** If QuickBase is not connected, the brief continues without a
QuickBase line or error. If a matching customer or rep contains "TEST", ignore that record.
