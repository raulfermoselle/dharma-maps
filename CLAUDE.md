# Dharma Maps — notes for whoever keeps this collection

A **map** is one self-contained HTML page laying out the shape of a teaching: what its
parts are, how they relate, what each term means. It is a reader's aid, never a source.
One map per directory, at `docs/<slug>/index.html`. `README.md` is the public face.

Published through GitHub Pages, and nowhere else. Do not republish a map on another
host, in another format, or as a hosted artifact — a shared link should have exactly one
place it can point.

**`docs/` is the entire published site, and nothing outside it is served.** GitHub Pages
publishes from this repo's `/docs` folder, so `docs/` is the site root —
`docs/mind/index.html` is served as `/mind/`. Everything else in the repo, this file and
`memory/` included, returns 404 on the live site. That is deliberate: publication is
opt-in, so a new note, script or memory is unpublished automatically rather than
depending on someone remembering to exclude it. Put a file in `docs/` only if the world
should be able to read it. See `memory/only-docs-is-published.md`.

## Your memory lives in this repo

`memory/` here **is** the auto-memory directory.

The harness keeps auto-memory at a path derived from the working directory it was
launched in. That path sits outside the repo and is unversioned, so anything written
there is one disk failure or one new laptop away from gone. Here that path is a **link**
into `memory/`, which means one source of truth, nothing to sync, and a memory that
travels with the clone.

The derived path is different on every machine and every clone, so it is computed at run
time and stored nowhere. **On a new machine or a fresh clone, link it before anything
else:**

```
bash .claude/link-memory.sh                                   # Git Bash, macOS, Linux
powershell -ExecutionPolicy Bypass -File .claude\link-memory.ps1   # Windows
```

Both are idempotent, and both refuse rather than destroy if they meet a state they do not
understand. Then read `memory/MEMORY.md` — the index — and the memories it points to.
Everything about voice, page construction, phone-first work and what may be published
without asking is in there; this file is only the part that has to survive a cold start,
before any memory has loaded.

**Knowledge here is exactly as durable as what has been committed and pushed.** Write
each memory as it is learned rather than in an occasional sweep, and write it for a
future keeper who has none of the conversation that produced it. That reader is the real
audience — not the person you are talking to now.

## What never goes into a memory, or anywhere else here

**This repo is public.** Every memory is published the moment it is pushed. Write only
what still makes sense, and is still appropriate, read by a stranger in ten years.

- **No absolute paths, no machine-, account- or employer-specific detail.** Say that
  source material lives outside the repo; never say where. Say that the linker computes
  the path; never record what it computed on some particular machine.
- **No credentials, no account names, no email addresses** — not the maintainer's, not
  anyone's. If something is broken that only a credential can fix, say so and stop.
- **Nothing personal.** Not why the maintainer studies this material, not who reads these
  maps, not anything said while thinking aloud. An editorial or technical rule that came
  out of such a conversation is fine to keep; it stands on its own without the story, and
  the story is the part that does not belong.
- **No source material, in any form.** See below.

A memory failing any of these is not one to reword. It is one not to write.

Keep it durable, too. A memory is a fact that will still be true and still be useful next
year: a rule, a reason, a hazard, a decision and why it went that way. A status update is
not a memory, and neither is a to-do list.

## The rules that are not a keeper's to change

These are the copyright posture. They were reasoned out with the maintainer; the
reasoning behind each one is in `memory/copyright-posture-is-fixed.md`. If you think one
should change, that is a conversation with him, not a commit.

1. **No source material in the repo. Ever.** No PDFs, no scans, no OCR'd text, no
   long-form extracts, no temporary copies. `.gitignore` refuses those file types, but
   that is a safety net, not the plan — the plan is that they never come near this
   directory. Before any `git add -A`, know what is staged.
2. **Every page carries** `<meta name="robots" content="noindex, nofollow, noarchive, nosnippet">`.
   Shared by link, not found by search.
3. **Attribution is prominent and the takedown offer is honoured.** Every map names its
   author, publisher, edition and ISBN, states plainly that it is an unofficial study aid
   with no affiliation or endorsement, marks quoted definitions as their publisher's
   copyright, and offers to amend or take the page down on a rights holder's request.
   **If that offer is ever taken up, honour it immediately and tell the maintainer.**

There is deliberately **no LICENSE file**, and adding one would be a mistake. You cannot
license a summary of in-copyright material.
