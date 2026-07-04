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
> DI через get_it, mock repos, go_router navigation.

---

## Использованные материалы

| Источник | Путь |
| :-- | :-- |
| Data model «Волна» | summer-school-2026/01-analysis/4-design/data-model.md |
| API «Волна» | summer-school-2026/01-analysis/api/ |
| Deriverse feature sample | frontend/lib/features/statistics_data/ |
| Требования этапа 1 | docs/01-analysis/2-requirements/ |
