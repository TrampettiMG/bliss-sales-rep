# my-new-leads — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Confirmed live against a
real rep's full "New" opportunity set (2026-09-22); cases below are the generic patterns that pull found,
not the real data itself.

1. **A normal rep query with a genuine mix of lead ages.** Some leads created recently, some sitting for
   weeks. Expect: the tool distinguishes fresh leads worth prioritizing from older untouched ones using a
   real age signal (days since created, activity/update history) — not just a flat list.

2. **A rep whose entire "New" set came from the same bulk-import or system-migration event.** All leads
   created within the same tight time window, all still at default values, no real per-lead activity since.
   Expect: the tool notices "days since created" can't honestly distinguish fresh from backlog here, says
   so plainly, and falls back to a defensible alternative grouping (e.g., by lead source) instead of
   guessing a fresh/backlog split it can't actually support. This is the single most important case — a
   silently fabricated split would be worse than admitting the data doesn't support one.

3. **Leads with missing or unusual lead-source values.** Some leads have a clean source tag, some have none
   set, some have multiple source tags across related records. Expect: the tool groups what it can and
   labels the rest "source not set" rather than dropping them or guessing a source.

4. **A single page vs. a paginated result.** A rep with a small new-lead count (single page) and,
   separately, a rep with enough leads to require paging. Expect: the tool reports the true total either
   way and never silently truncates results without saying so.

5. **A rep with zero new leads.** Expect: a plain, short "no new leads right now" rather than an empty
   table or a fabricated placeholder entry.

**What "fails gracefully" means for this tool specifically:** if the QuickBase connector isn't set up for
this rep, one plain sentence saying so. When it hands off to another tool (e.g., suggesting `research` or
`draft-outreach` for a specific lead), that's a natural next step, not an unrequested strategy wrap-up.
