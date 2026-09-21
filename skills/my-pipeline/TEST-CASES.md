# my-pipeline — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Confirmed live against a
real rep's full open pipeline (2026-09-21/22); cases below are the generic patterns that pull found, not
the real data itself.

1. **A normal rep query, rep-scoped correctly.** Ask for one rep's open pipeline. Expect: only that rep's
   opportunities come back — no bleed from other reps, and the full open set in one page for a
   normal-sized book (confirm `hasMore` is handled honestly if a rep's book is large enough to paginate).

2. **Missing confidence vs. confidence explicitly set to 0%.** A rep's book will have both: opps where
   confidence was never touched (blank/null) and opps where someone deliberately set it to 0%. Expect: the
   tool distinguishes these two states in its output ("no confidence set" vs. "confidence set to 0%")
   rather than collapsing them into one bucket — they mean different things to a rep reviewing gaps.

3. **A close date that's a plausible typo, not just "in the past."** An opp with a close date whose year is
   obviously wrong (e.g., a two-digit slip or an old/impossible year) rather than a date that's simply
   overdue. Expect: the tool flags it distinctly as a likely data-entry error worth a closer look, not
   lumped in with ordinary stale-but-real dates.

4. **A rep whose "New" opps are all bulk-import backlog, not fresh leads.** A batch of opps created in the
   same tight time window (a data migration or rollout), all still at default/blank values. Expect: the
   tool still reports them accurately — it isn't `my-pipeline`'s job to distinguish fresh vs. backlog (that
   judgment call belongs to `my-new-leads` and `forecast-update`), but it shouldn't miscategorize the whole
   batch as "clean" just because nothing's overdue yet if confidence/close-date gaps are still present.

5. **A rep with zero open opportunities, or a name that doesn't match QuickBase.** Expect: the tool checks
   `PROFILE.md` for a saved `QuickBase Name:` first, and if the query still comes back empty, asks the rep
   to confirm their exact QuickBase name rather than reporting "you have no pipeline" outright.

**What "fails gracefully" means for this tool specifically:** if the QuickBase connector isn't set up for
this rep, one plain sentence saying so — not a stack trace, not a guess at what their pipeline might look
like.
