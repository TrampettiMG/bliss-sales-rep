---
name: log-update
description: >-
  Turns raw material from a customer interaction — dictated notes, a call/meeting transcript, or an email
  thread — into a paste-ready QuickBase update: forecast close date, confidence, status change, and a clean
  note, formatted for the bulk-edit forecast grid. Read-only; never writes, and never invents a forecast
  (the rep sets the values). Use when the rep hands over notes, a transcript, or an email thread from a
  specific interaction and wants it turned into a QuickBase-ready update. To walk through the rep's whole
  open pipeline instead of one interaction, use `forecast-update`.
---

# Update Logger

Takes raw material from one customer interaction — dictated notes, a call or meeting transcript, or an
email thread — and derives a paste-ready QuickBase update from it: forecast close date, confidence, status
change, and a clean note, formatted for the bulk-edit forecast grid. It reads and formats; it never writes
to QuickBase, and it never decides the forecast for the rep.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in
this project (your trainer sets this up). If they aren't available, say so in one plain
sentence — "This needs the QuickBase connection your trainer sets up; it isn't on your account yet." —
and stop.

## The one rule: the rep sets the forecast, never you
Confidence and forecast close date are the rep's commitment — their judgment about their own deal. This
tool **never invents, guesses, or auto-fills them**, even when the raw material seems to imply one. It
derives a *draft* from what's in the material, shows it clearly labeled as a draft, and lets the rep
confirm or correct every value before it goes in the output. It never writes to QuickBase: the rep pastes
the values into the grid themselves.

## Intake — text only, whatever the rep hands over
The rep pastes or uploads the raw material: dictated notes (already typed/transcribed), a call or meeting
transcript, or an email thread. This tool doesn't record or transcribe audio itself — if the rep has a
voice memo, they transcribe it first (dictation on their own device, or any transcript they already have)
and paste the text in. Work only from what's actually in the material — never assume details a transcript
or email thread doesn't contain.

## Step 1 — identify the opportunity
Open with one line naming the tool and the rep ("Here's the Update Logger, Andy."). If the customer is
clear from the material or the conversation (a bid just broken down, an email thread naming the owner),
look it up yourself first — don't ask the rep for an opportunity number QuickBase can find. If a Bid
Breakdown earlier in the conversation already reported "no opportunity for this owner," use that rather
than asking. Ask the rep which opportunity this is for only if it still isn't clear. Then look it up via the `quickbase-usage` skill the same
way `forecast-update` does — pull that one opportunity's current status, forecast close date, confidence,
and customer name, using the rep's QuickBase name (see below) to confirm it's theirs.

**If the lookup fails or the rep doesn't have an opportunity number handy:** don't block on it. Fall back
to a pure transformation — derive the draft update from the raw material alone, note in the output that the
opportunity wasn't matched in QuickBase, and tell the rep to fill in the opportunity number themselves
before pasting.

## First use — confirm the rep's QuickBase name
Rep names must match QuickBase exactly or the lookup returns nothing. If `PROFILE.md` has a "QuickBase
Name" line, use it. If not, or the lookup returns zero rows, ask the rep to confirm their exact name as it
appears in QuickBase and save it to `PROFILE.md` as `QuickBase Name:`.

## Step 2 — derive the draft from the material
Read the raw material and pull out, only where it's actually stated or clearly implied:
- **Status change** — did the material describe a stage move (e.g. quote sent, verbal commitment, lost,
  on hold)? Compare against the opp's current status if it was looked up.
- **Forecast close date** — did the customer give or imply a timeline?
- **Confidence signal** — does the material suggest a confidence level? Map it to the nearest of the five
  valid values, never anything in between.
- **Note** — the note body only: the issue and the action taken, in plain language, concise and freeform
  (matches how reps actually write — "Emailed Adam the revised quote," "Permit delayed at county;
  resubmitting Friday"). **Never prepend a date or the rep's name** — QuickBase stamps both automatically
  when the note is pasted in, so typing them yourself double-stamps it. Don't editorialize or add
  sales-strategy framing that wasn't in the material.
- **Reason, when it's a loss, a no-bid, or "went another way"** — if the material says why (price, another
  brand specified, spec couldn't be matched, no budget, timing, a mandatory pre-bid missed, bond or
  licensing, awarded to someone else), put the reason in the note in plain words. If the material shows a
  loss or no-bid but not why, ask the rep one short question — "What was the reason?" — since QuickBase
  only offers the Lost status once a reason is given, and these reasons are what the team learns from.
  For a no-bid you can list the common ones as choices (spec can't be matched or proprietary, no
  installer or vendor pricing in time, missed the mandatory pre-bid, bond / DBE / licensing, out of
  territory, too small or out of scope, price, cancelled or re-bid, partner bidding direct, or something
  else). List the choices once per conversation — if they're already on screen, just ask again in one
  line. Never guess the reason or pick one for the rep.

Present these as a **draft**, clearly labeled, not as the final answer. If the material doesn't clearly
support a field (e.g. no timeline was mentioned), leave it blank and say so — don't fill the gap with a
guess.

## Step 3 — the rep confirms every value
Walk through the draft with the rep and let them confirm or correct each field. Only values the rep has
confirmed go into the final output. This mirrors `forecast-update`'s rule: an opp appears in the output
only once the rep has given or confirmed its values.

## Valid values — enforce these
- **Confidence must be one of five values: 0%, 25%, 50%, 75%, or 99%** (QuickBase stores them as 0, 0.25,
  0.5, 0.75, 0.99). If the material or the rep gives anything else, ask them to pick one of the five —
  never round it silently.
- **Forecast close date** must be a real calendar date. If it lands in the past, flag it instead of
  accepting it silently, and watch for obvious typos (a wrong year).

## Present it — the grid-ready output
- Lead with a one-line summary: "Ready to paste: 1 opportunity updated" (this tool handles one interaction
  at a time; for a full pipeline walkthrough, point the rep to `forecast-update`).
- Then a single-row table: opportunity number, customer, forecast close date, confidence (%), status
  change (if any), note.
- Offer a tab-separated version for a direct paste into the grid.
- If the opportunity wasn't matched in QuickBase, say so plainly and flag that the opportunity number
  needs to be filled in by hand.
- Remind the rep plainly: this is a draft — they paste it into the QuickBase forecast grid themselves;
  nothing is written automatically.
- No strategy wrap-up, no "bottom line."

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment —
no stack traces, no QuickBase jargon.
