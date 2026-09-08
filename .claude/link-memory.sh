#!/usr/bin/env bash
#
# Point the Claude Code auto-memory directory at this repo's memory/.
#
# The harness keeps auto-memory at a path derived from the working directory it was
# launched in, which lives outside the repo and is therefore unversioned. This script
# replaces that directory with a link into memory/ here, so there is one source of
# truth and nothing to keep in sync.
#
# The derived path differs on every machine and every clone, so it is computed here
# rather than stored anywhere. That is the whole reason this script exists.
#
# Usage:  bash .claude/link-memory.sh [repo-root]
#
# Safe to run repeatedly. It creates and it migrates; it never deletes anything it
# cannot re-create. If it finds a state it does not understand it stops and says so.

set -eu

say()  { printf '%s\n' "$*"; }
fail() { printf 'link-memory: %s\n' "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# Where the repo is
# ---------------------------------------------------------------------------

if [ "${1:-}" != "" ]; then
  repo=$1
  [ -d "$repo" ] || fail "not a directory: $repo"
  repo=$(cd "$repo" && pwd -P)
else
  here=$(cd "$(dirname "$0")" && pwd -P)
  repo=$(git -C "$here" rev-parse --show-toplevel 2>/dev/null) \
    || fail "not inside a git repo, and no repo root given as an argument"
fi

# ---------------------------------------------------------------------------
# The harness derives its per-project directory from the *native* absolute path,
# replacing every character that is not a letter or digit with a hyphen. Under Git
# Bash that means the Windows form (C:\Users\...), not the POSIX one (/c/Users/...) —
# deriving the slug from the wrong form produces a directory the harness never reads,
# and the failure is silent.
# ---------------------------------------------------------------------------

case "$(uname -s)" in
  MINGW* | MSYS* | CYGWIN*) windows=1 ;;
  *)                        windows=0 ;;
esac

to_native() {
  if [ "$windows" = 1 ]; then
    if command -v cygpath >/dev/null 2>&1; then
      cygpath -w "$1"
    else
      # No cygpath: translate /c/foo -> C:\foo ourselves.
      printf '%s' "$1" | sed -E 's#^/([A-Za-z])/#\1:/#' | tr '/' '\\'
    fi
  else
    printf '%s' "$1"
  fi
}

repo_native=$(to_native "$repo")
slug=$(printf '%s' "$repo_native" | sed 's/[^A-Za-z0-9]/-/g')

config=${CLAUDE_CONFIG_DIR:-$HOME/.claude}
project="$config/projects/$slug"
link="$project/memory"
target="$repo/memory"

say "repo    : $repo_native"
say "slug    : $slug"
say "link    : $link"
say "target  : $target"
say ""

# ---------------------------------------------------------------------------
# Make sure both ends exist before linking
# ---------------------------------------------------------------------------

mkdir -p "$target"
mkdir -p "$project"

# Resolving both sides by cd'ing into them works for a junction, a symlink and a real
# directory alike, so we never have to ask which kind of link we are looking at.
want=$(cd "$target" && pwd -P)
resolve() { (cd "$1" 2>/dev/null && pwd -P) || true; }

# ---------------------------------------------------------------------------
# Deal with whatever is already there
# ---------------------------------------------------------------------------

if [ -e "$link" ] || [ -L "$link" ]; then

  if [ "$(resolve "$link")" = "$want" ]; then
    say "Already linked. Nothing to do."
    [ -f "$link/MEMORY.md" ] \
      && say "The index is visible through the link: memory/MEMORY.md" \
      || say "Note: memory/MEMORY.md does not exist yet."
    exit 0
  fi

  if [ -L "$link" ]; then
    fail "$link is already a link, but it points at $(resolve "$link").
       Refusing to repoint it. Remove it by hand if that is genuinely stale."
  fi

  if [ ! -d "$link" ]; then
    fail "$link exists and is not a directory. Refusing to touch it."
  fi

  # A real directory: move its contents into the repo, keeping anything that would
  # collide. Losing an unversioned memory to a link setup would be the one
  # unrecoverable outcome here, so a collision stops the script instead.
  collisions=0
  moved=0
  for f in "$link"/* "$link"/.[!.]*; do
    [ -e "$f" ] || continue
    base=$(basename "$f")
    if [ -e "$target/$base" ]; then
      say "  ! both sides have $base"
      collisions=$((collisions + 1))
    else
      mv "$f" "$target/$base"
      say "  moved $base into the repo"
      moved=$((moved + 1))
    fi
  done

  [ "$collisions" -eq 0 ] || fail "$collisions file(s) exist on both sides. Merge them by hand, then run this again.
       Unlinked memories are still at: $link"

  [ "$moved" -eq 0 ] || say ""
  rmdir "$link" || fail "could not empty $link"
fi

# ---------------------------------------------------------------------------
# Create the link
#
# On Windows this is a directory *junction*, not a symlink: creating a directory
# symlink needs administrator rights or developer mode, a junction does not.
# ---------------------------------------------------------------------------

if [ "$windows" = 1 ]; then
  link_native=$(to_native "$link")
  target_native=$(to_native "$target")
  powershell.exe -NoProfile -NonInteractive -Command \
    "New-Item -ItemType Junction -Path '$link_native' -Value '$target_native' | Out-Null" \
    || fail "could not create the junction"
  say "Created a directory junction."
else
  ln -s "$target" "$link"
  say "Created a symlink."
fi

# ---------------------------------------------------------------------------
# Verify by reading through the link, not by trusting the command that made it
# ---------------------------------------------------------------------------

got=$(resolve "$link")
[ "$got" = "$want" ] || fail "the link was created but resolves to '$got', not '$want'"

say "Verified: the auto-memory path now resolves into the repo."
if [ -f "$link/MEMORY.md" ]; then
  say "The index is visible through the link: memory/MEMORY.md"
else
  say "Note: memory/MEMORY.md does not exist yet."
fi
say ""
say "Memory is only durable once committed and pushed."
