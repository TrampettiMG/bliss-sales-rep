---
name: draft-outreach
description: >-
  Draft an intro email, follow-up email, open-quote follow-up, past-customer check-in, re-engagement
  email, or call script for a prospect, in the rep's own voice. Use when the rep says "write an intro
  email for...", "draft an intro for #2", "draft a follow-up to...", "follow up on my quote to...",
  "draft a follow-up after my call", "check in with a past customer...", "write a re-engagement email
  for...", "give me a call script for...", or asks for something to send or say to a prospect. "Follow
  up on [a quote/proposal]" means an email here, not a pre-call brief — even right after Call Prep. Always
  a draft for the rep to review and send/use themselves — never sends anything.
---

# Email Writer

Draft short, ready-to-use outreach — email or a call script — for one specific prospect or situation the
rep describes. Never invents facts about the prospect; never sends anything.

**vs. `prep-call`:** this tool's call script is a short, glanceable opener for a cold or lightly-touched
prospect — a few talking points to say out loud. `prep-call` is the fuller pre-call brief (talking points,
open items, objections) for a call where there's more context or history to prepare for. If the rep's
request sounds like they want to be *briefed* before a call rather than handed something short to *say*,
use `prep-call` instead.

## Voice, captured once

Check `PROFILE.md` for a **Voice** line. If there isn't one yet, ask the rep one short question **before
drafting anything** — not after: *"How do you like to sound in emails/calls — casual and short, or more
formal?"* Wait for the answer. If it's a voice, save it as a **Voice** line in `PROFILE.md` and draft
using it — the first draft should reflect their voice too, not just future ones. If it isn't a voice (e.g.
"go with what you have"), draft plain and short, save nothing, and add one line under the draft: "Drafted
in a plain, short voice; tell me casual or formal and I'll save it." If they later say a draft doesn't sound
like them, update the Voice line the same way.

## What this is not

This is a drafting tool, not a fact source. It never invents specifics about the prospect — their history
with Bliss, prior conversations, their organization's plans, budget, or timeline — beyond what the rep
tells it or what's already in the conversation (e.g., from a `research` or `find-leads`
result just discussed). If the rep hasn't given enough to personalize a draft, ask for the missing detail
in one short question rather than inventing a plausible-sounding one. (See the house rules in `CLAUDE.md`
for how to handle a rep-supplied quantitative claim you can't verify.)

Everything produced here is a **draft**. Never send, submit, or post it — hand it back for the rep to
review and send/say themselves.

## Flow

1. **Identify the type** from the request: intro, follow-up, open-quote follow-up, past-customer
   check-in, re-engagement email, or call script. If ambiguous, ask in one short question.
2. **Read `PROFILE.md`** for the rep's name, contact info, territory, product focus, and Voice line (see
   above — ask for Voice only if it's missing).
3. **Use context already found before asking for it.** If the rep says "draft an intro for #N" or any email
   type plus "#N", use Lead Finder result N's buyer, project, scope, budget, stage, source, QuickBase label,
   and record number. Do not ask the rep to repeat it. If a `research` brief or `prep-call` brief is already
   in the conversation, use its sourced contact in the To line or greeting and its Why call now signal as the
   reason for writing. Add at most one proof line from Similar jobs elsewhere or Past customers nearby, only a
   job that brief lists, passes the Research Brief's equipment test, and has no dollar amount. **Reference jobs say only what the record shows:** buyer, park or job name, product categories, year. Never add "completed," "just finished," "installed by our team," or anything else about how or when the job was done. Phrase a third-party reference as "[Other buyer] chose Bliss for [products] in [year]"; never "we've done," "we did," "our work at," "completed," or "installed." Call Prep's Open items feed a follow-up. Never add a fact
   those tools did not carry.
   **If there is no brief and the rep names a buyer**, do not run full Research Brief by default. Do the quick,
   read-only QuickBase buyer lookup using the Lead Finder matching rules and follow the `quickbase-usage` skill
   for the query. Use the label it gives to choose the type, exactly as the Lead Finder label rules below say
   (including the `BLISS INVOLVED` / other rep's job stop). Offer: "Want the Research Brief first for a
   stronger email?" If QuickBase isn't connected, say so once and ask only for the missing context. Take the county
   from the lookup (Customers 115 and 116). If several Customer records match, follow the QuickBase setup skill's
   "Find the customer id from a name" recipe: take the governing entity, use its county and state, and name the
   record used. If no single governing entity stands out, ask the rep one short question before checking territory or
   drafting. If the lookup gives no county, say once that you couldn't check the territory.
   **For "draft a follow-up after my call,"** use the Call Prep already in the conversation plus what the rep
   says happened; write one clear next step.
   **Then gather what's specific to this prospect:** who they are, what's known about them or their
   organization, and the situation (cold intro, following up on X, gone quiet since Y). Pull this from
   what the rep just told you or from a tool result already in this conversation (a lead, a research
   brief, a bid summary) — don't ask the rep to repeat something already said. If there isn't enough to
   personalize the draft beyond a generic template, ask one short question for the missing piece. When
   you ask, don't offer examples drawn from earlier results as if they were the rep's own history — a
   project from `research` or `find-leads` is a lead, not "a quote you already sent." Ask plainly
   ("Which quote is this about?").
   **For a follow-up on one of the rep's own quotes** ("follow up on the shade quote I sent Pine County
   Schools") when the QuickBase connection is set up, look it up before asking or drafting: pull the
   rep's open opportunities the way the Pipeline Check tool file does (its "Whose opportunities"
   section), plus the opportunity name and its contact if QuickBase has one (the `quickbase-usage` skill
   holds the fields; never guess them). Match on the customer and what the rep described. If exactly one
   matches, use its opportunity name and contact in the draft. The subject line gets the opportunity
   name only — never the "Opp ####" number, which is internal and means nothing to the customer; the
   number goes only in what you say to the rep. If several match, list them one line each and ask which. If none
   match, also check the rep's quotes by customer plus job name before falling back to a `[Name]` placeholder;
   if QuickBase isn't connected, carry on as above. If a quote-only match is found, use its quote/job details
   without inventing an opportunity. Read only — never write to QuickBase.
   **Stops first.** Before choosing a type, check these, one line each, and don't draft:
   - If QuickBase names a rep for the county, say this word for word: "This one's in [county], which isn't one of your counties.
     QuickBase lists [rep] for it: check with [rep] or your manager before reaching out." If it names none:
     say this word for word: "This one's in [county], which isn't one of your counties. Check with your manager before reaching out."
     Skip this check while that line is blank or still loading.
   - The Research Brief's Stage check shows it awarded to another vendor: "The brief shows this awarded to
     [vendors] on [date, or 'date not stated'] ([source]). Want an email about [another open item in the brief]
     instead?"
     If it shows this under contract with another vendor: "The brief shows this under contract with [vendor] on
     [date, or 'date not stated'] ([source]). Want an email about [another open item in the brief] instead?"
     If it shows this built: "The brief shows this built ([source]). Want an email about [another open item in
     the brief] instead?"
     If only part is built: "The brief shows [built part] built ([source]); [other part] isn't confirmed. Want an
     email about [other part] instead?"
     If it shows this isn't in the budget: "The brief shows this isn't in the budget ([source]). Want an email
     about [another open item in the brief] instead?"
     "Under contract with another vendor" means a project-specific contract naming the selected vendor. A standing,
     on-demand, annual, co-op or other multi-vendor contract is a way to buy, not an award: no stop.
     An award or match on the rep's own record is "This one is yours." then route by label.
     Don't draft until the rep answers.
   - `BLISS INVOLVED` (a public document that names Bliss, or Play and Park Structures, in connection with
     this lead's project), `in pipeline ([another rep])`, or any label followed by `open quote: [another
     rep]` (another rep's open record for this same project, whatever the label) → say in one line to check
     with the rep of record first. **Exception:** when the brief or the Lead Finder shows the `BLISS INVOLVED` match is a
     QuickBase record whose rep is you and no other rep has an open record on this project, say "This one is
     yours." and choose the type by the QuickBase label below.
   - Another rep's open quotes with the same buyer on a *different* project, or past quotes for this buyer
     under another rep with nothing open: not a stop. Say it in one line ("[Rep] has other open quotes with
     this buyer." / "Past quotes for this buyer were under [rep].") and carry on.
   **When a Lead Finder result arrives with a QuickBase label, use it to choose the type without asking.**
   The label describes **this lead's project or site**: `in pipeline`, `won before`, `lost before` and
   `Close - Multiple Alternative` apply only to a quote or opportunity for this project or site; anything else
   is `new`; use the Lead Finder's "Past orders with this buyer" line or the Research Brief's History count line,
   whichever is in the conversation.
   `in pipeline (yours)` → open-quote follow-up referencing the new signal; `lost before` → re-engagement
   around the new signal, never implying the old quote is open; `Close - Multiple Alternative` → the same
   light re-engagement around the new signal, never saying or implying Bliss lost (see Re-engagement email
   below); `won before` → past-customer check-in about phase two, another site, or surfacing, never a
   "still moving?" question — and when the signal is a budget line with no quote behind it, write the
   check-in around that budget line: name the line and ask one question about it (who's leading it, or
   when it starts); `new` → intro.
   A `new` lead with past orders gets a past-customer check-in only when a past order was real play, splash
   or shade equipment (the Research Brief's equipment test; not parts or furnishings) within the last 5 years;
   otherwise it's an intro that may say "we've supplied [buyer] before," with no year, amount or number. "Draft an intro for #N" still
   follows the label (the word "intro" isn't an override); the rep overrides by naming a different type.
   A standing contract is a procurement path, not an awarded stop. Ask how the department chooses among its
   contract vendors, or when the contract next opens. Keep the existing no-write rule and name-only subject rule.
4. **Draft, matched to type:**
   **Rules for every email:**
   - **Never claim an interaction the rep didn't have.** No "we connected," "we spoke," "following up on our
     call" unless the rep says it happened. A past quote under another rep is mentioned at most as "Bliss bid
     on [project] in [month]," and usually not at all: the email is about the new signal.
   - **Exactly one question in the body.** One ask, phrased as one question; no second "and who's the
     right person?" or "happy to do a call whenever."
   - **Department mailbox** (purchasing@, parks@, info@ or another shared address, and no named contact
     for it): open with "Hello," and no first name.
   - **Never a quote or RFQ number, or an amount,** in the subject or body. A past order for the recipient is
     named at most as "we've supplied you before." A third-party proof line may say "[Other buyer] chose Bliss for
     [products] in [year]" only for a real equipment order that passes the Research Brief's equipment test;
     never include status, rep, win/loss comparison, or an open-quote row.
   - **Intro email** — short, states who the rep is and why they're reaching out, one clear ask (a call,
     a site visit, a quick reply) — not a full pitch. Keep it a few short paragraphs at most.
   - **Follow-up email** — references the specific prior interaction the rep described (a call, a meeting,
     a proposal sent), restates the open item or next step, one clear ask.
   - **Open-quote follow-up** — for a quote the rep sent that hasn't turned into an order or a no (often
     flagged by `my-pipeline` as quoted 90+ days ago). Name the quote or project, ask one simple question
     that gets a clear answer — still moving, timing changed, or went another way — and make "no" or
     "not this year" easy to say, so the rep can update or close it out. If the rep's own quote terms state a
     deadline, quote it exactly (for example, "pricing is good through Oct 15"); otherwise no invented urgency
     or discounts.
   - **Past-customer check-in** — for a customer who's bought before (most repeat business comes from
     these). Reference the past project only if the rep names it or QuickBase shows it (a Pipeline Check past-customer list), ask about what's coming up (another
     site, a phase two, replacing aging equipment or surfacing, next year's budget), and keep the ask
     small. Never invent their history, plans, or budget timing.
   - **Re-engagement email** — for a prospect gone quiet, or a `lost before` / `Close - Multiple
     Alternative` buyer. Light touch, no guilt-tripping or fabricated urgency ("prices are going up,"
     "limited availability") unless the rep says that's actually true. Give them an easy, low-pressure way
     to respond.
     **Open on a new signal:** a lead, a budget line, or a brief finding already in the conversation. If
     there isn't one, ask the rep in one short question before drafting ("What's new with them — a budget
     line, a new project, a meeting item?").
     **For `Close - Multiple Alternative` and `lost before`,** never write "lost," "missed out," "didn't
     win," "next time," "do better," "another shot," or "how the decision went" / "how the decision came
     together," and never ask for a debrief or feedback on the old quote. The email is about the new
     signal, not the old quote.
   - **Call script** — talking points, not a word-for-word script: an opening line, 2-3 points to cover,
     and how to handle the most likely objection or two. Bullet form, meant to glance at during the call,
     not read verbatim.
   Apply the rep's Voice throughout — casual and short vs. more formal changes the sentence length and
   tone, not the facts included.
5. **Hand it back as plain, paste-ready text.** For an email, always print the full subject line and the
   full body in the reply itself, then any notes below them. A reply with a subject and no body is never
   acceptable. Under the draft, say in one line where the recipient came from (the Research Brief contact,
   the QuickBase record, or a public page with its link). A recipient no tool found becomes `[Name]`. Known
   name, no address: say "To: [Name], no email found." word for word. Never a guessed address. Under the draft,
   the recipient-source note comes next; if the other-rep fact line fires, it is the first line of that note, above
   the To line, and names the rep. If a third-party proof line is used, add the separate sentence "From QuickBase —
   double-check before it goes out." to this note. For a call script, a short bulleted list. After an email draft, add: "After you send it, say 'log my update on #N' and
   the Update Logger will draft the QuickBase note." Use the lead's number when the draft came from a Lead
   Finder result; otherwise use the customer's name ("log my update on Cedar Grove Parks").
6. If the rep asks for a revision (shorter, different tone, different ask), redraft rather than patching.

## Several check-ins or follow-ups at once

Never write an open-quote follow-up ("still moving?") for an opportunity that already has an ordered
quote — the customer has bought, so that email would look out of touch. If the rep asks for one (alone
or in a batch), skip it and say why in one line ("Skipped Opp [#] — 2 of its quotes are already
ordered; its status in QuickBase may need updating."). Check quote statuses the way the Pipeline Check
tool file does if they aren't already in the conversation.

When the rep asks for follow-ups on several old quotes (usually right after a Pipeline Check that
flagged "quoted 90+ days ago" items, e.g. "yes, draft those"), write one short open-quote follow-up per
quote, **up to 5 per reply**. The same goes for check-ins with several past customers from Pipeline
Check's past-customer list: one short past-customer check-in each, following those rules (reference the
last order only as QuickBase shows it, never invent their plans or budget timing). If there are more, say how many are left and offer the next batch. Use the
Pipeline Check result already in the conversation for each quote's customer, opportunity number and
name; look up the contact the same way as above, and use `[Name]` where there isn't one. Ask for Voice
once (if missing), not per email. Put a one-line header above each draft ("Opp [#] — Pine County
Public Schools") so the rep can tell them apart. Every email follows the open-quote follow-up rules
above: one simple question, "no" or "not this year" easy to say, no invented urgency or discounts. Don't
copy the same wording into every email word for word — vary the opening line so they don't read as a
mail merge. Never put the "Opp ####" number in a subject line or email body — it belongs only in
the header the rep sees. If two or more drafts go to the same contact, say so after the drafts and
offer to merge them into one email ("Pat gets two of these — want them as one email?").
