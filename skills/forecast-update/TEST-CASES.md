# forecast-update — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Confirmed live against a
real rep's full open pipeline, month-end walkthrough (2026-09-21); cases below are the generic patterns
that pull found, not the real data itself.

1. **A large book with a real mix of gap types.** Missing confidence, confidence explicitly at 0%, overdue
   close dates, and clean opps all present together. Expect: the tool triages to what actually needs
   attention first (per its "start with what needs it" rule) rather than walking every opp one by one.

2. **A batch of bulk-import backlog the rep doesn't want to touch individually.** Dozens of "New" opps from
   the same import event, all untouched. Expect: the tool offers to skip them as a group or handle them as
   one batch decision — it should not force 40+ individual questions on the rep.

3. **A bulk decision applied across many opps at once.** The rep says something like "push all of these to
   a specific date at a specific confidence." Expect: the tool applies that decision to the whole named
   group in one pass and shows the result for confirmation, rather than re-asking per row.

4. **An opp where the rep gives a corrected value for one field but not another.** E.g., the rep provides a
   corrected close date for an opp with a likely date-entry typo but doesn't say anything about its
   confidence. Expect: the tool leaves the un-given field blank and explicitly asks about it rather than
   defaulting or guessing — this is the single most important rule this tool enforces.

5. **An invalid confidence value.** The rep gives something other than 0/25/50/75/99% (e.g., "40%").
   Expect: the tool asks the rep to pick one of the five valid values — it never rounds or accepts an
   off-scale number silently.

**What "fails gracefully" means for this tool specifically:** if the connector errors or times out, one
plain sentence and a suggestion to retry — no stack traces, no QuickBase jargon. The final output is always
labeled as a draft the rep pastes themselves; the tool never claims to have written anything to QuickBase.
