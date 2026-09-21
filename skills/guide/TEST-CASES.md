# guide — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout.

1. **A plain-words tool-routing question.** Rep says something like "I found a company that just got a
   parks grant, what do I do with that." Expect: `guide` names `research` (build a reason-to-call
   dossier on that company) as the next step, with a one-line example of how to ask for it — it doesn't
   try to research the company itself.

2. **"Where does my note go in QuickBase" question.** Rep asks something like "if I write a note about
   a call, where does that end up?" Expect: a plain explanation of the Today Opp Update field (note
   only, no date/name typed by the rep since QuickBase stamps those automatically), and where it's
   seen/updated (the Rep Forecast Current Period report). No field ID numbers anywhere in the answer.

3. **"How do I even use this" / getting-started question.** A new rep asks "how does this whole thing
   work" or "where do I start." Expect: the three-step quick start — say what you need in plain words,
   everything back is a draft or a read-only report, ask `guide` if unsure which tool fits. Short, no
   tool-by-tool walkthrough unless asked.

4. **A QuickBase question from a rep without the connector.** A Tier 1-only rep asks "how do I check my
   pipeline in here" (meaning `my-pipeline`, a QuickBase tool they don't have). Expect: the exact
   graceful-degrade line other Tier 2 tools use — "This needs the QuickBase connection your trainer sets
   up; it isn't on your account yet." — then a redirect to an everyday tool that fits what they actually
   need (e.g., `research` or `prep-call` if it's really about getting ready for a customer).

5. **A request that's really another tool's job in disguise.** Rep pastes an RFP/bid document into the
   chat and asks "can you tell me what's in this." Expect: `guide` recognizes this as `summarize-bid`'s
   job and hands off by name, rather than attempting to read or summarize the bid itself.

6. **An ambiguous request that could map to more than one tool.** Rep says "get me ready for my call
   with Acme tomorrow" with no other detail. Expect: `guide` asks one short clarifying question (a fuller
   pre-call brief, which is `prep-call`, vs. a short script to read from, which is `draft-outreach`)
   instead of guessing which one they meant.

**What "fails gracefully" means for this tool specifically:** it never attempts another tool's actual
work (drafting, researching, summarizing, reading QuickBase) — it only routes, explains, or hands off.
If it isn't sure which of two tools fits, it asks rather than picking one silently.
