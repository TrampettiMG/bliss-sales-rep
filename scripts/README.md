The release check scans the public tracked files for record IDs, RFQ and quote numbers,
dollar figures, and names from the optional private scrub list.
It also checks the QuickBase description length and the single tools-version line,
reviews private references in SETUP.md, and verifies listed tool/reference files exist.
Dollar figures and SETUP.md private references are reviews for a human to inspect.
Run it from the repository root before every release:

  bash scripts/release-check.sh
