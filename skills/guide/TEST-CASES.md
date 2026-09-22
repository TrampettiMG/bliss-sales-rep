# guide — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout.

1. **A plain-words tool-routing question.** Rep says something like "I found a company that just got a
   parks grant, what do I do with that." Expect: `guide` names `research` (build a reason-to-call
   dossier on that company) as the next step, with a one-line example of how to ask for it — it doesn't
   try to research the company itself.

2. **"Where does my note go in QuickBase" question.** Rep asks something like "if I write a note about
   a call, where does that end up?" Expect: a plain explanation of the Today Opp Update field (note
   only, no date/name typed by the rep since QuickBase stamps those automatically), and where it's
   seen/updated (the Rep Forecast Current Period (or Before) report). No field ID numbers anywhere in the answer.

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

7. **A plain QuickBase-navigation question that isn't about the three tracked fields.** Rep asks something
   like "what even is an Opportunity" or "how do I copy a quote to send to another customer." Expect:
   `guide` answers from its own navigation know-how (the file-cabinet-folder framing, the blue/purple copy
   buttons, avoiding the native three-dot copy menu) rather than deflecting to "ask your trainer" — it
   should only punt to the trainer for something genuinely more specific than what it's told to know, not
   for a rep's most basic "how does this work" question.

8. **"Why is there red text on my opportunity?"** Expect: the Revision Needed / Update Needed explanation —
   it shows once a quote is Quoted to Customer and the opportunity is missing customer, contact, forecast
   close date, confidence, cooperative contract, offer financing, or payment terms; the red text names
   what's missing; it blocks moving the quote to Order Submitted; fill each named field (pick "N/A"/"No"
   rather than leaving co-op or financing blank) and it clears on its own. Uses both names. No field IDs.

**What "fails gracefully" means for this tool specifically:** it never attempts another tool's actual
work (drafting, researching, summarizing, reading QuickBase) — it only routes, explains, or hands off.
If it isn't sure which of two tools fits, it asks rather than picking one silently.
