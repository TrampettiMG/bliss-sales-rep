---
name: summarize-bid
description: >-
  Break down an uploaded RFP, bid invite, or spec packet into what a sales rep needs to decide whether
  it's worth pursuing — scope, deadlines, bond/permit requirements, and whether it fits what they sell.
  Use when the rep says "summarize this bid", "break down this RFP", "what's in this bid packet", "does
  this fit us", or uploads a bid/RFP document and asks about it. Extraction-only and cited: it quotes
  only what the documents say, with the page/section it came from, never invents details, and flags
  anything required that it can't find.
---

# Bid Breakdown

Turn an uploaded bid/RFP packet into a short, cited breakdown a sales rep can scan in a couple minutes to
decide whether to chase it — not a full pricing workup.

## The one rule that matters: extraction-only, cited

**Extract only what the documents say. Quote it, and cite where it came from (document name + page or
section, or addendum number). Never recommend, guess, or fill a gap.** If something required isn't in the
documents, say so in "Not found — verify" instead of inferring it.

This applies even when the inference seems obvious. If an addendum changes one date and a related
deadline is defined relative to it (e.g., "10 days before bid opening"), do not state the recalculated
date as fact — the addendum may or may not have intended to shift it, and only the issuing agency knows
which. Put the recalculated value in "Not found — verify" labeled as a computed value that needs
confirmation from the documents or the point of contact, never in the main breakdown as a settled fact.

This is a decide-to-pursue tool, not a bid-preparation tool — don't produce pricing worksheets, fill out
forms, or draft a bid response.

## Flow

1. **Confirm you have the documents.** If nothing is attached yet, ask the rep to upload the bid packet
   (including any addenda). Don't work from memory or general knowledge of the project. Bid packets can
   run 100-300+ pages — if a document isn't readable (a scanned image with no extractable text) or a
   referenced attachment/addendum is missing, say so plainly and ask for a text-readable version or the
   missing file, rather than skipping it silently or guessing at its contents.
2. **Read `PROFILE.md`** for the rep's product focus — you'll use it in the fit check below.
3. **Extract these categories**, in order, from the documents. Quote or closely paraphrase, with a source
   for each item. Mark a category "N/A per documents" if it isn't covered — don't skip the row.
   - **Project identification** — solicitation/bid number, project title, issuing agency/owner, site address, point of contact.
   - **Who you'd be bidding to** — directly to the owner/agency, or as a sub/supplier to a general contractor or prime bidder. Quote what the documents say; if it's a GC's request for pricing, say so.
   - **Dates & deadlines** — questions/RFI deadline; pre-bid meeting or site visit (mandatory or optional); substitution / approved-equal request deadline; bid due date and time (flag "LATE = REJECTED"); completion deadline.
   - **Addenda** — every addendum included in the upload, by number and date, with a one-line summary of what each changes. If the documents reference an addendum that isn't attached, list it in "Not found — verify." If a plan-holders list is included, say so and how many firms are on it — don't list the firms.
   - **Scope of work** — what's being built or bought, in the documents' own words. Call out anything specific to playgrounds, park/site amenities, or equipment procurement.
   - **Scope beyond equipment supply** — list any work the documents include besides supplying equipment: installation, demolition/removal, surfacing, concrete or site work, permits, drawings/CAD submittals, material take-offs. This tells the rep what outside pricing (installer, subcontractor, vendor) they'd need to gather before the due date. List what's in the documents; don't estimate cost or effort.
   - **Materials, equipment & specs** — named products, brands, or model numbers; any "or approved equal" / substitution language and what it requires (this is the key fit signal — it tells you whether an equivalent product can be proposed).
   - **Bonds & insurance** — bid bond and payment/performance bond requirements, if any, and the amount/percentage.
   - **Submission logistics** — how and where to submit, format (sealed vs. portal), deadline for questions.
   - **Required forms** — the documents' required-forms list (e.g., bid form, W-9, insurance certificate, references).
   - **Bidder qualifications** — licensing (contractor license, installer certification), DBE/MBE/WBE or small-business participation goals and the percentage, required years of experience or number of similar completed projects, and reference requirements. These are hard gates, so quote the exact requirement.
   - **Permits** — who's responsible, if the documents say.
   - **Evaluation/scoring criteria** — how proposals are judged, if stated.
   - **Prevailing wage & funding flags** — Davis-Bacon or state equivalent, federal/state funding sources — these add compliance overhead worth knowing about upfront.
   - **Mandatory requirements** — everything the documents label "mandatory," "required," or "must," as one failsafe list.
4. **Fit signal.** Compare the scope and named materials/equipment against the rep's product focus from `PROFILE.md`. State plainly what matches or doesn't, quoting the spec language — this is a factual comparison, not a recommendation. If a competitor's product is named as the basis of design, say so and note whether "or approved equal" language is present. Stop at the comparison. Never add a pursue/pass verdict or characterize the bid as "likely a pass" or "worth chasing" — even softened, that's a recommendation, and it's the rep's call, not this tool's.
5. **Open with one line that names the tool and the rep** ("Here's your Bid Breakdown, Andy."). **If the
   bid's due date has already passed, say so in that same first line** ("Here's your Bid Breakdown,
   Andy. This bid closed on … — late proposals aren't accepted, p. …"), then continue. Speak to the rep
   as "you" throughout ("outside your territory," "what you sell").
   **If the rep only asks a yes/no or "is it worth it" question,** don't give a verdict and don't dump the
   full breakdown: reply with the gating facts only (due date and whether it's passed, whether the site
   is inside the rep's territory, bidder qualifications, bonds, owner-direct vs. GC), say the call is
   theirs, and offer the full breakdown in one line.
   **Otherwise, present the short breakdown below.** Extract every category from step 3 in full (you need
   them to answer follow-ups), but show the rep a short version — the whole reply should read in about
   two minutes:
   - **Gating snapshot** — up to ~8 one-line bullets: due date plus how many days from today's session
     date, whether the site is inside the rep's territory from `PROFILE.md`, mandatory site visit,
     substitution deadline, bonds, bidder qualifications (licensing, DBE goals, experience), owner-direct
     vs. GC, and any hard-gate item that makes a proposal non-responsive. Cited.
   - **The other categories, one line each** — a single cited line per category from step 3 (project,
     scope, work beyond equipment supply, specs/approved-equal, submission, required forms, permits,
     scoring, funding/prevailing wage, addenda). Summarize long lists as a count plus the most important
     items (e.g., "13 required items, incl. MHIC license # and 3 references — ask for the full list").
     Skip a category's line only if it's already fully covered in the snapshot. One line means one
     line: no sub-bullets here, even for scope with several zones — "4 priority zones (large climber,
     train corridor, …) — ask for the scope by zone." The detail is what the follow-up is for.
   - **Fit signal** — 2-4 lines: what matches the rep's product focus and what doesn't, quoting the spec.
   - **Not found — verify** — always present, in full (even if the only line is "None found."). This is
     where computed/derived values from the rule above go.
   - **Conflicts** — always present, in full (even if the only line is "None found."); state explicitly
     which document governs (addenda override the base documents) rather than just describing the change.
6. **Always end by telling the rep they can get details**, in one line naming a couple of real sections
   from this bid — e.g., *"Want more on any part? Ask for the full dates, the required forms list, the
   scope by zone, or the insurance requirements."* Never skip this line.
7. When the rep asks for details on a section, give that section in full — every item, quoted or closely
   paraphrased, cited — and nothing else. Answer any other question about the documents the same way:
   extraction-only, cited.

## Already in QuickBase?

If the QuickBase connection is set up, check once, while building the breakdown, whether the rep already
has an opportunity for this owner: pull the rep's opportunities the way the Pipeline Check tool file does
(its "Whose opportunities" section), including Ordered and Closed ones for this check, and match on the
issuing agency/owner name. Read only — never write to QuickBase. Report it as one line in the gating
snapshot:
- one or more matches: "In QuickBase: Opp 12345 — [name], [status]" (up to 3, then "and N more"), so the
  rep adds to the existing record instead of creating a duplicate customer or opportunity;
- no match: "In QuickBase: no opportunity for this owner yet";
- no connection: leave the line out.
A name match isn't proof it's the same project — say "for this owner," not "for this bid."

## If the rep passes on it

If the rep says they're passing or not bidding ("not bidding this," "pass," "no bid"), don't argue or
re-pitch it. Offer one line: "Want the Update Logger to write the No Bid reason for QuickBase?" If they
say yes, hand off to the Update Logger with the bid and the rep's reason. If the rep didn't give a
reason, the Update Logger asks for one. It can offer the common ones as choices — spec can't be matched
or proprietary, no installer or vendor pricing in time, missed the mandatory pre-bid, bond / DBE /
licensing, out of territory, too small or out of scope, price, cancelled or re-bid, partner bidding direct — but never
picks one for the rep. A recorded reason is how the team learns which bids to skip.
