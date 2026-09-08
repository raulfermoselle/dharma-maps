---
name: terms-follow-the-official-glossary
description: Every English technical term on a map must match the official Kadampa glossary — the page's own vocabulary is not automatically the tradition's, and the glossary is unreachable from this machine, so this records how to actually reach it
metadata:
  type: project
---

**Every English technical term on a map must match the official English Kadampa glossary**
(`kadampa.org/reference/glossary-of-buddhist-terms`, five letter-pages, also available as a
searchable app).

**Do not assume the wording already on a page is the glossary's.** Map 1 shipped with a
dozen terms that were not: it said **knower** where the glossary says **cognizer** — 55
occurrences — along with *sense perception* for **sense awareness**, *discernment* for
**discrimination**, *apparent object* for **appearing object**, *nonconceptual* for
**non-conceptual**, and *unconscientiousness* for **non-conscientiousness**, which is not
an entry at all. Each read perfectly naturally. **A word that reads naturally is not
evidence; the glossary is.** Check every technical noun before writing it.

## Getting at the glossary, which is the hard part

**The glossary cannot be fetched from this machine, by either route:**

- The browser is blocked by the network's web filter under the category *Religion*.
- A server-side fetch gets **403 from the site's own origin**, including the glossary
  index — so a backend fetch is not a way around the filter. Do not assume it is.

**WebSearch does return real glossary text** and is the working route: query the term with
`glossary` and a distinguishing word from its definition. It is lossy — perhaps two in
five queries come back empty or hedged — so treat only a verbatim-looking definition as
confirmation, and re-query with different wording before giving up.

**The reliable route is to ask the maintainer**, who can open the glossary app on a device
outside this network. Name the exact terms and ask for three things per term: the headword
as spelled, the first line of the definition, and the book under *Further reading* — that
last is what separates a right word in the right sense from a coincidental match. Several
terms were settled this way after search had failed on them.

**Terms that are section names rather than headwords** — the six groups of mental factors,
for instance — are not in the glossary at all. Those come from the book's own contents.

**Beware other translators.** Searches surface Berzin's *studybuddhism.com*, Thubten
Chodron and FPMT material, whose vocabulary is different and internally consistent —
*discrimination* vs *discernment*, *ever-functioning* vs *all-accompanying*. Their
agreement with each other is not evidence about Kadampa usage. Restrict to `kadampa.org`
when it works.

**Some words have no entry at all.** *Cognizer* is the clearest case: it appears as the
genus inside about twenty definitions and never as a headword. Established usage, no
lemma — so use it, and do not go hunting for a definition that is not there.

## A multilingual concordance exists, and is a lead rather than an authority

The maintainer holds a concordance of glossary lemmas across languages, outside the repo.
It is useful for generating candidates and it independently corroborated several terms
that had been derived the hard way. But it is not an authority: it contained at least one
mapping the source text explicitly contradicts, and it is silent on several terms the maps
lean on hardest. **Mine it for candidates, then confirm each against the glossary.** A tick
in a table is a reason to look, never a reason to write.

## Keep the working method off the page and out of the repo

**Do not state on a page, in a commit, or in a memory which edition or route the map was
built from.** Attribution names the work, its author and its publisher — that is what a
reader and a rights holder need. How the compiler got there is not part of it, and the
maintainer has asked that it stay out. Say *summarised*, not *quoted*, unless the words on
the page really are the source's own.

**Why:** a summary that uses the wrong words quietly teaches a reader vocabulary that will
not match their book or anything said at their centre — precisely the failure a reader's
map exists to prevent.

**How to apply:** confirm each technical noun before writing it, and record what you
confirmed as well as what you changed, so a later pass does not re-litigate settled terms.
When a term cannot be resolved either way, say so and ask. See
[[write-plainly-for-the-reader]] for the separate rule about your own jargon, which this
one does not touch: the tradition's vocabulary is kept exact, only yours is cut.
