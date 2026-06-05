#!/usr/bin/env bash
# Индексация базы знаний через md-semantic-search (mdss).
# Запуск:  bash knowledge-base/semantic/kb-index.sh [доп.флаги mdss]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KB="$(dirname "$SCRIPT_DIR")"            # корень knowledge-base/
INDEX_DIR="$SCRIPT_DIR/.mdss"            # индекс в semantic/.mdss
CACHE_DIR="$SCRIPT_DIR/.cache"           # единый кэш моделей (самодостаточно)
MODEL="${MDSS_MODEL:-bge-m3}"           # модель по умолчанию для этой базы

mdss_run() {
  if command -v mdss >/dev/null 2>&1; then mdss "$@"
  else npx -y md-semantic-search "$@"; fi
}

# semantic/ и templates/ исключаем; dot-папки mdss пропускает сам.
# "$@" в конце → пользовательский --model переопределит дефолт (последний флаг выигрывает).
mdss_run index --db "$KB" --index-dir "$INDEX_DIR" --cache-dir "$CACHE_DIR" --model "$MODEL" \
  --ignore "semantic/**" --ignore "templates/**" "$@"
