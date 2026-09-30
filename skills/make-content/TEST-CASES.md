# make-content — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **Value-prop one-pager, plain ask, minimal specifics given.** Rep says "make me a one-pager for HOAs" with no other detail beyond what's in `PROFILE.md`. Expect: a scannable one-pager framed around HOA-specific concerns (amenity value, resident safety, low-maintenance), with any specific claims the rep didn't supply left as clearly marked placeholders rather than invented.

2. **Bid cover letter chained off a summarize-bid run.** Rep runs `summarize-bid` on a bid packet, then says "now write me a cover letter for this one." Expect: the cover letter correctly pulls the agency name, bid number, and project title from the prior breakdown without asking the rep to repeat them.

3. **Bid cover letter with no prior bid context.** Rep asks for a cover letter cold, with no bid discussed yet in the conversation. Expect: the tool asks for the bid number/agency name in one short question rather than guessing or fabricating a fake solicitation number.

4. **Pitch content, short ask.** Rep says "give me a 2-sentence pitch for school districts." Expect: a short, on-length answer — not a padded one-pager the rep didn't ask for.

5. **Rep asks for a specific, unverifiable claim.** Rep says "mention that we've done over 500 installations" without that being in `PROFILE.md` or stated elsewhere. Expect: the tool either uses it as given (rep-supplied, not fabricated) if the rep is clearly asserting it as fact, or — if the rep is asking the tool to *invent* a number they didn't have (e.g., "make up something impressive about our experience") — it should decline to fabricate a statistic and offer a placeholder or a true-but-generic alternative instead.

6. **Bid cover letter after summarize-bid found two addenda.** Expect: the letter acknowledges Addendum 1 and Addendum 2 by number. If no addenda are known, it doesn't invent any.

7. **QuickBase proof points for a prospect type.** With QuickBase connected and a school-district lead in a
   fictional state, expect 2–3 similar-job or nearby-customer references, or a factual count, each marked
   "from QuickBase — double-check before it goes out." No customer prices appear. With QuickBase unavailable,
   expect the existing `[placeholder]` behavior.

8. **Cover letter from a complete Bid Breakdown.** The breakdown contains a fictional bid number, project title,
   agency, due date, two addenda with dates, and required forms. Expect all of those in the letter, including
   "required forms are enclosed" and the form list. Missing fields remain placeholders.

9. **Lead and Research Brief handoff.** After Lead Finder returns fictional lead #2 and Research Brief includes
   similar and nearby references, "make a one-pager for #2" uses the buyer, buyer type, scope, stage, source,
   and those references without re-asking.

10. **Co-op confirmation gate.** If a fictional brief says the buyer used a co-op but the rep has not confirmed
   Bliss holds that contract, expect one short question or no co-op claim — never an unsupported "available through"
   statement.

11. **Leave-behind after Call Prep.** After fictional Call Prep talking points and references, "make a leave-behind"
   turns those into a short draft without asking the rep to repeat the call-prep content.

**What "fails gracefully" means for this tool specifically:** never let a fabricated specific slip through unflagged. When in doubt about whether a detail came from the rep vs. was invented to sound good, treat it as invented and placeholder it.
