---
title: "<Название проекта> — Справочник API"
project: "<project-slug>"
type: api
canonical: true
tags: [type/api, domain/backend, status/active]
updated: YYYY-MM-DD
---

# <Название проекта> — Справочник API

> Шаблон. Скопируй в `projects/<project>/api-reference.md`.

## Обзор
Базовый URL, версия, формат (REST / GraphQL / gRPC), аутентификация.

## Аутентификация
Схема (Bearer / API Key / OAuth2), заголовки, получение токена.

## Эндпоинты

### `METHOD /path`
- **Описание:** что делает.
- **Параметры:**

| Имя | В | Тип | Обяз. | Описание |
|-----|---|-----|-------|----------|
| … | path/query/body | string | да/нет | … |

- **Запрос:**
```http
POST /path HTTP/1.1
Content-Type: application/json

{ "field": "value" }
```
- **Ответ `200`:**
```json
{ "result": "..." }
```
- **Ошибки:** `400`, `401`, `404`, `500` — когда возникают.

<!-- Копируй блок для каждого эндпоинта -->

## Модели данных
Схемы объектов, ссылки на ER-модель в [[architecture-diagram]].

См. также: [[architecture]] · [[requirements]] · [[project-index]]
