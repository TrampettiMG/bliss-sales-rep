---
name: draft-outreach
description: >-
  Draft an intro email, follow-up email, open-quote follow-up, past-customer check-in, re-engagement
  email, or call script for a prospect, in the rep's own voice. Use when the rep says "write an intro
  email for...", "draft a follow-up to...", "follow up on my quote to...", "check in with a past
  customer...", "write a re-engagement email for...", "give me a call script for...", or asks for
  something to send or say to a prospect. "Follow up on [a quote/proposal]" means an email here, not a
  pre-call brief — even if the previous message in the chat was a `prep-call` brief. Always a draft for the rep to review and send/use themselves —
  never sends anything.
---

# Email Writer

Draft short, ready-to-use outreach — email or a call script — for one specific prospect or situation the
rep describes. Never invents facts about the prospect; never sends anything.

**vs. `prep-call`:** this tool's call script is a short, glanceable opener for a cold or lightly-touched
prospect — a few talking points to say out loud. `prep-call` is the fuller pre-call brief (talking points,
open items, objections) for a call where there's more context or history to prepare for. If the rep's
request sounds like they want to be *briefed* before a call rather than handed something short to *say*,
use `prep-call` instead.

## Voice, captured once

Check `PROFILE.md` for a **Voice** line. If there isn't one yet, ask the rep one short question **before
drafting anything** — not after: *"How do you like to sound in emails/calls — casual and short, or more
formal?"* Wait for their answer, save it as a **Voice** line in `PROFILE.md`, then draft using it — the
first draft should reflect their voice too, not just future ones. If they later say a draft doesn't sound
like them, update the Voice line the same way.

## What this is not

This is a drafting tool, not a fact source. It never invents specifics about the prospect — their history
with Bliss, prior conversations, their organization's plans, budget, or timeline — beyond what the rep
tells it or what's already in the conversation (e.g., from a `research` or `find-leads`/`lead-ideas`
result just discussed). If the rep hasn't given enough to personalize a draft, ask for the missing detail
in one short question rather than inventing a plausible-sounding one. (See the house rules in `CLAUDE.md`
for how to handle a rep-supplied quantitative claim you can't verify.)

Everything produced here is a **draft**. Never send, submit, or post it — hand it back for the rep to
review and send/say themselves.

## Flow

1. **Identify the type** from the request: intro, follow-up, open-quote follow-up, past-customer
   check-in, re-engagement email, or call script. If ambiguous, ask in one short question.
2. **Read `PROFILE.md`** for the rep's name, contact info, territory, product focus, and Voice line (see
   above — ask for Voice only if it's missing).
3. **Gather what's specific to this prospect:** who they are, what's known about them or their
   organization, and the situation (cold intro, following up on X, gone quiet since Y). Pull this from
   what the rep just told you or from a tool result already in this conversation (a lead, a research
   brief, a bid summary) — don't ask the rep to repeat something already said. If there isn't enough to
   personalize the draft beyond a generic template, ask one short question for the missing piece. When
   you ask, don't offer examples drawn from earlier results as if they were the rep's own history — a
   project from `research` or `find-leads` is a lead, not "a quote you already sent." Ask plainly
   ("Which quote is this about?").
   **For a follow-up on one of the rep's own quotes** ("follow up on the shade quote I sent Henrico
   Schools") when the QuickBase connection is set up, look it up before asking or drafting: pull the
   rep's open opportunities the way the Pipeline Check tool file does (its "Whose opportunities"
   section), plus the opportunity name and its contact if QuickBase has one (the `quickbase-usage` skill
   holds the fields; never guess them). Match on the customer and what the rep described. If exactly one
   matches, use its opportunity name and contact in the draft. The subject line gets the opportunity
   name only — never the "Opp ####" number, which is internal and means nothing to the customer; the
   number goes only in what you say to the rep. If several match, list them one line each and ask which. If none match
   or QuickBase isn't connected, carry on as above and leave a `[Name]` placeholder. Read only — never
   write to QuickBase.
4. **Draft, matched to type:**
   - **Intro email** — short, states who the rep is and why they're reaching out, one clear ask (a call,
     a site visit, a quick reply) — not a full pitch. Keep it a few short paragraphs at most.
   - **Follow-up email** — references the specific prior interaction the rep described (a call, a meeting,
     a proposal sent), restates the open item or next step, one clear ask.
   - **Open-quote follow-up** — for a quote the rep sent that hasn't turned into an order or a no (often
     flagged by `my-pipeline` as quoted 90+ days ago). Name the quote or project, ask one simple question
     that gets a clear answer — still moving, timing changed, or went another way — and make "no" or
     "not this year" easy to say, so the rep can update or close it out. No invented urgency or
     discounts.
   - **Past-customer check-in** — for a customer who's bought before (most repeat business comes from
     these). Reference the past project only if the rep names it or QuickBase shows it (a Pipeline Check past-customer list), ask about what's coming up (another
     site, a phase two, replacing aging equipment or surfacing, next year's budget), and keep the ask
     small. Never invent their history, plans, or budget timing.
   - **Re-engagement email** — for a prospect gone quiet. Light touch, no guilt-tripping or fabricated
     urgency ("prices are going up," "limited availability") unless the rep says that's actually true.
     Give them an easy, low-pressure way to respond.
   - **Call script** — talking points, not a word-for-word script: an opening line, 2-3 points to cover,
     and how to handle the most likely objection or two. Bullet form, meant to glance at during the call,
     not read verbatim.
   Apply the rep's Voice throughout — casual and short vs. more formal changes the sentence length and
   tone, not the facts included.
5. **Hand it back as plain, paste-ready text.** For an email, that means subject line + body. For a call
   script, a short bulleted list.
6. If the rep asks for a revision (shorter, different tone, different ask), redraft rather than patching.

## Several check-ins or follow-ups at once

When the rep asks for follow-ups on several old quotes (usually right after a Pipeline Check that
flagged "quoted 90+ days ago" items, e.g. "yes, draft those"), write one short open-quote follow-up per
quote, **up to 5 per reply**. The same goes for check-ins with several past customers from Pipeline
Check's past-customer list: one short past-customer check-in each, following those rules (reference the
last order only as QuickBase shows it, never invent their plans or budget timing). If there are more, say how many are left and offer the next batch. Use the
Pipeline Check result already in the conversation for each quote's customer, opportunity number and
name; look up the contact the same way as above, and use `[Name]` where there isn't one. Ask for Voice
once (if missing), not per email. Put a one-line header above each draft ("Opp 12345 — Henrico County
Public Schools") so the rep can tell them apart. Every email follows the open-quote follow-up rules
above: one simple question, "no" or "not this year" easy to say, no invented urgency or discounts. Don't
copy the same wording into every email word for word — vary the opening line so they don't read as a
mail merge. Never put the "Opp ####" number in a subject line or email body — it belongs only in
the header the rep sees. If two or more drafts go to the same contact, say so after the drafts and
offer to merge them into one email ("Pat gets two of these — want them as one email?").
