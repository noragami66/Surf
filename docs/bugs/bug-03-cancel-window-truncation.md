# Bug 03: Cancellation window uses truncated minutes

## Symptom

Отмена за **2 часа 1 минуту** до начала (окно = 120 мин) ошибочно считается
**поздней** (`late_cancel`), хотя должна быть **ранней** (`cancelled`).

## Steps to reproduce

1. Mock-слот с `start_at = now + 121 minutes`.
2. Создать бронь, отменить.
3. Статус `late_cancel` вместо `cancelled` — места не возвращаются.

## Expected

Ранняя отмена, если до начала ≥ `cancellation_window_minutes` (120 мин).

## Root cause

`BookingRepositoryMock.cancelBooking` использовал `difference.inMinutes`, который
**отбрасывает секунды** (121 min 30 sec → 121, но 120 min 45 sec → 120).

## Fix (PLATF-019)

Сравнивать `slot.startAt.difference(DateTime.now())` с
`Duration(minutes: AppConfigMock.cancellationWindowMinutes)`.

## Prompt for AI

```
Fix early vs late cancel: replace inMinutes with Duration comparison
in BookingRepositoryMock.cancelBooking.
```
