# summarize-bid — golden test cases

Not shipped to reps — internal checklist for verifying the skill before rollout. 3-5 realistic inputs it has to handle.

1. **Clean municipal ITB, playground equipment named directly.** A well-formed bid packet (single PDF, one addendum) for a park improvement project that explicitly specifies playground/site-amenity equipment by name. Expect: full breakdown, high-confidence fit signal (spec names the product category directly), no major "Not found" gaps.

2. **Bid names a competitor's product as basis-of-design, with "or approved equal" language.** Expect: the fit signal explicitly surfaces the competitor's name and quotes the substitution language, so the rep knows a proposal is possible but needs to prove equivalence — this must not get lost or softened.

3. **General construction bid with no playground/equipment scope at all.** A generic building-construction RFP that has nothing to do with what Bliss sells. Expect: the tool still extracts the categories accurately (it doesn't know Bliss's business), but the fit signal plainly states the scope doesn't match the rep's product focus from `PROFILE.md` — it should not force a fit that isn't there.

4. **Bid packet missing an addendum or a referenced attachment.** The rep uploads the base RFP but a referenced addendum or spec section isn't attached. Expect: the gaps show up honestly in "Not found — verify," not silently skipped or guessed.

5. **Conflicting dates between the base RFP and an addendum.** Base document says one bid due date, an addendum changes it. Expect: the "Conflicts" section catches this and states the addendum governs — this is the single highest-cost failure mode (a rep working off a stale due date).

6. **GC request for sub pricing, with install and surfacing scope.** A general contractor's invitation to price the playground portion of a larger project, including installation and poured-in-place surfacing. Expect: "Who you'd be bidding to" says it's a GC request, not owner-direct; "Scope beyond equipment supply" lists install and surfacing so the rep knows installer/sub pricing is needed — no cost or effort estimates, no pursue/pass verdict.

7. **Bid with a DBE goal and a licensing requirement.** A packet with a stated DBE participation percentage and a required contractor license. Expect: both appear in "Bidder qualifications" quoted exactly, and both show up in the gating snapshot.

8. **Packet with two addenda and a plan-holders list.** Expect: the Addenda section lists both by number and date with a one-line change summary each, and notes the plan-holders list and its firm count without naming the firms.

**What "fails gracefully" means for this tool specifically:** if no documents are attached, one plain sentence asking the rep to upload the packet — not a guess, not an error dump. If a document is unreadable (e.g., a scanned image PDF with no extractable text), say so plainly and ask for a text-readable version instead of fabricating a breakdown.
