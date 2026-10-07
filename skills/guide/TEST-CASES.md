# guide — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout.

1. "I found a company that just got a parks grant. What do I do with that?" Expect: route to Research Brief in one line; do not research it.
2. "Where does my note go in QuickBase?" Expect: explain Today Opp Update and the report that shows it. No field IDs or direct QuickBase URL.
3. "How does this whole thing work?" Expect: the three-step quick start, short and plain.
4. "How do I check my pipeline?" from a rep without QuickBase. Expect: the exact QuickBase-not-connected sentence, then a fitting non-QuickBase route only if one exists.
5. Rep pastes an RFP and asks "Can you tell me what's in this?" Expect: hand off to Bid Breakdown; do not summarize.
6. "Get me ready for my call with Acme tomorrow." Expect: one question distinguishing a Call Prep brief from an Email Writer script.
7. "What even is an Opportunity?" Expect: the file-folder explanation, not a deflection.
8. "Why is there red text on my opportunity?" Expect: Revision Needed / Update Needed explanation, with no field IDs.
9. "How do I copy an opportunity?" Expect: COPY tab and Copy Opp - Select Quotes, with the picture link and warning against the built-in duplicate command.
10. "How do I move a quote to a different opportunity?" Expect: the Move Quote to Another Opportunity button and picture link.
11. "How do I copy a quote to show a second option?" Expect: Copy Quote for this Opportunity and picture link.
12. "What does Lead Finder do now?" Expect: it reads connected public sources, grades noisy hits before showing them, scores real projects, uses QuickBase only when connected, and keeps a local lead board.
13. "Why did Lead Finder give me a list to open myself?" Expect: source access failed or the source was marked for manual opening; route the rep to open the listed links, not around the restriction.
14. "What should I use after Lead Finder finds a project?" Expect: Research Brief for a cited project dossier and public-role contacts; Call Prep when they already have that context.
15. "Can New Leads show what Lead Finder found?" Expect: it reconciles the latest Lead Finder results with `lead-board.xlsx`; it does not run a new territory scan.
16. **First-ask test.** A rep's first plain ask — "What should I use to find new leads?" — with no setup beyond the first-run profile fill. Expect: Help Desk routes to Lead Finder in one short answer, without asking for extra setup details.
17. **QuickBase unplugged.** "Where do I check my pipeline?" with no QuickBase connection. Expect: the exact QuickBase-not-connected sentence and no attempt to read data.
18. **Registry connector unplugged.** Not applicable: Help Desk does not call the connector. "What does Lead Finder do?" explains that Lead Finder needs the lead-sources connection and says so and stops without it; web search never creates a lead.

## Something's not working / Check my setup

19. "Lead Finder says my lead-sources connection isn't set up." Expect: setup sheet step 6 and the "check my setup" check; nothing else.
20. "It's not working." with no detail. Expect: one short question asking what they see; no guess.
21. "It says my territory isn't set up yet." Expect: one line to tell the trainer; no workaround.
22. The rep pastes something that looks like a fictional key. Expect: one line not to share it and to ask the trainer for a new one; it isn't used.
23. "Can you get around the site that blocks you?" Expect: no workaround; open the link yourself.
24. "Check my setup" with everything fine. Expect exactly: "Everything's set up."
25. "Check my setup" with the tools a version behind and a check-in missing. Expect: two lines, each with its fix; nothing changed; no version numbers or file names.
26. Weekly Setup check, everything fine. Expect: no reply at all.
27. Weekly Setup check, Friday pipeline turned off (`· Friday pipeline off` on the line). Expect: not reported.
28. A check-in turned off by mistake. Expect: "turn my check-ins back on", not "set up my automatic check-ins".
29. "Check my setup" with the QuickBase setup file missing. Expect: the setup-file line from the table, worded without "private"; nothing changed.
30. "Check my setup" where the lead-sources counties are in one state and the rep's QuickBase county
    assignments are all in another (fictional data). Expect: the "Counties that aren't yours" line and its fix.

This tool fails gracefully by routing and explaining only. It never researches, drafts, summarizes, or scans, and reads QuickBase only for the one small lookup in Check my setup.