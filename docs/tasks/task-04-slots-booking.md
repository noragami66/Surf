# Task 04: Slots detail + Booking — этап 5

## Цель

Реализовать просмотр карточки слота и запись на мастер-класс: детальный экран,
форма бронирования (места + прокат), создание брони через mock-репозиторий.

Соответствует **US-2…8**, **UC-1** (запись), **UC-3** (просмотр слота),
API-контракту `/slots/{id}` и `POST /bookings`.

## Требования

| Источник | Что покрываем |
| :-- | :-- |
| UC-1 | seats 1–3, rental ≤ seats, idempotency key, price_total |
| UC-1 E1–E5 | slot_full, double_booking, slot_cancelled, slot_started |
| UC-3 | карточка слота: программа, мастер, места, прокат, цена |
| api-contract | GET slot, POST booking + error codes |
| Architecture | Widget → BLoC → Service → Repository |

## Архитектура (цепочка)

```
SlotDetailScreen → SlotDetailBloc → ISlotsService → SlotsRepositoryMock
BookingScreen → BookingBloc → IBookingService → BookingServiceImpl
  → IBookingRepository → BookingRepositoryMock → MockSlotStore
```

`MockSlotStore` — общее in-memory хранилище слотов и броней; счётчики мест
обновляются атомарно при `createBooking`.

## Артефакты

| Слой | Файлы |
| :-- | :-- |
| domain | `booking/domain/entities/booking_entity.dart`, `enums/booking_enums.dart`, `i_booking_repository.dart` |
| data | `booking/data/repositories/booking_repository_mock.dart`, `slots/data/mock_slot_store.dart` |
| application | `i_booking_service.dart`, `booking_service_impl.dart` |
| presentation | `slot_detail_bloc/*`, `slot_detail_screen.dart`, `booking_bloc/*`, `booking_screen.dart` |
| router | `/slots/:id`, `/slots/:id/book` (root navigator — без bottom nav) |
| l10n | slot detail + booking strings (ru + en) |
| tests | `booking_service_impl_test.dart`, `booking_bloc_test.dart` |

## BookingBloc

| Events | States |
| :-- | :-- |
| `LoadBookingSlotEvent` | loading → editing |
| `BookingSeatsChanged`, `BookingRentalChanged` | editing (estimated total) |
| `SubmitBookingEvent` | submitting → success / editing+error |

Idempotency-Key генерируется один раз на попытку и переиспользуется при retry.

## Mock

- `createBooking`: задержка ~350 ms; проверка инвариантов; idempotency cache.
- Успех → decrement `free_seats` / `free_rental_kits` в `MockSlotStore`.
- OTP / auth — без изменений (clientId из `AuthBloc`).

## Проверка

- [ ] `flutter analyze` — 0 issues
- [ ] `flutter test` — pass
- [ ] **Студент:** слот → деталь → запись → «Мои записи» (empty state пока, этап 6)

## Commit

```
PLATF-014: feat(slots): slot detail screen and booking flow
```
