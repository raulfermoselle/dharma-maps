---
name: verify-on-the-live-host
description: A local check and a tool's success message both prove less than they seem — after pushing, poll the Pages build and then fetch the live URL and grep for the change
metadata:
  type: feedback
---

After a push, verify on the live host rather than locally:

1. Poll the Pages build until it reports `built`.
2. Fetch the live URL and grep for the actual change.

This has already caught things twice that no local check could have.

## Two failures this defends against

- **A tool reporting success is not evidence that it worked.** Same lesson as the window
  resize in [[phone-first-and-measure-the-render]]: the report and the effect are separate
  facts, and only one of them is the one you care about.
- **A build reporting `built` can precede the CDN serving the new bytes.** The build status
  is not the thing being tested. The bytes a reader would receive are.

## The general form

**A detector that sees nothing and a page with nothing to see are indistinguishable.**
Before trusting any check, calibrate it against the real phenomenon at least once — make
the thing you are looking for actually happen, and confirm the check notices.

**Why:** every one of these failures is silent and looks exactly like success, which means
it survives right up until a reader hits it.

**How to apply:** do not report a change as live until a fetch of the live URL contains it.
Quote the evidence — the status, the matched line — rather than asserting the outcome.
