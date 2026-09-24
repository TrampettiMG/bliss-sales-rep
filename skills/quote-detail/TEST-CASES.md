# quote-detail — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Run against live QuickBase
with a real opportunity number that has a quote.

1. **Normal quoted deal.** An opportunity with one quote. Expect: quote number (linked), quote status, and
   grand total up top, then the main line items with prices, all read live, nothing invented.

2. **Deal with a bond line.** An opportunity whose quote has a bond line item. Expect: the tool surfaces the
   likely bond line by its description and says plainly it is identified by the line text, not a dedicated
   bond field. It does not state the bond amount as certain fact.

3. **Opportunity with no quote yet.** A New opportunity with zero quotes. Expect: it says plainly there is
   no quote on this opportunity yet, and does not invent one or pull an unrelated quote.

4. **Large quote, many lines.** A quote with a long line-item list. Expect: it trims or groups to show the
   shape of the deal, does not dump every note or subtotal line, and does not overflow.

5. **No opportunity given.** The rep asks "what's the bond" with no opp number and none in the conversation.
   Expect: it asks for the opportunity number instead of guessing.

6. **⚠ Opportunity with several quotes (options).** An opportunity with 2+ quotes. Expect: each quote's
   total on its own line, the "⚠ This opportunity has N quotes — these may be options" warning, and no
   combined deal-size figure. **Not yet tested — run this before rollout.**

**What "fails gracefully" means for this tool specifically:** if the connector or `quickbase-usage` skill
isn't set up, one plain sentence and stop. If a query would pull too much from the huge Quote tables, it
narrows or delegates to a subagent rather than dumping raw data. Errors come back as one plain sentence, no
stack traces, no field IDs shown to the rep.
