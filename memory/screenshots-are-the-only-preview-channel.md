---
name: screenshots-are-the-only-preview-channel
description: The preview browser is a separate instance the maintainer cannot see, so a screenshot sent as a file is the only way he can watch a change — send them as the work happens, not batched at the end
metadata:
  type: feedback
---

**The Chrome instance the devtools tooling drives is not the browser on the maintainer's
screen.** It is a separate instance: listing its tabs shows only its own `about:blank` and
whatever page you opened, while his tabs are somewhere else entirely.

So he **cannot see your preview window.** Nothing you do in it reaches him.

**A screenshot sent as a file is the only channel.** Take one to an explicit `filePath`,
then send that path as a file with `display: "render"` so it appears inline rather than as
a download card. He reads on a phone, and this is how he actually watches the work.

**Send after each meaningful change, not batched at the end.** A single dump of images once
the work is finished is not watching, it is a report — and by then it is too late for him
to redirect anything cheaply. A screenshot of a complete, meaningfully different state is
worth sending; every incremental save of something still being edited is not.

**Why:** it is easy to assume a preview is shared because it is "on the same machine", work
for an hour on that assumption, and hand over something he has had no chance to steer. The
whole value of a phone-first preview loop is that he can see it while it is still cheap to
change.

**How to apply:** when a change to a page is under way, screenshot at 390 px and send it
when the state is worth looking at. Say what changed in the caption, and quote the
measurement — see [[phone-first-and-measure-the-render]] — rather than asking him to spot
the difference himself.
