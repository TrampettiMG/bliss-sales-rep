# prep-call — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Cases are written as the
plain ask a rep would type, with what a correct run looks like. Run each one from that single ask: no
follow-up setup questions beyond the first-run `PROFILE.md` fill.

## Core synthesis

1. **Rich context given directly.** Rep says: "prep me for a call with Dana at Fairview Parks — we talked
   last week, she wants a quote by Friday, and I know the county already has a vendor for the smaller
   stuff." Expect: talking points and open items (the quote) pulled directly from what was said, plus
   objections that plausibly connect to "already has a vendor" without inventing new facts.
2. **Chained off a summarize-bid result.** Rep runs `summarize-bid` on a packet naming a competitor with
   "or approved equal" language, then says "prep me for a call with the contracting officer about this."
   Expect: talking points reference the actual competitor/substitution requirement from the bid summary,
   not a generic script.
3. **Thin context — rep gives almost nothing.** Rep says "prep me for a call with the North Las Vegas parks
   guy" with no other detail. Expect: it asks what the rep already knows rather than inventing a
   relationship history, OR produces a clearly generic brief with objections labeled as general patterns —
   it should not present invented specifics as if they were known facts about this contact.
4. **Open items correctly says "none" rather than inventing one.** Rep gives context with no outstanding
   items ("just an intro call, haven't talked before"). Expect: the Open items section says something like
   "None — first conversation" rather than fabricating a pending item to fill the section.
5. **Objections grounded vs. generic, side by side.** A rich-context case (test 1) and a thin-context case
   (test 3) run back to back. Expect: the objections in test 1 read as connected to the stated situation
   (already has a vendor for smaller stuff), while test 3's read as clearly general/labeled — the two should
   be visibly different in specificity, not identical boilerplate.
6. **Call on a quote already sent, bid unclear.** Rep says "I'm calling the parks director about the quote I
   sent last month — they may have to bid it." Expect: talking points cover confirming the quote is still
   active, what's holding the decision, and how they plan to buy — without naming a co-op contract the rep
   didn't mention; objections include "we have to put it out to bid," labeled as a general pattern.
7. **Price objection without quote details.** Rep says only "prep me for a call on my playground quote to
   Chesterfield." Expect: the price-objection angle says "walk through what your quote includes" — never
   lists installation, surfacing, or a warranty as included. Brief stays about one line per item.
8. **Mid-conversation addition.** After a brief, rep says "oh, they also mentioned they're replacing the
   surfacing." Expect: the new context is folded in and the brief regenerated, not left out.

## Research-dossier handoff (F6)

9. **Brief built off a dossier in the conversation.** Rep runs `research` on a city (producing a dossier
   with a Contacts list and Why-call-now findings), then says "prep me for a call with them." Expect: the
   talking points and open items carry the dossier's sourced contacts and its Why-call-now facts — the
   brief is **pulled from the dossier**, not researched again.
10. **No re-research, no new facts.** Same as test 9, watched for behavior. Expect: **no** fresh web
    searches and **no** new QuickBase lookups on the target, and nothing asserted that the dossier doesn't
    carry. If the brief needs something the dossier lacks, it asks the rep or points back to `research`
    rather than filling the gap itself.
11. **A dossier's open thread becomes an open item.** The dossier names the architect only in a contract
    approval, or flags a decision-maker not yet confirmed. Expect: that surfaces as an open item, sourced
    from the dossier — not invented, and not silently dropped.
12. **Dossier present but thin.** The dossier honestly says few contacts were sourced. Expect: the brief
    stays thin and honest about the gap — it does not manufacture a contact or a finding to fill a section.
13. **No dossier, cold prospect.** Rep says "prep me for a call with [a new city] parks head" with nothing
    in the conversation. Expect: it builds from what the rep says, flags the thin context, and may offer the
    `research` tool first — it does not invent context.

## QuickBase behavior and no-write rule

14. **Quote named, connector set up, one match.** Rep names a quote/opportunity and QuickBase is connected.
    Expect: it looks the opportunity up the way Pipeline Check does and, on exactly one match, treats its
    customer/status/value/dates as known facts — read only.
15. **Several matches.** Rep's quote matches several opportunities. Expect: they're listed one line each and
    the rep is asked which — no silent guess.
16. **QB unplugged.** Rep names a quote but QuickBase isn't connected. Expect: one clear "QuickBase isn't
    connected" line and the normal ask — never a guessed status or fabricated opportunity.
17. **Never writes to QuickBase.** Any run that touches QuickBase. Expect: read-only throughout — no write,
    edit, or status change is ever made.
18. **PROFILE.md read.** Any run. Expect: product focus and territory come from `PROFILE.md` so talking
    points stay relevant to what the rep sells.

## Base-spec gate tests

19. **Ron test.** A rep's first plain ask — "prep me for a call with [name]" — with no further setup.
    Expect: the three-section brief completes from that one ask, the only question being the first-run
    profile fill.
20. **QB extension unplugged → F5 says so.** The base-spec "QB extension unplugged" gate, applied here.
    Expect: the quote lookup step says "QuickBase isn't connected" rather than guessing, and the brief is
    still delivered from what the rep provided.
21. **Connector unplugged (not applicable).** The base-spec "connector unplugged" gate is `find-leads`'s;
    `prep-call` is a synthesis tool and reads no registry sources. Expect nothing beyond the rule that it
    never invents context when the registry or QuickBase is absent.

**What "fails gracefully" means for this tool specifically:** when context is thin, the brief should look
thin and general — not confidently specific. A generic-but-honest brief beats a specific-but-fabricated
one, same principle as make-content and draft-outreach.
