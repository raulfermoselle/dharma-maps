---
name: pages-make-zero-external-requests
description: Every map inlines its CSS, JS, fonts and images so it fetches nothing at all — which is why it will render in ten years and why nobody gets a log of who read it; the font and favicon consequences follow from it
metadata:
  type: project
---

A map fetches **nothing**. No CDN, no web fonts, no analytics, no external images. CSS and
JS are inlined, images are embedded as data URIs, typography uses system font stacks.
Verified against the live host: the first map issues zero external requests.

Two things this buys, and both are the point rather than a side effect:

- **It will render identically in ten years.** Nothing to rot, no dependency to go away, no
  build step to become unreproducible. Open the file straight off a disk and it works.
- **Nobody gets a request log of who read it.** No third party learns that someone opened
  a page about Buddhist psychology. For a page shared privately among friends, that
  matters more than a typeface does.

**Do not trade this away for a font, an icon set, or a chart library.** If a page seems to
need one, embed it or do without it.

## The font consequence: accept it, do not fix it

System font stacks mean the page genuinely looks different per platform. iOS may resolve a
handsome old-style serif; Windows falls through to something more ordinary. That is the
price of the guarantee above and it is worth paying.

Embedding a base64 serif is possible if the maintainer ever asks for it — a few hundred KB
on top of a page currently measured in tens of KB. His call, not a keeper's.

## The favicon consequence: draw it, do not reach for an emoji

The favicon is a **drawn SVG data URI**. An emoji favicon depends on the viewer having an
emoji font: it renders differently on every platform and can render as nothing at all on a
bare Linux box.

Declaring `rel="icon"` also stops the browser making an automatic `/favicon.ico` request,
which would 404 — the domain root belongs to the hosting platform, not to this collection,
so there is nothing there to serve.

Match the icon to the page it belongs to; the first map's is a disc, ring and centre
echoing the medallion on the page itself.

**Why:** the promise a map makes is that it keeps working and keeps quiet. Both are broken
by a single external request, and neither breakage is visible while you are looking at the
page on your own machine.

**How to apply:** after any change that adds an asset, confirm the page still fetches
nothing — load it and check the network panel is empty, and check it again on the live host
per [[verify-on-the-live-host]].
