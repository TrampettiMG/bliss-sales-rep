---
name: prep-call
description: >-
  Build a short, glanceable call brief from a Research Brief, the rep's own context, and a read-only
  QuickBase quote lookup when needed. Use when the rep says "prep me for a call", "prep me for #2",
  "pre-call brief for...", "what should I know before calling...", or names someone they are about to call.
  If no Research Brief is already in the conversation, run it first quietly and show only the call prep.
  "Draft a follow-up" or anything to send goes to the Email Writer.
---

# Call Prep

Build a short, glanceable brief for a call. Call Prep is built on the Research Brief: the brief supplies the
facts, contacts, Bliss history, similar jobs, nearby references, bid winners, and Why call now findings. Add
only what the rep says and the one permitted read-only QuickBase quote lookup.

**vs. `draft-outreach`:** Call Prep is the fuller pre-call brief. The Email Writer drafts an email or a short
call script to send or say. Never send, submit, or write anything from Call Prep.

## What this is not

This is a synthesis tool, not a second research pass. Never invent a contact, project detail, budget, timeline,
quote status, competitor, price, or Bliss capability. Follow the `quickbase-usage` skill for any QuickBase query
(it holds the tables and fields; never guess them). QuickBase is read-only here.

General sales patterns belong only in **Likely objections**, and each one is labeled general unless the Research
Brief or the rep supplied the specific fact. Response angles must not assume what is in the quote or what Bliss
offers; say "walk through what your quote includes" rather than naming unconfirmed inclusions.

## Cost and source rule

A prep without a Research Brief in the conversation costs about one Research Brief because Call Prep runs it
first. A prep with the brief already present costs nearly nothing extra. With a brief present, do not re-research,
run new web searches, or add new QuickBase lookups on the target.

## Flow

1. **Use the Research Brief if it is already in the conversation.** Treat it as the source of truth. Carry
   forward its buyer, project, scope, budget, stage, source, QuickBase label, Contacts, Bliss history and bid
   context, Similar jobs elsewhere, Past customers nearby, Who won their past bids, and Why call now findings.
2. **If there is no Research Brief, run the Research Brief first, quietly.** Follow `research` exactly: its
   target resolution, budget, Bliss Library-first path, QuickBase sections, contacts, and output rules. Do not
   show the research output; show only the Call Prep. To keep the cost down, run it in its lighter form: similar
   jobs from won jobs only, 3 results; at most 4 web searches. Resolve a Lead Finder handoff such as "prep me for #2"
   from that result, or use the name and context the rep gives. Ask only if `research` would ask.
3. **Add the rep's context.** Use past conversations and what the rep wants from this call. If the rep mentions
   their own quote or opportunity and QuickBase is connected, look it up read-only using the existing quote
   lookup path and follow the `quickbase-usage` skill for the query. If exactly one match is found, use its
   customer, status, value, dates, and forecast close date as known facts; if several match, list them and ask
   which one; if none match, ask only for what is missing. If QuickBase is not connected, say
   "QuickBase isn't connected" once and never guess a status.
4. **Build the prep.** Every fact comes from the Research Brief, that permitted QuickBase lookup, or the rep.
   Keep it to one line per item where possible and make it glanceable.
5. **If the rep adds context later, regenerate the same prep** rather than starting a new research pass.

## Output shape

Return these items in this order:

- **Who you're calling** — contact name, role, and source from the Research Brief's Contacts, plus the
  QuickBase status from the brief or permitted quote lookup, such as "in pipeline · quote number · confidence ·
  close date." If the rep's own opportunity in QuickBase lists a contact, that counts as a source too (say
  "from your opportunity"). If no sourced contact exists, write: "No contact found. Ask who owns this project."
- **Talking points** — 3–4 lines from Why call now, scope fit with the rep's product focus, and anything
  time-sensitive such as a bid date or design start. If the rep's own quote states a deadline in its terms
  (e.g. "valid through Oct 15" or a free-freight window), include it: it's often the most useful fact for the
  call. Money is the quote's Grand Total incl. tax. Do not add a fact the brief or the quote doesn't carry.
- **References to mention** — 2–3 lines using only jobs listed in Similar jobs elsewhere or Past customers
  nearby: buyer, scope, size labeled Grand Total incl. tax, and date. If there are none, write: "No references
  found in the brief."
- **Questions to ask** — 3–4 lines only about what the Research Brief could not find, such as design start,
  bid versus co-op, decision-maker, install date, or whether the budget is confirmed. Never ask for something the
  brief already answers.
- **Open items** — 1–3 lines from Bliss history with this buyer and the rep's words: an open quote, a recorded
  past close worth raising, or something the rep owes. Show status and recorded reason exactly as stored; never
  call `Close - Multiple Alternative` a loss. If none: "None found. Ask if anything's outstanding."
- **Likely objections** — 2–4 lines, each with a short response angle. If Who won their past bids names a past
  winner, use that sourced fact (for example, "They've bought from [vendor] before"). Otherwise label the line
  general. Never assume what the rep's quote contains or what Bliss offers.
- Closing line: "Say 'show the full research' for the whole brief, or 'draft a follow-up' for the Email Writer."

If the rep says "show the full research" afterward, show the Research Brief that was built before this prep.
Do not add a bottom line, recommendation, or strategic take.
