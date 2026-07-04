# Task 02: Flutter bootstrap (этап 3)

## Цель

Создать Flutter-проект `app/` со структурой Clean Architecture, DI, l10n и skeleton feature-модулей.

## Требования

- NFR-ARCH-1…5, [02-architecture.md](../02-architecture.md) (этап 3)
- Mock-репозитории, `flutter analyze` без warnings

## Реализация

| Артефакт | Содержание |
| :-- | :-- |
| `app/` | Flutter project `glina` |
| `lib/dependency_injection/locator/` | GetIt registration |
| `lib/features/*` | auth, slots, booking, my_bookings skeleton |
| `lib/l10n/` | ru + en ARB |
| Slots slice | Mock → Service → Bloc → SlotListScreen (empty state) |

## Промпты

[prompts/03-flutter-bootstrap.md](../../prompts/03-flutter-bootstrap.md)

## Ручная проверка

- [x] `flutter create` + dependencies
- [x] Структура папок по architecture doc
- [x] `flutter analyze` — no issues
- [x] `flutter test` — pass
- [x] **Студент:** `flutter run` — см. [manual-test-checklist.md](../bugs/manual-test-checklist.md)

## Commit

```
PLATF-009: feat: Flutter bootstrap with Clean Architecture skeleton
```
