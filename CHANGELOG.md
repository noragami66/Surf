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

- (dev) Initial MVP analytics for «Глина»: customer brief, elicitation, user stories, FR/BR/NFR, use cases, prompts, task doc, git init ([PLATF-001](docs/tasks/task-00-mvp-analysis.md))
- (dev) Architecture phase: data model, API contract, Flutter Clean Architecture plan ([PLATF-004](docs/tasks/task-01-architecture.md))

### Changed

- (dev) Refine MVP after review: auth OTP Must (UC-5), US-16 workshop cancellation, R-021 cancel policy, brief program names, rental kits=8, error matrix, FR-22 idempotency ([PLATF-002](docs/tasks/task-00-mvp-analysis.md))
- (dev) Add CHANGELOG and `PLATF-XXX` commit message convention ([PLATF-003](CHANGELOG.md))
- (dev) README: link to prompts folder and architecture docs ([PLATF-004](docs/tasks/task-01-architecture.md))

### Fixed

### Removed

## Commit log (PLATF)

| PLATF | Hash | Summary |
| :-- | :-- | :-- |
| PLATF-001 | `8f2f836` | Этап 1: полный пакет аналитики по структуре summer-school-2026 |
| PLATF-002 | `565b0e9` | Правки по ревью: auth Must, US-16, R-021, термины брифа |
| PLATF-003 | `fc5ac88` | CHANGELOG + правило `PLATF-XXX` в сообщениях коммитов |
| PLATF-004 | `06e0187` | Data model, API contract, Flutter architecture, prompts link in README |
