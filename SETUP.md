# Bliss Sales Rep setup

Follow these steps in order. Your trainer provides your QuickBase token and your personal registry connector URL. Do not share either.

1. Account
   - If your trainer invited you to a Business account, accept the invite.
   - Otherwise, sign in to your Pro account, turn off "help improve Claude" in settings, and verify it is off.
   You should now see your Claude account home.

2. Desktop app
   Install the Claude desktop app for Windows or Mac, open it, and open Cowork.
   You should now see Cowork.

3. Code-execution network access
   In Cowork settings, enable network access for code execution so Lead Finder can download public PDFs when needed. If this setting is unavailable, ask your trainer before continuing.
   You should now see network access enabled for code execution.

4. QuickBase extension
   Go to Settings → Extensions → Advanced. Install `quickbase-mcpb.mcpb`, then follow its prompts with your own QuickBase user token and realm/app details from your trainer. Start a fresh chat after installation.
   You should now see the QuickBase extension connected. If you do not have it yet, the public tools still work; QuickBase tools will say they are unavailable.

5. QuickBase setup file
   Your trainer gives you one private file alongside your QuickBase token. Add it to your Cowork project the same way you'd install any other skill package on your machine. Never share this file — it holds real QuickBase configuration and is never linked or posted anywhere public.
   You should now see the file in your project.

6. Registry connector
   Go to Settings → Connectors → Add custom connector. Paste your personal connector URL, choose **No sign-in**, then connect. On a Team plan, the owner adds it and you click Connect.
   You should now see the registry connector connected. If you skip it, Lead Finder still uses public web search.

7. Skills
   Create a Cowork project named Bliss Sales Rep. In its message box, paste:

   ```
   Set yourself up using https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/CLAUDE.md
   ```

   You should now see Claude checking your connections and setting up your profile and tools.

8. Profile
   Confirm your name, counties, product focus, and notes. Counties come from the registry connector when it is connected; otherwise Claude reads your QuickBase county assignments. You only confirm or correct what it found.
   You should now see your saved profile.

9. Smoke test
   Ask: "What's new in my counties?"
   You should now see a short list or "nothing new." If not, check that you are in the Bliss Sales Rep project, the registry connector is connected when you expect it, and your territory has finished loading. If that does not fix it, text your trainer.

## What we do not do

We do not send email, write to QuickBase, or store a rep's QuickBase token on the registry connector. The connector reads public government sites and the rep's assigned territory only.