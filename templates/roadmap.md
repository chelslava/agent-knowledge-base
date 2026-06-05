---
title: "<Название проекта> — Дорожная карта"
project: "<project-slug>"
type: roadmap
canonical: true
tags: [type/roadmap, domain/process, status/active]
updated: YYYY-MM-DD
---

# <Название проекта> — Дорожная карта

> Шаблон. Скопируй в `projects/<project>/roadmap.md`.

## Видение
Куда движется проект в горизонте 6–12 месяцев.

## Этапы (milestones)
| Этап | Цель | Срок | Статус |
|------|------|------|--------|
| M1 | … | YYYY-Qn | planned / in-progress / done |

## Ближайший спринт / итерация
- [ ] Задача 1
- [ ] Задача 2

## Бэклог
- Идея/задача → ссылка на [[requirements]] при детализации.

## Временная шкала

```mermaid
gantt
    title Roadmap
    dateFormat YYYY-MM-DD
    section Этап 1
    Задача A :a1, 2026-01-01, 30d
    section Этап 2
    Задача B :after a1, 20d
```

См. также: [[requirements]] · [[release-notes]] · [[project-index]]
