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
Make the change and tell him what changed — but see the next section on when to commit it.

## Commit when asked, not after every edit

**Making a change and committing it are two separate decisions.** The list above says what
is yours to change. It does not say to commit each change as you finish it.

**Work in the working tree, and commit when the maintainer asks.** He asked for this
directly, and the reason is that a commit is not cheap here: every push triggers a Pages
build, and verifying the change actually reached the live host means waiting for that
build. Ten edits committed one at a time is ten rebuilds and ten waits; the same ten
committed together is one. During a working session that difference is most of the elapsed
time, and it is time he spends watching rather than steering.

**So batch, and keep him oriented instead:** say what is now in the working tree and
uncommitted, so nothing is invisible while it waits. Verify each change locally as you go —
the preview loop in [[phone-first-and-measure-the-render]] does not need a commit — and
save the live-host verification in [[verify-on-the-live-host]] for the push at the end.

**The exception is losing work.** If a session is ending, or a change is large enough that
losing it would hurt, say so and ask — memory is only as durable as what has been pushed
([[memory-lives-in-this-repo]]).

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
