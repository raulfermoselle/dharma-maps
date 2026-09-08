---
name: phone-first-and-measure-the-render
description: 390 CSS px is the design target and length is the real mobile constraint — plus the exact preview sequence that works, the two viewport tools that report success while doing nothing, and the one query that settles an overflow question
metadata:
  type: project
---

**390 CSS px is the design target.** Almost everyone reads these on a phone.

**Length, not width, is the real constraint.** The first map measures 9,404 px at that
width — 11.1 phone screens. Width problems are easy to see and easy to fix; the thing
actually standing between a reader and the material is how far they have to scroll.

## The preview sequence that works

Use the **chrome-devtools** tooling, in this order. Set the emulation once — it survives
reloads, so the edit loop stays fast.

1. **`new_page`** on the local `file://` URL of the map. **`file://` works here.** It is a
   browser *extension* driving your everyday browser that refuses `file://`, not this
   toolchain — do not confuse the two and conclude local preview is impossible. Keep the
   `pageId` it returns; `list_pages` recovers it.
2. **`emulate`** with viewport `390x844x3,mobile,touch`. **`emulate` is the tool that
   works.**
3. **Read the viewport back before trusting it** — `evaluate_script` returning
   `window.innerWidth` must say `390`. Not optional; see below.
4. **`navigate_page`** type `reload`, `ignoreCache: true` after each edit.
5. **`take_screenshot`** with `format: "jpeg"`, `quality: 80`, and an explicit `filePath`.

## Two viewport tools report success while doing nothing

**Never use `resize_page` to get a phone viewport.** Called for 390x844 it returned success
while `window.innerWidth` stayed **1249** and every grid stayed multi-column. The
claude-in-chrome extension's `resize_window` lies identically — "Successfully resized to
406x900" with `innerWidth` still **2560**.

**Resizing a window is not emulating a device**, and the tool that only resizes will not
say so. This is the general rule from [[verify-on-the-live-host]] arriving from a third
direction: the report and the effect are separate facts.

## The query that settles an overflow question

```js
[...document.querySelectorAll('*')]
  .filter(el => el.getBoundingClientRect().right > window.innerWidth)
```

On the first map this returns **zero elements**, confirmed independently at 390 px. That is
the measurement of record.

**Do not use `scrollWidth` comparisons.** They produced five phantom overflows on that same
page — the medallion's decorative rays (`inset: -6%`, behind a mask) plus subpixel rounding
— and very nearly cost a hunt for a bug that did not exist. A detector that fires on a
clean page is worse than no detector, because you then "fix" what was never broken.

**Why:** eyeballing a screenshot cannot separate "fine" from "slightly broken", and an
uncalibrated detector will confidently report either. Measuring the render is the only step
that yields an answer worth acting on.

**How to apply:** before claiming a layout is clean at phone width, run the query and quote
the count. Before claiming a viewport is emulated, quote `innerWidth`. And send the result
to the maintainer as you go — see [[screenshots-are-the-only-preview-channel]].
