# PDF fallback ladder — when `read_source` can't parse a document

Read this when `read_source` returns any of these literal strings:

- `scanned PDF: download it and read the page images`
- `large PDF: open it yourself`
- `PDF couldn't be read here: download it and extract the text` (live: the connector returns this
  today)
- `no readable text` — this is `read_source`'s empty-body result, and the same reason shows up in
  `lead_scan`'s footer as `Couldn't read: <url> - no readable text; open it yourself`.
- WebFetch returns binary, "can't parse", or a saved-file note for a PDF.

For a WebFetch PDF fallback, first retry the same URL through `read_source` with a query.

1. **If the session has code execution, download the PDF and extract its text.** Many of these have a text layer the
   server can't parse, and the extraction works fine. If there is no code execution, put the PDF straight on the
   closing "Couldn't read these, open them yourself" list as "PDF not readable here".
2. **If the extracted text is empty, read the page images** instead — render the pages and read them.
3. **Only then** put it on the closing "Couldn't read these, open them yourself" list.

**`no readable text` forks on the link type:**
- **A PDF link** — treat it exactly like the strings above: run the same download → extract → page-image
  ladder, under the same 3-download cap.
- **A non-PDF page** (an HTML page with no extractable text) — there's nothing to download or extract; it
  goes straight to the closing "Couldn't read these, open them yourself" list.

**Respect the site's robots.txt, always.**
- **The connector refused for robots:** if `read_source` or `lead_scan` says the site's robots.txt disallows the path (live wording: `robots.txt for <site> disallows this path; open it yourself`), don't download it. It goes straight to the closing list. The rep can open it in their browser.
- **Before any download above:** fetch `https://<site>/robots.txt` first. If it disallows that path for all automated readers (`User-agent: *`), don't download; put it on the closing list instead.
- **Never work around a robots block.**

**Cap it at 3 downloads per run** so one big territory doesn't stall the scan. Anything past the third
download goes straight to the closing list, no attempt — and say that the cap was hit, so the rep knows the
list is longer for that reason.
