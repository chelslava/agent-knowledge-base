---
title: Projects Registry — Реестр проектов
type: index
canonical: true
tags: [meta/index, domain/process]
updated: 2026-06-05
---

# 📦 Projects Registry — Реестр проектов

> Единый реестр всех проектов базы знаний. Каждая запись ссылается на
> [[project-index|карту документов проекта]]. Поддерживается агентами при
> создании/архивации проектов.

---

## Активные проекты

| Проект | Папка | Статус | Обзор | Карта | Обновлён |
|--------|-------|--------|-------|-------|----------|
| _(пока нет)_ | — | — | — | — | — |

<!--
Пример заполненной строки:
| my-app | `projects/my-app/` | active | [[project-overview]] | [[project-index]] | 2026-06-05 |
-->

---

## Архивные проекты

| Проект | Папка | Архивирован | Причина |
|--------|-------|-------------|---------|
| _(пока нет)_ | — | — | — |

---

## Как добавить проект

1. Создай папку `projects/<project-name>/`.
2. Скопируй в неё стандартный набор документов из `templates/`:
   - [[project-overview]], [[project-index]], [[architecture]],
     [[architecture-diagram]], [[requirements]], [[roadmap]], [[decisions]],
     [[api-reference]], [[development-log]], [[release-notes]], [[technical-debt]].
3. Создай подпапки `wiki/` и `raw/`.
4. Заполни `project-overview.md` и `project-index.md`.
5. Добавь строку в таблицу **Активные проекты** выше.
6. Обнови [[index]] и [[CHANGELOG]].

> Перед стартом работы по проекту — читать его документацию (правило 1 в [[AGENTS]])
> и выполнять семантический поиск (правило 2).

---

## Стандартная структура проекта

```
projects/<project-name>/
├── project-overview.md      # обзор, цели, контекст
├── project-index.md         # карта документов проекта
├── architecture.md          # архитектура (canonical)
├── architecture-diagram.md  # диаграммы (Mermaid)
├── requirements.md          # требования
├── roadmap.md               # дорожная карта
├── decisions.md             # журнал решений (ADR)
├── api-reference.md         # справочник API
├── development-log.md       # лог разработки
├── release-notes.md         # заметки о релизах
├── technical-debt.md        # технический долг
├── wiki/                    # внутренняя вики проекта
└── raw/                     # сырые материалы
```

См. также: [[index]] · [[AGENTS]] · [[knowledge-rules]]
