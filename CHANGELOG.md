# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

Each git commit is prefixed with `PLATF-XXX` (sequential task id). Entries below
reference the same id.

<!-- Template
## [Unreleased]

### Added

### Changed

### Fixed

### Removed
-->

## [Unreleased]

### Added

- Quality (stage 7): expanded BLoC/repo tests (43 total), logout in header, pull-to-refresh on schedule, bug docs + manual checklist ([PLATF-016](docs/tasks/task-06-quality.md))
- My Bookings list: `MyBookingsBloc`, `MyBookingsServiceImpl`, `listBookings` in mock repo, `BookingCard`, refresh after booking and on tab switch ([PLATF-015](docs/tasks/task-05-my-bookings.md))
- My Bookings detail + cancel: `BookingDetailScreen`, `BookingDetailBloc`, `getBooking`/`cancelBooking`, route `/bookings/:id`, early/late cancel via `cancellation_window_minutes` mock ([PLATF-015](docs/tasks/task-05-my-bookings.md))
- Slots detail + booking slice: `SlotDetailScreen`, `BookingScreen`, `SlotDetailBloc`, `BookingBloc`, `BookingServiceImpl`, `BookingRepositoryMock`, shared `MockSlotStore`, routes `/slots/:id` and `/slots/:id/book`, unit + bloc tests ([PLATF-014](docs/tasks/task-04-slots-booking.md))
- UI polish: mesh-gradient ambient background, black card surfaces with `cardBorder`, `HomeUserHeader` greeting, shared `GlassPrimaryButton` / `GlassEmptyState` / `GlassIconBadge`, docked full-width bottom nav with labels, l10n home greeting strings ([PLATF-013](app/))
- (dev) Initial MVP analytics for «Глина»: customer brief, elicitation, user stories, FR/BR/NFR, use cases, prompts, task doc, git init ([PLATF-001](docs/tasks/task-00-mvp-analysis.md))
- (dev) Architecture phase: data model, API contract, Flutter Clean Architecture plan ([PLATF-004](docs/tasks/task-01-architecture.md))
- Flutter bootstrap: `app/` project, Clean Architecture skeleton, slots empty-state slice ([PLATF-009](docs/tasks/task-02-flutter-bootstrap.md))
- Dark glassmorphism design system: palette, theme extensions, ambient background, glass widgets, slots screen redesign ([PLATF-010](app/))
- Auth (OTP) slice: AuthBloc, phone → OTP → name glass screens, router session guard, AuthRepositoryMock (code `0000`, rate limit), session persistence in secure storage, unit + bloc tests ([PLATF-012](docs/tasks/task-03-auth.md))

### Changed

- (dev) Refine MVP after review: auth OTP Must (UC-5), US-16 workshop cancellation, R-021 cancel policy, brief program names, rental kits=8, error matrix, FR-22 idempotency ([PLATF-002](docs/tasks/task-00-mvp-analysis.md))
- (dev) Add CHANGELOG and `PLATF-XXX` commit message convention ([PLATF-003](CHANGELOG.md))
- (dev) README: link to prompts folder and architecture docs ([PLATF-004](docs/tasks/task-01-architecture.md))
- (dev) Application layer (NFR-ARCH-5), Deriverse-aligned Flutter structure, service specs in architecture docs ([PLATF-005](docs/tasks/task-01-architecture.md))
- (dev) Doc review fixes: R registry, rental projection (R-023), config API, session refresh (UC-6), 3-design rename ([PLATF-006](docs/tasks/task-00-mvp-analysis.md))
- (dev) Align booking state diagram labels with cancellation_window from API ([PLATF-007](docs/01-analysis/3-design/data-model.md))
- (dev) Fix prompts link in README to point at prompts/README.md ([PLATF-008](README.md))

### Fixed

- Schedule stale `free_seats` after booking/cancel — auto `RefreshSlotsEvent` ([PLATF-017](docs/bugs/bug-01-stale-slots-after-booking.md))
- My Bookings list not cleared on logout — `ResetMyBookingsEvent` via auth listener ([PLATF-018](docs/bugs/bug-02-stale-bookings-after-logout.md))
- Early/late cancel window used truncated `inMinutes` — compare full `Duration` ([PLATF-019](docs/bugs/bug-03-cancel-window-truncation.md))
- Slot detail «Записаться» navigation: absolute route `/slots/:id/book` instead of relative push ([PLATF-015](app/))

### Removed

## Commit log (PLATF)

| PLATF | Hash | Summary |
| :-- | :-- | :-- |
| PLATF-001 | `8f2f836` | Этап 1: полный пакет аналитики по структуре summer-school-2026 |
| PLATF-002 | `565b0e9` | Правки по ревью: auth Must, US-16, R-021, термины брифа |
| PLATF-003 | `fc5ac88` | CHANGELOG + правило `PLATF-XXX` в сообщениях коммитов |
| PLATF-004 | `2b75ef1` | Data model, API contract, Flutter architecture, prompts link in README |
| PLATF-005 | `f244e75` | Application layer, Deriverse structure alignment between BLoC and Repository, NFR-ARCH-5 |
| PLATF-006 | `6fc5f74` | Review fixes: R registry, cancellation_window API, UC-6, 3-design rename |
| PLATF-007 | `6dc2e63` | Booking state mermaid: cancellation window labels |
| PLATF-008 | `b4975ea` | Fix prompts link in README |
| PLATF-009 | — | Flutter bootstrap: glina app, DI, l10n, slots slice |
| PLATF-010 | — | Dark glassmorphism design system |
| PLATF-011 | — | Handoff doc for stage 4 continuation |
| PLATF-012 | — | Auth OTP flow: bloc, screens, router guard, secure session, tests |
| PLATF-013 | `00cfc1c` | UI polish: mesh gradient, card surfaces, home header, docked nav |
| PLATF-014 | `28e10c7` | Slot detail screen, booking flow, mock repo, tests |
| PLATF-015 | `1417f5d` | My bookings list, detail, cancel flow |
| PLATF-016 | `1ae73c4` | Tests expansion, logout, pull-to-refresh, quality docs |
| PLATF-017 | — | Fix stale slots after booking/cancel |
| PLATF-018 | — | Fix stale my bookings after logout |
| PLATF-019 | — | Fix cancellation window Duration comparison |
