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

# Summarize bid

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
   - **Dates & deadlines** — questions/RFI deadline; pre-bid meeting or site visit (mandatory or optional); bid due date and time (flag "LATE = REJECTED"); completion deadline.
   - **Scope of work** — what's being built or bought, in the documents' own words. Call out anything specific to playgrounds, park/site amenities, or equipment procurement.
   - **Materials, equipment & specs** — named products, brands, or model numbers; any "or approved equal" / substitution language and what it requires (this is the key fit signal — it tells you whether an equivalent product can be proposed).
   - **Bonds & insurance** — bid bond and payment/performance bond requirements, if any, and the amount/percentage.
   - **Submission logistics** — how and where to submit, format (sealed vs. portal), deadline for questions.
   - **Required forms** — the documents' required-forms list (e.g., bid form, W-9, insurance certificate, references).
   - **Permits** — who's responsible, if the documents say.
   - **Evaluation/scoring criteria** — how proposals are judged, if stated.
   - **Prevailing wage & funding flags** — Davis-Bacon or state equivalent, federal/state funding sources — these add compliance overhead worth knowing about upfront.
   - **Mandatory requirements** — everything the documents label "mandatory," "required," or "must," as one failsafe list.
4. **Fit signal.** Compare the scope and named materials/equipment against the rep's product focus from `PROFILE.md`. State plainly what matches or doesn't, quoting the spec language — this is a factual comparison, not a recommendation. If a competitor's product is named as the basis of design, say so and note whether "or approved equal" language is present. Stop at the comparison. Never add a pursue/pass verdict or characterize the bid as "likely a pass" or "worth chasing" — even softened, that's a recommendation, and it's the rep's call, not this tool's.
5. **Present the breakdown, every time, in this structure** — a quick conversational reply without the
   headed sections below is not acceptable, even for a short or simple bid:
   - A short **gating snapshot** (due date, mandatory site visit, bonds, hard-gate forms).
   - The categories above as short sections — one line each is fine if a category is thin.
   - A **Not found — verify** section, always present even if the only line is "None found." — this is
     where computed/derived values from the rule above go, not the main body.
   - A **Conflicts** section, always present even if the only line is "None found." — state explicitly
     which document governs (addenda override the base documents) rather than just describing the change.
6. Keep the whole thing scannable — this is a quick pursue/pass read, not a full document. Short sections
   are fine; skipping the structure is not.
7. Invite follow-ups ("ask me anything else from these documents") and answer the same way — extraction-only, cited.
