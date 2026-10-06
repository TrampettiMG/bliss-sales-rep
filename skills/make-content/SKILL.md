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
     featured — don't assume a product catalog the rep hasn't given you. **Exception: when it's for a lead
     already in the conversation** ("#2," a Research Brief, a Call Prep), don't ask: use the lead's scope and
     the Product Focus line in `PROFILE.md`, and the rep can ask for changes after.
   - **Only claim what a source shows.** Benefit bullets and the why-Bliss paragraph may only name products
     the rep sells (the Product Focus line in `PROFILE.md`) and claim capabilities the rep has stated or a tool
     result in the conversation shows (e.g. QuickBase jobs). Anything else ("one team for play, shade and surfacing," "in-house install") is a
     `[capability]` placeholder the rep fills in. That includes design or layout help, "one team" or
     in-house install, "from design through installation," warranty, and years in business.
   - **Headings and bold lead-ins are claims too.** The rule covers the headline, section headings and bold
     lead-ins, not only sentences: an unsourced "One team for play, shade and surfacing" heading becomes a
     `[capability]` placeholder.
   - **Product Focus is what the rep sells, not what Bliss is.** It picks which products to feature; it
     isn't a source for a company-level claim. "Bliss does…", "Bliss offers…" and the like need a source
     (the rep's words or a tool result) or a `[capability]` placeholder.
   - **Reach claims only as wide as a source shows.** Working with designers, consultants or general
     contractors, and geographic reach ("across Florida," "throughout the Southeast"), are written only as
     wide as a source shows (e.g. a count of QuickBase jobs in that county or state); otherwise
     `[capability]`.
   - **Reference jobs say only what the record shows:** buyer, park or job name, product categories, year. Never add "completed," "just finished," "installed by our team," or anything else about how or when the job was done.
   - **Check before you hand it back.** Read every benefit bullet and sentence once more and ask: which line
     of the profile, the rep's words, or a tool result says this? If none does, make it a `[capability]`
     placeholder or cut it.

4. **Draft the content:**
   - **Value-prop one-pager** (as long as the sourced content supports, 400 words at most; scannable): a
     short headline, up to 4 benefit bullets, each sourced; fewer is complete, and a page with two sourced
     bullets and placeholders elsewhere is finished. Make them specific to the named prospect type (why this
     matters to *them*, not generic marketing copy), then add a brief why-Bliss paragraph and a contact block
     from the profile.
   - **Bid cover letter** (standard business-letter format): addressed to the agency/point of contact if
     known, references the bid/solicitation number and project title, acknowledges each addendum by number
     if the addenda are known (e.g., from `summarize-bid`) — never guess addendum numbers — one paragraph
     on fit and interest. **Never commit the rep's proposal**: what it covers, which tasks or zones, staying
     under a budget, following a theme, or complying with all terms is a placeholder (`[what your proposal
     covers]`, `[compliance statement]`) unless the rep has said it. Describe the bid from the breakdown;
     the rep decides what Bliss offers,
     closes with the rep's name/contact from the profile. Keep it short — one page.
   - **Pitch content**: match the length the rep actually asked for (an elevator pitch is a few sentences,
     talking points are a short bulleted list) — don't pad it into a one-pager they didn't ask for.

5. **Hand it back as plain, paste-ready text** the rep can copy into an email, a document, or print
   directly. Offer a downloadable document only if the rep asks for one.
   The reply ends with the draft, the placeholder flag (step 6), and, after a one-pager with a lead in the
   conversation, one line: `Say "draft an email for #N".` Otherwise nothing. No separate sources list, no notes
   to a trainer, admin or tester, and no description of how it was built.

6. **Flag placeholders clearly** at the end if any were used (e.g., "You'll want to fill in `[years in
   business]` before sending this") — don't let a bracketed placeholder slip through unnoticed. List each
   placeholder by its bracket text, one per line, with no count.

7. If the rep asks for a revision (shorter, different tone, different prospect type), redraft rather than
   patching — keep the same discipline about not inventing specifics.

## Stop for another rep's deal, another county, or an awarded job

Prospect-facing content follows the same stops as the Email Writer, one line each, and doesn't draft:
- **Another rep's deal:** a lead labeled `BLISS INVOLVED`, or another rep's open quote or opportunity for
  this same project (whatever the label, including `· open quote: [rep]` after it): say in one line to check
  with the rep of record first. If the brief or the Lead Finder shows the `BLISS INVOLVED` match is your own QuickBase record
  and no other rep has an open record on this project, say "This one is yours." and carry on.
- **Outside your counties:** the lead's county isn't on the Territory/Counties line in `PROFILE.md`: "This one's
  in [county], which isn't one of your counties. QuickBase lists [rep] for it: check with [rep] or your manager
  before reaching out." If no rep is named: "This one's in [county], which isn't one of your counties. Check
  with your manager before reaching out." Skip this check while that line is blank or still loading.
- **Awarded to another vendor:** the Research Brief's Stage check says awarded, so say: "The brief shows this awarded to
  [vendors] on [date, or 'date not stated'] ([source]). Want content about [another open item in the brief]
  instead?"
- **Under contract with another vendor:** say: "The brief shows this under contract with [vendor] on [date, or
  'date not stated'] ([source]). Want content about [another open item in the brief] instead?"
- **Built:** say: "The brief shows this built ([source]). Want content about [another open item in the brief]
  instead?"
- **Partly built:** say: "The brief shows [built part] built ([source]); [other part] isn't confirmed. Want content
  about [other part] instead?"
- **Not in the budget:** say: "The brief shows this isn't in the budget ([source]). Want content about [another open
  item in the brief] instead?"
- "Under contract with another vendor" means a project-specific contract naming the selected vendor. A standing,
  on-demand, annual, co-op or other multi-vendor contract is a way to buy, not an award: no stop.
  An award or match on the rep's own record is "This one is yours." then route by label.

## Chained context and QuickBase proof

- **From a Lead Finder result:** "make a one-pager for #2" means use lead #2 without re-asking. Carry over
  its buyer, buyer type, project scope, stage, source, and QuickBase label. If a Research Brief for that lead
  is already in the conversation, use its similar-jobs and nearby-customer references too.
- **After Call Prep:** "make a leave-behind" means turn that Call Prep's talking points and references into
  paste-ready leave-behind content. Do not ask the rep to repeat them.
- **When QuickBase is connected:** for a one-pager or pitch, add 2–3 reference bullets or a factual count,
  such as "3 school playgrounds in [state] in 2026." Use won jobs only, and apply the Research Brief's equipment
  test; a job that fails it is listed as "furnishings" or "parts", or left out. If a Research Brief is in the
  conversation, use only its Similar jobs elsewhere and Past customers nearby. Otherwise run just the Past
  customers nearby lookup (the county's rows, plus same-state rows up to 5 when the county has fewer than 3),
  kept to the prospect type; don't run the full Research Brief. Mark each reference on its own line, ending with "from QuickBase — double-check before it goes
  out." after the reference's period (on every item, not once for the group). Follow the `quickbase-usage` skill
  (it holds the tables and fields; never guess them). Never put customer pricing in prospect-facing content. If
  QuickBase is not connected, keep the current `[placeholder]` behavior instead of inventing proof.
- **Co-op claims:** if QuickBase or the Research Brief shows the buyer used a co-op, write "available through
  `[co-op]`" as a placeholder the rep fills in once they've confirmed Bliss holds that contract; don't ask a
  confirmation question. Otherwise leave the co-op out.

## Bid Breakdown handoff

When a Bid Breakdown is in the conversation, a cover letter uses only its facts: solicitation/bid number,
project title, issuing agency, due date, every acknowledged addendum by number and date, and a
`[confirm: required forms enclosed — list them]` placeholder for the forms (the rep confirms what's actually
enclosed). If the breakdown shows the forms or addenda only as a count ("13 required items"), ask the Bid
Breakdown for the full list first, in the same conversation, rather than listing only the few shown. Anything missing from the breakdown stays a
`[placeholder]`; never infer or fill it from general bid conventions.
