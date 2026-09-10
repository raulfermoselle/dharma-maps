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

## Your jargon creeps in when you explain structure, not content

Two more went in and had to come out of a single card, both caught by the maintainer
rather than by me:

- **"the same field sorted by what each mind depends on"** — *field* is nobody's term. It
  sounds like an explanation and carries no information.
- **"different cuts of the same set"** — *cut* was used six times across one card and
  defined nowhere on the page. The maintainer's question was exact: *I only understood
  what a cut is from your prose; is it explained anywhere on the page?* It was not.

**The pattern is that this happens while describing how the material is organised, not
while describing the material.** Terms are checked against the glossary
([[terms-follow-the-official-glossary]]); metaphors for structure get invented on the
spot and never checked against anything.

**The test:** a structural word that is neither the book's nor defined on the page is
yours, and has to go.

**The book usually supplies something better.** Here it did: it classifies minds four
times over, each time announcing *desde el punto de vista de…* — from what point of
view. Rendering each as **the question it answers** ("What does it depend on?") replaced
the invented metaphor with the author's own device, and was clearer than either.

## A popover is looked up, so its first sentence must define

A term note took three attempts because each draft explained the *mechanism* before
saying what the word meant. The reader taps a word wanting a meaning; they did not ask
for a procedure. The failing openings were **"Not a vaguer word for mind…"** — defining
by what it is not — and **"Sort minds by what they depend on and you get awarenesses"**
— an instruction, when what was needed was **"An awareness is a mind, named by what it
depends on."**

Two checks that would have caught it:

- **First sentence is "X is …".** Every other popover on the page does this; the ones that
  drift are the ones written as explanation rather than definition.
- **Every "this", "that" or "both" has its referent inside the same note.** The second
  draft said *"This is how one mind can be both"* — both *what*? Stripping the opener had
  removed the contrast while leaving the payoff pointing at nothing. If a note is a
  popover, it is read cold and alone; nothing outside it can be assumed.

**The `kind` label is read alone too**, so it must be a noun phrase that stands by itself
— *Secondary delusion*, *Synonym of primary mind*, *The general term for any mind* — never
a fragment answering an unasked question, which is what *"By what a mind depends on"* was.

## Say "X is Y", not "Y is what X means"

A note read **"sharing it is what *basis* means here."** Explaining the same change out
loud, the sentence came out as **"Basis is the thing they share."** The second is the one
that should have shipped. The plain version is very often the one already used when
describing the work; the shipped version is the one that got dressed on the way out.

**The tell is a nominalisation** — a verb turned into a noun and made the subject
(*sharing is…*, *the naming of…*, *what X means here*) — usually with a limp pointer like
*here* or *in this context* propping it up. Also: passive constructions, and any sentence
whose real subject arrives after the verb.

**The check:** say the sentence as you would to somebody standing next to you. If that
comes out shorter and starts with the term, that is the sentence.

This is the same fault as the popover that opened by telling the reader to sort minds
instead of saying what an awareness is. Both dress up an explanation where a plain
statement was wanted, and the maintainer has now caught it twice.

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

## Define with the tradition's own concrete word, then let the example confirm it

The same note was rewritten four times before it worked, and the last two failures were
not vagueness — they were *order*.

- **"Basis is the thing they share."** Vacuous: all five similarities are things they
  share, so this defined *similarity*, not *basis*. It left the tea as the only concrete
  noun in the paragraph, and the reader landed on the tea — which is the *object*, the
  one answer the note most needed to exclude.
- **"Basis is what a mind arises from — its support, not what it is about."** True, and
  still wrong. Correct but abstract, so the example had to carry the whole load, and the
  reader did not reach the actual answer (*the tongue sense power*) until word 38.

**What fixed it was going back to the book.** It spends one clause: *Basis: they have the
same dominant condition* — then one sentence naming the tongue sense power outright. The
book's own word for the thing is **power**, and it covers both cases (a sense power, the
mental power). So *"A mind's basis is the power it arises from"* defines and is concrete
at the same time, and the answer arrives at word 20 as a plain identification: *the basis
is the tongue sense power*.

**Two rules out of it:**

- **Name the example's answer early, as an identification.** Not "A and B both arise from
  X, so X is their basis" — the reader has to hold two clauses and assemble the
  conclusion. Say "the basis is X", then let the rest explain why.
- **When a definition comes out abstract, look for the tradition's own noun before
  inventing a paraphrase.** The abstraction is usually a sign the book's concrete term was
  skipped over. See [[terms-follow-the-official-glossary]].

**And rule out the near miss by name.** If a note sits in a list of five similar things,
say which of the neighbours it is *not*: *the taste of the tea is not the basis; the taste
is the object.* The wrong answer a reader is likely to reach is worth one sentence.
