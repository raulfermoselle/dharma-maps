---
name: terms-follow-the-official-glossary
description: English technical terms on these pages must match the official Kadampa glossary, not a back-translation from the Spanish edition — the source is Spanish, so drift is the default, and the glossary itself is unreachable from this machine
metadata:
  type: project
---

**Every English technical term on a map must match the official English Kadampa glossary**
(`kadampa.org/reference/glossary-of-buddhist-terms`, five letter-pages), not a rendering of
the Spanish.

This matters because the source is the **Spanish edition**. Translating its vocabulary back
into English produces plausible words that are not the tradition's, and the first map shipped
with a dozen of them. The Spanish reads *conocedor*, so the page said **knower** where the
glossary says **cognizer** — 55 occurrences. Likewise *percepción sensorial* became **sense
perception** rather than **sense awareness**, and *discernimiento* became **discernment**
rather than **discrimination**.

**Back-translation is the default failure here, so check every technical noun before writing
it.** A word that reads naturally is not evidence; the glossary is.

## Getting at the glossary, which is the hard part

**The glossary cannot be fetched from this machine, by either route:**

- The browser is blocked by the network's web filter under the category *Religion*.
- A server-side fetch gets **403 from the site's own origin**, including the glossary index —
  so a backend fetch is not a way around the filter. Do not assume it is.

**WebSearch does return real glossary text** and is the working route: query the term with
`glossary` and a distinguishing word from its definition. It is lossy — perhaps two in five
queries come back empty or hedged — so treat only a verbatim-looking definition as
confirmation, and re-query with different wording before giving up. Terms that are **section
names rather than headwords** (the six groups of mental factors, for instance) are not in the
glossary at all; those come from the book's own contents listing, which search will surface.

**Beware other translators.** Searches surface Berzin's *studybuddhism.com*, Thubten Chodron
and FPMT material, whose vocabulary is different and internally consistent — *discrimination*
vs *discernment*, *ever-functioning* vs *all-accompanying*. Their agreement with each other is
not evidence about Kadampa usage. Restrict to `kadampa.org` when it works.

## The route that actually settles a term

**The glossary is also a searchable app**, one term per query with the source book listed
under *Further reading* — which is how you tell a right word in the wrong sense from a right
word in the right one. The maintainer can open it on a device outside this network, so the
reliable move for a stubborn term is to name it precisely and ask, rather than to keep
guessing. That is how *Denial*, *Initial scope practitioner* and the rest were finally
settled.

**It carries a language selector.** A Spanish glossary would map the Spanish edition's
vocabulary straight onto its official English and remove the guesswork from every future map.
Worth asking for before starting one.

**Do not copy the glossary into the repo.** Its own footer asserts copyright — New Kadampa
Tradition, from the Collected Works — so it is source material like the book: consult it
freely, keep it outside the repo, quote a definition only in brief.

**An unauthorised full text of the English edition circulates on archive.org.** It would
settle every term at once. **Do not use it.** This collection's whole standing rests on
respecting the publisher ([[copyright-posture-is-fixed]]), and building it from a pirate scan
would contradict the notice printed on the page. If a clean English source is ever wanted, the
edition is on sale from the publisher — that is the maintainer's call to make, not a keeper's.

**Why:** a summary that uses the wrong words is not a neutral stylistic choice — it quietly
teaches the reader vocabulary that will not match the book or anything said at their centre,
which is precisely the failure a reader's map exists to prevent.

**How to apply:** before writing any technical noun, confirm it. Record what you confirmed as
well as what you changed, so a later pass does not re-litigate settled terms. When a term
cannot be resolved either way, say so and ask — the maintainer can open the glossary on a
device outside this network. See [[write-plainly-for-the-reader]] for the separate rule about
your own jargon, which this one does not touch: the tradition's vocabulary is kept exact, only
yours is cut.
