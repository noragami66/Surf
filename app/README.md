# Glina — Flutter client

Mobile client for the «Глина» pottery workshop (Surf summer school 2026).

## Run

```bash
cd app
flutter pub get
flutter gen-l10n   # if l10n not generated yet
flutter run
```

From repo root with FVM cache Flutter:

```bash
cd app
/Users/alekseycodintsev/fvm/cache.git/bin/flutter run
```

**Mock OTP:** `0000`

## Architecture

Clean Architecture (4 layers): `domain / data / application / presentation`.

```
Widget → BLoC → I_Service → ServiceImpl → I_Repository → RepositoryImpl
```

See [docs/02-architecture.md](../docs/02-architecture.md).

## Feature status

| Этап | PLATF | Статус |
| :-- | :-- | :-- |
| Bootstrap, DI, router, l10n | 009 | ✅ |
| Dark glass UI + polish | 010, 013 | ✅ |
| Auth OTP + session guard + UC-6 refresh | 012, 020 | ✅ |
| Slots list (7 days, filters) | 021 | ✅ |
| Slot detail + booking | 014 | ✅ |
| My bookings + cancel | 015 | ✅ |
| Tests + bug fixes | 016…019 | ✅ |

### Checklist

- [x] Project `glina`, GetIt locator, go_router shell
- [x] Core: theme, l10n (ru/en), glass widgets
- [x] Auth: phone → OTP → name, secure storage, logout
- [x] Slots: 7-day window, filters, empty states, pull-to-refresh
- [x] Booking: form, idempotency, mock store seat updates
- [x] My bookings: list, detail, early/late cancel
- [x] `flutter analyze` — 0 issues; `flutter test` — 56 tests

Ручная проверка UI: [manual-test-checklist.md](../docs/bugs/manual-test-checklist.md).

## Analyze

```bash
flutter analyze
flutter test
```
