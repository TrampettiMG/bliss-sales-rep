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

7. **Normal connector run.** Rep asks "what's new in my territory" with the registry connector
   connected. Expect: `lead_scan` runs first; then `my_sources` → `read_source` on agendas, then the CIP,
   then the budget — in that order; and **no** web search, because every county has a readable source
   (it should say why the search pass was skipped).
8. **One county the registry can't cover.** `my_sources` has no readable row for one county in the
   territory. Expect: a search pass for **that county only**, and the other counties read from the
   registry.
9. **Focus Counties respected.** Profile lists focus counties in a rep whose territory is wider. Expect:
   only the focus counties are scanned, no metro/region widening, and the coverage line names each one,
   including "nothing new" for the empty ones.
10. **Manual-source county.** A county where every row reads "open it yourself." Expect: no fetch
    attempts and a closing "Couldn't read these, open them yourself" line per source with its link —
    a robots refusal is accepted, not routed around.

## Grading — REAL vs ROUTINE

11. **Agenda full of noise.** A `lead_scan` result whose hits are mostly minutes approvals, a road
    resurfacing award, and an HR item, with one real playground procurement. Expect: only the playground
    hit appears as a lead (staged, scored, cross-referenced), and the output ends with one count-only
    line like "Set aside 9 routine items" — no list of them.
12. **Judicial "courts" vs basketball courts.** Hits containing "courts" from a municipal court annex and
    from a parks courts resurfacing. Expect: the annex is ROUTINE (set aside), the courts resurfacing is
    REAL.
13. **Ambiguous phrased word.** An agenda with "motion to table" and "picnic table." Expect: only the
    picnic table hit survives grading.
14. **Zero routine.** A scan whose hits are all real projects. Expect: the closing line reads "Set aside
    0 routine items," not an omitted line.

## Fallbacks — PDFs, download cap, couldn't-read list

15. **Connector returns the scanned-PDF string.** `read_source` returns `scanned PDF: download it and
    read the page images`. Expect: it downloads the PDF and extracts text first; if the text comes back
    empty, it reads the page images; only then does it go on the closing list.
16. **Connector returns the large-PDF string.** Same ladder for `large PDF: open it yourself`. Expect: the
    text extraction is attempted first (many of these have a text layer), then page images, and the
    closing list only after both fail.
17. **Download cap.** A territory with six such PDFs. Expect: at most 3 downloads attempted, the rest go
    straight to "Couldn't read these, open them yourself," and the output says the cap was hit.
18. **Genuinely unreadable source.** A source that refuses at run time. Expect: it's on the closing list
    with its link and the reason, it isn't in the log, and the next run tries it again.

## Stages and scoring

19. **Stage-7 exclusion.** A result where a lead is already awarded/under construction. Expect: it never
    appears in the output at all (zero stage-7 leads).
20. **Every lead carries stage, date, source.** A normal run. Expect: each lead shows its stage number,
    its document date, and a source link.
21. **Currency.** A stale project page or a budget from a previous fiscal year. Expect: dropped, unless a
    newer source shows the project still moving.
22. **Score and reason.** A run with several real leads. Expect: each has a 0–100 score with a one-line
    reason, highest first, and the list opens with "Found N, call these X now."
23. **Unknown factors aren't assumed.** A playground renovation with no funding or size stated. Expect:
    scored on what's shown, with "funding not stated" — never assumed committed.
24. **Interim weights flagged.** Rep asks "where do these weights come from?" Expect: it says the rubric
    is interim, pending the bid team's guide.

## QuickBase cross-reference

25. **First use resolves and caches.** First run with the QuickBase extension connected. Expect: table
    names resolved to IDs and written into `PROFILE.md` under a "QuickBase tables" section, with targeted
    field-label lookups (one per table, no full field dump) — and no ID printed into any repo/skill file.
26. **Second run reads the cache.** The next run. Expect: IDs read from `PROFILE.md`, no re-resolution.
27. **Lead already in the pipeline.** A lead whose jurisdiction has an open opportunity. Expect: labeled
    "in pipeline" with the record number, never shown as new.
28. **Lead found through the design firm.** A document naming the design firm/engineer but not matching
    on jurisdiction. Expect: the cross-reference searches both the jurisdiction and the firm name.
29. **BLISS INVOLVED.** A public document naming "Play and Park Structures" (as distributed by Bliss
    Products). Expect: the lead is labeled BLISS INVOLVED ahead of the cross-reference label, with one
    line telling the rep to check with the rep of record rather than pitch it.
30. **QB extension unplugged.** Same ask with QuickBase not connected. Expect: one clear "QuickBase isn't
    connected" line, no labels guessed, and the scan still delivers graded, staged, scored leads.

## Degradation, budget, and output

31. **Connector unplugged.** Ask with no registry connector. Expect: it skips the connector steps, runs
    the search pass for all counties, and says **once** that the registry connector would read the rep's
    sources directly.
32. **Usage budget respected.** A connector-missing run. Expect: roughly 2 searches per category (~10
    total), and if the budget runs out it names the counties/categories not reached.
33. **Same-day re-run.** Two runs in one day. Expect: the second notices the board's last-checked dates are
    today and asks whether the rep still wants to spend a fresh scan.
34. **Broad-word trap.** Product focus is site furnishings. Expect: queries pair broad terms ("site
    furnishings," "picnic tables," "trash receptacles") instead of bare "site"/"table," and parking-lot or
    court-building results are excluded.
35. **Co-op purchase on a council agenda.** A board agenda approving a playground purchase "through
    Sourcewell" (no open bid). Expect: reported as a real signal, and it scores on the cooperative-contract
    factor.
36. **Open RFP found.** Expect: the item includes the bid due date, or "due date not visible — verify on
    the page."
37. **Vague or missing territory.** Territory listed as a whole state. Expect: it asks for the specific
    county/counties rather than returning a flood of unfocused results.
38. **Coverage line.** Any multi-county run. Expect: one coverage line naming every county scanned and
    whether each had anything new.
39. **Output order.** Any run that produces results. Expect, in order: moved-up leads (if any), the ranked
    leads with the "Found N, call these X now" opener, the coverage line, the couldn't-read list, the
    verified "Saved N new items" line, the closing offer of the Research Brief / Email Writer, and — as
    the last line of the output — the one count-only routine line ("Set aside N routine items"), with
    nothing after it.
40. **Ron test.** A rep's first plain ask — "find leads in my counties" — with no further setup. Expect:
    the full run completes from that one ask, the only question being the first-run profile fill.

41. **Demo territory.** Ask for leads in Nassau County, Florida. Expect: the run reproduces the
    Nassau County and Fernandina Beach leads from the PRD demo, each with a dated source link, a
    stage, and a score.
42. **Territory not loaded yet.** A rep whose territory Trampetti hasn't finished loading asks, plainly,
    "find leads for my county." The connector returns the literal `TERRITORY_PENDING` message ("Your
    territory isn't set up yet. Trampetti is loading it; your sources will appear here."). Expect: it stops
    the run — one plain line saying the territory is still loading and to try again later today or
    tomorrow — with **no** web-search pass, **no** empty or thin lead list, and nothing written to the board.

**What "fails gracefully" means for this tool specifically:** every reported lead has a real source link
and a real date, a stage number, and — when QuickBase is connected — a cross-reference label. If a scan
can't confirm a link or a date, the item doesn't get reported; silence is better than a plausible-sounding
but unverifiable "lead." A source that won't open is never faked into a lead; it goes on the "open it
yourself" list where the rep can deal with it.
