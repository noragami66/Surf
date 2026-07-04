# API-контракт (клиентское приложение «Глина»)

> Этап 2. Контракт для mock-репозиториев и будущей интеграции с бэкендом.
> Формат описания — по образцу [summer-school-2026/api](https://github.com/surfstudio/summer-school-2026/tree/main/01-analysis/api).
>
> Base URL (mock): `https://api.glina.example/v1`  
> Auth: `Authorization: Bearer {access_token}`

## Auth

| Method | Path | operationId | Описание |
| :-- | :-- | :-- | :-- |
| POST | `/auth/request-code` | requestAuthCode | OTP на телефон |
| POST | `/auth/verify-code` | verifyAuthCode | Проверка кода → tokens + client + `is_new` |
| POST | `/auth/refresh` | refreshToken | Обновление access/refresh |
| POST | `/auth/logout` | logout | Выход |

### request-code

**Body:** `{ "phone": "+79991234567" }`  
**200:** `{ "ttl_seconds": 300, "resend_after_seconds": 60 }`

### verify-code

**Body:** `{ "phone": "+79991234567", "code": "123456" }`  
**200:**

```json
{
  "access_token": "...",
  "refresh_token": "...",
  "is_new": true,
  "client": { "id": "uuid", "name": "", "phone": "+79991234567" }
}
```

## Programs & Masters (read-only)

| Method | Path | Описание |
| :-- | :-- | :-- |
| GET | `/programs` | Справочник программ |
| GET | `/masters` | Справочник мастеров |

## Slots

| Method | Path | operationId | Описание |
| :-- | :-- | :-- | :-- |
| GET | `/slots` | listSlots | Список слотов (SCR-002) |
| GET | `/slots/{slotId}` | getSlot | Карточка слота (SCR-003) |

### GET /slots — query parameters

| Param | Тип | Default | Описание |
| :-- | :-- | :-- | :-- |
| date_from | datetime | now | Начало периода (R-027) |
| date_to | datetime | now + 7d | Конец периода |
| program_type | enum[] | — | `handbuilding`, `wheel` (OR) |
| master_id | uuid[] | — | Фильтр по мастеру (OR) |
| only_available | bool | false | Только со свободными местами |
| limit | int | 50 | Пагинация |
| offset | int | 0 | Пагинация |

**200:** `{ "items": [Slot], "total": N }`

### Slot (response fragment)

```json
{
  "id": "uuid",
  "program": { "id": "uuid", "name": "Лепка для новичков", "type": "handbuilding", "duration_min": 120 },
  "master": { "id": "uuid", "name": "Анна" },
  "start_at": "2026-07-10T14:00:00Z",
  "total_seats": 6,
  "free_seats": 2,
  "free_rental_kits": 3,
  "price": { "amount": 250000, "currency": "RUB" },
  "rental_price": { "amount": 50000, "currency": "RUB" },
  "workshop_address": "ул. Гончарная, 12",
  "status": "scheduled"
}
```

> Money: amount в **копейках** (250000 = 2500.00 ₽) — как в «Волне».

## Bookings

| Method | Path | operationId | Описание |
| :-- | :-- | :-- | :-- |
| POST | `/bookings` | createBooking | Создать бронь (SCR-004) |
| GET | `/bookings` | listBookings | Мои брони (SCR-005) |
| GET | `/bookings/{bookingId}` | getBooking | Детали (SCR-006) |
| POST | `/bookings/{bookingId}/cancel` | cancelBooking | Отмена (UC-2) |

### POST /bookings

**Headers:** `Idempotency-Key: {uuid}` (обязательно, R-022)

**Body:**

```json
{
  "slot_id": "uuid",
  "seats_count": 2,
  "rental_count": 1
}
```

**201:** Booking + `price_total` (read-only)

**Errors:**

| code | HTTP | details |
| :-- | :-- | :-- |
| slot_full | 409 | `available_seats`, `available_rental_kits` |
| double_booking | 409 | `booking_id` |
| slot_cancelled | 410 | `slot_id`, `cancellation_reason` |
| slot_started | 422 | `slot_id`, `start_at` |

### POST /bookings/{id}/cancel

**200:** Booking со статусом `cancelled` или `late_cancel` (сервер решает по R-021).

### Booking status enum

`active` | `cancelled` | `late_cancel` | `workshop_cancelled`

При `workshop_cancelled` — поле `workshop_cancel_reason` (Must в UI, R-008).

## Profile (Should)

| Method | Path | Описание |
| :-- | :-- | :-- |
| GET | `/profile` | Текущий клиент |
| PATCH | `/profile` | Обновить имя (после OTP для `is_new`) |

## Mock-стратегия

1. `*RepositoryMock` хранит in-memory коллекции Slot/Booking/Client.
2. Seed-данные: 2 программы, 4 мастера, ~15 слотов на 7 дней.
3. `createBooking` / `cancelBooking` — атомарная проверка инвариантов.
4. Искусственная задержка 200–500 ms для имитации сети.
5. OTP: код `0000` в debug/mock.
