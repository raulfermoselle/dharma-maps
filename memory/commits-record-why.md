---
name: commits-record-why
description: Put the reason in the commit message, especially the reason a wording was rejected — that is the thing that stops it coming back; write multi-line messages with -F or repeated -m, because heredocs and here-strings mangle prose on Windows shells
metadata:
  type: feedback
---

**Record why, not just what** — in commit messages and in code comments alike.

The most valuable thing a commit message here can carry is **the reason a wording was
rejected.** "What" is already visible in the diff. The reason is not, and without it the
same phrasing gets proposed again in three months by someone acting in good faith,
including you. [[write-plainly-for-the-reader]] exists because three such phrases were
written down; that is the mechanism working.

## Writing a multi-line message on this kind of machine

Use `git commit -F <file>`, or repeated `-m` flags. **Do not** build the message with a
shell heredoc or a PowerShell here-string: both mangle prose on Windows shells — the
observed failure is doubled backslashes silently collapsing to single, and the mangling is
quiet, so the damaged message is what gets committed.

The same hazard applies to writing prose files through a shell heredoc. Use a file-writing
tool for prose and keep heredocs for things where a corrupted character would be obvious.

**Why:** a decision with no recorded reason is indistinguishable from an accident, and gets
"corrected" accordingly. A quietly corrupted commit message cannot be fixed later without
rewriting history, which is on the never list in [[what-ships-without-asking]].

**How to apply:** before committing, check that the message answers "why this, and why not
the obvious alternative". If it only restates the diff, it is not finished.
