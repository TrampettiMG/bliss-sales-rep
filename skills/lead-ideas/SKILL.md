---
name: lead-ideas
description: Give the rep a few generic lead ideas for their county. Stage A dummy tool — proves a skill can load in CoWork and read the rep's profile. Not a real tool; no live data source.
---

# Lead ideas

Trigger on plain-language asks like "give me lead ideas for my county," "any leads near me," or "what should I look into."

Steps:
1. Read `PROFILE.md`. If it doesn't exist yet, tell the rep in one sentence to finish setup first (they should trigger the CLAUDE.md first-run flow instead).
2. Using the rep's territory/counties and product focus from the profile, return 3-5 generic, plausible lead categories for that kind of territory — e.g. municipal park upgrades, new school construction, HOA amenity projects. These are illustrative placeholders, not real research.
3. Keep the answer short — a plain list, mobile-readable, no preamble.

This is a placeholder for Stage B's real `find-leads` tool, which will do actual research. Don't try to make this one accurate — it only needs to prove the mechanism works.
