# PRD-V1 status

Branch: `prd-v1` from `main` at `8fa565a`.
Head before Wave 4: `7809af9`.
Push status: not pushed.

Commits before Wave 4:

- `5b8dba1` — find-leads: registry-first scan, REAL/ROUTINE gate, staging/scoring, QB cross-reference, PDF fallback, and tests.
- `4a2aa72` — research/prep-call: QB cross-reference, public-role contacts, and research-dossier call prep.
- `0cc5ffd` — find-leads: TERRITORY_PENDING stop branch, compact references, and Claude review fixes.
- `7809af9` — leads: shared `lead-board.xlsx` replaces the markdown tracker across find-leads and my-new-leads.

Wave 4:

- Removed the guide's QuickBase deep link and scrub exception; guide now explains the reworked skills and manual-open list.
- Replaced `SETUP-CARD.md` and `TIER2-SETUP.md` with `SETUP.md` based on the 05 source.
- Updated the guide's test cases and README.
- `CLAUDE.proposed.md` holds the intended `CLAUDE.md` replacement. It is deliberately uncommitted for Claude to review and move into place.

What remains:

- Claude reviews and applies `CLAUDE.proposed.md` to `CLAUDE.md`, then commits it.
- Wave 5: final scrub, packaging, per-skill `TEST-CASES.md`, PR creation, and the exact implementation handoff.

Exact next step:

Wait for Claude's `CLAUDE.md` review-and-apply commit, then resume Wave 5 from this branch.