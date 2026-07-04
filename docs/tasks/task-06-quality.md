# Task 06: Tests, bugs, polish — этап 7

## Цель

Расширить unit/bloc-тесты, добавить polish (logout, pull-to-refresh), задокументировать
и исправить **3 намеренных бага** (каждый — `.md` + fix + PLATF commit).

## Тесты (PLATF-016)

| Уровень | Файлы |
| :-- | :-- |
| BLoC | `slots_bloc`, `slot_detail_bloc`, `my_bookings_bloc`, `booking_detail_bloc` |
| Repository | `booking_repository_mock` (early/late cancel, getBooking) |
| Service | `my_bookings_service_impl` (existing + empty list) |
| Slots filters | `slots_filter_applier`, `slots_repository_filter` (PLATF-021) |

Цель: `flutter test` — **56** зелёных; `flutter analyze` — 0 issues.

## Polish (PLATF-016)

- Logout в `HomeUserHeader`
- Pull-to-refresh на `SlotListScreen`
- README: статусы этапов 4–7 ✅

## Баги (PLATF-017…019)

| ID | Документ | Суть |
| :-- | :-- | :-- |
| 01 | [bug-01-stale-slots-after-booking.md](../bugs/bug-01-stale-slots-after-booking.md) | Расписание не обновляет `free_seats` после записи/отмены |
| 02 | [bug-02-stale-bookings-after-logout.md](../bugs/bug-02-stale-bookings-after-logout.md) | «Мои записи» показывают данные прошлой сессии после logout |
| 03 | [bug-03-cancel-window-truncation.md](../bugs/bug-03-cancel-window-truncation.md) | Окно отмены считается через `inMinutes` (теряются секунды) |

## Ручная проверка

См. [manual-test-checklist.md](../bugs/manual-test-checklist.md).

## Commits

```
PLATF-016: test(quality): expand bloc/repo tests, logout, pull-to-refresh
PLATF-017: fix(slots): refresh schedule after booking and cancel
PLATF-018: fix(my_bookings): reset list state on logout
PLATF-019: fix(booking): use Duration for cancellation window comparison
PLATF-020: feat(auth): UC-6 token refresh on startup and before API calls
PLATF-021: feat(slots): 7-day window, filters, seed data
PLATF-022: docs: sync README status and manual checklist
```
