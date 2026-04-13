# Fix Log

## Rules
- Add a new section for each fix.
- Keep entries short: issue, correction, prevention.

## 2026-04-13 | Initialization
- No fixes yet.
# FIX Log

## 2026-04-13
- Fixed known issue from previous work style: avoid DB setup assumptions on host MySQL auth; keep SQL scripts environment-neutral and executable on clean DB.
- Fixed consistency issue risk: aligned report Steps 7-9 with concrete SQL artifacts (forms, reports, tests) to avoid narrative-only sections.
### 2026-04-13 | docker-compose deprecated
- Replaced `docker-compose` command with `docker compose` in `README.md`. Newer Docker versions bundle Compose as a CLI plugin (`docker compose`) rather than a standalone binary (`docker-compose`), causing "command not found" errors when using the old format.
### 2026-04-13 | Change Database Port to 3308
- Port `3307` was already allocated by another container (likely from `flights-db-hw-3`). Changed port mapping in `docker-compose.yml`, `application.properties`, `README.md`, and `Assistantships_Pasichnyk.md` from `3307` to `3308`.
### 2026-04-13 | Spring Boot App Database Connection Fix
- Issue: Encountered `Public Key Retrieval is not allowed` causing Hikari pool and `liquibase` bean failure.
- Fix: Modified `application.properties` URL to contain `allowPublicKeyRetrieval=true` and disabled Liquibase schema generation via `spring.liquibase.enabled=false`.
### 2026-04-13 | Student Foreign Key Deletion Cascade
- Issue: Students could not be deleted because `ON DELETE RESTRICT` was enforced on the `assistantship` logic mapped from HW2.
- Fix: Updated `WebController.deleteStudent` to explicitly delete `workload_change_record`, `duty`, `teaching_assistantship`, `research_assistantship`, and `assistantship` layers sequentially before dropping the target `student`. 
