---
title: Taxonomy — Контролируемый словарь
type: taxonomy
canonical: true
tags: [meta/taxonomy]
updated: 2026-06-05
---

# 🏷️ Taxonomy — Контролируемый словарь тегов и категорий

> Единый словарь, чтобы знания были связными и находимыми. Поддерживается
> **автоматически** агентами (правило 7 в [[AGENTS]]). Перед введением нового
> тега проверь, нет ли подходящего существующего.

Теги иерархические, через `/`: например `pattern/architecture`, `lang/python`.

---

## 1. Тип документа (`type`)

| Тег | Назначение |
|-----|-----------|
| `type/overview` | Обзор проекта |
| `type/index` | Карта/индекс |
| `type/architecture` | Архитектура |
| `type/diagram` | Диаграмма |
| `type/requirements` | Требования |
| `type/roadmap` | Дорожная карта |
| `type/decision` | Решение (ADR) |
| `type/api` | Справочник API |
| `type/devlog` | Лог разработки |
| `type/release` | Заметки о релизе |
| `type/debt` | Технический долг |
| `type/wiki` | Свободная вики-заметка |
| `type/raw` | Сырой материал |
| `type/shared` | Общее переиспользуемое знание |

## 2. Домен знаний (`domain`)

| Тег | Назначение |
|-----|-----------|
| `domain/architecture` | Архитектура и проектирование |
| `domain/backend` | Бэкенд |
| `domain/frontend` | Фронтенд |
| `domain/devops` | Инфраструктура, CI/CD |
| `domain/data` | Данные, БД, ETL |
| `domain/ml` | ML / AI |
| `domain/security` | Безопасность |
| `domain/testing` | Тестирование |
| `domain/docs` | Документация |
| `domain/process` | Процессы и методология |

## 3. Технологии (`lang` / `tech`)

| Тег | Назначение |
|-----|-----------|
| `lang/python` `lang/typescript` `lang/go` `lang/rust` … | Языки |
| `tech/react` `tech/fastapi` `tech/postgres` `tech/docker` … | Фреймворки/инструменты |

## 4. Тип знания (`kind`)

| Тег | Назначение |
|-----|-----------|
| `kind/pattern` | Паттерн |
| `kind/recipe` | Рецепт (пошаговое решение) |
| `kind/guide` | Гайд/руководство |
| `kind/checklist` | Чек-лист |
| `kind/gotcha` | Подводный камень |
| `kind/reference` | Справочный материал |

## 5. Статус (`status`)

| Тег | Назначение |
|-----|-----------|
| `status/draft` | Черновик |
| `status/active` | Актуально |
| `status/stable` | Стабильно/canonical |
| `status/deprecated` | Устарело |
| `status/archived` | В архиве |

## 6. Мета (`meta`)

| Тег | Назначение |
|-----|-----------|
| `meta/index` `meta/changelog` `meta/taxonomy` `meta/rules` | Служебные документы |

---

## Правила тегирования

1. Каждый документ имеет **минимум один** `type/*`.
2. Указывай `status/*` и хотя бы один `domain/*` или `kind/*`.
3. Не плоди синонимы — расширяй этот словарь осознанно.
4. При добавлении нового тега — запиши его сюда и в [[CHANGELOG]].

См. также: [[index]] · [[knowledge-rules]] · [[AGENTS]]
