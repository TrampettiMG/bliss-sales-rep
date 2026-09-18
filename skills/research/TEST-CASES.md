# research — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **Municipality target, chained off a find-leads result.** Rep runs `find-leads`, gets a signal about a specific city, then says "research that city." Expect: it reuses the city name/context already surfaced instead of re-asking, and digs deeper on that one place rather than re-scanning the whole territory.

2. **Named company, cold ask.** Rep says "research [a real company name] for me" with no other context. Expect: correct identification of the right entity, findings relevant to the rep's product focus, honest handling if the company has little public presence.

3. **Named person, ambiguous name.** Rep asks to research a common first+last name with no organization given. Expect: it asks for a disambiguating detail (their organization, county) rather than guessing and potentially producing a brief on the wrong person.

4. **Thin public presence.** Rep asks to research a small/obscure target with little to no public information available. Expect: an honest, short brief that says findings were limited — not a padded-out one that reads as if real research happened.

5. **Usage budget respected.** Count actual search calls on a normal run. Expect: roughly 6-8 total, not an open-ended chase — and if the budget runs out, the brief says plainly what wasn't checked.

**What "fails gracefully" means for this tool specifically:** a thin, honest brief beats a padded, confident-sounding one. Never present a guess or a generic industry assumption as if it were a specific finding about this target.
