# Промпт — продолжение проекта «Глина» (новый чат)

> **Статус (PLATF-020):** этапы 1–7 + UC-6 завершены. Используйте для контекста или доработок.

> Скопируй блок **«Промпт для нового чата»** ниже целиком в новый чат Cursor Agent.

---

## Промпт для нового чата

```
Проект «Глина» — Flutter-клиент гончарной мастерской (Surf summer school 2026).
Репозиторий: /Users/alekseycodintsev/Documents/Surf
GitHub: https://github.com/noragami66/Surf.git (ветка main, всё запушено).

## Правила работы
- После каждого завершённого действия агента: **commit + push** с префиксом **PLATF-XXX** (следующий — **PLATF-012**).
- Обновляй CHANGELOG.md.
- Архитектура: Clean Architecture (4 слоя) — domain / data / application / presentation.
- Цепочка: Widget → BLoC → I_Service → ServiceImpl → I_Repository → RepositoryImpl.
- Mock-репозитории, строки в l10n (ru + en), ThemeExtension без magic numbers.
- Стиль UI: тёмный минимализм + glassmorphism (см. PLATF-010).
- Код: package imports, English comments, dart format, very_good_analysis — 0 issues.

## Что уже сделано

| Этап | PLATF | Статус |
| :-- | :-- | :-- |
| 1. MVP / Аналитика | PLATF-001…003 | ✅ |
| 2. Архитектура | PLATF-004…008 | ✅ |
| 3. Flutter bootstrap | PLATF-009 | ✅ |
| UI: dark glass design system | PLATF-010 | ✅ |

### Текущее состояние app/
- Flutter-проект: `app/` (name: glina)
- DI: `dependency_injection/locator/locator.dart` (get_it)
- Роутинг: go_router, StatefulShellRoute (вкладки Slots / Bookings)
- **slots**: mock repo → service → bloc → SlotListScreen + SlotCard (3 mock-слота)
- **my_bookings**: placeholder screen (glass empty state)
- **auth**: skeleton (IAuthRepository, AuthServiceImpl, AuthRepositoryMock, token storage) — **без UI и AuthBloc**
- **booking**: только IBookingService interface + IBookingRepository — **не реализовано**
- Дизайн: `core/style/` (palette, theme extensions), `core/widgets/` (AmbientBackground, GlassContainer, GlassBottomNav)

Запуск: `cd app && flutter run` (FVM: `/Users/alekseycodintsev/fvm/cache.git/bin/flutter`)

## Общий план (этапы 4–7)

| Этап | Фокус | Ключевые US/UC | Экраны / артефакты |
| :-- | :-- | :-- | :-- |
| **4. Auth** | OTP-авторизация, сессия | US-1, UC-5, UC-6 | LoginScreen, OtpScreen, NameScreen, AuthBloc, router guard, flutter_secure_storage |
| **5. Slots + Booking** | Деталь слота + запись | US-2…8, UC-1, UC-3 | SlotDetailScreen, BookingScreen, BookingBloc, BookingServiceImpl, BookingRepositoryMock |
| **6. My Bookings** | Список, деталь, отмена | US-9,10,16 UC-2, UC-4 | MyBookingsBloc, list/detail/cancel, cancellation_window из GET /config |
| **7. Тесты + баги** | Качество | — | unit (service, bloc), 3 намеренных бага (.md + fix + PLATF commit каждый) |

Навигация (целевая): Launch → AuthCheck → Login → Slots → Detail → Booking → MyBookings → BookingDetail.
См. mermaid в docs/02-architecture.md.

## Документы (читать перед реализацией)
- docs/02-architecture.md — структура, BLoC, сервисы, checklist
- docs/01-analysis/3-design/data-model.md — сущности
- docs/01-analysis/3-design/api-contract.md — mock API
- docs/01-analysis/2-requirements/use-cases.md — UC-1…6
- docs/01-analysis/2-requirements/functional-requirements.md — FR
- prompts/README.md — промпты по этапам

## Задача сейчас

**Стартуем этап 4 — Auth (OTP).**

Сделай:
1. Прочитай architecture doc + UC-5/UC-6 + api-contract (auth endpoints).
2. Создай docs/tasks/task-03-auth.md и prompts/05-auth.md (если нужно).
3. Реализуй полный auth slice:
   - AuthBloc (RequestCode, VerifyCode, SetName, Logout)
   - Экраны в glass-стиле (phone → OTP → имя)
   - Router: redirect если нет сессии
   - Mock: AuthRepositoryMock (код 1234 или из контракта)
   - SecureTokenStorage для access/refresh
4. flutter analyze + flutter test — без issues.
5. Commit PLATF-012 + push + CHANGELOG.

Не трогай booking/my_bookings beyond router integration — это этапы 5–6.
```

---

## Краткая шпаргалка для агента

```
PLATF-012 → Auth (OTP + session)
PLATF-013 → Slot detail + Booking flow
PLATF-014 → My bookings (list, detail, cancel)
PLATF-015+ → Tests, dev_panel, intentional bugs (этап 7)
```
