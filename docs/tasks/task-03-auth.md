# Task 03: Auth (OTP) — этап 4

## Цель

Реализовать полный slice авторизации по OTP: ввод телефона → код → имя (для нового
пользователя) → сессия. Router закрывает приложение guard-ом: без сессии — только
экраны входа.

Соответствует **US-1**, **UC-5** (авторизация OTP), **UC-6** (обновление сессии),
API-контракту `/auth/*` и требованию хранения токенов в `flutter_secure_storage`
(R-024, R-025).

## Требования

| Источник | Что покрываем |
| :-- | :-- |
| UC-5 | phone → OTP → имя → токен → список слотов |
| UC-5 E1/E2 | неверный код, rate limit |
| UC-6 | refresh access/refresh токенов, logout при истечении refresh |
| api-contract Auth | request-code, verify-code (`is_new`, `client`), refresh, logout |
| R-024/R-025 | secure storage, `expires_in` / `refresh_expires_in` |
| Mock-стратегия §6 | OTP-код `0000` в mock |

## Архитектура (цепочка)

```
Widget (Login/Otp/Name) → AuthBloc → IAuthService → AuthServiceImpl
  → IAuthRepository → AuthRepositoryMock → in-memory session
                    → ITokenStorage → SecureTokenStorage
```

## Артефакты

| Слой | Файлы |
| :-- | :-- |
| domain | `entities/client_entity.dart`, `entities/auth_session.dart`, `repositories/i_auth_repository.dart` (расширен) |
| data | `models/auth_tokens_model.dart`, `models/client_model.dart`, `mappers/auth_mapper.dart`, `repositories/auth_repository_mock.dart`, `secure_token_storage.dart` (session) |
| application | `i_auth_service.dart` (расширен), `auth_service_impl.dart` |
| presentation | `manager/auth_bloc/*`, `screens/login_screen.dart`, `screens/otp_screen.dart`, `screens/name_screen.dart`, `widgets/*` |
| core | `exception/app_exception.dart` — auth-коды |
| router | `app/router.dart` — redirect guard на основе `AuthBloc` |
| l10n | `app_ru.arb`, `app_en.arb` — строки auth |

## AuthBloc

| Events | States (status enum) |
| :-- | :-- |
| `AuthStarted` (проверка сессии) | `unknown` |
| `AuthCodeRequested(phone)` | `unauthenticated` |
| `AuthCodeVerified(code)` | `codeSent` |
| `AuthNameSubmitted(name)` | `needName` (is_new) |
| `AuthLoggedOut` | `authenticated` |
| — | `failure` (сообщение) + под-статус loading |

`AuthState` хранит: `status`, `phone`, `client`, `errorCode`, `isSubmitting`.

## Mock

- `request-code`: задержка 300 ms, всегда успех.
- `verify-code`: код **`0000`** → успех; иначе `AppException.invalidCode`. Первый вход
  по номеру → `isNew = true`, `client.name = ''`.
- `refresh`: возвращает новую пару токенов.
- `logout`: чистит in-memory + secure storage.
- Rate limit: > 5 запросов кода подряд → `AppException.rateLimited` (демонстрация E2).

## Router guard

- `refreshListenable` = стрим/`AuthBloc`.
- `redirect`: если `status == unknown` — splash; если `unauthenticated`/`codeSent`/
  `needName` — держим на `/auth/*`; если `authenticated` — пускаем в `/slots`.

## Проверка

- [ ] `flutter analyze` — 0 issues (very_good_analysis)
- [ ] `flutter test` — pass (AuthServiceImpl + AuthBloc)
- [ ] `dart format` — clean
- [ ] **Студент:** `flutter run` — phone → `0000` → имя → слоты; logout → снова вход

## Commit

```
PLATF-012: feat(auth): OTP login flow, session guard, secure token storage
```
