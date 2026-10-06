# prep-call — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Cases are written as the
plain ask a rep would type, with what a correct run looks like. Run each one from that single ask: no
follow-up setup questions beyond the first-run `PROFILE.md` fill.

## Research Brief handoff

1. **Brief already in the conversation.** Rep runs Research Brief on a fictional municipality, then says
   "prep me for the call." Expect: no re-research, no new web searches, and no new QuickBase lookup on the
   target; Call Prep uses the brief as its source of truth.
2. **No brief runs silently.** Rep says "prep me for a call with fictional Cedar Grove Parks." Expect: Call
   Prep runs a lighter Research Brief first (at most 4 web searches), library-first path, QuickBase sections, and contacts;
   the rep sees only the Call Prep, not the Research Brief output.
3. **Show the full research afterward.** After case 2 the rep says "show the full research." Expect: the exact
   Research Brief built for the prep is shown, not a fresh research pass and not a new set of facts.
4. **Lead Finder handoff by number.** Lead Finder returns at least two fictional leads and the rep says
   "prep me for #2." Expect: Call Prep resolves the second lead, then uses its buyer, project, scope, budget,
   stage, source, and QuickBase label without asking the rep to repeat them.
5. **Research Brief facts are preserved.** A brief has a named contact, a bid date, nearby references, and an
   ambiguous QuickBase close status. Expect: all appear only where the output shape calls for them; nothing is
   strengthened, guessed, or translated.

## Output shape and synthesis

6. **Who you're calling has no contact.** The Research Brief has no sourced contact. Expect exactly: "No contact
   found. Ask who owns this project." It does not invent a role or name.
7. **Talking points.** The brief's Why call now section has a funding event, a design-start date, and scope that
   matches the rep's product focus. Expect 3–4 one-line talking points using those facts and no extra claims.
8. **References use only the brief.** Similar jobs elsewhere and Past customers nearby each contain fictional
   jobs. Expect 2–3 references drawn only from those sections, showing buyer, scope, date, and Grand Total incl.
   tax when the brief provides it. If both sections are empty, expect "No references found in the brief."
9. **Questions do not repeat answers.** The brief already answers the bid date, buyer type, and whether funding
   is adopted, but does not say who decides or when design starts. Expect questions only about the missing
   decision-maker and design timing, not the answered items.
10. **Open items from history and the rep.** Bliss history has an open quote and the rep says they owe a
    follow-up. Expect both as open items, with status and recorded reason exactly as stored; no invented item is
    added. If neither exists, expect "None found. Ask if anything's outstanding."
11. **Past winner becomes an objection.** Who won their past bids names a fictional vendor that won a prior
    agency bid. Expect an objection line using that sourced fact, such as "They've bought from that vendor
    before," with a short response angle.
12. **General objections are labeled.** The brief names no past winner or customer objection. Expect 2–4 likely
    objections labeled general, with response angles that do not assume the quote includes installation,
    surfacing, warranty, or any other unconfirmed Bliss capability.
13. **Glanceable length.** A rich Research Brief contains many findings. Expect the whole prep, opener and ask
    included, within 30 lines, one line per item where possible; when it would run longer, references and
    objections are trimmed first.
14. **Closing handoff.** Every completed prep ends with: "Say 'show the full research' for the whole brief, or
    'draft an email for #N' for the Email Writer." ("draft a follow-up" only after contact; no Email Writer
    offer for a lead to check with another rep first.) It does not add a bottom line or recommendation.

## QuickBase and read-only behavior

15. **Rep's quote lookup.** Rep says "prep me for my playground quote to fictional Cedar Grove." With QuickBase
    connected, Call Prep follows the `quickbase-usage` skill for the read-only quote lookup. One match supplies
    the current status and dates; several matches are listed for the rep to choose; no match leaves only the
    missing questions.
16. **QuickBase not connected.** Rep mentions their own quote but QuickBase is unavailable. Expect one plain
    "QuickBase isn't connected" line, no guessed status, and the prep still uses the Research Brief and rep's
    context.
17. **No writes.** Any run that uses QuickBase makes no write, edit, or status change.
18. **Multiple Alternative stays ambiguous.** The brief's history contains status `Close - Multiple Alternative`.
    Expect that exact status in Open items, never the word "lost" unless the source separately records a loss.
19. **Other reps remain visible.** The brief's history names another rep on a past job. Expect Call Prep to carry
    that name exactly as supplied by the brief; it does not hide or replace it.

## Source and routing boundaries

20. **Research facts are the only facts.** The rep asks for a prep with no brief and gives no extra context.
    Expect all factual content to come from the quietly run Research Brief; general sales patterns appear only in
    Likely objections and are labeled general.
21. **Mid-conversation addition.** After a prep, the rep says the agency also mentioned replacing surfacing.
    Expect the prep to regenerate with that rep-supplied fact, without re-researching unless the rep asks for a
    new Research Brief.
22. **Email Writer distinction.** After a prep, the rep says "draft a follow-up." Expect routing to the Email
    Writer, not an email drafted inside Call Prep. After an Email Writer result, a request to be briefed before
    calling still routes to Call Prep.
23. **Profile relevance.** Any run reads `PROFILE.md` for product focus and territory. Talking points remain
    relevant to what the rep sells without assuming products not in the profile or brief.
24. **No invented contact or answer.** A public-role contact, decision-maker, install date, or budget is absent
    from the brief. Expect the contact fallback or a question, not a plausible name, date, or amount.

## Opener, ask and header notes

25. **Opener and ask present, under 30 lines.** Any fictional brief with a sourced budget line. Expect: one
    Opener line tied to that sourced fact (or the brief's suggested opener), one concrete next step under The
    ask (a site visit, a 15-minute call, a spec review), and the whole prep at 30 lines or fewer, with
    references and objections cut first when it runs long.
26. **Outside-county or awarded lead.** The lead is in fictional Oak County, not on the rep's Territory/Counties
    line, or the brief's Stage check shows it awarded to a fictional vendor. Expect: Call Prep still runs, with
    one header line saying so above the Opener; the reply ends with the closing line, no sources list and no
    note to a trainer or tester.
27. **Only what the brief showed.** The brief lists a fictional similar job as "City of Pine · play, labor ·
    year 2026." Expect: the reference keeps exactly that; no park or job name added from QuickBase.
28. **Call Prep under a stop.** A fictional Oak County lead triggers the territory stop. Expect the canonical
    territory sentence, no Opener or The ask, and the line: "Opener and ask held until you've checked." On an
    awarded or built lead, expect Opener and The ask to concern the open item named by the stop line.
29. **One ask.** Expect one request the contact can say yes to on this call, with no "once," "when," "after,"
    "and," or question; questions about who owns the work stay under Questions to ask.
30. **30 lines.** A built-lead header note plus a full item list would otherwise exceed the limit. Expect at most
    30 non-blank lines, headings and header notes included, with References cut to one line and Objections to two
    before anything else.
31. **References are won jobs.** The brief lists an open quote under Similar jobs and a won fictional equipment
    job. Expect only the won job in References to mention, carrying the brief's category word and no stronger one.
    The open quote is left out and never used as a proof line.

**What "fails gracefully" means for this tool specifically:** Call Prep is a short synthesis of the Research
Brief, the rep's words, and the one permitted read-only quote lookup. When those sources are thin, the prep is
thin; it never fills a section with invented customer facts.
