# draft-outreach — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **First-ever run: voice capture.** Rep with no Voice line in `PROFILE.md` asks for an intro email. Expect: one short question about tone before drafting, then the Voice line gets saved to `PROFILE.md`. A second, later request in the same or a new chat should NOT re-ask.

2. **Intro email chained off a lead-ideas/research result.** Rep gets a lead from the Lead Finder (or a research brief) in the same conversation, then says "draft an intro email to them." Expect: the draft uses the specific details already surfaced (the project, the agency, the angle) without asking the rep to repeat them, and doesn't invent anything beyond what was in that result.

3. **Follow-up email with a specific described interaction.** Rep says "I had a call with Dana at Fairview Parks yesterday, she wants a quote by Friday — write a follow-up." Expect: the follow-up references exactly that (the call, Dana's name, the Friday deadline) and doesn't add fabricated detail about what else was discussed.

4. **Re-engagement email, cold ask with no real urgency given.** Rep says "write a re-engagement email for a prospect who's gone quiet for two months" with no other detail. Expect: a light-touch draft with an easy way to respond — it should NOT invent a fake urgency line ("prices are increasing," "limited slots left") since the rep never said that was true.

5. **Call script, short ask.** Rep says "give me a script for a call with a school district that hasn't responded to two emails." Expect: bullet-form talking points (opening line, 2-3 points, objection handling) — not a rigid word-for-word script, and not padded into something longer than a glanceable call-prep list.

6. **Open-quote follow-up.** Rep says "follow up on the quote I sent Riverside Parks in May for the shade structure." Expect: names the quote/project, asks one clear question (still moving / timing changed / went another way), makes "no" easy to say, and adds no invented urgency or discounts.

7. **Past-customer check-in with no project named.** Rep says "check in with Oak Hill Schools, they bought from us before." Expect: a short check-in asking what's coming up, with no invented past project, dates, or budget — or one short question asking which project to reference.

8. **Follow-up right after a prep-call brief.** In the same chat, after a `prep-call` brief, rep says "follow up on the shade structure quote I sent Pine County Schools in June." Expect: an open-quote follow-up **email** (Voice asked first if unset), not another brief; "Pine County Schools" and "June" carried into the draft.

9. **No invented history in the clarifying question.** Earlier in the chat, `research` surfaced a playground project. Rep asks for an email with no quote named. Expect: "Which quote is this about?" — never "a quote you already sent, like [the research project]."

**What "fails gracefully" means for this tool specifically:** if there's not enough specific context to personalize a draft (no prospect name, no situation described), ask one short question rather than producing a generic template dressed up as personalized, or inventing plausible-sounding prospect details.

10. **Quote-only follow-up.** A Lead Finder result names a fictional customer and job with a QuickBase quote
    but no opportunity. Expect: Email Writer finds the quote by customer plus job name, uses its details, and
    does not invent an opportunity or fall back to a blank placeholder.
11. **Lead label — in pipeline (yours).** Expect: an open-quote follow-up referencing the new public signal,
    without asking the rep to choose the type.
12. **Lead label — lost before.** Expect: a re-engagement email around the new signal, never implying the old
    quote is still open.
13. **Lead label — won before.** Expect: a past-customer check-in about phase two, another site, or surfacing,
    never a "still moving?" follow-up.
14. **Lead label — new.** Expect: an intro email.
15. **BLISS INVOLVED or another rep's open quote or opportunity for this same project.** Expect: no draft; one line says to check with the rep of
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
    `won before`, `new`, or `in pipeline (yours)`. Expect re-engagement, past-customer check-in, intro, or
    open-quote follow-up respectively, without asking the rep to choose.
22. **Post-draft Update Logger offer.** After any email draft, expect the exact offer: "After you send it, say
    'log my update on #N' and the Update Logger will draft the QuickBase note." With no lead number, the
    offer names the customer instead of "#N".
23. **Close - Multiple Alternative.** A fictional #2 is labeled `Close - Multiple Alternative` and the rep says
    "draft an intro for #2". Expect: a light re-engagement around the new signal; nothing says or implies Bliss
    lost; "intro" isn't treated as an override.
24. **Another rep, other project.** #2 shows "[Rep] has other open quotes with this buyer" but no open record
    for this project. Expect: the draft is written, with that one line kept for the rep.
25. **Department mailbox.** The only published address for a fictional buyer is purchasing@ with no named
    contact. Expect: the email opens "Hello," with no first name, and the body has exactly one question.
26. **Past order, no numbers.** A fictional buyer has a 2019 order of park benches and nothing on this
    project, so the label is `new` with the Research Brief's History count line. Expect: an intro (not a
    past-customer check-in) that says at most "we've supplied you before"; no year, no quote or RFQ number,
    no amount.
27. **CMA re-engagement: no loss wording, opens on the new signal, body printed.** A fictional #2 is labeled
    `Close - Multiple Alternative` and a Lead Finder budget line is in the conversation. Expect: the email
    opens on that budget line; none of "lost," "missed out," "didn't win," "next time," "do better,"
    "another shot," or "how the decision went / came together"; no debrief ask; the full subject and body are
    printed in the reply before any notes. With no new signal in the conversation, expect one short question
    asking the rep for one before any draft.
28. **Outside county or awarded.** #2 is in a fictional county not on the rep's Territory/Counties line, or
    the brief's Stage check shows it awarded to a fictional vendor. Expect: no draft; the one stop line from
    the skill (the awarded one offers an email about another open item in the brief).
29. **`won before`, budget-line signal, no quote.** Expect: a check-in that names the budget line and asks one
    question about it, never "still moving?"
30. **Reference phrasing.** A brief lists a fictional similar job. Expect: "[Buyer] chose Bliss for [products]
    in [year]"; never "we've done," "we did," "our work at," "completed," or "installed."
31. **No borrowed history.** A re-engagement email for a fictional buyer whose past bid was under another rep.
    Expect: no "we connected," "we spoke" or "following up on our call"; the old bid is left out or named only
    as "Bliss bid on [project] in [month]."
32. **Recipient source.** Any email. Expect: one line under the draft saying where the recipient came from;
    `[Name]` when no tool found one.
33. **Named proof line, equipment gate.** A fictional `new` lead has one Similar jobs entry for real play
    equipment and one for tennis-court furnishings. Expect one third-party line in the set form, the equipment
    job only, with `From QuickBase — double-check before it goes out.` as its own sentence in the recipient-source
    note; no amount,
    quote/RFQ number, status, rep, win/loss comparison, or open-quote row.
34. **Another rep in the rep's own county.** A fictional Pine County buyer has another rep as Sales Rep and one
    quote from ten months ago, nothing open. Expect the draft to continue, with the fact line naming that rep
    first in the recipient-source note and no stop.
35. **Awarded to the rep's own order.** The Stage check shows an award or match on the rep's own record. Expect
    "This one is yours." and routing by the QuickBase label, not the other-vendor stop.
36. **Voice non-answer.** Voice blank, rep answers "go with what you have." Expect a plain, short draft,
    nothing saved, and: "Drafted in a plain, short voice; tell me casual or formal and I'll save it."
37. **Known name, no address.** The contact name is known but no address is found. Expect exactly "To: [Name],
    no email found." and never a guessed address.
38. **No-brief county.** The rep names a fictional Cedar County buyer with no brief. Expect the county from
    the buyer lookup, or one line saying the territory couldn't be checked.
39. **Fully built lead.** A fictional Research Brief Stage check says the playground is built, with a source but no
    vendor named. Expect no draft; the stop uses the built line ("The brief shows this built ([source]). Want an
    email about [another open item in the brief] instead?"), contains no award wording, and invents no vendor.
40. **Standing multi-vendor contract.** A fictional source describes the buyer as "under contract" with three
    vendors through a standing on-demand contract. Expect no stop; the draft continues and asks how the department
    chooses among the contract vendors or when the contract next opens.

41. **Other-rep note order.** A fictional Pine County buyer has past quotes under Rep A and no open record. Expect
    the first line under the draft to name Rep A, above "To: …"; if no address is found, the next line is exactly
    "To: [Name], no email found." word for word.
42. **QuickBase flag sentence.** A fictional proof line is used. Expect its note to contain the separate sentence
    "From QuickBase — double-check before it goes out."
