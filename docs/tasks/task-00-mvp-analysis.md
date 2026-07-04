# Task 00: MVP / Анализ требований

## Цель

Сгенерировать MVP-требования для клиентского мобильного приложения гончарной мастерской «Глина»: user stories, функциональные и нефункциональные требования, use cases, описание домена.

## Требования

- Бриф: [customer-brief.md](../01-analysis/0-customer-brief/customer-brief.md)
- BR-1…BR-9: [business-requirements.md](../01-analysis/2-requirements/business-requirements.md)
- US-1…US-15: [user-stories.md](../01-analysis/2-requirements/user-stories.md)
- FR-9, FR-10, FR-16…FR-18, FR-46: ключевые Must для MVP
- UC-1…UC-4: [use-cases.md](../01-analysis/2-requirements/use-cases.md)
- R-004, R-008, R-015, R-027, R-028 — из уточнений брифа

## Реализация

Создана структура `docs/01-analysis/` по образцу [summer-school-2026](https://github.com/surfstudio/summer-school-2026/tree/main/01-analysis):

| Файл | Содержание |
| :-- | :-- |
| `0-customer-brief/customer-brief.md` | Исходный бриф Марины + уточнения scope |
| `1-elicitation/domain-description.md` | Домен, роли, ограничения, глоссарий |
| `1-elicitation/customer-questions.md` | 19 вопросов + ответы |
| `2-requirements/user-stories.md` | 15 user stories с критериями приёмки |
| `2-requirements/functional-requirements.md` | FR Must/Should/Won't |
| `2-requirements/business-requirements.md` | BR + метрики |
| `2-requirements/use-cases.md` | UC-1…UC-4 с alt/exception |
| `2-requirements/non-functional-requirements.md` | NFR + архитектурные NFR |

## Промпты

Все промпты: [prompts/01-mvp-analysis.md](../../prompts/01-mvp-analysis.md)

## Инструменты

| Инструмент | Назначение |
| :-- | :-- |
| **Cursor IDE** | Среда разработки и агента |
| **Cursor AI (Agent)** | Генерация и адаптация артефактов |
| Референс summer-school-2026 | Формат и структура документов |
| brief-pottery.md | Исходный бриф заказчика |

## Ручная проверка

- [x] Бриф «Глина» скопирован в `0-customer-brief/`
- [x] User stories покрывают ключевые сценарии: слоты, запись, отмена, прокат
- [x] Scope ограничен ролью «Клиент» (R-028)
- [x] Оценки мастеров вынесены в Phase 2
- [x] Empty state: «Пока нет доступных занятий» (R-027)
- [x] Статус «Отменено мастерской» описан (R-008)
- [x] Промпты сохранены в `prompts/`
- [x] US-16: отмена мастерской (R-008)
- [x] Auth — Must (OTP в MVP), без заглушки в требованиях
- [x] R-021: 2 часа — решение аналитика, не ответ заказчика
- [x] Термины брифа: «лепка для новичков», «работа на гончарном круге»
- [ ] **Проверка студентом:** согласны ли с порогом отмены 2 ч до согласования с «Мариной»?

## Commit

```
docs: refine MVP requirements after review
```
