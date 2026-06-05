#!/usr/bin/env bash
# kb-autocommit.sh — auto-commit knowledge base changes (POSIX variant).
#
# Invoked by a Claude Code "Stop" hook (see docs/AGENT-INTEGRATION.md) after each
# agent response. Keeps the knowledge base versioned in git without manual commits.
#
# - operates only on this repo; root is resolved from the script location
#   (tools/ -> repo root), so it is path-independent;
# - no changes -> quiet exit 0;
# - else: git add -A + commit; push to origin in the background (fire-and-forget).
# Never crashes a session: errors are tolerated, exit 0.
set +e

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ -d "$REPO/.git" ] || exit 0
cd "$REPO" || exit 0

if [ -z "$(git status --porcelain 2>/dev/null)" ]; then exit 0; fi

git add -A 2>/dev/null
git commit -q -m "kb: auto $(date '+%Y-%m-%d %H:%M')" 2>/dev/null

if [ -n "$(git remote 2>/dev/null)" ]; then
  ( git push --quiet >/dev/null 2>&1 & )
fi

exit 0
