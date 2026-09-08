---
name: memory-lives-in-this-repo
description: The auto-memory directory is a link into this repo's memory/, created by a linker that computes the machine-specific path at run time — so memory travels with the clone, and is only as durable as what has been pushed
metadata:
  type: reference
---

The harness keeps auto-memory at a path derived from the working directory it was
launched in. That path is outside the repo and unversioned. Rather than keep two copies
and let them drift, the harness path **is** a link into `memory/` here:

```
<claude config>/projects/<slug>/memory   (junction on Windows, symlink elsewhere)
    -> <repo>/memory                     (the real files, in git)
```

Reads and writes through the harness path land in the repo transparently. One source of
truth, nothing to remember to sync.

## Why there is a script rather than a recorded path

`<slug>` is the absolute repo path with every non-alphanumeric character replaced by a
hyphen, so it is different on every machine and every clone. A stored path would be wrong
everywhere except where it was written. `.claude/link-memory.sh` and
`.claude/link-memory.ps1` compute it instead, which is what makes the arrangement
portable rather than a one-machine trick.

Three details in those scripts were learned the hard way and should not be simplified
away:

- **On Windows it must be a directory junction, not a symlink.** Creating a directory
  symlink needs administrator rights or developer mode; a junction needs neither.
- **Under Git Bash the slug must come from the Windows form of the path**
  (`C:\...`), not the POSIX form (`/c/...`). Deriving it from the wrong one produces a
  directory the harness never looks at, and nothing announces the mistake.
- **The scripts verify by reading back through the link**, not by trusting the command
  that created it. They also refuse to repoint an existing link or overwrite a colliding
  file, because an unversioned memory destroyed during setup is the one unrecoverable
  outcome here.

## The failure mode to check first

**If memory looks empty, or a write seems to vanish, check the link before theorising.**
Anything that deletes and recreates that directory severs it silently: memory appears to
work, but the writes go into a plain directory nobody backs up. Re-running the linker
diagnoses and repairs it, and says which case it found.

## The obligation this creates

A file in a repo is durable only once **committed and pushed**. That makes the whole
arrangement conditional on a habit: commit memory as it is written, not in an occasional
sweep, and push, so a lost machine does not cost months of accumulation.

Related: [[what-ships-without-asking]], [[commits-record-why]]
