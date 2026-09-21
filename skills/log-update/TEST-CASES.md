# log-update — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Confirmed live against a
real opportunity from a one-line description of a call (2026-09-22, Tool 7's first live test); cases below
are the generic patterns that pull found, not the real data itself.

1. **A clear call summary with an explicit timeline and an implied confidence.** E.g., "customer says
   they'll decide by [month], leaning toward us but still comparing a competitor." Expect: the tool looks
   up the named opportunity in QuickBase for current values first, derives a close date from the stated
   timeline, and maps the implied sentiment to the nearest of the five valid confidence values — while
   explicitly flagging that the confidence is *its own mapping*, not a number the rep stated, and asking
   the rep to confirm or correct it. This is the single most important behavior this tool has to get right.

2. **An email thread or transcript with no clear forecast signal at all.** Raw material that describes an
   interaction but doesn't give a timeline or confidence signal either directly or by implication. Expect:
   the tool leaves those fields blank and says so, rather than inventing a plausible-sounding date or
   confidence to fill the gap.

3. **No opportunity number given, or a lookup that finds nothing.** The rep hands over raw material without
   an opportunity number, or gives one that doesn't match anything in QuickBase. Expect: the tool doesn't
   block on this — it falls back to a pure transformation from the raw material alone, clearly flags in the
   output that the opportunity wasn't matched, and tells the rep to fill in the number by hand.

4. **A status-change signal in the material.** The raw material describes something that sounds like a
   stage move (e.g., a quote was sent, the deal was lost, it's on hold) rather than just a timeline update.
   Expect: the tool picks this up as a status-change field, comparing against the opp's current status if
   it was looked up, rather than only ever touching date/confidence/note.

5. **An update that would supersede or overlap a value set by a different tool for the same opp.** E.g., a
   fresh call-note update for an opp that already had a bulk `forecast-update` value applied earlier in the
   same session. Not something the skill file requires, but a good-behavior bonus if the tool notices the
   overlap and flags which value should win rather than presenting two silently conflicting drafts.

**What "fails gracefully" means for this tool specifically:** if the connector errors or times out, one
plain sentence and a suggestion to retry. The final output is always labeled as a draft the rep pastes
themselves; the tool never claims to have written anything to QuickBase, and it never treats a rep's own
raw material as license to invent details beyond what's actually in it.
