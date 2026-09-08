# Point the Claude Code auto-memory directory at this repo's memory/.
#
# The Windows-native twin of link-memory.sh. Same behaviour, same guarantees; use
# whichever suits the shell you are in. See that script's header for the reasoning.
#
# Usage:  powershell -ExecutionPolicy Bypass -File .claude\link-memory.ps1 [repo-root]
#         pwsh -File .claude/link-memory.ps1 [repo-root]
#
# Safe to run repeatedly. It creates and it migrates; it never deletes anything it
# cannot re-create. If it finds a state it does not understand it stops and says so.

[CmdletBinding()]
param([string]$RepoRoot)

$ErrorActionPreference = 'Stop'

function Fail($msg) { Write-Error "link-memory: $msg"; exit 1 }

# ---------------------------------------------------------------------------
# Where the repo is
# ---------------------------------------------------------------------------

if ($RepoRoot) {
    if (-not (Test-Path -LiteralPath $RepoRoot -PathType Container)) {
        Fail "not a directory: $RepoRoot"
    }
    $repo = (Resolve-Path -LiteralPath $RepoRoot).ProviderPath
}
else {
    $here = Split-Path -Parent $PSCommandPath
    $repo = & git -C $here rev-parse --show-toplevel 2>$null
    if ($LASTEXITCODE -ne 0 -or -not $repo) {
        Fail 'not inside a git repo, and no repo root given as an argument'
    }
    # git reports forward slashes even on Windows; normalise to a native path.
    $repo = (Resolve-Path -LiteralPath $repo).ProviderPath
}

$repo = $repo.TrimEnd('\', '/')

# ---------------------------------------------------------------------------
# The harness derives its per-project directory from the native absolute path,
# replacing every character that is not a letter or digit with a hyphen. It differs
# on every machine and every clone, so it is computed here and stored nowhere.
# ---------------------------------------------------------------------------

$slug = [regex]::Replace($repo, '[^A-Za-z0-9]', '-')

$config = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR }
          else { Join-Path $env:USERPROFILE '.claude' }

$project = Join-Path (Join-Path $config 'projects') $slug
$link    = Join-Path $project 'memory'
$target  = Join-Path $repo 'memory'

Write-Host "repo    : $repo"
Write-Host "slug    : $slug"
Write-Host "link    : $link"
Write-Host "target  : $target"
Write-Host ''

# ---------------------------------------------------------------------------
# Make sure both ends exist before linking
# ---------------------------------------------------------------------------

foreach ($d in @($target, $project)) {
    if (-not (Test-Path -LiteralPath $d)) {
        New-Item -ItemType Directory -Path $d -Force | Out-Null
    }
}

# Resolving by walking into the directory works for a junction, a symlink and a real
# directory alike, so we never have to ask which kind of link we are looking at.
function Resolve-Real($path) {
    try { (Get-Item -LiteralPath $path -Force).PSParentPath | Out-Null
          return (Resolve-Path -LiteralPath $path).ProviderPath.TrimEnd('\') }
    catch { return $null }
}

$want = (Resolve-Path -LiteralPath $target).ProviderPath.TrimEnd('\')

# ---------------------------------------------------------------------------
# Deal with whatever is already there
# ---------------------------------------------------------------------------

if (Test-Path -LiteralPath $link) {

    $item     = Get-Item -LiteralPath $link -Force
    $linkKind = $item.LinkType          # 'Junction', 'SymbolicLink', or $null

    if ($linkKind) {
        $pointsAt = @($item.Target)[0]
        if ($pointsAt) { $pointsAt = $pointsAt.TrimEnd('\') }
        if ($pointsAt -eq $want) {
            Write-Host 'Already linked. Nothing to do.'
            if (Test-Path -LiteralPath (Join-Path $link 'MEMORY.md')) {
                Write-Host 'The index is visible through the link: memory/MEMORY.md'
            } else {
                Write-Host 'Note: memory/MEMORY.md does not exist yet.'
            }
            exit 0
        }
        Fail "$link is already a $linkKind, but it points at $pointsAt.`n       Refusing to repoint it. Remove it by hand if that is genuinely stale."
    }

    if (-not $item.PSIsContainer) {
        Fail "$link exists and is not a directory. Refusing to touch it."
    }

    # A real directory: move its contents into the repo, keeping anything that would
    # collide. Losing an unversioned memory to a link setup would be the one
    # unrecoverable outcome here, so a collision stops the script instead.
    $collisions = 0
    $moved      = 0
    foreach ($f in Get-ChildItem -LiteralPath $link -Force) {
        $dest = Join-Path $target $f.Name
        if (Test-Path -LiteralPath $dest) {
            Write-Host "  ! both sides have $($f.Name)"
            $collisions++
        }
        else {
            Move-Item -LiteralPath $f.FullName -Destination $dest
            Write-Host "  moved $($f.Name) into the repo"
            $moved++
        }
    }

    if ($collisions -gt 0) {
        Fail "$collisions file(s) exist on both sides. Merge them by hand, then run this again.`n       Unlinked memories are still at: $link"
    }

    if ($moved -gt 0) { Write-Host '' }
    Remove-Item -LiteralPath $link -Force
}

# ---------------------------------------------------------------------------
# Create the link
#
# A directory *junction*, not a symlink: creating a directory symlink needs
# administrator rights or developer mode, a junction does not.
# ---------------------------------------------------------------------------

New-Item -ItemType Junction -Path $link -Value $target | Out-Null
Write-Host 'Created a directory junction.'

# ---------------------------------------------------------------------------
# Verify by reading through the link, not by trusting the command that made it
# ---------------------------------------------------------------------------

$got = (Get-Item -LiteralPath $link -Force)
if (-not $got.LinkType) { Fail 'the link was created but does not report as a link' }
$gotTarget = @($got.Target)[0]
if ($gotTarget) { $gotTarget = $gotTarget.TrimEnd('\') }
if ($gotTarget -ne $want) {
    Fail "the link was created but resolves to '$gotTarget', not '$want'"
}

Write-Host 'Verified: the auto-memory path now resolves into the repo.'
if (Test-Path -LiteralPath (Join-Path $link 'MEMORY.md')) {
    Write-Host 'The index is visible through the link: memory/MEMORY.md'
} else {
    Write-Host 'Note: memory/MEMORY.md does not exist yet.'
}
Write-Host ''
Write-Host 'Memory is only durable once committed and pushed.'
