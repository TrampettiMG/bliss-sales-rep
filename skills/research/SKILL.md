---
name: research
description: >-
  Build a one-page "reason to call" dossier on a named person, company, or municipality, from public
  web sources. Use when the rep says "research...", "give me a dossier on...", "look into...", "reason
  to call brief for...", or wants to dig into a specific signal or contact by name. For a broad scan of
  the rep's territory instead of one named target, use `find-leads` instead.
---

# Research Brief

Build a short, cited "reason to call" brief on one specific, named target — a person, a company, or a
municipality/agency. This is the deep-dive tool for something specific; scanning a whole territory for
signals is `find-leads`'s job.

## What this is not

It never invents facts about the target. If public search comes back thin, the brief should look thin and
say so ("Limited public information found on [target]") rather than padding with generic filler dressed up
as research. Every finding needs a real source and, where relevant, a real date.

## Usage budget — most reps are on a standard/basic Claude plan

Cap this at roughly 6-8 searches total for one brief. Go broad first (recent news, official
site/announcements), then one or two follow-ups only on the most promising thread. Don't chase every
tangent. If the budget runs out, present what was found and say plainly what wasn't checked, rather than
silently stopping partway through.

## Flow

1. **Identify the target and type** — person, company, or municipality/agency — from the rep's request. If
   the rep just got this from a `find-leads` result or another tool's output earlier in the conversation,
   use those details instead of re-asking. If the target name is ambiguous (common name, multiple
   organizations with similar names), first try to settle it from the rep's territory in `PROFILE.md`
   (e.g., "Richmond parks" for a rep who covers Richmond city, VA): if exactly one match is in their
   territory, go with it and say so in one line ("I took this to mean … — tell me if you meant …").
   Only if the territory doesn't settle it, ask for a disambiguating detail before searching.
2. **Read `PROFILE.md`** for the rep's product focus, territory, and Voice (if set) — used for relevance
   framing and the suggested opener.
3. **Research, within the usage budget**, gathering what's publicly available and relevant:
   - **Person:** current role/title, organization, and any recent public professional activity (news
     mentions, public statements, project involvement) — not personal/private information.
   - **Company:** what they do, recent news, projects, or public activity relevant to the rep's product
     focus.
   - **Municipality/agency:** recent capital projects, budgets, procurement activity, or public meeting
     items relevant to parks/rec/playground work — similar territory to `find-leads` but focused on one
     specific place instead of scanning broadly. The most useful public items, in rough order:
     - the parks master plan or capital improvement plan (named parks and planned years/amounts);
     - grants awarded or applied for (e.g., LWCF, CDBG, state recreation grants) and their match deadlines;
     - bond referendums or budget adoptions that fund parks/rec, and when the agency's fiscal year ends;
     - council/board agenda items approving park purchases, including purchases through a cooperative
       contract (Sourcewell, BuyBoard, TIPS, OMNIA, etc.);
     - open or recent bids on the agency's own bid page, and published bid tabulations/awards (who won
       a past playground or park bid, if public).
     For a **school district**, the equivalent is its facilities plan or bond program.
4. **Present the brief**, one page, in this order:
   - **Header** — name, title/role or type, organization, and any public contact info found (never
     inferred or guessed).
   - **Why call now** — a dated, cited bullet list of the most relevant findings, each with one line on
     why it connects to the rep's product focus (a factual connection, not a pursue/pass verdict or
     timing advice — "design is still open" is a fact; "a good time to pitch" is advice).
   - **Suggested opener** — one short, natural conversation-starter line referencing the findings above,
     written in the rep's Voice from `PROFILE.md` if set.
   If research comes back thin, keep the same structure but say so honestly in "Why call now" rather than
   inventing content to fill it. **End after the suggested opener — no added "bottom line," recommended
   framing, or strategic take.** If a pattern is genuinely worth naming (e.g., "these two awards both
   skipped playground scope"), it belongs as a factual note inside "Why call now," not as a separate
   verdict on how the rep should approach the account.
5. If the rep wants to act on this brief next (an email, a call), hand off to `draft-outreach` or
   `prep-call` rather than drafting those here — this tool's job stops at the research.
