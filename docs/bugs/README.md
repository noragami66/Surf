# Намеренные баги (этап 7)

Три бага для учебного сценария «найти → воспроизвести → исправить».

Каждый баг:

1. Описан в отдельном `.md` (симптом, шаги, ожидание, root cause).
2. Исправлен в коде отдельным commit с префиксом `PLATF-XXX`.
3. Покрыт тестом там, где возможно.

| Баг | PLATF | Статус |
| :-- | :-- | :-- |
| [Stale slots after booking](bug-01-stale-slots-after-booking.md) | PLATF-017 | ✅ fixed |
| [Stale bookings after logout](bug-02-stale-bookings-after-logout.md) | PLATF-018 | ✅ fixed |
| [Cancel window truncation](bug-03-cancel-window-truncation.md) | PLATF-019 | ✅ fixed |

Ручная проверка MVP: [manual-test-checklist.md](manual-test-checklist.md) (17 пунктов, ✅).
