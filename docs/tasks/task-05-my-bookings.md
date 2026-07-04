# Task 05: My Bookings — этап 6

## Цель

Список броней клиента, деталь записи, отмена (UC-2). Этап 6 — PLATF-015.

## Требования

| Источник | Что покрываем |
| :-- | :-- |
| US-9, US-10 | список и деталь «Мои записи» |
| US-16, UC-2 | отмена записи (ранняя / поздняя) |
| UC-4 | статус `workshop_cancelled` + причина (read-only в детали) |
| api-contract | `GET /bookings`, `GET /bookings/{id}`, `POST .../cancel`, `/config` |

## Архитектура

```
MyBookingsScreen → MyBookingsBloc → IMyBookingsService → MyBookingsServiceImpl
  → IBookingRepository → BookingRepositoryMock → MockSlotStore
BookingDetailScreen → BookingDetailBloc → IMyBookingsService
```

## Артефакты

| Статус | Компонент |
| :-- | :-- |
| ✅ | listBookings, MyBookingsBloc, BookingCard, refresh on book/tab |
| ✅ | Nav fix: AppRoutes.slotBook on slot detail |
| 🔲 | getBooking, cancelBooking, BookingDetailScreen, /bookings/:id |
| 🔲 | cancellation_window_minutes mock (120 min) |
| 🔲 | Tests |
