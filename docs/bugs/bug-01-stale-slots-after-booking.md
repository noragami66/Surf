# Bug 01: Stale slots after booking / cancel

## Symptom

После успешной записи или отмены брони экран «Расписание» показывает **старое**
число свободных мест. Pull-to-refresh помогает, но автоматического обновления нет.

## Steps to reproduce

1. Войти в приложение, открыть «Расписание» — запомнить `free_seats` у слота.
2. Записаться на этот слот (1 место).
3. Вернуться на вкладку «Расписание» — счётчик мест **не изменился**.

## Expected

`free_seats` уменьшается сразу после записи; после ранней отмены — возвращается.

## Root cause

`SlotsBloc` загружается один раз при старте. `BookingScreen` и отмена не
отправляют `RefreshSlotsEvent`.

## Fix (PLATF-017)

После успешной записи и после отмены брони — `RefreshSlotsEvent` в `SlotsBloc`.

## Prompt for AI

```
После createBooking и cancelBooking расписание показывает старые free_seats.
Добавь автоматический RefreshSlotsEvent в SlotsBloc.
```
