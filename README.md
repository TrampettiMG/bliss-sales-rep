# Bliss Sales Rep

A public GitHub repo a Bliss sales rep's Claude (Cowork) sets itself up from with one pasted message. It supports the Bliss Products sales-rep AI training.

Cowork fetches `CLAUDE.md` directly, then saves the profile and skill files in the rep's project. Setup runs once; later chats use the saved files. See `SETUP.md`.

## What's here

- `CLAUDE.md` — house rules, first-run profile onboarding, connector checks, and tool fetch instructions.
- `SETUP.md` — the one-page setup path for the rep.
- `skills/` — 12 sales-rep tools. Each has a `SKILL.md` and `TEST-CASES.md`.

## Tools

| Tool | What it does |
|---|---|
| `find-leads` | Finds, grades, stages, scores, and tracks public lead signals. |
| `research` | Builds a cited reason-to-call dossier and public-role contacts. |
| `prep-call` | Builds a short pre-call brief from known context. |
| `draft-outreach` | Drafts outreach; never sends it. |
| `make-content` | Builds one-pagers and pitch content. |
| `summarize-bid` | Breaks down an uploaded bid packet. |
| `guide` | Routes and explains. |
| `log-update` | Turns notes into a paste-ready QuickBase update. |
| `my-pipeline` | Reviews open opportunities. |
| `my-new-leads` | Reviews unworked opportunities and the local lead board. |
| `forecast-update` | Prepares forecast values for the grid. |
| `quote-detail` | Reviews one quote's details. |

## House rules

- Never invent facts about a prospect, bid, or Bliss.
- Nothing sends, submits, or posts on a rep's behalf.
- This public repository contains no customer records, QuickBase IDs, internal paths, tokens, or credentials. Run the prescribed scrub before every push.
- QuickBase tools are read-only. IDs resolve by table and field name on first use, then remain only in the rep's local `PROFILE.md`.
- The registry connector reads public government sources. If it is missing, Lead Finder falls back to public web search.