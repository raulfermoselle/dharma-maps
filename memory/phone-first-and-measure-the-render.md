---
name: phone-first-and-measure-the-render
description: 390 CSS px is the design target and length is the real mobile constraint, not width — plus the local preview loop, the two tools that quietly lie about it, and the one query that actually settles an overflow question
metadata:
  type: project
---

**390 CSS px is the design target.** Almost everyone reads these on a phone.

**Length, not width, is the real constraint.** The first map is roughly 9,400 px tall —
about eleven phone screens. Width problems are easy to see and easy to fix; the thing
actually standing between a reader and the material is how far they have to scroll.

## The local preview loop

1. Edit the file.
2. Open it in a browser-automation tool that accepts `file://` URLs and device emulation.
3. Emulate a phone viewport — `390x844`, device pixel ratio 3, mobile, touch.
4. Reload after each edit. The emulation survives a reload, so this stays a fast loop.

**A browser extension that drives your own everyday browser will typically refuse
`file://` URLs.** That is a sandbox rule, not a bug to work around — use a devtools-protocol
tool for local files and save the extension for the live site.

## Two tools that report success without doing anything

- **Resizing a window is not emulating a device.** One tool reported "successfully resized
  window to 406x900" while `window.innerWidth` stayed at 2560. **Always read back
  `innerWidth` before trusting a viewport.**
- **A tool reporting success is not evidence that it worked.** This is the same lesson as
  [[verify-on-the-live-host]], and it keeps arriving from new directions.

## The query that settles an overflow question

Ask whether anything actually paints past the viewport:

```js
[...document.querySelectorAll('*')]
  .filter(el => el.getBoundingClientRect().right > window.innerWidth)
```

On the first map this returns **zero elements**, and that is the measurement of record.

**`scrollWidth` comparisons do not settle it.** They flagged five overflows on that same
page which all turned out to be phantoms: a decorative element inset negatively behind a
mask, plus subpixel rounding. A detector that fires on a page with nothing wrong is worse
than no detector, because you then "fix" things that were never broken.

**Why:** eyeballing a screenshot cannot distinguish "fine" from "very slightly broken",
and a detector calibrated against nothing will confidently report either. Measuring the
render is the only step that produces an answer you can act on.

**How to apply:** before claiming a layout is clean at phone width, run the query above
and quote the count. Before claiming a viewport is emulated, read back `innerWidth`.
