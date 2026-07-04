# Task 01: Архитектура

## Цель

Спроектировать архитектуру клиентского Flutter-приложения «Глина»: модель данных, API-контракт, план слоёв Clean Architecture.

## Требования

- FR-9…FR-46, NFR-ARCH-1…5
- [data-model.md](../01-analysis/4-design/data-model.md)
- [api-contract.md](../01-analysis/4-design/api-contract.md)
- [02-architecture.md](../02-architecture.md)

## Реализация

| Артефакт | Содержание |
| :-- | :-- |
| `4-design/data-model.md` | Сущности, ERD, состояния, инварианты, Dart mapping |
| `4-design/api-contract.md` | REST endpoints, query params, errors, mock strategy |
| `02-architecture.md` | Feature modules, **application layer**, DI, BLoC, navigation, data flow |

## Промпты

[prompts/02-architecture.md](../../prompts/02-architecture.md)

## Инструменты

- Cursor IDE + Cursor AI Agent
- Референс: summer-school-2026, Deriverse/frontend

## Ручная проверка

- [x] Program/Master/Slot/Booking/Client покрывают US-2…US-10, US-16
- [x] `workshop_cancelled` + reason (R-008)
- [x] Цепочка I_Repo → … → Widget задокументирована
- [x] Application layer (`application/`, I*Service, *ServiceImpl) описан (NFR-ARCH-5)
- [x] Mock strategy описана
- [ ] **Студент:** согласен с feature split (auth / slots / booking / my_bookings)?

## Commit

```
PLATF-004: docs: architecture and data model for Glina app
```
