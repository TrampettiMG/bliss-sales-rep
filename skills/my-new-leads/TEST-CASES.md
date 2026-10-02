# my-new-leads — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. Confirmed live against a
real rep's full "New" opportunity set (2026-09-22); cases below are the generic patterns that pull found,
not the real data itself. Every case is written as the plain ask a rep would type — one ask, no follow-up
setup beyond the first-run QuickBase name confirmation.

## The Ron test

1. **"What new leads do I have?"** — a rep's first run, nothing on disk yet. Expect: it pulls the rep's New
   opportunities read-only from QuickBase and creates the lead board in the rep project folder
   (`lead-board.csv` where the project only holds text files), one row per lead, with the full 18-column set
   (agency, county, project, stage, score, QB status, status, contact, next action, source link, doc date,
   last checked, phone, email, website, contact source, next action date, bid due). It reads the file back before saying it saved, says
   where the board lives, and asks nothing beyond the QuickBase name if that's missing.

## The board

2. **"Check my lead board — what's new?"** right after a `find-leads` run in the same conversation. Expect:
   the board holds the QuickBase New opps *and* that run's leads, one row per lead — stage, score, source
   link and doc date filled from the `find-leads` results, QB status on the QuickBase rows. It does **not**
   run its own territory scan to fill the board, and it doesn't re-add a lead the rep has already seen.

3. **"One of these agencies showed up again under a different link."** Expect: it's the same row — matched
   on the underlying lead (agency + project + county), not the literal URL. The row's stage/score/link/doc
   date update in place, last checked updates, and nothing is duplicated or shown as new.

4. **"A tracked lead moved to design — anything else?"** with a brand-new lead in the same run. Expect: the
   stage change is reported **first**, one line with old stage → new stage, date and link, ahead of the
   newly found lead.

5. **"Did my board save?"** Expect: it reads `lead-board.xlsx` back and reports the row count it actually
   found, with only the rows it really changed. If the readback doesn't match, it says the save didn't
   fully work rather than claiming success.

6. **"Show me my board."** Expect: the full board as a plain, paste-ready table with the fixed column order.
   No formulas, no merged cells, nothing the rep can't edit in Excel or Google Sheets.

7. **"Can you mark that one dropped?"** then a later run where `find-leads` surfaces the same project again.
   Expect: the row stays `dropped`, the lead is not re-added and never comes back as new.

8. **"What's the status on each of these?"** Expect: every value in the Status column is one of exactly
   **new, watching, contacted, in QB, dropped** — never a free-text status, never a combined label.

9. **"Any updates on my leads?"** — a second run with nothing changed. Expect: leads already seen are not
   re-surfaced as new; rows carry over with last checked moved to today's session date, and the rep gets a
   plain "nothing moved" line instead of the same list again.

10. **A run where a lead arrives with no visible stage, score, or doc date.** Expect: those cells are left
    blank (or noted as not staged / date not visible on the source page) — never a guessed stage, score,
    date, or contact, and never a row invented to round out the table.

11. **A board that already exists in a `claude/` subfolder.** Expect: it finds and updates that board where
    it is. No second board, no new log file.

## The QuickBase New read (unchanged behavior)

12. **"What new leads do I have?" on a rep with zero New opportunities.** Expect: a plain, short "no new
    leads right now" — after the QuickBase name is confirmed — rather than an empty table or a fabricated
    placeholder row.

13. **"What new leads do I have?" with the QuickBase connector not set up for this rep.** Expect: one plain
    sentence saying the QuickBase connection isn't on the account yet, and it stops there — no fabricated
    leads, no guessed QB status, and the existing board left exactly as it was.

14. **A normal rep query with a genuine mix of lead ages.** Some leads created recently, some sitting for
    weeks. Expect: fresh leads are distinguished from older untouched ones using a real age signal (days
    since created, activity/update history) — not just a flat list.

15. **A rep whose entire "New" set came from the same bulk-import or system-migration event.** All leads
    created within the same tight time window, all at default values, no real per-lead activity since.
    Expect: it notices "days since created" can't honestly distinguish fresh from backlog here, says so
    plainly, and falls back to a defensible alternative grouping (e.g., by lead source) instead of guessing
    a fresh/backlog split it can't support. The most important case — a silently fabricated split would be
    worse than admitting the data doesn't support one. The whole set still lands on the board.

16. **Leads with missing or unusual lead-source values.** Some leads have a clean source tag, some have
    none set. Expect: it groups what it can and labels the rest "source not set" rather than dropping them
    or guessing a source.

17. **Same source, different spellings.** Leads with sources "Current Client" and "EXISTING CUSTOMER."
    Expect: each shown as written; if grouped by source, they're one group and the output says so.

18. **A single page vs. a paginated result.** A rep with a small new-lead count, and separately a rep with
    enough leads to require paging. Expect: the true total is reported either way, and nothing is silently
    truncated without saying so.

19. **A name that doesn't match QuickBase.** Expect: one plain ask to confirm the exact name as it appears
    in QuickBase, the confirmed name saved to `PROFILE.md`, and never "you have no new leads" on a name
    mismatch alone.

**What "fails gracefully" means for this tool specifically:** if the QuickBase connector errors or times
out mid-run, one plain sentence saying so, and the board is left as it was — no rewrite off a partial read,
and it says which rows it couldn't check. When it hands off to another tool (e.g., suggesting `research` or
`draft-outreach` for a specific lead), that's a natural next step, not an unrequested strategy wrap-up.
