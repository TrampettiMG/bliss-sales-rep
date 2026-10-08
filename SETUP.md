# Bliss Sales Rep setup

Follow these steps in order. Your trainer sets you up on a call and gives you your QuickBase token and your registry key then. Do not share either.

1. Account
   Accept the invite to the Bliss Claude organization from your trainer and sign in with that account.
   You should now see your Claude account home.

2. Desktop app
   Install the Claude desktop app for Windows or Mac, open it, and open Cowork.
   You should now see Cowork.

3. Code-execution network access
   In Cowork settings, enable network access for code execution so Lead Finder can download public PDFs when needed. If you can't find it, tell your trainer.
   You should now see network access enabled for code execution.

4. QuickBase extension
   Go to Settings → Extensions and find QuickBase in your organization's list. Install it, then enter your own QuickBase user token and the realm/app details from your trainer. Start a fresh chat after installation.
   You should now see the QuickBase extension connected. If you do not have it yet, the public tools still work; QuickBase tools will say they are unavailable.

5. QuickBase skill
   The QuickBase skill (`quickbase-usage`) comes from the Bliss organization. There is nothing to download or install. If Claude later says the QuickBase skill isn't available, tell your trainer.
   You should now see nothing to do for this step.

6. Registry connector
   1. In Claude Desktop, go to Settings → Connectors → Add custom connector.
   2. Name: `Bliss Lead Registry`
   3. URL: `https://bliss-lead-registry.trampetti.com/mcp`
   4. Leave every other field blank. Click Add.
   5. Claude opens a web page titled "Bliss Registry: enter your key".
   6. Paste the key your trainer gives you during your setup call. You only do this once.
   7. Click Connect.
   8. You land back in Claude with the connector connected.
   9. Test it. Open a new chat and ask Claude: "run my_sources".
   10. You should see the counties you cover.
   11. If you see "Your territory isn't set up yet", tell your trainer.

   The connector gives Claude its lead tools, including `my_sources`, `read_source` and `lead_scan`.

   If something goes wrong:
   - The page says the link expired: start again from step 6.1 above.
   - The page says "Paused by Trampetti": the tool is paused. Try again later.
   - Your key doesn't work: ask your trainer for a new one.

   Still stuck? Contact Nick Ambrose first, then Mike Trampetti.

   You should now see the registry connector connected. Lead Finder needs it: without it, Lead Finder says so and stops.

7. Skills
   Create a Cowork project named Bliss Sales Rep. Then, in its message box, paste:

   ```
   Set yourself up using https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/CLAUDE.md
   ```

   You should now see Claude checking your connections and setting up your profile and tools.

8. Profile
   Confirm your name, contact, counties, and (optionally) your product focus. Counties come from the registry connector. If it says your territory isn't set up yet, Claude leaves counties as loading; say "refresh my profile" once your trainer confirms it's ready. You only confirm or correct what it found.
   You should now see your saved profile.

9. Automatic check-ins
   Claude sets these up for you:
   - **A daily run** every weekday at 7 AM: new leads, who to call (name, phone, website), today's follow-ups, and bid deadlines this week
   - **A pipeline check** every Monday at 8 AM and Friday at 5 PM
   - **A profile refresh** every Monday at 6:30 AM
   - **A setup check** every Monday at 6 AM. It tells you only if something needs fixing.

   They run while the Claude app is open on your computer. If it's closed at that time, they run the next time you open it.
   You should now see "I set up your automatic check-ins…". To change them later, say "change my check-in times" or "turn off my check-ins."

10. Smoke test
   Ask: "What's new in my counties?"
   You should now see a short list or "nothing new." If not, check that you are in the Bliss Sales Rep project, the registry connector is connected when you expect it, and your territory has finished loading. If that does not fix it, text your trainer.

## What we do not do

We do not send email, write to QuickBase, or store a rep's QuickBase token on the registry connector. The connector reads public government sites and the rep's assigned territory only.