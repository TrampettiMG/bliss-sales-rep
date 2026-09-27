# The log — dedupe, moved-up leads, and write verification

Read before you check or update `find-leads-log.md` — every run. SKILL.md carries the flow; this file
carries the log rules.

Keep a project file `find-leads-log.md` — one entry per signal ever surfaced, each with its date, county,
one-line description, stage, score, QuickBase label, and source URL. On every run:

1. **Look for the log anywhere in the project first**, including a subfolder like `claude/` — some setups
   save files there. Use and update it where you find it; never start a second log. If it truly doesn't
   exist, this is the rep's first run — scan normally, treat everything found as new, and create the log
   with today's results.
2. Compare against the log **by the underlying event, not just the literal URL** — a different article on
   the same groundbreaking, budget vote, or grant award is the same signal, not a new one. Report only
   genuinely new items. **Exception — the same project at a later stage is news:** report it under a
   separate **"Moved up since your last scan"** heading above everything else, one line each with the old
   stage, the new stage, date and source ("Tuckahoe District Park, Henrico: FY27 design money →
   construction RFP posted Oct 3"), and update its log entry rather than adding a second one. Never spend
   extra searches re-checking old items. If nothing new turned up, say so plainly: "Nothing new since your
   last run on [date]" — don't re-surface old items or pad the list.
3. Append newly surfaced items to the log after reporting them. **Verify the write actually happened** —
   read the file back, count the entries you just added in what you read back, and put that count in the
   saved line ("Saved 10 new items to your lead log.") so it can be checked. If the count doesn't match what
   you reported, say the save didn't fully work instead. Never claim the log was updated unless you've
   confirmed it.
4. **Keep the log from growing unbounded.** Once entries older than ~90 days start making the log large
   enough to burn significant context just checking for dupes, collapse them to a compact one-line-per-item
   form (date + headline + URL) instead of dropping them — they're still needed for dedup.
