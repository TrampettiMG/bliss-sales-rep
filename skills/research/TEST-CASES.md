# research — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Cases are written as the
plain ask a rep would type, with what a correct run looks like. Run each one from that single ask: no
follow-up setup questions beyond the first-run `PROFILE.md` fill.

## Target identification and honesty

1. **Municipality target, chained off a find-leads result.** Rep runs `find-leads`, gets a signal about a
   specific city, then says "research that city." Expect: it reuses the city name/context already surfaced
   instead of re-asking, and digs deeper on that one place rather than re-scanning the whole territory.
2. **Named company, cold ask.** Rep says "research [a real company name] for me" with no other context.
   Expect: correct identification of the right entity, findings relevant to the rep's product focus, honest
   handling if the company has little public presence.
3. **Named person, ambiguous name.** Rep asks to research a common first+last name with no organization
   given. Expect: it asks for a disambiguating detail (their organization, county) rather than guessing and
   potentially producing a brief on the wrong person.
4. **Thin public presence.** Rep asks to research a small/obscure target with little to no public
   information. Expect: an honest, short brief that says findings were limited — not a padded-out one that
   reads as if real research happened.
5. **Agency with a master plan and a grant.** Research a city whose parks master plan names a playground
   renovation and which recently won a recreation grant. Expect: both appear in "Why call now," dated and
   cited, with the grant's match or deadline if public — no invented amounts or timelines.
6. **Ambiguous name settled by territory.** A rep covering Richmond city, VA asks "research Richmond parks."
   Expect: goes with the City of Richmond, says so in one line, and offers the alternative (Richmond County)
   — no other-state Richmond mixed in, no extra round-trip question.

## Usage budget

7. **Usage budget respected.** Count web searches on a normal run (page fetches are counted separately).
   Expect: roughly 6–8 web searches, not an open-ended chase — and if the budget runs out, one "Not checked:"
   line after the opener says what wasn't.
8. **QuickBase read doesn't spend the search budget.** A municipality run with the cross-reference. Expect:
   the QuickBase read is not counted against the 6-8 web searches, and the brief stays honest about which
   searches were actually spent.

## QuickBase cross-reference (F5)

9. **Jurisdiction first, then the design firm.** Rep researches a city where the jurisdiction alone doesn't
   match QuickBase, but the design firm named in the public document does. Expect: it searches the
   jurisdiction name first, then the design-firm/engineer name, and reports the hit found through the firm.
10. **Recipes, no discovery.** First run with the QuickBase extension connected. Expect: queries come from
    the QuickBase setup skill's recipes — no table listing, no field dump, no ID lookup step — and no ID
    printed into any repo/skill file.
11. **QuickBase budget.** Any full brief. Expect: about 16 bounded QuickBase queries in all; run the QuickBase
    queries directly, with Similar jobs step a in a subagent when one is available.
12. **Table names only in the skill.** Any run. Expect: the brief and its sources refer to tables by name
    ("Opportunities," "Quote Pipeline"), never by a table ID — no QuickBase ID appears in the output.
13. **Every call bounded.** Any cross-reference. Expect: every QuickBase call carries `select`, `where`, and
    `max_records` — no whole-table scan.
14. **Sales Rep link, not Record Owner.** A target with several opportunities. Expect: reps are grouped by
    the **Sales Rep** link; "Record Owner" is never used.
15. **UTC shown as Eastern.** A record whose timestamp is UTC. Expect: the time shown in the brief is
    converted to Eastern Time, not left in UTC.
16. **Confidence constrained to five values.** A record with a confidence figure. Expect: it appears only as
    one of 0%, 25%, 50%, 75%, 99% — never rounded to something else, never invented when absent.
17. **Target already in the pipeline.** A municipality with an open opportunity or quote. Expect: labeled
    `in pipeline (yours)` or `in pipeline ([rep])` with the record number, never presented as new.
18. **Lost-before / won-before labels.** A city Bliss quoted and lost, and one it won, from public history.
    Expect: `lost before` and `won before` respectively, each with the record number.
19. **BLISS INVOLVED.** A public document naming "Play and Park Structures" as distributed by Bliss
    Products. Expect: the target is labeled BLISS INVOLVED **ahead of** the cross-reference label, with one
    line telling the rep to check with the rep of record rather than pitch it.
20. **QB extension unplugged.** Same ask with QuickBase not connected. Expect: one clear "QuickBase isn't
    connected" line, no label guessed, and the brief still delivered from public sources.

## Contact finder (F6)

21. **The core roles.** A municipality lead. Expect: the parks director and purchasing agent (and city
    manager where that's the decision-maker) are returned, each tied to the lead, each with the public page
    it came from.
22. **School-district lead.** A lead on a school district. Expect: the school facilities director is the
    contact found, sourced from the district's own facilities page or an agenda/staff report.
23. **Landscape architect only from a minute or contract approval.** A lead whose architect appears on the
    firm's team page and in a council minute approving the design contract. Expect: the architect is
    returned **only** because the council minute / contract approval names them — not because a directory
    or team page lists them.
24. **Architect not inferable.** A lead with a design firm named but no minute or contract approval naming
    an individual. Expect: no architect is returned (and the brief says the role couldn't be sourced),
    rather than naming someone from the firm's roster.
25. **Source each contact.** Any contact returned. Expect: every one carries its source page — a government
    staff directory, agenda/staff report, firm site, or another opened public page that names the person.
26. **No personal data.** A staff directory that also shows a personal cell for a parks director. Expect: it
    is left out — only role-tied public contact info is used; no home address, personal phone, or personal
    email appears.
27. **No guessed email.** A municipality that publishes no email for the purchasing agent. Expect: no email
    is shown and none is constructed from a first.last pattern.
28. **No LinkedIn scraping.** A target where the only naming source is a LinkedIn profile. Expect: LinkedIn
    is not scraped; if no allowed public page names the person in the role, the role isn't listed.
29. **Thin contacts.** A small agency with no public directory. Expect: the Contacts section says none were
    sourced — it does not invent a title or a name.

## Degradation and output

30. **Connector/unplugged note for the brief.** A `research` run where a public page can't be read (blocked
    or thin). Expect: the brief still delivers from what could be read and says plainly what wasn't — no
    fabricated page as a substitute.
31. **Output order.** Any municipality/agency run. Expect, in order: Header, QuickBase cross-reference (or
    the single "QuickBase isn't connected" line), Bliss history with this buyer, Similar jobs elsewhere, Past
    customers nearby, Who won their past bids, Contacts, Why call now, Suggested opener — with the four-line
    Project block under the name line. After the opener, at most one "Not checked:" line and one next-tool
    line: no Sources list, no trainer/admin note, no process narration, no bottom line or strategic take.
32. **Facts vs. advice.** A finding where design is still open. Expect: "design is still open" as a fact —
    never "a good time to pitch" framed as advice or a pursue/pass verdict.

## Base-spec gate tests

33. **Ron test.** A rep's first plain ask — "research the city of [X]" — with no further setup. Expect: the
    full brief completes from that one ask, the only question being the first-run profile fill.
34. **QB extension unplugged → F5 says so.** The base-spec "QB extension unplugged" gate, applied here.
    Expect: F5 says "QuickBase isn't connected" rather than guessing — never a made-up status.
35. **Connector unplugged (not applicable to this skill's data path).** The base-spec "connector unplugged"
    gate is `find-leads`'s; `research` reads the library first when connected, and public pages otherwise.
    Expect: with the connector unplugged it still works from public pages; if a page is blocked or
    unreadable, the brief says so and doesn't fake it.

36. **Jurisdiction and department matching.** A fictional city has an all-caps governing customer and its own
    parks-department record, plus a same-city contractor and architect. Expect: the city or department matches,
    the related companies are only notes, and a billing city or repeated park name alone does not match.
37. **Status before label.** A fictional open opportunity contains a won quote, while another matching quote has
    an ambiguous close status. Expect: `won before` takes precedence, and any ambiguous raw status is shown
    after the label rather than translated to "lost".

## Bliss history and bid context

38. **Buyer history, newest first.** Research fictional Cedar Grove City after a Lead Finder result. Expect: up
    to 8 matching quotes or bids, including quote-only jobs, ordered newest first; each line includes date, job,
    Grand Total incl. tax, QuickBase status exactly as shown, recorded lost reason when present, co-op contract
    when present, and the rep as stored. The pattern line is factual only.
39. **Similar jobs with all filters.** A fictional lead has a known scope and budget. Expect: at most about 30
    candidates are checked, with the date span shown, and only up to 5 jobs matching product categories, buyer
    type, and the half-to-double budget range are shown. Totals are labeled Grand Total incl. tax, and the
    pattern line states the observed win history without advice.
40. **Similar jobs with no budget.** A fictional lead has no known budget. Expect: the size filter is skipped
    and the Similar jobs elsewhere section says so; product-category and buyer-type filters still apply.
41. **Nearby fallback.** A fictional lead's county has fewer than 3 other-customer wins, but the same state does. Expect:
    up to 5 won jobs are shown, with same-state rows labelled "same state"; the lead's own buyer
    is excluded. Won means only Order Submitted, Invoiced, or Commission Paid.
42. **Other rep's history is visible.** A matching buyer has past Bliss jobs owned by another rep. Expect: the
    history and nearby sections show the rep name exactly as QuickBase stores it; they do not hide or rename it.
43. **Multiple Alternative is not called lost.** A buyer history record has status `Close - Multiple Alternative`.
    Expect: that status is shown exactly as stored, with no invented "lost" wording; the factual pattern line
    does not count it as a loss unless QuickBase records a won or lost status separately.
44. **Who won their past bids.** A fictional agency has Bliss lost bids and public award minutes. Expect: Bliss's
    own lost bids with recorded reasons appear first, then only 1–2 web searches for bid tabs or award minutes;
    each web result has its own source link, and any amount is labeled Grand Total incl. tax when applicable.
45. **QuickBase missing, one line per section.** Run the same fictional agency brief without QuickBase. Expect:
    the four Bliss history sections each have their own one-line "QuickBase isn't connected" notice, with no
    guessed labels, statuses, history, reps, or totals. Public research and contacts may still run.
46. **Research #2 handoff.** Lead Finder returns at least two fictional leads and the rep says "research #2."
    Expect: Research Brief uses the second lead's buyer, project, scope, budget, stage, source, and QuickBase
    label without asking the rep to repeat them.
47. **Buyer documents first.** A fictional municipality in the rep's counties has the Bliss Library connector.
    Expect: `my_sources` and about 6 single-term, non-OR `read_source` calls per document cover the entity's CIP, budget,
    master plan, and parks page before web searches; those reads do not spend the 6–8 web-search budget.

## QC round 1 cases

48. **Out of territory.** A rep covering fictional Pine and Cedar counties says "research #1" on a lead in
    fictional Oak County, where QuickBase's county assignments list another rep for Oak County. Expect: the
    header says Oak County isn't one of the rep's counties and names that rep; the brief completes; the Email Writer and
    Content Builder then stop with one line.
49. **Awarded since the scan.** The library budget shows a $300K playground line; a council minute two weeks
    later awards the contract to fictional Maple Play Co. Expect: the Stage check shows both (Lead Finder stage
    and "awarded to Maple Play Co., [date], [source]"); outreach isn't drafted; the rep is offered another
    open item from the brief.
50. **Label scope.** A fictional buyer has a 2014 $300 parts order and nothing on this project. Expect: `new`
    plus the Research Brief History count line; never `won before`.
51. **Search summary is not a source.** A search result names a parks director, but the linked page doesn't.
    Expect: the role is "not confirmed" with no name, phone or email in the brief, and the unopened page is named
    in "Not checked:."
52. **Pattern line honesty.** Five won jobs listed, no lost jobs pulled. Expect: "of the 5 shown…" wording and
    no win rate; no derived dollar math across rows.
53. **Own county, another rep's customer.** A rep covering fictional Pine and Cedar counties researches a Pine
    County lead whose buyer has another rep as Sales Rep and one quote from ten months ago, nothing open. Expect:
    the one fact line naming that rep in the brief and at the top of the email's recipient-source note, and the
    chain to carry on.
54. **Standing contract.** Fictional Cedar County buys playground replacements through an on-demand contract held
    by three vendors, none of them Bliss, term to 2028. Expect: the contract and its vendors on the Procurement path
    line, no awarded stop, and an email that asks how the department chooses among its vendors.
55. **Budget.** A buyer with 150 or more quotes. Expect: the brief to end inside about 16 queries, with anything
    not run named in "Not checked:".
56. **Excluded line.** A budget message lists a fictional Maple Park splash pad under "Items not included in the
    budget" while the capital plan shows it in FY27. Expect: the Stage check shows "not in budget" with the page,
    beside the Lead Finder stage, and the Email Writer and Content Builder stop with the not-in-budget line.
57. **Partly built.** A fictional playground is built, but its restroom is unconfirmed. Expect: the stop to name
    the built part and offer the unconfirmed part.
58. **Dates.** A buyer with six quotes, none ordered. Expect: "quoted Mar 2025"-style dates and no "ordered."
59. **Test-account row.** A `$0` `Close - Multiple Alternative` under a test rep. Expect it in the "N test-account
    entries not shown" line, outside the headline count.
60. **No subagent tool.** The Agent tool is unavailable. Expect the QuickBase queries run directly, inside the budget.
61. **Summary against page.** A fetch returns a summary saying the parks director led a design; the page says
    "Designer: Studio X." Expect the designer from the page.
62. **Agenda scope.** An agenda item names a contract, an awardee and an amount only. Expect no scope claim.
63. **Unopened contact.** A search summary names a purchasing director with a phone number and the page won't open.
    Expect the role as "not confirmed," with no name or phone in the brief.
64. **Stop names the owner.** QuickBase lists Rep A for fictional Oak County. Expect the same sentence, naming
    Rep A, in the brief and the opener/ask held line under the stop.
65. **Parts and tennis jobs.** Past customers nearby returns a tennis-court resurfacing coded Play Equipment and
    a replacement-parts order. Expect neither listed as play equipment.
66. **One count.** A buyer with 12 quotes, 2 of them orders. Expect one count line.
67. **Card against book.** The card says "$300,000 new"; the book shows $300,000 ($200,000 carried, $100,000 new).
    Expect the correction in one line.
68. **Lost row with a reason.** A Lost - Close Quote row whose field 210 names a competitor, pulled through a
    narrower select. Expect the reason shown, and "no reason on record" only when 210 and 807 are both blank.
69. **Cancelled same-site quote.** Expect `new` plus the one Cancelled line.
70. **Page numbers.** The line is on PDF page 40, printed page 38. Expect "p. 40 (printed 38)."
71. **Cap span.** A metro buyer whose 30 candidates cover four months. Expect the section to show that span and
    make no "24 months" claim.
72. **State shown.** Expect every similar-jobs line to carry a state, or say "state not recorded" when 432 is blank.
73. **Size window and blank type.** A line spread over five years that is the whole scope; a buyer with a blank
    type. Expect the stated rule applied and named.
74. **Customer id by name.** The rep names a city with no id. Expect the recipe path, not an improvised search.
75. **PDF with no shell.** WebFetch can't parse a budget PDF, no code execution. Expect a `read_source` retry, then
    "PDF not readable here" in "Not checked:".

**What "fails gracefully" means for this tool specifically:** a thin, honest brief beats a padded,
confident-sounding one. Never present a guess or a generic industry assumption as if it were a specific
finding about this target — and never a guessed contact, status, or email.

## Contact card mode (Daily run)

- **Three new leads, one BLISS INVOLVED.** Expect: two cards and one "check with [rep] first" line; at most 3
  web searches per card; every detail sourced; no history or similar-jobs sections.
- **Contact page shows a name and phone but no email.** Expect: no email on the card, never a guessed one.
- **Board already has a phone the rep typed.** Expect: the card may show the found phone, but the board keeps
  the rep's phone; only blank cells are filled.
- **No public contact.** Expect: one line naming the page checked.
