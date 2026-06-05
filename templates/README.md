---
title: Templates
type: index
tags: [meta/index]
updated: 2026-06-05
---

# 🧩 Templates — Шаблоны документации

Заготовки документов. Перед использованием **копируй** шаблон в нужное место и
заполняй — не редактируй сам шаблон.

## Шаблоны проекта
При создании проекта скопируй весь набор в `projects/<project>/`:

- [[project-overview]] — обзор проекта
- [[project-index]] — карта документов проекта
- [[architecture]] — архитектура (canonical)
- [[architecture-diagram]] — диаграммы (Mermaid)
- [[requirements]] — требования
- [[roadmap]] — дорожная карта
- [[decisions]] — журнал решений (ADR)
- [[api-reference]] — справочник API
- [[development-log]] — лог разработки
- [[release-notes]] — заметки о релизах
- [[technical-debt]] — технический долг

Плюс создай подпапки `wiki/` и `raw/`.

## Универсальные шаблоны
- [[wiki-note]] — заметка для `shared/` и `wiki/` проекта
- [[raw-note]] — сырой материал для `inbox/` и `raw/`

## Замени плейсхолдеры
- `<project-slug>`, `<Название проекта>` → реальные значения
- `YYYY-MM-DD` → дата по ISO
- теги — приведи к словарю [[taxonomy]]

См. также: [[index]] · [[projects-registry]] · [[AGENTS]]
