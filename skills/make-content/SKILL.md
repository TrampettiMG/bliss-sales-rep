---
name: make-content
description: >-
  Draft a value-prop one-pager, a bid cover letter, or short pitch content for a named prospect type
  (e.g. parks departments, HOAs, school districts), or a leave-behind after a call. Use when the rep says
  "make me a one-pager for...", "make a one-pager for #2", "write a value prop for...", "draft a cover
  letter for this bid", "write the cover letter", "make a leave-behind", "give me pitch content for...", or
  asks for something to hand a prospect or attach to a bid. Always produces a draft for the rep to
  review, edit, and send themselves — never sends or submits anything.
---

# Content Builder

Draft short, ready-to-use written content for a rep to hand a prospect, attach to a bid, or use as talking
points. Three content types, one flow.

## What this is not

This is a drafting tool, not a fact source. It never invents specifics — certifications, awards, past
project names, statistics, warranty terms, pricing — that the rep hasn't given it or that aren't already
in `PROFILE.md`. If a piece of content would be stronger with a specific claim the rep hasn't supplied,
leave a clearly marked placeholder (e.g., `[years in business]`, `[certification name]`) instead of making
one up. A generic-but-true draft beats a specific-but-fabricated one — a false claim in writing is a real
liability for Bliss, not just a weak pitch. (See the house rules in `CLAUDE.md` for how to handle a
rep-supplied quantitative claim you can't verify.)

Everything produced here is a **draft**. Never send, submit, or post it — hand it back for the rep to
review and send themselves.

## Flow

1. **Identify the content type** from the request:
   - **Value-prop one-pager** — a short standalone piece about why to work with Bliss, for a named
     prospect type (e.g., "parks departments," "city/county government," "school districts," "HOAs,"
     "churches," "property management," "general contractors").
   - **Bid cover letter** — a letter to attach to a specific bid submission.
   - **Pitch content** — shorter, more flexible: an elevator pitch, a few talking points, a short intro
     paragraph, for a named prospect type or situation. A **leave-behind** (after Call Prep) is pitch content
     for one buyer: see "Chained context" below.
   If it's ambiguous which one the rep wants, ask in one short question rather than guessing.

2. **Read `PROFILE.md`** for the rep's name, contact info, territory, and product focus — use it to
   personalize the signature block and framing. Don't ask the rep to re-state anything already there.

3. **Gather what's specific to this piece:**
   - For a **bid cover letter**: pull the agency name, bid/solicitation number, and project title from
     context — if the rep just ran `summarize-bid` on this bid in the same conversation, or uploaded the
     bid packet, use those details instead of asking again. If none of that is available, ask for the bid
     number and agency name.
   - For a **one-pager or pitch content**: confirm the named prospect type if it isn't already clear from
     the request, and ask the rep for any specific products, capabilities, or selling points they want
     featured — don't assume a product catalog the rep hasn't given you.

4. **Draft the content:**
   - **Value-prop one-pager** (~250–400 words, scannable): a short headline, 3–4 benefit bullets specific
     to the named prospect type (why this matters to *them*, not generic marketing copy), a brief
     why-Bliss paragraph, and a contact block from the profile.
   - **Bid cover letter** (standard business-letter format): addressed to the agency/point of contact if
     known, references the bid/solicitation number and project title, acknowledges each addendum by number
     if the addenda are known (e.g., from `summarize-bid`) — never guess addendum numbers — one paragraph
     on fit and interest,
     closes with the rep's name/contact from the profile. Keep it short — one page.
   - **Pitch content**: match the length the rep actually asked for (an elevator pitch is a few sentences,
     talking points are a short bulleted list) — don't pad it into a one-pager they didn't ask for.

5. **Hand it back as plain, paste-ready text** the rep can copy into an email, a document, or print
   directly. Offer a downloadable document only if the rep asks for one.

6. **Flag placeholders clearly** at the end if any were used (e.g., "You'll want to fill in `[years in
   business]` before sending this") — don't let a bracketed placeholder slip through unnoticed.

7. If the rep asks for a revision (shorter, different tone, different prospect type), redraft rather than
   patching — keep the same discipline about not inventing specifics.

## Chained context and QuickBase proof

- **From a Lead Finder result:** "make a one-pager for #2" means use lead #2 without re-asking. Carry over
  its buyer, buyer type, project scope, stage, source, and QuickBase label. If a Research Brief for that lead
  is already in the conversation, use its similar-jobs and nearby-customer references too.
- **After Call Prep:** "make a leave-behind" means turn that Call Prep's talking points and references into
  paste-ready leave-behind content. Do not ask the rep to repeat them.
- **When QuickBase is connected:** for a one-pager or pitch, add 2–3 reference bullets or a factual count,
  such as "3 school playgrounds in [state] in 2026." If a Research Brief is in the conversation, use only its
  Similar jobs elsewhere and Past customers nearby. Otherwise run just the Past customers nearby lookup (the
  county, else the same state), kept to the prospect type; don't run the full Research Brief. Mark every item
  exactly: "from QuickBase — double-check before it goes out." Follow the `quickbase-usage` skill (it holds
  the tables and fields; never guess them). Never put customer pricing in prospect-facing content. If QuickBase is not
  connected, keep the current `[placeholder]` behavior instead of inventing proof.
- **Co-op claims:** if QuickBase or the Research Brief shows the buyer used a co-op, write "available through
  [co-op]" only after the rep confirms Bliss holds that contract. Otherwise ask one short confirmation question
  or leave the co-op out.

## Bid Breakdown handoff

When a Bid Breakdown is in the conversation, a cover letter uses only its facts: solicitation/bid number,
project title, issuing agency, due date, every acknowledged addendum by number and date, and a line that the
required forms are enclosed, listing the forms from the breakdown. Anything missing from the breakdown stays a
`[placeholder]`; never infer or fill it from general bid conventions.
