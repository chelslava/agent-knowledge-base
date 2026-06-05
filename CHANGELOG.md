---
title: CHANGELOG — Журнал изменений базы знаний
type: changelog
canonical: true
tags: [meta/changelog]
updated: 2026-06-05
---

# 📜 CHANGELOG — Журнал изменений базы знаний

> Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/).
> Поддерживается **автоматически** агентами (правило 6 в [[AGENTS]]).
>
> Типы изменений: `Added` (добавлено), `Changed` (изменено),
> `Deprecated` (устарело), `Removed` (удалено), `Fixed` (исправлено),
> `Knowledge` (новое знание/решение).

---

## [0.1.0] — 2026-06-05

### Added
- Инициализирован публичный шаблон базы знаний для ИИ-агентов.
- Корневые документы-контракт: [[AGENTS]], [[knowledge-rules]], [[index]],
  [[taxonomy]], [[CHANGELOG]], [[projects-registry]].
- Шаблоны документации в `templates/`: [[project-overview]], [[project-index]],
  [[architecture]], [[architecture-diagram]], [[requirements]], [[roadmap]],
  [[decisions]], [[api-reference]], [[development-log]], [[release-notes]],
  [[technical-debt]], [[wiki-note]], [[raw-note]].
- Разделы `inbox/`, `shared/`, `projects/`, `templates/`, `semantic/`, `tools/`.
- Интеграция семантического поиска
  [md-semantic-search](https://github.com/chelslava/md-semantic-search) в `semantic/`:
  обёртки `kb-index.{ps1,sh}` / `kb-search.{ps1,sh}` (модель по умолчанию `bge-m3`),
  раннер планировщика `kb-reindex-task.ps1` и установщик `install-task.ps1`,
  пример env `mdss.env.example`.
- Автоматизация для агента: `tools/kb-autocommit.{ps1,sh}` (автокоммит базы через
  Stop-hook, путь-независимый — корень репо вычисляется от расположения скрипта).
- Документация: `README.md`, `docs/SETUP.md`, `docs/AGENT-INTEGRATION.md`,
  лицензия MIT.

---

<!--
Шаблон новой записи:

## [X.Y.Z] — YYYY-MM-DD

### Added / Changed / Knowledge / Fixed / Removed
- Краткое описание. Ссылки: [[...]].
-->

См. также: [[index]] · [[AGENTS]]
