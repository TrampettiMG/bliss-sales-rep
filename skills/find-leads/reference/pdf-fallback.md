# PDF fallback ladder — when `read_source` can't parse a document

Read this when `read_source` returns either literal string:

- `scanned PDF: download it and read the page images`
- `large PDF: open it yourself`

Both mean "the server can't parse this one, you try". For either, before giving up:

1. **Download the PDF and extract its text** (CoWork code execution). Many of these have a text layer the
   server can't parse, and the extraction works fine.
2. **If the extracted text is empty, read the page images** instead — render the pages and read them.
3. **Only then** put it on the closing "Couldn't read these, open them yourself" list.

**Cap it at 3 downloads per run** so one big territory doesn't stall the scan. Anything past the third
download goes straight to the closing list, no attempt — and say that the cap was hit, so the rep knows the
list is longer for that reason.
