---
name: what-ships-without-asking
description: Improvements to pages that already exist ship on their own; a new map going public, anything touching the copyright posture, and anything touching credentials wait for the maintainer — and a published slug is a promise
metadata:
  type: feedback
---

The boundary was set with the maintainer deliberately, so that ordinary work does not need
a round trip and consequential work does not happen without him.

## Ships without asking

Fixes and improvements to what already exists: copy and wording, layout, breakpoints,
accessibility, the favicon, the README, in-page navigation, the memory system itself.
Commit it, push it, tell him what changed.

## Show him first, and wait

- **A new map going public.** New material summarising someone's in-copyright book should
  have a human read it before the world can.
- **Anything touching the copyright posture** — attribution, the robots tag, the licence
  stance, the takedown wording. See [[copyright-posture-is-fixed]].
- **Anything touching credentials or authentication.** Report it, never repair it. See
  [[git-identity-is-not-the-default]].

## Never

- **Force-push, or rewrite published history.**
- **Delete the repo, or a published map.**
- **Move a map once its link has been shared.** The slug is the public URL and a shared
  link is a promise; a renamed directory silently breaks every message anyone ever sent
  about that page. Get the slug right the first time and then leave it alone.
- **Make the repo private, or otherwise break a link that is already out there.**
- **Add discovery surfaces** — repo topics, directory submissions, anything that
  advertises the collection. Public and unadvertised is the deliberate position, for the
  reasons in [[copyright-posture-is-fixed]].
- **Republish a map anywhere but this repo's GitHub Pages site** — not as a hosted
  artifact, not on another host. One page, one URL, no route through anyone's corporate
  account.

**Why:** the two categories fail differently. A bad wording change is cheap and reversible;
a broken shared link, a rewritten history, or a copyright change made without the
maintainer is not. The line is drawn at reversibility, not at effort.

**How to apply:** if a change is in the first list, do it and report it. If it is in the
second, do everything around it, then stop and ask. If it is in the third, do not do it —
including when a tidier structure is obviously available.
