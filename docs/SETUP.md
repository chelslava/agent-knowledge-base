# Установка и запуск

Пошаговая настройка базы знаний у себя на ПК. Время — ~10 минут (плюс первая
загрузка модели эмбеддингов).

## Требования

- **Git**.
- **Node.js ≥ 18** (для семантического поиска `md-semantic-search`).
- **PowerShell 7 (`pwsh`)** — для Windows-обёрток и Task Scheduler. На POSIX —
  любой `bash`.
- ~3 ГБ места на диске под модель `bge-m3` (кэшируется один раз).
- _(опционально)_ [Obsidian](https://obsidian.md/) — открыть базу как vault.

## 1. Получить репозиторий

Вариант А — клонировать как старт для своей базы:

```bash
git clone https://github.com/chelslava/agent-knowledge-base.git my-knowledge-base
cd my-knowledge-base
```

Вариант Б — использовать как **GitHub-шаблон**: нажмите «Use this template» на
странице репозитория, затем клонируйте свой новый репозиторий.

После клонирования сделайте базу **своим** репозиторием (чтобы автокоммит писал
в вашу историю):

```bash
rm -rf .git && git init && git add -A && git commit -m "init knowledge base"
# и при желании привяжите свой приватный remote:
# git remote add origin https://github.com/<you>/<your-kb>.git && git push -u origin main
```

## 2. Установить движок поиска

```bash
npm install -g md-semantic-search   # команды: mdss, md-semantic-search
```

Без глобальной установки обёртки сами используют `npx -y md-semantic-search`
(медленнее на старте).

## 3. Построить индекс

Первый запуск скачает модель `bge-m3` (~2.3 ГБ) в `semantic/.cache` — это
происходит один раз.

```powershell
# Windows / PowerShell
pwsh semantic/kb-index.ps1
```

```bash
# POSIX / bash
bash semantic/kb-index.sh
```

## 4. Проверить поиск

```powershell
pwsh semantic/kb-search.ps1 "single source of truth"
```

```bash
bash semantic/kb-search.sh "single source of truth"
```

Должны вернуться релевантные секции из `knowledge-rules.md` / `AGENTS.md`.
Поиск **кросс-язычный** — запрос на русском найдёт и англоязычные документы.

## 5. (Windows, опционально) Авто-переиндексация

Зарегистрировать задачу планировщика, которая обновляет индекс по расписанию
(права админа не нужны — выполняется под текущим пользователем):

```powershell
pwsh semantic/install-task.ps1            # каждые 30 минут
pwsh semantic/install-task.ps1 -Minutes 15

# управление
Get-ScheduledTask  -TaskName KB-Semantic-Reindex
Start-ScheduledTask -TaskName KB-Semantic-Reindex
Unregister-ScheduledTask -TaskName KB-Semantic-Reindex -Confirm:$false
```

`mdss` инкрементальный: без изменений прогон ≈ 0.1 с, модель даже не грузится —
частые запуски почти бесплатны.

## 6. Подключить ИИ-агента

Дайте агенту прочитать `AGENTS.md` **первым** в каждой сессии. Для Claude Code —
полная инструкция в [`AGENT-INTEGRATION.md`](AGENT-INTEGRATION.md): глобальный
блок в `CLAUDE.md` и авто-коммит через Stop-hook.

## Что коммитится, а что нет

В git попадают только Markdown-знания и скрипты. Не коммитятся (см. `.gitignore`):

- `semantic/.mdss/` — индекс (генерируется);
- `semantic/.cache/` — кэш моделей (большой);
- `semantic/.logs/` — логи переиндексации.

## Частые вопросы

**Нужен ли интернет?** Только для первой загрузки модели. Дальше поиск работает
офлайн.

**Можно ли сменить модель?** Да: `MDSS_MODEL=e5-base` (легче, 280 МБ) или флаг
`--model`. Смена модели → полная переиндексация. Подробности — в
[`../semantic/README.md`](../semantic/README.md).

**Это работает на Linux/macOS?** Да — используйте `*.sh`-обёртки. Task Scheduler
заменяется на `cron` (вызывайте `bash semantic/kb-index.sh`).
