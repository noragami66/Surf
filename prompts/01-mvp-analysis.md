# Промпты — Этап 1: MVP / Анализ

> Все промпты, использованные при генерации артефактов аналитики.
> Инструмент: **Cursor AI** (Agent mode).

---

## Prompt 1 — Старт проекта и выбор брифа

**Контекст:** Задание летней школы Surf 2026.

**Промпт:**
> Прочитай задание и скажи что мне нужно тебе дать, чтобы ты начал работу
> [текст задания летней школы]

**Ответ:** Запрос брифа, стека, материалов «Волны». Рекомендация начать с пустого workspace.

---

## Prompt 2 — Выбор темы и архитектурные решения

**Промпт:**
> Будем работать с гончарной, State Management - хочу Bloc, Clean Architecture
> I_Repo -> RepoImpl -> I_Service -> ServiceImpl -> BLoC -> Widget.
> Mock репозитории. По пунктам: начнем с MVP.
> [брифы, материалы лекций, ссылки на summer-school-2026, Deriverse rules, Figma]

**Решения:**
- Бриф: Гончарная мастерская «Глина»
- Bloc + Clean Architecture + mock
- Поэтапная работа с проверкой после каждого этапа

---

## Prompt 3 — Старт этапа 1

**Промпт:**
> стартуем этап 1

**Задача агенту:**
> Сгенерировать MVP-требования по структуре summer-school-2026 / 01-analysis,
> адаптировав домен «Волна» (SUP) → «Глина» (гончарная мастерская).
> Создать: customer-brief, elicitation, user-stories, FR, UC, BR, NFR, prompts, task doc.
> Commit: `docs: MVP requirements for Glina pottery app`.

---

## Prompt 4 — Внутренний (агент → себе при генерации US/FR)

**Промпт (неявный, по референсу):**
> Адаптируй user stories и functional requirements из
> `/Users/alekseycodintsev/Downloads/summer-school-2026/01-analysis/2-requirements/`
> для гончарной мастерской «Глина»:
> - Route → Program (лепка / гончарный круг)
> - Instructor → Master
> - Board → Equipment kit (фартук + инструменты)
> - club_cancelled → workshop_cancelled
> - 12 досок → 10 кругов, новичковая группа ≤6
> - Оценки мастеров → Phase 2
> - Сохрани R-004, R-008, R-015, R-027, R-028

**Почему работает:** Есть референс-артефакт, явный маппинг домена, границы scope.

---

## Prompt 5 — Внутренний (elicitation)

**Промпт (неявный):**
> На основе brief-pottery.md и customer-questions из «Волны» сформируй
> domain-description.md и customer-questions.md с ответами заказчика Марины.
> Закрой противоречие «10 минут» vs «2 часа»: 10 мин — пример боли в брифе; 2 ч — **решение аналитика (R-021)**, требует подтверждения заказчиком.

---

## Prompt 6 — Ревью и правки MVP (2026-07-04)

**Промпт:**
> Делай: 1-A auth в MVP; 2-push отмена Must UI / Should delivery; 3-исправь ошибку аналитика по 2ч;
> 4-US-16; 10-язык брифа; средний приоритет на усмотрение.

**Правки:** commit `docs: refine MVP requirements after review`.

---

## Использованные материалы

| Источник | Путь / URL |
| :-- | :-- |
| Бриф «Глина» | `/Users/alekseycodintsev/Desktop/brief-pottery.md` |
| Референс аналитики «Волна» | `/Users/alekseycodintsev/Downloads/summer-school-2026/01-analysis/` |
| Лекция День 1 | `/Users/alekseycodintsev/Downloads/ЛШ 2026 День 1.txt` |
| Лекция День 2 | `/Users/alekseycodintsev/Downloads/AiРазработка_День2.txt` |
