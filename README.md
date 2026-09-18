# Bliss Sales Rep

Stage A spike: proves that a rep can set up a personalized, working Claude in Cowork from this public repo — before the real 10 sales tools get built.

**Confirmed mechanism:** Cowork can't mount a folder from a repo URL, so setup is a single pasted message that has Claude fetch `CLAUDE.md` directly (`WebFetch`) and follow its instructions — no download, no zip, no folder picker. Profile and fetched skill files are saved as project files, so setup only has to happen once per rep; every later chat in that project just works.

- `CLAUDE.md` — persona, house rules, first-run profile onboarding (self-deletes after first run; also has Claude fetch and save the skill files below).
- `skills/lead-ideas/` — one dummy tool proving a fetched skill loads and reads the rep's profile.
- `SETUP-CARD.md` — the one-page install steps for a non-technical rep, tested and confirmed working end-to-end.

No customer, QuickBase, or Trampetti-internal data belongs in this repo. Public repo — scrub before every push.
