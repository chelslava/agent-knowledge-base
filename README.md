# 🧠 agent-knowledge-base

> **Долговременная память для ИИ-агентов** — самодостаточный каркас базы знаний
> на Markdown с локальным семантическим поиском (без облака и API-ключей) и
> протоколом работы для Claude Code, Cursor, Gemini CLI, Aider и др.

[![Use this template](https://img.shields.io/badge/Use%20this%20template-2ea44f?logo=github&logoColor=white)](https://github.com/chelslava/agent-knowledge-base/generate)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Markdown](https://img.shields.io/badge/format-Markdown-083fa1)
![Local-first](https://img.shields.io/badge/search-local%20%C2%B7%20no%20API%20keys-2ea44f)
![Cross-lingual](https://img.shields.io/badge/embeddings-bge--m3%20(RU%2FEN)-blue)

> [!NOTE]
> **🇬🇧 TL;DR (English).** A drop-in, file-based long-term memory for AI coding
> agents. Markdown notes + Obsidian-style `[[wikilinks]]` + a controlled taxonomy,
> governed by a single contract file (`AGENTS.md`) every agent reads first. Ships
> with local, cross-lingual semantic search (via
> [md-semantic-search](https://github.com/chelslava/md-semantic-search), runs
> fully offline) to prevent duplicate notes, document templates for projects, and
> an optional auto-commit hook so your knowledge stays versioned. Clone, point
> your agent at it, done. Docs below are in Russian.

---

## Зачем это нужно

ИИ-агенты теряют контекст между сессиями и проектами. Эта база — **единый
внешний «мозг»**: накопленные решения, паттерны, архитектура и грабли живут в
обычных Markdown-файлах, которые агент читает **перед** задачей и пополняет
**после**. Никакой векторной БД в облаке, никаких API-ключей — всё считается
локально на вашей машине.

Ключевая идея: **один контракт-файл `AGENTS.md`**, который любой агент читает
первым, задаёт правила игры — куда складывать знания, как связывать, как искать
перед созданием заметки, чтобы не плодить дубликаты.

## Что внутри (что сделано и для чего)

| Компонент | Что это | Зачем |
|-----------|---------|-------|
| **`AGENTS.md`** | Главный контракт для агентов | Единые правила: читается первым в любой сессии |
| **`knowledge-rules.md`** | Детальные правила управления знаниями | Single Source of Truth, антидубликат-протокол, связи |
| **`taxonomy.md`** | Контролируемый словарь тегов | Знания остаются связными и находимыми |
| **`index.md`** | Карта базы знаний | Главная точка входа, поддерживается агентами |
| **`CHANGELOG.md`** | Журнал изменений базы | История знаний по [Keep a Changelog](https://keepachangelog.com/ru/) |
| **`templates/`** | 13 шаблонов документации | Единый формат для проектов (overview, ADR, архитектура, API…) |
| **`projects/`** | Документация по проектам + реестр | Структурированная память по каждому проекту |
| **`shared/`** | Переиспользуемые знания | Паттерны/рецепты/гайды — один источник на все проекты |
| **`inbox/`** | Входящие, черновики | Зона разбора сырья перед оформлением |
| **`semantic/`** | Локальный семантический поиск | Кросс-язычный (RU↔EN) поиск перед созданием заметки |
| **`tools/`** | Авто-коммит хук | База всегда версионируется в git без ручных коммитов |

### Принципы, заложенные в каркас

- **Single Source of Truth.** Одна тема — один канонический документ
  (`canonical: true`); остальное ссылается через `[[wikilink]]`, текст не копируется.
- **Антидубликат-протокол.** Перед созданием заметки — **семантический поиск**.
  Тема уже покрыта → дополняем существующий документ, а не плодим новый.
- **Obsidian-совместимость.** Связи через `[[...]]`, YAML-frontmatter, иерархичные
  теги — базу можно открыть в [Obsidian](https://obsidian.md/) как vault.
- **Локальность и приватность.** Эмбеддинги (`bge-m3`, 1024d) считаются офлайн;
  индекс и кэш моделей не коммитятся.

## Структура репозитория

```
agent-knowledge-base/
├── AGENTS.md                 # 📜 главный контракт для ИИ-агентов (читается первым)
├── knowledge-rules.md        # 📐 детальные правила управления знаниями
├── index.md                  # 🗺️ карта базы знаний
├── taxonomy.md               # 🏷️ контролируемый словарь тегов
├── CHANGELOG.md              # 📜 журнал изменений
├── inbox/                    # 📥 входящие/черновики (зона разбора)
├── shared/                   # 🌐 переиспользуемые знания (паттерны, рецепты, гайды)
├── projects/                 # 📦 документация проектов + projects-registry.md
├── templates/                # 🧩 13 шаблонов документов
├── semantic/                 # 🔎 семантический поиск (md-semantic-search)
│   ├── kb-index.{ps1,sh}     #    индексация (обёртки, модель bge-m3)
│   ├── kb-search.{ps1,sh}    #    поиск
│   ├── kb-reindex-task.ps1   #    раннер авто-переиндексации (Task Scheduler)
│   ├── install-task.ps1      #    установка задачи планировщика (Windows)
│   └── mdss.env.example      #    пример env-переменных
├── tools/
│   └── kb-autocommit.{ps1,sh}# 🤖 автокоммит базы через Stop-hook агента
├── docs/
│   ├── SETUP.md              # установка и запуск
│   └── AGENT-INTEGRATION.md  # интеграция с Claude Code (CLAUDE.md + хук)
└── LICENSE                   # MIT
```

## Быстрый старт

> Подробности — в [`docs/SETUP.md`](docs/SETUP.md).

**1. Клонировать**

```bash
git clone https://github.com/chelslava/agent-knowledge-base.git
cd agent-knowledge-base
```

**2. Поставить движок поиска** (Node ≥ 18; первый запуск скачает модель `bge-m3` ~2.3 ГБ)

```bash
npm install -g md-semantic-search   # даёт команды mdss / md-semantic-search
```

**3. Построить индекс и проверить поиск**

```powershell
# Windows / PowerShell
pwsh semantic/kb-index.ps1
pwsh semantic/kb-search.ps1 "правила оформления заметок"
```

```bash
# POSIX / bash
bash semantic/kb-index.sh
bash semantic/kb-search.sh "правила оформления заметок"
```

**4. Подключить агента.** Дайте агенту прочитать `AGENTS.md` первым.
Для Claude Code — см. [`docs/AGENT-INTEGRATION.md`](docs/AGENT-INTEGRATION.md)
(глобальный блок в `CLAUDE.md` + авто-коммит через Stop-hook).

## Как с этим работать (рабочий цикл)

1. **Перед задачей** — читать документацию проекта и `shared/`, выполнить
   семантический поиск (`kb-search`).
2. **Создавая заметку** — взять шаблон из `templates/`, заполнить frontmatter,
   проставить `[[ссылки]]`.
3. **После изменений** — обновить `index.md`, `CHANGELOG.md`, `taxonomy.md`
   (агент делает это по контракту; авто-коммит фиксирует в git).
4. **Новый проект** — зарегистрировать в `projects/projects-registry.md`,
   скопировать набор шаблонов в `projects/<name>/`.

## Семантический поиск

Движок — [md-semantic-search](https://github.com/chelslava/md-semantic-search)
(CLI `mdss`, на `@xenova/transformers`). Работает **локально, без API-ключей**,
поддерживает **кросс-язычный** поиск: запрос на русском находит документ на
английском и наоборот. Модель этой базы — `bge-m3` (закреплена в обёртках
`kb-index.*`). Полная справка — в [`semantic/README.md`](semantic/README.md).

## Совместимость

- **Агенты:** Claude Code, Cursor, Gemini CLI, Aider, OpenCode, Roo Code и любой,
  кто умеет читать `AGENTS.md`.
- **ОС:** Windows (PowerShell-обёртки + Task Scheduler) и POSIX (bash-обёртки).
- **Редакторы знаний:** Obsidian (vault), VS Code, любой Markdown-редактор.

## Благодарности

Семантический поиск — [md-semantic-search](https://github.com/chelslava/md-semantic-search).
Соглашения: [Keep a Changelog](https://keepachangelog.com/),
[Architecture Decision Records](https://adr.github.io/),
[Obsidian](https://obsidian.md/).

## Лицензия

[MIT](LICENSE).
