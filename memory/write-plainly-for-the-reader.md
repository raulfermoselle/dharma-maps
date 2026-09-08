---
name: write-plainly-for-the-reader
description: Cut your own jargon, keep the tradition's vocabulary exact — the reader is a friend on a phone, not a developer, and three rejected phrases are on record as evidence
metadata:
  type: feedback
---

The reader of a map is a friend reading on a phone. Not a developer, not a reviewer of
your work, and not someone who will forgive a sentence that makes them feel outside the
conversation.

This was learned by getting it wrong three times, and the specific phrases are recorded
because a rejected wording that leaves no trace comes straight back:

- **"an entity-relationship model"** — the first map's subtitle. Wrong for the reader, and
  also simply untrue: the map did not turn out to be one.
- **"structural maps"** — same problem, softer. It describes the work to a colleague, not
  the page to a reader.
- **"bands"** — the internal name for the first map's four sections. A useful word while
  building the page and never a word a reader needed to learn.

The test that catches all three: **if a phrase would land well in a design review and
badly read aloud to a friend who does not write software, it is the wrong phrase.**

## Plain is not vague

The tradition's own technical vocabulary — *primary mind*, *mental factor*,
*non-ascertaining perceiver* — is exactly right, and must stay exact. Blurring it to
sound friendlier would break the one thing the page is for.

**What gets cut is your jargon, not the tradition's.** Those are opposite operations and
it is easy to do the wrong one while feeling virtuous about clarity.

**Why:** a reader who trips over the framing stops reading, and the teaching is the part
that was supposed to arrive. Meanwhile a term the book uses precisely is doing real work,
and softening it makes the map wrong rather than warm.

**How to apply:** read any new copy back as a phone-sized paragraph and ask which words
are the tradition's and which are yours. Keep the first set verbatim. Justify or cut the
second. When a wording gets rejected, record why in the commit message — see
[[commits-record-why]].
