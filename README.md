# Dharma Maps

Structural maps of Buddhist teachings, kept in git so they can be corrected over time.

Each map is a single self-contained HTML page — no build step, no dependencies, no
JavaScript beyond what the page needs for its own term definitions. Open any of them
straight from disk and they work.

**Live:** https://raulfermoselle.github.io/dharma-maps/

## The maps

| Map | Subject | Source |
|---|---|---|
| [The Mind & Its 51 Mental Factors](mind/) | What mind is, how it is built, how it knows, how it is transformed | Geshe Kelsang Gyatso, *How to Understand the Mind* (Tharpa Publications) |

## What these are, and what they are not

These are **a reader's maps, not sources.** Each one summarises a book and names it
plainly. They carry no authority of their own.

- **Not affiliated with, reviewed by, or endorsed by** any publisher, teacher, centre or
  tradition — including, for the map above, Tharpa Publications and the New Kadampa
  Tradition.
- **No substitute for the books.** A map shows you the shape of a teaching; it cannot
  give you the teaching. Read the originals.
- **Quoted definitions remain the copyright of their authors and publishers**, reproduced
  here only in brief and only for private study and discussion.
- Any error in a map is the compiler's, not the author's.

**If a rights holder would like a page amended or taken down, that will be done on
request.** Open an issue or make contact and it will be handled.

## Why there is no LICENSE file

Deliberate. These pages summarise material that is still in copyright, so there is no
licence here to grant — publishing this under MIT or CC would be claiming a right over
someone else's work. Absent a licence, default copyright applies: please don't
redistribute these as your own, and do go and buy the books.

## Source material is not in this repo

By design, and it is not negotiable. The books these maps are drawn from are in
copyright and live **outside** this folder. No PDFs, no scans, no OCR'd text, no
long-form extracts. `.gitignore` refuses those file types as a safety net, but the real
rule is that they never come near this directory in the first place.

## Adding a map

1. Write the page as one self-contained `.html` file — inline the CSS and JS, embed any
   images as data URIs. No CDNs, so nothing rots.
2. Put it at `<slug>/index.html` so its URL is stable and clean.
3. Include `<meta name="robots" content="noindex, nofollow, noarchive, nosnippet">`.
   These pages are meant to be shared by link, not found by search — which respects both
   the copyright position and the fact that a summary shouldn't outrank the book.
4. Name the source, the edition and the publisher on the page itself, and carry the same
   notice as above.
5. Add a row to the table and a card to the root `index.html`.
