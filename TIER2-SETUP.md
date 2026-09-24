# Tier 2 setup — pilot reps only

Tier 2 tools (`my-pipeline`, `my-new-leads`, `forecast-update`) read live data from QuickBase. They are
**gated** — only for the small pilot group Mike selects, not part of the standard 24-rep rollout. Don't run
this for a Tier 1 rep; without the connector these tools can only fail.

## Prerequisites (the trainer/Vish handles these, not the rep)

1. **The read-only QuickBase connector** (`quickbase-mcpb`, the private Tier 2 extension — 11 tools, zero
   writes) must be installed and connected in the rep's Cowork setup, with a per-rep QuickBase token. Per
   the handoff doc's agent-security standard: per-user credentials, least privilege, no shared tokens —
   loop Nick in before wiring this, and it's gated on Gregg at Bliss. **After installing the extension in
   Settings → Extensions, quit and reopen the app (or at least start a fresh chat) before testing** —
   installing it alone doesn't reliably make a running chat see the connection as active.
2. **The `quickbase-usage` skill** (built by Vish) — the field-ID/query-discipline reference all three
   Tier 2 skills below assume is present, since none of them will guess at query details without it.
   **This file is private and must never go in this public repo or be fetched from a public URL** — it
   contains real Bliss QuickBase config (realm, app/table/field IDs, live record counts). Vish/the trainer
   hands it directly to each pilot rep's Cowork setup (e.g., drag-and-drop into the project, or install it
   the way any other Claude skill package is installed on that machine) — never a link, never this repo.

**The four Tier 2 skills are now installed for every rep during the normal setup** (they're
public/generic, no Bliss-specific IDs, and they fail gracefully without the connector). So for a rep set up
after 2026-09-24, the two prerequisites above are all that's needed. Only a project set up **before** that
date needs this one-time paste to add them:

```
Fetch each of these and save it as the matching project file:
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/my-pipeline/SKILL.md → skills/my-pipeline/SKILL.md
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/my-new-leads/SKILL.md → skills/my-new-leads/SKILL.md
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/forecast-update/SKILL.md → skills/forecast-update/SKILL.md
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/log-update/SKILL.md → skills/log-update/SKILL.md
```

## What's different about these three vs. the Tier 1 tools

- **Read-only, always.** None of them ever write to QuickBase — `my-pipeline` and `my-new-leads` are pure
  reads, `forecast-update` produces a paste-ready table the rep pastes into the bulk-edit grid themselves.
- **A `QuickBase Name:` line gets added to `PROFILE.md` automatically** the first time any of these run,
  the same self-persisting pattern `draft-outreach` uses for Voice — no manual setup needed, but it means
  a pilot rep's `PROFILE.md` will look slightly different from a Tier 1-only rep's.
- All three fail gracefully with one plain sentence if the connector isn't there — that's the expected
  behavior for the other 21+ reps who don't have Tier 2, not a bug.

## Tool 7

`log-update` — built and live-tested. It's the one Mike most wants (turning dictated notes, a call
transcript, or an email thread into a QuickBase-ready update), and it's gated the same way as 8-10. Intake
is text only (the rep transcribes a voice memo themselves before pasting it in — this tool doesn't do
audio transcription). It optionally looks up the opportunity in QuickBase for current values, and falls
back to a pure transformation from the raw material if the lookup fails or no opportunity number is given.
