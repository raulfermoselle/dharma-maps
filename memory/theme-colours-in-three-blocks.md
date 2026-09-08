---
name: theme-colours-in-three-blocks
description: Define the full light palette on bare :root, then redefine only the tokens under a guarded prefers-color-scheme block and again under [data-theme="dark"] — never give a colour its only definition inside a media block
metadata:
  type: reference
---

Every map handles light and dark the same way, in three blocks and in this order:

```css
:root { /* the complete light palette, every token defined here */ }

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) { /* redefine only what changes */ }
}

:root[data-theme="dark"] { /* redefine again, so an explicit toggle wins */ }
```

Two rules that make it hold together:

- **Never give a colour its only definition inside a media block or a `[data-theme]`
  block.** It will be undefined for some real viewer, and the failure shows up as an
  unstyled or invisible element on someone else's phone rather than on yours.
- **The guard `:root:not([data-theme="light"])` is what lets an explicit light choice beat
  the OS preference.** Without it, a reader who has chosen light gets dark anyway when
  their system is dark.

Also give `body` an explicit background from a token. A transparent body borrows whatever
the host paints behind the page, which is not always what you designed against.

## Reuse the palette, do not invent one

The first map's tokens are the house palette. Later maps should reuse them so the
collection reads as one thing rather than a folder of separate pages that happen to share
a domain. A new map that needs a colour the palette lacks is a reason to extend the
palette, not to start a second one.
