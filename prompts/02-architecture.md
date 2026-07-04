# Промпты — Этап 2: Архитектура

> Инструмент: **Cursor AI** (Agent mode).

---

## Prompt 7 — Старт этапа 2

**Промпт:**
> Переходим к этапу 2, также в readme добавь в разделе документации ссылку на prompts
> чтобы при проверке преподователям было проще ориентироваться и не забывай промпты обновлять

**Задача:**
- data-model.md, api-contract.md, 02-architecture.md
- prompts/02-architecture.md, task-01-architecture.md
- README: ссылка на prompts/
- Commit PLATF-004

---

## Prompt 8 — Внутренний (data model)

**Промпт (неявный):**
> Адаптируй data-model «Волны» для «Глины»:
> Route→Program (handbuilding/wheel), Instructor→Master,
> free_rental_boards→free_rental_kits, club_cancelled→workshop_cancelled,
> убрать geometry/meeting_point_lat/lng, добавить workshop_address.

---

## Prompt 9 — Внутренний (architecture)

**Промпт (неявный):**
> Спроектируй Flutter Clean Architecture по правилам пользователя:
> I_Repo → RepoImpl → I_Service → ServiceImpl → BLoC → Widget.
> Feature modules: auth, slots, booking, my_bookings.
> Обязательный слой application/ (I*Service, *ServiceImpl) между BLoC и Repository.
> DI через get_it (locator.dart), mock repos, go_router navigation.

---

## Prompt 10 — Application layer (2026-07-04)

**Промпт:**

> Я забыл про application layer, добавь его.

**Задача:**

- Секция «Слой application» в `02-architecture.md` (ответственность, таблица сервисов, пример кода)
- NFR-ARCH-5: `application/` обязателен в каждой feature
- Маппинг слоёв в `data-model.md`, разделение валидации в `api-contract.md`
- README, task-01, prompts обновлены

---

## Prompt 11 — Ревью документов (2026-07-04)

**Промпт:**

> Провёл ревью пакета документов — 12 замечаний. Режим Q&A: rental projection, FR-13,
> cancellation_window_minutes, риск R-001, R-реестр, 3-design rename, session refresh…

**Решения студента:**

- П.3: `cancellation_window_minutes`, дефолт 120
- П.4: Phase 2 + открытый риск №1
- П.11–12: Must silent refresh + `expires_in`
- П.8: rename `4-design` → `3-design`
- П.10: `flutter_secure_storage`

---

## Использованные материалы

| Источник | Путь |
| :-- | :-- |
| Data model «Волна» | summer-school-2026/01-analysis/4-design/data-model.md |
| API «Волна» | summer-school-2026/01-analysis/api/ |
| Deriverse feature sample | frontend/lib/features/statistics_data/ |
| Требования этапа 1 | docs/01-analysis/2-requirements/ |
