# День 1 — Анализ · «Гончарная мастерская „Глина“»

Артефакты аналитика по проекту летней школы Surf 2026. Структура повторяет
классический процесс работы аналитика: от входа заказчика до ТЗ, которое
передаётся в **День 2** разработчику.

Референс формата: [summer-school-2026 / 01-analysis](https://github.com/surfstudio/summer-school-2026/tree/main/01-analysis) (проект «Волна»).

> **Нумерация папок** (`0-`, `1-`, `2-`, `3-design/`) — этапы **аналитики День 1**.
> Это **не** совпадает с этапами проекта в [корневом README](../../README.md) (1. MVP … 7. Тесты).

## Маршрут по этапам (аналитика)

| Этап | Папка | Что внутри |
| :-- | :-- | :-- |
| **0. Вход** | [0-customer-brief/](0-customer-brief/) | [customer-brief.md](0-customer-brief/customer-brief.md) — сырой бриф заказчика |
| **1. Выявление требований** | [1-elicitation/](1-elicitation/) | [customer-questions.md](1-elicitation/customer-questions.md), [domain-description.md](1-elicitation/domain-description.md) |
| **2. Описание требований** | [2-requirements/](2-requirements/) | [business](2-requirements/business-requirements.md) · [functional](2-requirements/functional-requirements.md) · [non-functional](2-requirements/non-functional-requirements.md) · [user-stories](2-requirements/user-stories.md) · [use-cases](2-requirements/use-cases.md) |
| **3. Проектирование** | [3-design/](3-design/) | [data-model.md](3-design/data-model.md), [api-contract.md](3-design/api-contract.md) |
| **Архитектура Flutter** | [../02-architecture.md](../02-architecture.md) | Clean Architecture, feature modules, DI (этап проекта **2**) |
| **4. ТЗ / разработка** | app/ | Flutter-приложение — **этап проекта 3+** |

## Статус

| Артефакт | Статус |
| :-- | :-- |
| Бриф заказчика | ✅ Заполнен |
| Выявление (elicitation) | ✅ Заполнено |
| Требования (US, FR, UC, BR, NFR) | ✅ Заполнено |
| Модель данных + API | ✅ Этап 2 |
| Архитектура Flutter | ✅ Этап 2 |
| Flutter-приложение | ✅ Этапы 3–7 (PLATF-009…021, UC-6 в PLATF-020) |

**Передача в День 2:** итоговые требования + контракт API + архитектура + реализация.
