# «Глина» — клиентское приложение гончарной мастерской

Учебный проект летней школы Surf 2026.

## Статус

| Этап | Статус |
| :-- | :-- |
| 1. MVP / Анализ | ✅ |
| 2. Архитектура | ✅ |
| 3. Flutter bootstrap + UI | ✅ PLATF-009…010 |
| 4. Auth (OTP) | ✅ PLATF-012 |
| 5. Slots detail + Booking | ✅ PLATF-014 |
| 6. My bookings + cancel | ✅ PLATF-015 |
| 7. Тесты + баги (3) | ✅ PLATF-016…019 |

> **Этап 7:** unit/bloc-тесты, polish, **3 бага** — см. [docs/bugs/README.md](docs/bugs/README.md).

## Соответствие нумерации этапов

| Контекст | Нумерация | Пример |
| :-- | :-- | :-- |
| **Проект (этот README)** | 1–7 | 1. MVP, 2. Архитектура, 3. Flutter bootstrap… |
| **Аналитика День 1** | Папки `0-`…`3-design/` | [docs/01-analysis/README.md](docs/01-analysis/README.md) |
| **Референс «Волна»** | `4-design/` в upstream | Мы используем `3-design/` — без пропуска «3» в нашей структуре |

## Структура

```
docs/01-analysis/   — артефакты аналитики (День 1)
docs/tasks/         — документы по задачам задания
docs/bugs/          — намеренные баги этапа 7
prompts/            — промпты для AI
app/                — Flutter-проект (этап 3+)
CHANGELOG.md        — журнал изменений (формат Keep a Changelog)
```

## Коммиты

Каждый commit начинается с **`PLATF-XXX`** (порядковый номер задачи). Суть изменений — в [CHANGELOG.md](CHANGELOG.md).

## Документация

- [CHANGELOG](CHANGELOG.md)
- [Промпты (AI)](prompts/README.md) — все промпты по этапам
- [README аналитики](docs/01-analysis/README.md)
- [Модель данных](docs/01-analysis/3-design/data-model.md)
- [API-контракт](docs/01-analysis/3-design/api-contract.md)
- [Архитектура Flutter](docs/02-architecture.md)
- [User stories](docs/01-analysis/2-requirements/user-stories.md)
- [Use cases](docs/01-analysis/2-requirements/use-cases.md)
- [Task 00: MVP](docs/tasks/task-00-mvp-analysis.md)
- [Task 01: Architecture](docs/tasks/task-01-architecture.md)
- [Task 02: Flutter bootstrap](docs/tasks/task-02-flutter-bootstrap.md)
- [Task 06: Quality](docs/tasks/task-06-quality.md)
- [App README (run)](app/README.md)

## Стек (план)

- Flutter + flutter_bloc
- Clean Architecture (4 слоя): domain / data / **application** / presentation  
  Цепочка: `I_Repo → RepoImpl → I_Service → ServiceImpl → BLoC → Widget`
- Mock-репозитории

## Инструменты

- Cursor IDE + Cursor AI Agent
