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

## Architecture

Clean Architecture (4 layers): `domain / data / application / presentation`.

```
Widget → BLoC → I_Service → ServiceImpl → I_Repository → RepositoryImpl
```

See [docs/02-architecture.md](../docs/02-architecture.md).

## Bootstrap status (PLATF-009)

- [x] Project `glina`, GetIt locator, go_router shell
- [x] Core: theme (palette), l10n (ru/en)
- [x] Features skeleton: auth, slots, booking, my_bookings
- [x] Slots vertical slice: mock repo → service → bloc → list screen + empty state
- [ ] Auth OTP UI (phase 4)
- [ ] Booking / my_bookings implementation (phases 4–6)

## Analyze

```bash
flutter analyze
flutter test
```
