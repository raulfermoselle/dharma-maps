---
name: copyright-posture-is-fixed
description: The reasoning behind the three copyright rules — no source material, noindex everywhere, prominent attribution with a takedown offer that is actually honoured — and why there is deliberately no LICENSE
metadata:
  type: project
---

These maps summarise books that are still in copyright. The whole collection is only
defensible because of a posture that was reasoned out deliberately, and each rule has a
reason worth knowing before anyone is tempted to relax it.

## No source material in the repo

Not the books, not scans, not OCR'd text, not long-form extracts, not a temporary copy
that will "come out before the commit". The books belong to their publishers, and a git
history is permanent and replicated to every clone — a file removed in a later commit is
still there. `.gitignore` refuses the obvious file types, but treat that as a safety net
rather than the plan. The plan is that source material lives outside the repo entirely
and never comes near it.

## Every page carries noindex

```
<meta name="robots" content="noindex, nofollow, noarchive, nosnippet">
```

Three separate reasons, all real:

- A summary should never outrank the book it summarises in search results.
- `noarchive` and `nosnippet` stop quoted material persisting in a search cache after a
  page has been taken down — without them, honouring a takedown would not actually remove
  the quotes from the internet.
- It keeps the whole thing quiet, which is what everyone involved would prefer.

The same logic rules out every other discovery surface: no repo topics, no submitting the
site anywhere, no announcing it. The repo is public because the alternative is worse for
a page meant to be shared by link, not because the collection wants an audience.

## Attribution, and a takedown offer that is real

Every map names its author, publisher, edition and ISBN; states plainly that it is an
unofficial study aid with no affiliation, review or endorsement; marks quoted definitions
as remaining their publisher's copyright; says it is no substitute for the book; and
offers to amend or take the page down on a rights holder's request.

**If that offer is ever taken up, honour it immediately and tell the maintainer.** It is
the single thing most likely to keep a rights holder from escalating, and it is worth
nothing at all if it turns out to be decorative.

## Why there is no LICENSE file

You cannot license a summary of someone else's in-copyright work. Publishing under MIT or
CC would be claiming a right the collection does not hold. Absent a licence, default
copyright applies, which is the honest position. **Do not add one.**

**Why:** every one of these is load-bearing rather than cautious. Relaxing any of them
turns a defensible reader's aid into something a publisher would be right to object to,
and the cost lands on the maintainer, not on whoever made the change.

**How to apply:** treat all four as fixed. Changing any of them — the attribution
wording, the robots tag, the licence stance, the takedown language — is a conversation
with the maintainer, never a commit. See [[what-ships-without-asking]].
