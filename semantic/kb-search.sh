#!/usr/bin/env bash
# Семантический поиск по базе знаний через md-semantic-search (mdss).
# Запуск:  bash knowledge-base/semantic/kb-search.sh "запрос" [доп.флаги mdss]
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo 'usage: kb-search.sh "запрос" [флаги mdss]' >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB="$(dirname "$SCRIPT_DIR")"
INDEX_DIR="$SCRIPT_DIR/.mdss"
CACHE_DIR="$SCRIPT_DIR/.cache"

mdss_run() {
  if command -v mdss >/dev/null 2>&1; then mdss "$@"
  else npx -y md-semantic-search "$@"; fi
}

mdss_run search --db "$KB" --index-dir "$INDEX_DIR" --cache-dir "$CACHE_DIR" "$@"
