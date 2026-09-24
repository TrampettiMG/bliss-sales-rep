---
name: prep-call
description: >-
  Build a pre-call brief for a customer or prospect the rep is about to call — talking points, open
  items, and likely objections. Use when the rep says "prep me for a call with...", "pre-call brief
  for...", "what should I know before calling...", or names someone they're about to talk to and what
  they already know about the situation. Not for writing something to send — "follow up on…", "write /
  draft an email…", "email them about…" go to `draft-outreach`, even right after a prep-call brief.
---

# Call Prep

Turn what the rep already knows about a customer/prospect into a short brief to glance at right before
calling them: what to bring up, what's still unresolved, and what pushback to expect.

**vs. `draft-outreach`:** that tool's call script is a short opener for a cold or lightly-touched
prospect. This tool is the fuller brief for a call where there's real context or history to prepare for.
If the rep just wants a couple of lines to say on a cold call, `draft-outreach` is the better fit.

## What this is not

This is a synthesis tool, not a research or fact source. It never invents specifics about the customer —
their history, prior conversations, budget, or plans — beyond what the rep tells it or what's already in
the conversation (a `research` brief, a `summarize-bid` breakdown, a `lead-ideas`/`find-leads` result just
discussed). If the rep hasn't given enough to work with, ask what they know rather than guessing.

The **likely objections** section is the one place general sales judgment is expected and appropriate —
common pushback patterns (budget timing, "we already have a vendor," competing priorities, decision-maker
isn't on the call) are fine to suggest even when the rep hasn't mentioned them, since that's the point of
the section. Label it as a general pattern, not something specific to this customer, unless the rep or the
conversation actually said the customer raised it before.

## Flow

1. **Gather what the rep knows.** Ask (if not already given): who they're calling, and what they already
   know — prior conversations, where things stand, what they want out of this call. Pull in anything
   already sitting in the conversation from another tool (a bid summary, research brief, lead) instead of
   re-asking for it.
   **If the rep mentions a quote or opportunity of theirs** ("my playground quote to Chesterfield") and
   the QuickBase connection is set up, look it up first instead of asking about it: pull the rep's open
   opportunities the way the Pipeline Check tool file does (its "Whose opportunities" section), and match
   on the customer and what the rep described. If exactly one matches, use its customer, status, value,
   date created and forecast close date as known facts, and ask only for what QuickBase doesn't hold
   (who they're calling, past conversations, what they want from the call). If several match, list them
   in one line each and ask which. If none match or QuickBase isn't connected, just ask as above. Read
   only — never write to QuickBase.
2. **Read `PROFILE.md`** for the rep's product focus and territory, to keep talking points relevant to
   what they actually sell.
3. **Build the brief, three short sections:**
   - **Talking points** — what to bring up on this call, grounded in what the rep described (the
     situation, the product fit, anything time-sensitive like a bid deadline or site visit). Where it fits
     the situation, include: how the project is funded and when (a grant, bond, or budget year —
     only if known from the conversation or a `research`/`find-leads` result); whether they plan to bid it
     or buy another way — mention a specific cooperative contract only if the rep says Bliss holds it;
     and for a quote already sent, confirm it's still active and what's holding the decision.
   - **Open items** — anything unresolved from what the rep described: a quote they owe, a question the
     customer asked, a decision still pending, a follow-up they promised. If the rep didn't mention any,
     say "None mentioned — ask if there's anything outstanding" rather than inventing one.
   - **Likely objections** — 2-4 objections this kind of call commonly gets, each with a short response
     angle. Grounded in the situation where possible (e.g., a named competitor from a bid summary), general
     sales patterns otherwise — labeled as such. The common ones in playground/park sales: "another brand
     is already specified," "we have to put it out to bid," "your price is higher," "no budget until next
     fiscal year," and "we need it installed by a fixed date." Pick only the ones that fit this call.
     Response angles must not assume what's in the rep's quote or what Bliss offers (installation,
     surfacing, a warranty, a co-op contract) unless the rep said so — say "walk through what your quote
     includes," not a list of inclusions.
4. **Keep it short** — this is a glance-at-before-dialing brief, not a full account history. Aim for 3-4
   talking points, 1-3 open items, and 2-4 objections, one line each (a sub-bullet only when it carries
   a specific fact, like a project name or date). Don't repeat a point across sections or list two
   objections that are really the same one (e.g., "budget is tight" and "no money until next fiscal
   year") — merge them.
5. If the rep gives more context mid-conversation ("oh, they also mentioned X"), fold it in and regenerate
   rather than leaving it out.
