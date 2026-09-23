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

**What "fails gracefully" means for this tool specifically:** every reported signal has a real source link and a real date. If a search can't confirm either, the item doesn't get reported — silence is better than a plausible-sounding but unverifiable "lead."
