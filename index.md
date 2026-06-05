---
title: Index — Карта базы знаний
type: index
canonical: true
tags: [meta/index]
updated: 2026-06-05
---

# 🗺️ Index — Карта базы знаний

> Главная точка входа. Поддерживается **автоматически** агентами после каждого
> значимого изменения (правило 5 в [[AGENTS]]).

---

## Корневые документы

- [[AGENTS]] — правила работы агентов (контракт)
- [[knowledge-rules]] — правила управления знаниями
- [[taxonomy]] — контролируемый словарь тегов и категорий
- [[CHANGELOG]] — журнал изменений базы знаний
- [[projects-registry]] — реестр всех проектов

---

## Разделы

### 📥 inbox/
Сырые входные данные, черновики, недооформленные мысли. Подлежат разбору и
переносу в `shared/` или `projects/`.

### 🌐 shared/
Переиспользуемые между проектами знания: паттерны, рецепты, чек-листы, гайды.
**Источник общих знаний** — ссылайся сюда из проектов, не копируй.

### 📦 projects/
Документация проектов. Каждый проект — отдельная папка со стандартным набором
документов. Реестр: [[projects-registry]].

### 🧩 templates/
Шаблоны документов:
- [[project-overview]] · [[project-index]] · [[architecture]] · [[architecture-diagram]]
- [[requirements]] · [[roadmap]] · [[decisions]] · [[api-reference]]
- [[development-log]] · [[release-notes]] · [[technical-debt]]
- [[wiki-note]] · [[raw-note]]

### 🔎 semantic/
Конфигурация и индексы [md-semantic-search](https://github.com/chelslava/md-semantic-search).

---

## Карта shared-знаний

> Заполняется по мере наполнения `shared/`. Пример структуры:

- shared/patterns/ — архитектурные и кодовые паттерны
- shared/recipes/ — пошаговые рецепты решения задач
- shared/guides/ — гайды и руководства
- shared/checklists/ — чек-листы

---

## Активные проекты

> Подробности — в [[projects-registry]].

| Проект | Статус | Документы |
|--------|--------|-----------|
| _(пока нет)_ | — | — |

---

См. также: [[AGENTS]] · [[taxonomy]] · [[CHANGELOG]]
