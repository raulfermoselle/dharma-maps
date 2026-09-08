---
name: only-docs-is-published
description: GitHub Pages publishes this repo's /docs folder, so docs/ is the whole live site and everything outside it returns 404 — publication is opt-in by structure rather than a denylist someone has to maintain
metadata:
  type: project
---

**`docs/` is the entire published site.** Pages is configured to publish from the `/docs`
folder of the default branch, which makes `docs/` the site root:

```
docs/index.html        ->  /
docs/mind/index.html   ->  /mind/
everything else        ->  404, not served at all
```

`CLAUDE.md`, `memory/`, `.claude/`, `README.md`, `.gitignore` all live at the repo root and
are **not** part of the site. They remain visible on the repository host, because the repo
is public — but they are not served by the site and cannot be crawled through it.

## Why it is arranged this way

The site used to publish from the repository root, which meant **everything** was served:
the agent instructions, every memory file, the setup scripts, `.gitignore`. Nothing was
secret and nothing quoted the book, so the stakes were low — but a `.md` file cannot carry
`<meta name="robots">` and Pages does not allow custom headers, so those files had no way
to carry the `noindex` every map does ([[copyright-posture-is-fixed]]).

The move fixes the **polarity**, which matters more than the individual files. Publishing
from the root means everything ships unless somebody maintains a denylist and remembers to
update it. Publishing from `docs/` means nothing ships unless somebody deliberately puts it
there. A new memory, hook, script or note is unpublished automatically. **Put a file in
`docs/` only if the world should be able to read it.**

`robots.txt` was considered and is weaker: it asks well-behaved crawlers not to index while
the files stay fully served to anyone with the URL. It is a request; this is enforcement.

## Constraints worth knowing before changing any of this

- **Branch-based Pages offers exactly two source folders**: the repository root (`/`) or
  `/docs`. There is no third option and no per-file exclusion. Arbitrary control requires
  switching to a GitHub Actions workflow, which would add a build step and break the
  "no build step, open it from disk and it works" promise in the README.
- **`.nojekyll` must sit at the root of the publishing source**, so it belongs at
  `docs/.nojekyll`. Without it Jekyll processes the site and can mangle inline JS that
  happens to contain Liquid delimiters.
- **If `docs/` is ever removed from the branch the site stops building** with a page build
  error for the missing folder. The folder must always exist.
- **The move did not change any public URL.** `/` and `/mind/` resolve exactly as before,
  which is what made it safe given that a published slug is a promise
  ([[what-ships-without-asking]]).

**Why:** a posture that depends on somebody remembering to exclude each new file fails
quietly the first time somebody forgets, and nothing announces it.

**How to apply:** when adding a map, put it at `docs/<slug>/index.html`. When adding
anything else, leave it outside `docs/` and it is private to the site by default. Verify
after any change to the publishing setup by fetching a public URL and an internal one and
confirming 200 and 404 respectively — see [[verify-on-the-live-host]].
