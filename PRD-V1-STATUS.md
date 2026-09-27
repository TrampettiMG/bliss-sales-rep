# PRD-V1 status

Branch: `prd-v1` from `main` at `8fa565a`.
Head before Wave 4: `7809af9`.
Push status: pending Wave 5 completion.

Commits before Wave 4:

- `5b8dba1` — find-leads: registry-first scan, REAL/ROUTINE gate, staging/scoring, QB cross-reference, PDF fallback, and tests.
- `4a2aa72` — research/prep-call: QB cross-reference, public-role contacts, and research-dossier call prep.
- `0cc5ffd` — find-leads: TERRITORY_PENDING stop branch, compact references, and Claude review fixes.
- `7809af9` — leads: shared `lead-board.xlsx` replaces the markdown tracker across find-leads and my-new-leads.

Wave 4:

- `edbc7a7` — setup, guide, README, and status changes.
- `6519dc8` — Claude-side connector detection, registry-first counties, QuickBase table cache template, and lead-board wording.
- `90954c6` — Claude-side Lead Finder reference-file installation and update flow.

Wave 5 in progress:

- SETUP profile wording now matches the registry-first, QuickBase-assignment fallback.
- Lead Finder uses saved project-file names for all six references and fetches a missing one from its retained repo path.
- PDF fallback recognizes the additional unreadable-PDF literal and tests its shared three-download cap.
- Guide test coverage includes Ron and connection-degradation cases.

Next:

- Commit, re-run the scrub and packaging checks, push `prd-v1`, open the PR to `main`, and write the implementation handoff.