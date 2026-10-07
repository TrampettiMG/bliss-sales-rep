# find-leads — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Cases are written as the
plain ask a rep would type, with what a correct run looks like. Run each one from that single ask: no
follow-up setup questions beyond the first-run `PROFILE.md` fill.

## Repeatability and the lead board

1. **First-ever run.** Rep with no `lead-board.xlsx` yet asks "find leads for my county." Expect: a normal
   scan, everything found reported as new, and the board created afterward with those rows — agency, county,
   project, stage, score, source link, doc date, last checked — and the file read back before it says
   anything is saved.
2. **Second run, nothing new happened.** Immediately re-run the same request. Expect: it reconciles against
   the board by the underlying lead and reports "Nothing new since your last run on [date]" — it does NOT
   re-report the same signals as fresh, and the rows carry over with last checked moved to today.
3. **Second run, one genuinely new item.** Case 2 with one new dated item available. Expect: only that item
   comes back as new, and it is the only row added.
4. **Republished coverage of an already-seen event.** The same underlying event covered later by a different
   outlet (new URL). Expect: reconciled to the same row — not reported as new, not duplicated.
5. **A project that moved stage.** A tracked project now shows money budgeted, or an RFP posted. Expect: it
   appears under "Moved up since your last scan" **before** any newly found lead, with old stage → new stage,
   date and source, and its board row updates in place rather than a second row being added.
6. **Spreadsheet write failure.** Simulate a save that doesn't land. Expect: it says the save didn't fully
   work, never a false "saved" line; the count in the saved line matches the rows actually read back from the
   file.
7. **Co-existence with `my-new-leads`.** A rep whose `my-new-leads` run already created `lead-board.xlsx`
   from the QuickBase read. Expect: this skill reads and updates that **same** board in place — the
   QuickBase-origin `QB Status` and `Status` values (and any `Contact` / `Next Action`) are left exactly as
   they were; only stage, score, source link, doc date, and last checked change on a matching row.
8. **Legacy log migration.** A rep with an old `find-leads-log.md` and no board (or a board that doesn't hold
   those leads). Expect: the log's leads are seeded onto the board as `watching` — never reported as newly
   found — and the `find-leads-log.md` is left untouched: not appended to, not rewritten, not deleted.
9. **No second board.** A board already sitting in a `claude/` subfolder. Expect: it finds and updates that
   board where it is; no second board file, no new log file.

## Reading order and the registry connector

10. **Normal connector run.** Rep asks "what's new in my territory" with the registry connector
    connected. Expect: `lead_scan` runs first; then `my_sources` → `read_source` on agendas, then the CIP,
    then the budget — in that order. Leads come only from those connector results; web search is not used
    unless a top lead is missing an enrichment detail.
11. **One county has no library sources.** `my_sources` has no row for one county in the territory. Expect:
    no web lead search for that county; it appears in the gaps list as "no library sources for [county] yet —
    tell your trainer," while the other counties are read from the registry.
12. **Focus Counties respected.** Profile lists focus counties in a rep whose territory is wider. Expect:
    only the focus counties are scanned, no metro/region widening, and the coverage line names each one,
    including "nothing new" for the empty ones.
13. **Manual-source county.** A county where every row reads "open it yourself." Expect: no fetch
    attempts and a closing "Couldn't read these, open them yourself" line per source with its link —
    a robots refusal is accepted, not routed around.

## Grading — REAL vs ROUTINE

14. **Agenda full of noise.** A `lead_scan` result whose hits are mostly minutes approvals, a road
    resurfacing award, and an HR item, with one real playground procurement. Expect: only the playground
    hit appears as a lead (staged, scored, cross-referenced), and the output ends with one count-only
    line like "Set aside 9 routine items" — no list of them.
15. **Judicial "courts" vs basketball courts.** Hits containing "courts" from a municipal court annex and
    from a parks courts resurfacing. Expect: the annex is ROUTINE (set aside), the courts resurfacing is
    REAL.
16. **Ambiguous phrased word.** An agenda with "motion to table" and "picnic table." Expect: only the
    picnic table hit survives grading.
17. **Zero routine.** A scan whose hits are all real projects. Expect: the closing line reads "Set aside
    0 routine items," not an omitted line.

## Fallbacks — PDFs, download cap, couldn't-read list

18. **Connector returns the scanned-PDF string.** `read_source` returns `scanned PDF: download it and
    read the page images`. Expect: it downloads the PDF and extracts text first; if the text comes back
    empty, it reads the page images; only then does it go on the closing list.
19. **Connector returns the large-PDF string.** Same ladder for `large PDF: open it yourself`. Expect: the
    text extraction is attempted first (many of these have a text layer), then page images, and the
    closing list only after both fail.
20. **Connector returns the unreadable-PDF string.** `read_source` returns `PDF couldn't be read here:
    download it and extract the text`. Expect: the same download → text extraction → page-image ladder as
    the scanned-PDF string; it counts against the same 3-download cap and reaches the closing list only
    after both attempts fail.
21. **Download cap.** A territory with six such PDFs. Expect: at most 3 downloads attempted, the rest go
    straight to "Couldn't read these, open them yourself," and the output says the cap was hit.
22. **Genuinely unreadable source.** A source that refuses at run time. Expect: it's on the closing list
    with its link and the reason, it isn't added to the lead board, and the next run tries it again.
23. **Connector returns "no readable text" on a PDF link.** `read_source` returns the empty-body
    no-readable-text reason (or `lead_scan`'s footer reads `Couldn't read: <url> - no readable text; open
    it yourself`) for a link that is a PDF. Expect: the same download → text extraction → page-image
    ladder as the other PDF strings, counted against the same 3-download cap.
24. **Connector returns "no readable text" on a non-PDF page.** Same reason, but the link is an HTML page
    with no extractable text. Expect: no download attempt — it goes straight to the closing "Couldn't read
    these, open them yourself" list.
25. **Connector refuses for robots.txt.** `read_source` returns `robots.txt for <site> disallows this path; open
    it yourself`. Expect: no download attempt; the link goes straight to the closing list for the rep to open
    in their browser.
26. **Robots check before a fallback download.** A scanned-PDF link whose site's robots.txt disallows the
    path for `User-agent: *`. Expect: Claude checks robots.txt first, doesn't download, and lists the link
    on the closing list instead.

## Stages and scoring

27. **Stage-7 exclusion.** A result where a lead is already awarded/under construction. Expect: it never
    appears in the output at all (zero stage-7 leads).
28. **Every lead carries stage, date, source.** A normal run. Expect: each lead shows its stage number,
    its document date, and a source link.
29. **Currency.** A stale project page or a budget from a previous fiscal year. Expect: dropped, unless a
    newer source shows the project still moving.
30. **Score and reason.** A run with several real leads. Expect: each has a 0–100 score with a one-line
    reason, highest first, and the list opens with "Found N, call these X now."
31. **Unknown factors aren't assumed.** A playground renovation with no funding or size stated. Expect:
    scored on what's shown, with "funding not stated" — never assumed committed.
32. **Interim weights flagged.** Rep asks "where do these weights come from?" Expect: it says the rubric
    is interim, pending the bid team's guide.

## QuickBase cross-reference

33. **Recipes, no discovery.** First run with QuickBase connected. Expect: the cross-reference uses the setup
    skill's recipes directly: no table listing, no field dump, no "QuickBase tables" lookup step, and no ID
    printed into any repo/skill file or shown to the rep.
34. **Bounded queries.** Any run. Expect: every QuickBase call has `select`, `where` and `max_records`.
35. **Lead already in the pipeline.** A lead whose jurisdiction has an open opportunity. Expect: labeled
    "in pipeline" with the record number, never shown as new.
36. **Lead found through the design firm.** A document naming the design firm/engineer but not matching
    on jurisdiction. Expect: the cross-reference searches both the jurisdiction and the firm name.
37. **BLISS INVOLVED.** A public document naming "Play and Park Structures" (as distributed by Bliss
    Products). Expect: the lead is labeled BLISS INVOLVED ahead of the cross-reference label, with one
    line telling the rep to check with the rep of record rather than pitch it.
38. **QB extension unplugged.** Same ask with QuickBase not connected. Expect: one clear "QuickBase isn't
    connected" line, no labels guessed, and the scan still delivers graded, staged, scored leads.

## Degradation, budget, and output

39. **Connector unplugged.** Ask with no registry connector. Expect: one sentence saying Lead Finder needs
    the Bliss Library connection and the trainer sets it up, then it stops — no web search and no board write.
40. **Enrichment budget respected.** A connector run with missing details on several top leads. Expect: web
    search only for those existing leads, about 1–2 searches per lead and roughly 6 total; if the budget runs
    out it names the lead details not checked, never a county or a new web lead.
41. **Same-day re-run.** Two runs in one day. Expect: the second notices the board's last-checked dates are
    today and asks whether the rep still wants to spend a fresh scan.
42. **Broad-word trap.** Product focus is site furnishings. Expect: queries pair broad terms ("site
    furnishings," "picnic tables," "trash receptacles") instead of bare "site"/"table," and parking-lot or
    court-building results are excluded.
43. **Co-op purchase on a council agenda.** A board agenda approving a playground purchase "through
    Sourcewell" (no open bid). Expect: reported as a real signal, and it scores on the cooperative-contract
    factor.
44. **Open RFP found.** Expect: the item includes the bid due date, or "due date not visible — verify on
    the page."
45. **Vague or missing territory.** Territory listed as a whole state. Expect: it asks for the specific
    county/counties rather than returning a flood of unfocused results.
46. **Coverage line.** Any multi-county run. Expect: one coverage line naming every county scanned and
    whether each had anything new.
47. **Output order.** Any run that produces results. Expect, in order: moved-up leads (if any), the ranked
    leads with the "Found N, call these X now" opener, the coverage line, the couldn't-read list, the
    verified "Saved your lead board — N leads, M rows changed" line, the count-only routine line ("Set aside N
    routine items"), and, when shown, the closing offer of the Research Brief / Email Writer as the final line.
48. **First-ask test.** A rep's first plain ask — "find leads in my counties" — with no further setup. Expect:
    the full run completes from that one ask, the only question being the first-run profile fill.

49. **Demo territory.** Ask for leads in Nassau County, Florida. Expect: the run reproduces the
    Nassau County and Fernandina Beach leads from the PRD demo, each with a dated source link, a
    stage, and a score.
50. **Territory not loaded yet.** A rep whose territory Trampetti hasn't finished loading asks, plainly,
    "find leads for my county." The connector returns the literal `TERRITORY_PENDING` message ("Your
    territory isn't set up yet. Trampetti is loading it; your sources will appear here."). Expect: it stops
    the run — one plain line saying the territory is still loading and to try again later today or
    tomorrow — with **no** web search, **no** empty or thin lead list, and nothing written to the board.

51. **Literal `read_source` queries.** A readable CIP returns no useful matches for `playground OR shade`
    but returns hits for `playground`. Expect: one literal phrase per call, no OR query, duplicate/boilerplate
    hits skipped, and the total `read_source` calls capped at about 12.
52. **Blocked agenda scan.** A fictional county's `lead_scan` returns 0 leads and most agendas are blocked;
    it also includes an irrelevant advisory board. Expect: "agendas were not checked," not "nothing new";
    no next cursor means complete, and only governing/parks-board failures appear in the closing list.
53. **QuickBase jurisdiction matching.** A fictional city is stored under an all-caps city name and also has
    its own parks-department customer record. A school, contractor, and same-city architect also match the
    text. Expect: the city or its own department counts; the others are only brief related notes, and a shared
    billing city alone does not count. A same park name in another state and any TEST record are ignored.
54. **Status before label.** A fictional open opportunity has one matching quote marked Invoiced. Expect:
    `won before`, not `in pipeline`. A closed quote with status `Close - Multiple Alternative` gets that label
    on its own, never `lost before` (both statuses → `lost before` plus the other); if it says an alternative
    was chosen, nearby quotes are checked for a won one.
55. **Freshness follows QuickBase.** A stale fictional lead has an open same-job quote from within the last
    year. Expect: it survives as `in pipeline`; stale leads with only `lost before` or `won before` matches are
    dropped.
56. **Far-future money.** A fictional FY2027 plan has design money first in FY2031. Expect: the score reason
    notes funding planned three or more fiscal years out and scores the funding factor lower without changing
    the stage ladder.
57. **Stale library edition.** A library link for a fictional county has a fiscal year two or more years old.
    Expect: it is not a lead and the output includes "The library's link for [entity] [doc type] looks out of
    date. Tell your trainer."
58. **Label handoff.** A selected lead is passed to Email Writer. Expect: the handoff includes its label and
    record number along with what, when, stage, and source; `BLISS INVOLVED` or another rep's open quote or opportunity for this same project is not
    drafted cold.
59. **Web search never creates a lead.** A web result finds a fictional county playground project that does
    not appear in `lead_scan` or a library document. Expect: it is not reported, staged, scored, or written to
    the board.
60. **Enrichment fills a missing due date.** A connector lead for fictional Pine Ridge has no bid due date;
    one web search finds the bid page. Expect: the lead remains sourced to the library, the due date is added,
    and the web page is cited separately as enrichment.
61. **Web contradicts the library.** A library CIP gives fictional Oakview's project date as FY2028, while a
    newer web page says FY2029. Expect: both facts and both sources are shown with the disagreement stated; the
    library fact is not silently replaced.
62. **No library source means a gap.** A fictional county has no `my_sources` rows. Expect: no lead is made
    from web results; the closing list says "no library sources for [county] yet — tell your trainer."
63. **Single-term connector queries.** A fictional CIP has useful hits for `playground` but none for
    `playground OR shade structure`. Expect: one literal phrase per `read_source` call, no OR query, and the
    best 2–3 terms chosen within the roughly 12-call connector cap.
64. **Connector error retry.** A county filter fails once and succeeds on retry. Expect: the connector is
    retried once; if it fails again, one compact connector-error line appears in the closing gaps list and no
    web lead search is started.
65. **Morning digest, weekday.** The Daily run's step 1 runs on a Wednesday; the board's latest Last
    Checked date is Tuesday. Expect: no county question; `lead_scan` since Tuesday; no CIP/budget reads; no
    web searches; opens "Good morning, [First name]"; at most 5 lead lines; the couldn't-read list as one count
    line; saved-board and Set-aside lines.
66. **Morning digest, Monday.** Same, on a Monday. Expect: `lead_scan` since the previous Friday's run, plus
    the weekly library-document read at the normal cap.
67. **Morning digest, nothing new.** Expect: one line, "Nothing new in your counties since [date]." No
    padding, no old leads re-shown.
68. **Morning digest, second run the same day.** Expect: "Already checked this morning. Nothing new since
    then." and no scan, no board write.
69. **History line on the top five.** A normal run produces at least five ranked fictional leads with QuickBase
    connected. Expect: each top-five lead has one History line immediately after its QuickBase label, with buyer
    quote history and the most recent nearby won job; no web searches are used for the line.
70. **History none on file.** A top fictional lead has no matching buyer quotes. Expect exactly "History: none
    on file." and no invented nearby buyer if the bounded nearby lookup also finds nothing.
71. **Nearby history falls back to state.** A top fictional lead has no other-customer won job in its county but
    does have one in the same state. Expect the one-line History entry says "in [state]" and names the other
    customer and rep as QuickBase stores them; it never uses the lead's own buyer.
72. **Morning digest includes history.** A weekday morning run produces top-five fictional leads. Expect each
    lead's detail line carries one history clause after the QuickBase label, and the closing offer mentions
    "research #2" as an example of the full Research Brief handoff.
73. **Digest lead shape.** A Daily run's step 1 shows three fictional leads; the lead board is saved as a CSV
    (text-only project). Expect: each lead is exactly two lines — "#N · County · Buyer: Project", then "Stage ·
    Score — one-clause reason · label · one history clause · source link" — with no separate History bullet
    repeating the buyer's count. No score reason says "interim" (the rep didn't ask). The saved-board line is
    "Saved your lead board — N leads, M rows changed." with no mention of CSV, Excel or text files. No
    "Sources:" list, no note to a trainer or admin, no narration of the run.
74. **Score reason says only what the source shows.** A fictional park playground is on next week's council
    agenda; the buyer has two past Bliss orders under another rep. Expect: the reason says "on the [date]
    agenda," never "approved" or "money committed," and the relationship part says "2 past orders," never the
    other rep's name.
75. **History count matches the Research Brief.** A fictional buyer has 5 quotes under the rep and 1 under a
    test rep account. Expect: the History clause says 6 quotes, the test-account one counted once and shown as
    "test account," never attributed to the rep; a later "research #1" shows the same 6. A fictional customer
    named "TEST Parks" isn't counted at all.
76. **Label scope — old parts order.** A fictional buyer's only order is a small replacement-parts order from
    years ago, with nothing on this lead's project. Expect: label `new` plus "Past orders with this buyer: 1,
    last [year], parts" (or the count in the History clause on a top-five lead, never both); never `won before`.
77. **BLISS INVOLVED, rep's own record.** A fictional bid tab names Bliss on this project, and QuickBase
    resolves it to a won quote whose rep is the rep running the scan, with no other rep open on it. Expect:
    "This one is yours.", the QuickBase label shown instead of the check-with-the-rep stop, and the lead
    stays in the call-now names. A document naming Bliss on a different procurement doesn't trigger
    BLISS INVOLVED at all.
78. **Carried-over amount.** The book shows a prior-year balance beside new money. Expect the digest to carry both.

**What "fails gracefully" means for this tool specifically:** every reported lead has a real source link
and a real date, a stage number, and — when QuickBase is connected — a cross-reference label. If a scan
can't confirm a link or a date, the item doesn't get reported; silence is better than a plausible-sounding
but unverifiable "lead." A source that won't open is never faked into a lead; it goes on the "open it
yourself" list where the rep can deal with it.

## Board columns (Daily run)

- **An older board without the six newer columns.** Expect: they're added blank at the end on save; every
  existing value kept; no reordering.
- **A stage-6 bid lead with a stated due date.** Expect: `Bid Due` holds the date exactly as written.
