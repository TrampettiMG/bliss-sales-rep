# Tier 2 setup — pilot reps only

Tier 2 tools (`my-pipeline`, `my-new-leads`, `forecast-update`) read live data from QuickBase. They are
**gated** — only for the small pilot group Mike selects, not part of the standard 24-rep rollout. Don't run
this for a Tier 1 rep; without the connector these tools can only fail.

## Prerequisites (the trainer/Vish handles these, not the rep)

1. **The read-only QuickBase connector** (`quickbase-mcpb`, the private Tier 2 extension — 11 tools, zero
   writes) must be installed and connected in the rep's Cowork setup, with a per-rep QuickBase token. Per
   the handoff doc's agent-security standard: per-user credentials, least privilege, no shared tokens —
   loop Nick in before wiring this, and it's gated on Gregg at Bliss.
2. **The `quickbase-usage` skill** — the field-ID/query-discipline reference all three Tier 2 skills below
   assume is present. This ships with the QuickBase connector setup, not from this public repo — confirm
   it's actually there before relying on these tools, since all three explicitly refuse to guess at query
   details without it.

Once both of those are in place for a rep, install the three Tier 2 skills the same way the Tier 1 tools
were installed — a one-time paste, fetched and saved as project files:

```
Fetch each of these and save it as the matching project file:
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/my-pipeline/SKILL.md → skills/my-pipeline/SKILL.md
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/my-new-leads/SKILL.md → skills/my-new-leads/SKILL.md
https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/forecast-update/SKILL.md → skills/forecast-update/SKILL.md
```

## What's different about these three vs. the Tier 1 tools

- **Read-only, always.** None of them ever write to QuickBase — `my-pipeline` and `my-new-leads` are pure
  reads, `forecast-update` produces a paste-ready table the rep pastes into the bulk-edit grid themselves.
- **A `QuickBase Name:` line gets added to `PROFILE.md` automatically** the first time any of these run,
  the same self-persisting pattern `draft-outreach` uses for Voice — no manual setup needed, but it means
  a pilot rep's `PROFILE.md` will look slightly different from a Tier 1-only rep's.
- All three fail gracefully with one plain sentence if the connector isn't there — that's the expected
  behavior for the other 21+ reps who don't have Tier 2, not a bug.

## Not yet built

Tool 7 (`log-update`) — still not started. It's the one Mike most wants (turning a voice note, call
transcript, or email thread into a QuickBase-ready update), and it's also gated the same way as 8-10.
