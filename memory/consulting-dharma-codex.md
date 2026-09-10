---
name: consulting-dharma-codex
description: How to actually get an answer out of the dharma-codex consultant — the Enter is absorbed so sending takes two calls, it has no readable transcript, and any answer longer than a couple of sentences must be routed through a file
metadata:
  type: reference
---

`dharma-codex` is a consultant on Buddhist theory in the Kadampa presentation, reachable
from this workspace. It runs on a **different model family** from the keeper, which is most
of the reason it is worth asking rather than thinking harder alone: it reads the same
material without inheriting the keeper's assumptions.

**Ask it before guessing on doctrine.** The failure this collection cannot catch by itself
is a tidy structure the source does not actually make — confident, plausible, and wrong in
the one place nobody would check. It earned its keep the first time it was asked properly:
see [[anger-and-hatred-are-both-official]], where it argued *against* the obvious
normalisation and was right.

**By design it will not edit a page, commit, or push.** It describes the change; the keeper
makes it. Writing a note into a scratchpad outside the repo is not a page edit and does not
strain that rule — which matters, because it is the only channel that works for anything
long.

## Sending takes two calls, not one

The prompt swallows a trailing carriage return, so a single send leaves the text sitting
there unsent while reporting success:

1. `send_input` with the text and **no** submit.
2. `send_input` with an **empty string** and `submit: true`.

`enterWritten: true` means a carriage return was written, **not** that it acted — if it was
mid-turn, the text queues instead. And a message only runs as its own message: if anything
is already on the prompt, yours is appended and the whole lot is taken as prose.

## There is no transcript — reading it is the hard part

`read_transcript` refuses outright: *"has no transcript — it holds no session."* So
`read_output` is the only record, and it returns the terminal's **paint instructions** —
escape codes, cursor moves, and a spinner repainting several times a second. One ordinary
consultation produced **163 KB** of output, almost all spinner frames, with the answer
scattered through the middle. Sampling the tail found only the status line; the reasoning
was gone. **A long answer read this way is effectively unrecoverable.**

To get the cursor without reading the buffer, call `read_output` with an absurdly high
cursor — it returns empty output plus the current position, which costs nothing. Take that
before sending, so new output is distinguishable from what was already there. Do **not**
grep the retained buffer for a "working" marker: an old one is always still in it, and you
will read an idle agent as busy.

## So route every substantial answer through a file

Ask it to write the full answer as markdown into the **session scratchpad** — the
temporary directory outside the repo, whose path is per-session and belongs in no memory —
and to reply with just the filename. Then read the file. This is the reliable channel and
it should be the default for anything past a couple of sentences. It worked first time: a
15 KB answer, complete, in about five minutes.

**Wait for it properly.** Use a backgrounded `until` loop that exits when the file is
non-empty **and also exits on a timeout**, then read it when notified. Do not poll in a
sleep loop, and do not treat silence as progress — an `until` loop with no deadline cannot
tell you it failed.

## Two limits to plan around

- **It cannot be read from a phone.** It has no remote-control channel, so if the
  maintainer needs its reasoning, relay it — see
  [[screenshots-are-the-only-preview-channel]] for the same constraint on previews.
- **It is not revivable.** It survives an engine restart but not a reboot, and returns with
  none of its context. **A conclusion that lives only in its context is one reboot from
  never having happened**, so when it settles something, write the memory yourself, in this
  repo, that same session.

**Why:** the two traps here — a send that reports success without submitting, and an answer
that is delivered but unreadable — both fail silently and both look like the consultant
being slow or unhelpful. Neither is.

**How to apply:** two calls to send, ask for a file, wait on the file with a deadline, and
write down what it concludes. See [[commits-record-why]] on recording the reason rather
than the outcome.
