<#
  kb-autocommit.ps1 — auto-commit knowledge base changes.

  Invoked by a Claude Code "Stop" hook (see docs/AGENT-INTEGRATION.md) after each
  agent response in ANY session on this machine. Keeps the knowledge base in git
  without manual commits, so your long-term memory is always versioned.

  Logic:
    - operates ONLY on this knowledge-base repo. The repo root is resolved from
      the script's own location (tools/ -> repo root), so it is fully
      path-independent — copy the repo anywhere and the hook still works;
    - if there are no changes -> quiet exit 0 (git status ~0.1s, negligible cost);
    - else: git add -A + commit with an auto message;
    - push to origin runs in the background (fire-and-forget), never blocks the
      session; network errors are ignored — the next commit ships the backlog.

  The script must never crash a session: all errors are suppressed, exit 0.
#>
$ErrorActionPreference = 'SilentlyContinue'

# Repo root = parent of the tools/ folder this script lives in (path-independent).
$repo = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $repo '.git'))) { exit 0 }

Set-Location $repo

# Anything to commit?
$changes = git status --porcelain 2>$null
if ([string]::IsNullOrWhiteSpace($changes)) { exit 0 }

git add -A 2>$null
$msg = "kb: auto " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
git commit -q -m $msg 2>$null | Out-Null

# Background push (only if an origin remote exists) — do not wait, never fail the session.
$hasRemote = git remote 2>$null
if ($hasRemote) {
    Start-Process -FilePath 'git' -ArgumentList 'push','--quiet' `
        -WorkingDirectory $repo -WindowStyle Hidden -ErrorAction SilentlyContinue
}

exit 0
