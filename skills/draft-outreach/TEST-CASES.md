# draft-outreach — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **First-ever run: voice capture.** Rep with no Voice line in `PROFILE.md` asks for an intro email. Expect: one short question about tone before drafting, then the Voice line gets saved to `PROFILE.md`. A second, later request in the same or a new chat should NOT re-ask.

2. **Intro email chained off a lead-ideas/research result.** Rep gets a lead from `lead-ideas` (or a research brief) in the same conversation, then says "draft an intro email to them." Expect: the draft uses the specific details already surfaced (the project, the agency, the angle) without asking the rep to repeat them, and doesn't invent anything beyond what was in that result.

3. **Follow-up email with a specific described interaction.** Rep says "I had a call with Dana at Fairview Parks yesterday, she wants a quote by Friday — write a follow-up." Expect: the follow-up references exactly that (the call, Dana's name, the Friday deadline) and doesn't add fabricated detail about what else was discussed.

4. **Re-engagement email, cold ask with no real urgency given.** Rep says "write a re-engagement email for a prospect who's gone quiet for two months" with no other detail. Expect: a light-touch draft with an easy way to respond — it should NOT invent a fake urgency line ("prices are increasing," "limited slots left") since the rep never said that was true.

5. **Call script, short ask.** Rep says "give me a script for a call with a school district that hasn't responded to two emails." Expect: bullet-form talking points (opening line, 2-3 points, objection handling) — not a rigid word-for-word script, and not padded into something longer than a glanceable call-prep list.

6. **Open-quote follow-up.** Rep says "follow up on the quote I sent Riverside Parks in May for the shade structure." Expect: names the quote/project, asks one clear question (still moving / timing changed / went another way), makes "no" easy to say, and adds no invented urgency or discounts.

7. **Past-customer check-in with no project named.** Rep says "check in with Oak Hill Schools, they bought from us before." Expect: a short check-in asking what's coming up, with no invented past project, dates, or budget — or one short question asking which project to reference.

8. **Follow-up right after a prep-call brief.** In the same chat, after a `prep-call` brief, rep says "follow up on the shade structure quote I sent Henrico Schools in June." Expect: an open-quote follow-up **email** (Voice asked first if unset), not another brief; "Henrico Schools" and "June" carried into the draft.

9. **No invented history in the clarifying question.** Earlier in the chat, `research` surfaced a playground project. Rep asks for an email with no quote named. Expect: "Which quote is this about?" — never "a quote you already sent, like [the research project]."

**What "fails gracefully" means for this tool specifically:** if there's not enough specific context to personalize a draft (no prospect name, no situation described), ask one short question rather than producing a generic template dressed up as personalized, or inventing plausible-sounding prospect details.

10. **Quote-only follow-up.** A Lead Finder result names a fictional customer and job with a QuickBase quote
    but no opportunity. Expect: Email Writer finds the quote by customer plus job name, uses its details, and
    does not invent an opportunity or fall back to a blank placeholder.
11. **Lead label — in pipeline and yours.** Expect: an open-quote follow-up referencing the new public signal,
    without asking the rep to choose the type.
12. **Lead label — lost before.** Expect: a re-engagement email around the new signal, never implying the old
    quote is still open.
13. **Lead label — won before.** Expect: a past-customer check-in about phase two, another site, or surfacing,
    never a "still moving?" follow-up.
14. **Lead label — new.** Expect: an intro email.
15. **BLISS INVOLVED or another rep's open job.** Expect: no draft; one line says to check with the rep of
    record first.
16. **Intro for #2 with a Research Brief present.** Lead Finder has two fictional results, Research Brief has
    already supplied the second lead's sourced contact and Why call now signal, and the rep says "draft an intro
    for #2." Expect: the contact is used in the To line or greeting, the signal is the reason for writing, and
    at most one proof line comes from Similar jobs elsewhere or Past customers nearby. No dollar amount appears
    in the email, and nothing is re-asked or invented.
17. **No brief: quick buyer lookup and offer.** Rep says "draft an intro for fictional Cedar Grove Parks" with
    no Research Brief. Expect: no full Research Brief runs; a quick read-only QuickBase buyer lookup chooses the
    email type from the existing labels, and the response offers: "Want the Research Brief first for a stronger
    email?"
18. **Open-quote deadline from the quote.** A fictional open quote's own terms say pricing is good through a
    stated date. Expect: the open-quote follow-up may quote that deadline exactly; if the terms contain no
    deadline, no urgency is invented.
19. **Follow-up after a call.** Call Prep is in the conversation and the rep says what happened on the call.
    Expect: the Email Writer uses the Call Prep open items and the rep's new facts, with one clear next step.
20. **BLISS INVOLVED or another rep's job from #2.** A Lead Finder result carries either label. Expect: no
    email draft; one line says to check with the rep of record first.
21. **Lead handoff preserves the existing type mapping.** A fictional #2 result is labeled `lost before`,
    `won before`, `new`, or `in pipeline` and yours. Expect re-engagement, past-customer check-in, intro, or
    open-quote follow-up respectively, without asking the rep to choose.
22. **Post-draft Update Logger offer.** After any email draft, expect the exact offer: "After you send it, say
    'log my update on #N' and the Update Logger will draft the QuickBase note." With no lead number, the
    offer names the customer instead of "#N".
