---
name: git-identity-is-not-the-default
description: A machine can carry more than one account for the same host, and the wrong one may be the default — this repo pins its git identity and credential helper locally; check which account a push would use before theorising, and never rewrite a shared CLI's auth config
metadata:
  type: reference
---

A work machine often carries more than one account for the same forge, and **the default
is not necessarily the right one for this repo.** The consequences of getting it wrong are
outward-facing and awkward: a commit attributed to the wrong person, a push under an
identity that should not appear here at all.

## What is already pinned, and what is not

- **Git is configured correctly inside this repo, repo-locally.** `user.name` and
  `user.email` are set here, and a repo-local `credential.helper` overrides the machine's
  system-wide credential manager, which would otherwise hand a push whichever credential
  it holds by default. Both settings are invisible from outside the working directory, so
  they will not be obvious to anyone who has not been told.
- **A forge CLI (`gh` and friends) is a separate story and may not be pinned.** It has its
  own config and its own stored token, chosen machine-wide. Where a per-project config
  directory has been set up, every invocation has to point at it explicitly — a command
  that forgets to will quietly use the wrong account.

## Check identity before theorising

If a push does something surprising, find out which account git would actually use before
inventing an explanation. This prints the username without printing the token:

```
printf 'protocol=https\nhost=github.com\n\n' | git credential fill 2>/dev/null | grep '^username='
```

Checking this is why the first push here was safe rather than lucky.

## Never touch shared authentication

**Do not run anything that writes a CLI's default auth config** — logging in, switching
accounts, re-authenticating. Other tooling and other people on the same machine may depend
on that default, and you cannot see who. Breaking it is invisible to you and immediate for
them.

**Credentials are the maintainer's to handle, never a keeper's.** If authentication is
broken, say exactly what is broken and stop. Do not repair it, and do not work around it.
See [[what-ships-without-asking]].
