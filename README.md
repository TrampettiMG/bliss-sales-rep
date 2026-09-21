# Bliss Sales Rep

A public GitHub repo a Bliss sales rep's Claude (Cowork) sets itself up from — one pasted message, no
download, no folder picker. Built for the Bliss Products sales-rep AI training (Atlanta, ~Oct 2026).

**Confirmed mechanism (Stage A):** Cowork can't mount a folder from a repo URL, so setup is a single pasted
message that has Claude fetch `CLAUDE.md` directly (`WebFetch`) and follow its instructions. Profile and
fetched skill files are saved as project files, so setup only happens once per rep; every later chat in
that project just works. See `SETUP-CARD.md` for the exact, tested steps.

## What's here

- `CLAUDE.md` — persona, house rules, first-run profile onboarding (self-deletes after first run; also has
  Claude fetch and save each tool skill below).
- `SETUP-CARD.md` — the one-page install steps for a non-technical rep, tested end-to-end (Tier 1 only).
- `TIER2-SETUP.md` — the separate, gated install path for the pilot reps who get the QuickBase connector.
- `skills/` — the sales-rep tools, each a `SKILL.md` plus a `TEST-CASES.md` of golden test inputs used to
  verify it before rollout (Tier 1 tools only — Tier 2 tools aren't live-tested yet, see below).

## Tools — status

Tier 1 (all reps, no connector, desktop):

| # | Tool | Status |
|---|---|---|
| 1 | `find-leads` | Built |
| 2 | `research` | Built |
| 3 | `prep-call` | Built |
| 4 | `draft-outreach` | Built |
| 5 | `make-content` | Built |
| 6 | `summarize-bid` | Built |

Tier 2 (pilot only, needs the read-only QuickBase connector — see `TIER2-SETUP.md`, all owned by Vish):

| # | Tool | Status |
|---|---|---|
| 7 | `log-update` | Built — not yet live-tested |
| 8 | `my-pipeline` | Built (by Vish) — not yet live-tested |
| 9 | `my-new-leads` | Built (by Vish) — not yet live-tested |
| 10 | `forecast-update` | Built (by Vish) — not yet live-tested |

## House rules worth knowing before adapting or adding a tool

- **Never invent specifics** — about a prospect, a bid, or Bliss itself — beyond what the rep supplies or
  what's already in the conversation. A rep-supplied quantitative claim gets used as given, with a
  caution to double-check it, never refused and never fabricated independently. See `CLAUDE.md`.
- **Drafts never auto-send.** Nothing in this repo sends, submits, or posts on a rep's behalf.
- **Zero Bliss/Trampetti-internal data.** No customer records, no QuickBase field/table/app IDs, no
  internal paths — this repo is public. Scrub before every push. A Tier 2 tool's skill file should talk
  about "the QuickBase connector" generically; real field mappings live in the private connector, not here.
