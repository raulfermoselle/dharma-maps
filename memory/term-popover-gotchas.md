---
name: term-popover-gotchas
description: Six sharp edges in the tappable-term and popover system on map 1 — chiefly that button.t zeroes padding and border, so any state layered on it must restore both, and must do so without reflowing the line
metadata:
  type: reference
---

The maps' interactive terms are `button.t` elements carrying a `data-term`, resolved
against a `TIPS` object and rendered into a single `#tip` popover. Six things about that
system cost real time, and all of them fail quietly.

## button.t zeroes padding and border — restore both, deliberately

```css
button.t { font: inherit; ...; border: 0; padding: 0; margin: 0; border-bottom: 1.5px dotted …; }
```

Because it is an element+class selector it outranks a plain `.chip`, so **anything layered
on top of `button.t` loses its padding and its border unless they are set again.** This bit
three separate times: the chip pills lost their padding, then their border, then the lit
state on plain labels had its text jammed against the fill. Treat it as a property of the
component rather than as three bugs.

**And do not restore padding with padding.** These buttons are `inline-block`, so padding
grows the box and reflows the line every time the state turns on — the page twitches
whenever a note opens. Grow the fill *outside* the border box instead:

```css
box-shadow: 0 0 0 5px var(--accent);   /* reads as padding, costs no layout */
```

Verify it by measuring: the button's own width and a neighbour's position should both be
unchanged when the state comes on.

## An undefined custom property silently drops the whole declaration

`color: var(--bg)` looks fine and does nothing, because this page's tokens are
`--ground`, `--panel` and `--card`. There is no `--bg`. The declaration is invalid at
computed-value time and is dropped, which would have left accent text on an accent fill —
invisible. **Read the computed colour back rather than trusting the CSS you just wrote.**

## The popover backdrop dims the whole page

`#tip::backdrop` paints over everything behind the popover. Anything meant to read as
foreground while a note is open — a highlight on the element the note belongs to — is
*behind* that layer by construction, and no amount of styling will lift it. Lighten the
backdrop, or accept that the page recedes.

## Note content is rendered at click time, so listeners must be delegated

Terms named inside a note only exist once that note is built. Handlers attached at load
with `querySelectorAll('button.t')` can never reach them. Bind once on `document` and use
`e.target.closest('button.t')`.

## The popover `toggle` event is queued, not synchronous

Asserting immediately after `hidePopover()` reads the state *before* the handler runs. A
highlight that looks like it survived a close has probably just not been cleared yet. Wait
a tick before measuring, or the test reports a bug that is not there — which happened.

## Every data-term must resolve, in both directions

A renamed term key with a stale `data-term` leaves a button that opens nothing, and it
looks completely normal. Check both ways — no attribute without an entry, no entry never
referenced — after any rename.

**Do not strip whole `<script>` blocks to do it.** That was the earlier advice here and it
is wrong. It was reached for a real reason: the selector string the popover code builds,
`button.t[data-term="…"]`, is otherwise read as an orphaned attribute, a false positive
that appeared the moment delegation was added. But the `TIPS` object lives in that same
block, and **note text carries real, clickable links** — on map 1, 59 of them, 31
distinct. Stripping the script hides every one.

The cost of that was paid: renaming the root delusion `Hatred` to `Anger` left the
`Non-hatred` note pointing at a term that no longer existed, so tapping *hatred* inside it
answered *"No detail recorded for this term."* The checker reported a clean **0 orphans in
both directions** with that dead link live on the page. A checker that cannot see a whole
class of link is not a weak checker, it is a misleading one.

**Exclude the selector specifically instead of the block that contains it.** The two are
distinguishable by quote style, which is a property of the file rather than a coincidence:
note links are written `data-term='X'` in single quotes, because they sit inside
double-quoted `def:`/`ex:` strings, while the JS selector is double-quoted. So scan the
body for `data-term="X"` with scripts stripped, scan the script for `data-term='X'`, and
union the two. Assert the selector count is zero as a guard, so the exclusion is proven
each run rather than assumed.

Then **calibrate it**: plant one dead link in a throwaway copy and confirm the checker
names it and exits non-zero. Give the script a path override argument so calibration never
touches the working file. See [[verify-on-the-live-host]] — a detector that sees nothing
and a page with nothing to see are indistinguishable until you make it see something.
