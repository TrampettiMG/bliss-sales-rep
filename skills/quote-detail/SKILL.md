---
name: quote-detail
description: >-
  Pull the quote and line-item detail behind one opportunity from QuickBase — the quote total, the main line
  items, and any bond or permit related lines — so the rep can see what's in a deal without digging through
  QuickBase. Read-only; never writes. Use when the rep says "what's in this quote", "quote detail for [opp]",
  "what's the bond on [opp]", "line items for [opp]", or names an opportunity and asks what's in it. For a
  full pipeline health check use `my-pipeline`; to break down an uploaded bid document use `summarize-bid`.
---

# Quote Details

A read-only look at the quote and line items behind one opportunity: the quote total, the main line items,
and any bond or permit related lines. It lets the rep see what is actually in a deal without opening
QuickBase and clicking through. It reads; it never writes.

## Requires the QuickBase connection
This tool only works if the read-only QuickBase connector and the `quickbase-usage` skill are set up in this
project (your trainer sets this up). If they aren't available, say so in one plain sentence,
"This needs the QuickBase connection your trainer sets up; it isn't on your account yet," and stop. Never
guess or fabricate quote data.

## The one rule: real data only, read-only
Every figure comes from a live QuickBase read. Never invent a line item, a price, a bond amount, or a
total. Never write back to QuickBase.

## Which opportunity
Take the opportunity number from the rep, or from a `my-pipeline` / `my-new-leads` result already in the
conversation. If none is given, ask for the opportunity number instead of guessing.

## How to pull it
Follow the `quickbase-usage` skill for the query and field IDs. These are the two largest tables in the app,
so stay tight:

- Find the quote(s) for the opportunity in the Quote Pipeline table, filtered to that opportunity, reading
  the quote number, quote status, and grand total. Select only those fields; never pull the whole table.
- For each quote, pull its line items from the Quote Lines table, filtered to that quote, reading
  description, extended price, and product type. A single quote's lines are a small, bounded set.
- Never scan either table unfiltered. If you need to find a field, delegate to a subagent per the
  `quickbase-usage` rules rather than exploring in the main context.

## Reading the data
- **Bond is not a clean field.** Bond amounts sit on Quote Lines as line items, usually under the
  "Miscellaneous" product type or with "bond" in the description (freight and subcontracts also live under
  Miscellaneous). Surface the likely bond line(s) by their description, and say plainly it is identified by
  the line text, not a dedicated bond field. Never state a bond amount as certain when it is inferred from a
  description.
- Line prices can be blank on note or subtotal lines and negative on discounts. Show them as they are.
- The quote grand total is the figure to lead with for "how big is this deal."
- **⚠ More than one quote on the opportunity** (often options — e.g. a base design and an upgraded one):
  show each quote's total on its own line and **never add them together** into one deal size. Put a
  warning line above them: "⚠ This opportunity has N quotes — these may be options, so the totals aren't
  added together. Check which one the customer is weighing." (Flagged for testing: confirm against a
  real multi-quote opportunity that the tool keeps totals separate and shows this warning.)

## Present it
- Open with one line naming the tool and the rep ("Here's your Quote Details, Andy — Opp 12345, [customer].").
- Lead with the opportunity and its quote(s): quote number as a clickable link to the record (build the link
  from the record-URL pattern in the `quickbase-usage` skill; do not hardcode the realm/app/table IDs),
  quote status, and grand total.
- Then the main line items: description, quantity where useful, extended price. Group or trim if there are
  many; the rep wants the shape of the deal, not every note line.
- Call out any bond or permit related lines separately, with the "identified by description" caveat.
- Keep it scannable. No strategy wrap-up, no "bottom line."
- Offer next steps as offers only, by friendly name: "Want a cover letter for this? That's the Content
  Builder." and "Want a full bid document broken down? Upload it and ask the Bid Breakdown."

## If it fails
If the connector errors or times out, say so in one plain sentence and suggest trying again in a moment. If
a query is about to pull too much, narrow it or delegate to a subagent; never dump raw table data to the
rep, and never show stack traces or field IDs.
