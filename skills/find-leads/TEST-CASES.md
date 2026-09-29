# find-leads — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **First-ever run.** Rep with no `find-leads-log.md` yet asks "find leads for my county." Expect: a normal search, everything found reported as new, and the log file created afterward with those entries.

2. **Second run, same session or a new one, nothing new happened.** Immediately re-run the same request. Expect: it recognizes the same signals from the log and either reports "Nothing new since your last run" or surfaces only genuinely different items — it should NOT re-report the same signals as if they were fresh.

3. **Second run with one genuinely new item.** Simulate a case where one new dated item exists beyond what's in the log (may need to manually edit `find-leads-log.md` to remove one recent, real entry, then re-run, to check it re-surfaces just that one and not the others). Expect: only the missing item comes back as new.

4. **Thin results for a category.** Ask to narrow to a category unlikely to have recent activity in a small county (e.g., "just bond referendums in [small county]"). Expect: an honest "nothing found" rather than a padded or generic-sounding result presented as if it were a real signal.

5. **Vague or missing territory.** A profile with territory listed as a whole state or left too vague to search. Expect: it asks for a specific county rather than returning a flood of unfocused results or silently picking one county on its own.

6. **Usage budget respected.** Run a normal first-time scan and count actual search calls used. Expect: roughly 2 per category (~10 total), not an unbounded chase down every promising thread — and if the budget runs out early, it says plainly which categories weren't checked rather than silently dropping them.

7. **Same-day re-run.** Run the tool twice in one day. Expect: the second run notices the log's last-run date is today and asks whether the rep still wants to spend a fresh scan, rather than automatically burning another full search budget.

8. **Republished coverage of an already-logged event.** After a signal is logged, search again where a different outlet has since covered the same underlying event (a different URL, same story). Expect: it's recognized as already-known and not re-reported as new.

9. **Multi-county rep.** A profile listing 2-3 counties. Expect: the budget is shared across counties (not multiplied), it says plainly which counties got covered this run, and it doesn't silently ignore the counties it didn't get to.

10. **Broad-word trap.** A rep whose product focus is site furnishings. Expect: queries pair broad terms ("site furnishings," "picnic tables," "trash receptacles") instead of bare words like "site" or "table," and results about parking lots or court buildings are left out.

11. **Keyword terms don't multiply searches.** A normal scan. Expect: each category's query combines several terms with OR — the total search count stays at the ~10 budget, not one search per keyword.

12. **Co-op purchase on a council agenda.** A county board agenda approving a playground purchase "through Sourcewell" (no open bid). Expect: it's reported as a real signal under park projects, not skipped for lacking an RFP.

13. **Open RFP found.** Expect: the item includes the bid due date, or "due date not visible — verify on the page."

14. **Mixed results get tiered.** A scan that turns up (a) a city council approving a playground purchase through a co-op contract, (b) an open county RFP for a park playground due in three weeks, and (c) a parks master-plan survey with no project named. Expect: (a) Strongest, (b) Good, (c) Early or weaker — each with a few-word reason, grouped by tier, and no pursue/pass language.

15. **GC request and a lower-it flag.** A GC's invitation for sub pricing on a large multi-site school program. Expect: Early or weaker match, with the reason ("GC sub pricing + very large program"), not dropped from the list.

16. **Existing customer only if the rep says so.** Run once with no mention of customers, then again after the rep says "Riverside Schools is one of mine." Expect: the existing-customer factor is only applied the second time, and never guessed from the name.

17. **Unknown factors aren't assumed.** A news item about a playground renovation with no funding or size mentioned. Expect: ranked on what's shown, with "funding not stated" noted — not assumed committed.

18. **Focus counties are respected.** Profile has Focus Counties "Chesterfield County, Henrico County, Richmond city" in a rep whose territory also includes Hanover. Expect: no Hanover results, no "Richmond metro" widening, and a coverage line naming all three focus counties — including "nothing new" for any that came back empty.

19. **Stale page.** A search surfaces a county playground-replacement page last updated several years ago. Expect: dropped (or included only if a newer source shows the project still moving), never listed with just a "page is old" caveat.

**What "fails gracefully" means for this tool specifically:** every reported signal has a real source link and a real date. If a search can't confirm either, the item doesn't get reported — silence is better than a plausible-sounding but unverifiable "lead."

20. **Bliss Library connector with a CIP hit.** Connector is available and `my_sources(county="Miami-Dade")`
returns a readable CIP. A single-term `read_source` query finds the Coral Gables Capital Improvement Program
2026-2030, p.104-105: Betsy Adams Park playground expansion/additional play structures and playground shade.
Expect: it reads the promising pages, reports the named project with fiscal year and amount when shown, cites
the URL plus page number, and applies normal date, tier, log, and dedup rules.

21. **Library agenda scan has blocked sources.** `lead_scan` returns 0 leads and most agendas are blocked or
unreadable. Expect: it does not say "nothing new on agendas"; it says the agendas were not checked, keeps
relevant governing-board/parks failures in one concise "Couldn't open" line, and drops irrelevant boards.

22. **Connector absent.** The Bliss Library tools are unavailable. Expect: the current web-search flow runs
unchanged, with the existing search cap, coverage line, ranking, and log behavior.

23. **Single-term query trap.** A `read_source` query such as `playground OR shade structure` returns no useful
matches. Expect: the skill uses separate calls for `playground`, `shade`, and other chosen terms, never an OR
query, and stays within the connector call cap.

24. **QuickBase past customer, new job.** A fictional city, Mapleford, has a new capital-plan signal for a
named playground and shade project. QuickBase has the governing city as a past customer with closed quotes,
but no matching job. Expect: "Past customer, new job" with the latest job name and year and quote count; the
entity match is based on the distinctive city name, not a Parks & Recreation label or shared billing city.

25. **Same job quoted through a GC.** A fictional city's named park project appears in a quote and opportunity
name whose customer is a general contractor. The city/county also matches on the quote or customer. Expect:
"Already in QuickBase: open" with the number, status, date, and "yours" or "another rep's"; do not drop the lead.

26. **Same park name in another state.** The new signal is for Adams Park in one state, while QuickBase has an
Adams Park job in another state. Expect: no same-job match from the park name alone; use the city/county check.

27. **QuickBase unavailable.** The QuickBase connection is not set up. Expect: no QuickBase tag, no error or
repeated warning to the rep, and the existing ranking and web flow continue unchanged.

28. **Test records ignored.** A matching customer or rep record contains "TEST". Expect: it is ignored and
does not produce an Already in QuickBase or past-customer tag.

29. **Stale public item, active QuickBase job.** A fictional Pinehaven capital-plan page looks more than a
year old, but the same job has an open QuickBase quote dated within the last year. Expect: it is kept and
tagged "Already in QuickBase: open"; no extra lookup is made just because it was stale, and the normal lookup cap holds.

30. **Far-future funding.** A fictional Lake Mercer FY2027 plan has a playground line planned for FY2031.
Expect: Early or weaker match with the reason "money planned 3+ fiscal years out," not Good match.

31. **Capped quote history.** A fictional Cedar Grove past customer has more quote history than the bounded
QuickBase pull reads. Expect: "Past customer, new job" with "N+ quotes," not a falsely exact count.

34. **QuickBase state reaches Email Writer.** A new lead is reported with each possible state — open, ordered,
closed/no order, past customer/new job, or not in QuickBase — and an open job may be yours or another rep's.
Expect: the closing handoff passes the signal plus the exact QuickBase number, status, date, and ownership label
when present, so Email Writer can choose its type without re-asking.

32. **Same job, closed with no order.** A fictional Brookhaven park project matches a QuickBase quote whose
status is "Close - Multiple Alternative", with no won quote. Expect: the status is checked before tagging;
tag "Quoted before: closed, no order" with the number, close status and date; ranked as a normal new lead.
If the public item is also stale, the closed quote does not keep it alive.

33. **Same job, already ordered.** A fictional Fairview project's opportunity still shows Quoted to Customer,
but one of its quotes is Order Submitted. Expect: tagged "Already in QuickBase: ordered" and listed on one
line under "Already ordered" after the tiers, not ranked, and never offered a "still moving?" follow-up.
