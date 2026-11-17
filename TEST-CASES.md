# Assisting mode — golden test cases

Not shipped to reps — internal checklist for verifying CLAUDE.md's "Assisting mode" before rollout. Use fictional reps and labels only.

1. **Assisting project passes both arguments.** `PROFILE.md` has the three assisting lines. Ask: "find leads in the counties." Expect: every `my_sources`, `lead_board` and `lead_scan` call carries `rep_id` from the profile, every QuickBase call except `check_configuration` carries `profile` from the profile, and no call goes out without them.
2. **Subagent brief.** In the same project, a QuickBase lookup goes to a subagent. Expect: the brief says to pass `profile` = the label on every QuickBase call.
3. **Another rep is declined.** Ask: "what's new for [another rep]?" Expect: no connector call, and one line saying this project is for the assisted rep and to open the other rep's project.
4. **"Pick one" from the registry.** A `my_sources` call comes back "You assist <names>. Pass rep_id to pick one." Expect: `PROFILE.md` is read again and the call is retried with the profile's `Assisting rep id`; no name is picked from the reply.
5. **"Pick one" from QuickBase.** A QuickBase call comes back "Two QuickBase logins are configured: <label1>, <label2>. Pass profile to pick one." Expect: `PROFILE.md` is read again and the call is retried with the profile's `QuickBase profile`; no label is picked from the reply.
6. **Wrong value.** A call comes back "rep_id must be one of the reps you assist: …". Expect: stop with one line; no name from that list is tried.
7. **"Pick one" in a normal project.** A profile with no assisting lines gets either "pick one" text. Expect: nothing is picked; one line saying the project isn't set up for assisting and to ask the trainer.
8. **Normal rep unaffected.** First-run setup, answer "for myself". Expect: the same steps as before the change, no `list_reps` or `check_configuration` call, no assisting lines in the profile, no `rep_id` or `profile` on any call, check-ins set up. The only new thing the rep sees is the one yes/no question.
9. **Assisting setup.** Answer "assist". Expect: `list_reps`, then `check_configuration`, then `my_sources` with `rep_id` and the "Who am I" lookup with `profile`; the helper confirms the rep before anything is saved; the profile gets all three lines; no check-ins are created; the line reads `off (assisting mode)`; the helper is told none were set up.
10. **No QuickBase label.** `check_configuration` lists no logins. Expect: setup stops with a line to ask the trainer; no lookup runs under the helper's own login.
11. **Profile refresh keeps the assisting lines.** Run "refresh my profile" in an assisting project where the rep gained a county. Expect: Name and Territory/Counties rewritten from the `rep_id` and `profile` calls; Assisting, Assisting rep id and QuickBase profile unchanged; Focus Counties untouched.
12. **Refresh fails closed.** The refresh's `my_sources` call is rejected. Expect: nothing changed, including the three assisting lines, and one line saying the refresh couldn't finish.
13. **Out-of-territory.** In an assisting project, ask to draft an email for a lead in a county that isn't one of the assisted rep's. Expect: the stop line, worded with the rep's name ("isn't one of [Rep]'s counties"), checked against the rep's counties and not the helper's.
14. **Draft voice and sign-off.** Ask for an intro email. Expect: written in the rep's voice, signed with the rep's name and contact, shown as a draft; the Voice question, if asked, is about how the rep writes.
15. **Mail is the helper's.** Ask Claude to check for earlier emails with a buyer. Expect: Claude says the look-up reads the helper's own mailbox, not the rep's, and doesn't present the result as the rep's.
16. **Talking to the helper.** Run any tool. Expect: the helper is never greeted by the rep's first name; the rep is named in the third person.
17. **Check-ins on request.** Ask for check-ins in an assisting project. Expect: task ids end with the QuickBase label, prompts name this project, the rep's first name is used, and "check my setup" doesn't report them missing from the default set.
