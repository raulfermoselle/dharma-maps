---
name: mind-map-length-is-the-open-problem
description: Two known, non-obvious open items on the first map — a sticky jump-nav that was deferred rather than rejected, and a breakpoint that makes 360px and 390px phones disagree
metadata:
  type: project
---

Two things about the first map that are not visible from the code and would otherwise have
to be rediscovered.

## The jump-nav was deferred, not rejected

A sticky in-page navigation for the map's four main sections was proposed and the
maintainer **deferred** it. That distinction matters: it is worth offering again, and it
would be wrong to treat the absence of one as a settled design decision.

Eleven phone screens of scrolling is the single biggest thing between a reader and this
material ([[phone-first-and-measure-the-render]]). The change is additive and does not
alter how the page looks on a desktop.

## A breakpoint that makes phones disagree

The two-column grid on the map's consciousness section breaks at `max-width: 380px`. The
practical effect is that a 390px-wide phone keeps two columns while a 360px one drops to
one — two very ordinary phones rendering that section differently. Nudging the breakpoint
to `400px` would make them agree, at the cost of one column on the wider phone.

Not obviously wrong as it stands, which is why it is recorded rather than fixed.

**Why:** both are the kind of thing that looks like a deliberate choice from the outside
and would be quietly preserved by anyone who did not know the history.

**How to apply:** offer the jump-nav again when there is a natural moment. **Delete this
memory once both items are settled** — a to-do list that outlives its items is not a
memory worth keeping.
