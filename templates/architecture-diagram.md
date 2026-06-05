---
title: "<Название проекта> — Диаграммы архитектуры"
project: "<project-slug>"
type: diagram
canonical: true
tags: [type/diagram, domain/architecture, status/active]
updated: YYYY-MM-DD
---

# <Название проекта> — Диаграммы архитектуры

> Шаблон. Скопируй в `projects/<project>/architecture-diagram.md`.
> Диаграммы в [Mermaid](https://mermaid.js.org/). Текстовое описание → [[architecture]].

## Контекст (C4: System Context)

```mermaid
flowchart TB
    user([Пользователь]) --> system[Система]
    system --> ext[(Внешний сервис)]
```

## Контейнеры / компоненты

```mermaid
flowchart LR
    subgraph App
      api[API] --> svc[Сервис]
      svc --> db[(БД)]
    end
    client[Клиент] --> api
```

## Последовательность (ключевой сценарий)

```mermaid
sequenceDiagram
    actor U as Пользователь
    participant A as API
    participant S as Сервис
    U->>A: Запрос
    A->>S: Обработка
    S-->>A: Результат
    A-->>U: Ответ
```

## Модель данных (ER)

```mermaid
erDiagram
    ENTITY_A ||--o{ ENTITY_B : has
```

См. также: [[architecture]] · [[project-index]]
