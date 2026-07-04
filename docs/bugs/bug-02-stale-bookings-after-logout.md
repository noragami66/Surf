# Bug 02: Stale bookings after logout

## Symptom

После **logout** и входа под другим номером вкладка «Мои записи» может
кратковременно показывать **брони предыдущего пользователя**.

## Steps to reproduce

1. Войти, записаться на занятие — «Мои записи» показывает карточку.
2. Logout (иконка в шапке).
3. Войти с другим телефоном (новый mock-клиент).
4. Открыть «Мои записи» — видны записи **прошлой сессии** до ручного refresh.

## Expected

После logout список сбрасывается; новый пользователь видит empty state или свои брони.

## Root cause

`MyBookingsBloc` хранит `loaded` state в `StatefulShellRoute.indexedStack`.
`AuthLoggedOut` не сбрасывает bloc.

## Fix (PLATF-018)

`ResetMyBookingsEvent` при `AuthStatus.unauthenticated` через `BlocListener`.

## Prompt for AI

```
MyBookingsBloc не очищается при logout — fix через ResetMyBookingsEvent
и BlocListener на AuthBloc в GlinaApp.
```
