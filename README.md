# «Глина» — клиентское приложение гончарной мастерской

Учебный проект летней школы Surf 2026.

## Статус

| Этап | Статус |
| :-- | :-- |
| 1. MVP / Анализ | ✅ Готово |
| 2. Архитектура | ⏳ Следующий |
| 3. Flutter-приложение | ⏳ |
| 4–6. Фичи (3) | ⏳ |
| 7. Тесты + баги (3) | ⏳ |

## Структура

```
docs/01-analysis/   — артефакты аналитики (День 1)
docs/tasks/         — документы по задачам задания
prompts/            — промпты для AI
app/                — Flutter-проект (этап 3+)
CHANGELOG.md        — журнал изменений (формат Keep a Changelog)
```

## Коммиты

Каждый commit начинается с **`PLATF-XXX`** (порядковый номер задачи). Суть изменений — в [CHANGELOG.md](CHANGELOG.md).

## Документация

- [CHANGELOG](CHANGELOG.md)
- [README аналитики](docs/01-analysis/README.md)
- [User stories](docs/01-analysis/2-requirements/user-stories.md)
- [Use cases](docs/01-analysis/2-requirements/use-cases.md)
- [Task 00: MVP](docs/tasks/task-00-mvp-analysis.md)

## Стек (план)

- Flutter + flutter_bloc
- Clean Architecture: `I_Repo → RepoImpl → I_Service → ServiceImpl → BLoC → Widget`
- Mock-репозитории

## Инструменты

- Cursor IDE + Cursor AI Agent
