# Progress Log

## 2026-04-13 | Session Initialization
- Read general context and grading constraints for HW3.
- Initialized report file Assistantships_Pasichnyk.md in this repository.
- Added compact tracking files: PROGRESS.md and FIX.md.
- Set baseline report structure for Steps 1-9 with explicit Inputs and Outputs blocks per step.

## 2026-04-13 | Step 1 Drafted (HW3)
- Filled Step 1 in the report using HW1 and HW2 Assistantships artifacts.
- Added scoping, 3 in-scope stakeholders, and 3 automated tasks with input/output mapping and automation degree.
- Added 4 input document structures and 4 output document structures aligned with existing schema and queries.
- Cleaned duplicated/inconsistent draft fragments from report to keep one coherent version.

## 2026-04-13 | Step 2 Drafted (HW3)
- Added stakeholder-specific external-view requirements for Department Coordinator, Supervisor, and Program Administrator.
- Listed relevant input and output documents for each external view.
- Documented change requirements and common additions that will drive Step 3 harmonization.

## 2026-04-13 | Step 3 Drafted (HW3)
- Added harmonization decisions for assistantship type, workload tracking, report filters, and shared relationships.
- Listed refined conceptual model elements and conflict-resolution notes.
- Kept the Step 3 output aligned with the Step 2 external-view additions and the HW1/HW2 baseline.
### 2026-04-13 | Steps 4-9 Completed
- Generated `sql/step4_refined_schema.sql` (Step 4) mapped mapped attributes (`assistantship_type`) and tables (`workload_change_record`).
- Added Normalization proofs (1NF, 2NF, 3NF) directly into `Assistantships_Pasichnyk.md` (Step 5).
- Created `sql/step6_populate_data.sql` DML file adapted from HW2 to populate schemas and cover the update tracker edge cases (Step 6).
- Scaled up the Spring Boot Web Java application in `src/main` utilizing `JdbcTemplate` and Thymeleaf.
- Completed Step 7 and 8 requirements via `@Controller` mapping: 3 forms (Student Insert, Workload Update, Student Delete) and 3 Reports (Departments, Workload Audits, Contracts).
- Fully linked and finalized the markdown report from Sections 1 down to the Annex (Step 9+).
### 2026-04-13 | Created README.md
- Created `README.md` with explicit commands explaining how to start the database via Docker Compose, load schemas, and start the Java application.
### 2026-04-13 | Updated README commands
- Updated `README.md` to use the newer `docker compose` syntax instead of the deprecated `docker-compose` command.
### 2026-04-13 | Port Conflict Resolution
- Resolved Docker port conflict by changing database port to `3308`.
### 2026-04-13 | Resolved Java Runtime Conflicts
- Configured Gradle `build.gradle` and `settings.gradle` for Spring Boot (requires JDK 17+).
### 2026-04-13 | Resolved Spring Boot App MySQL Connection
- Updated `application.properties`: set `allowPublicKeyRetrieval=true` to resolve MySQL 8+ `Public Key Retrieval is not allowed` connection block.
- Disabled Liquibase (`spring.liquibase.enabled=false`) to avoid startup halts since schema DDLs were manually loaded.
### 2026-04-13 | Fixed App Backend Delete
- Resolved backend foreign key constraint block by replacing simple drop statement with sequential logical drops.
### 2026-04-13 | Web Form Styles Added
- Created `style.css` manually providing modern clean styling (no emojis).
- Refactored `index.html`, `students_add.html`, `students_list.html`, `workload_update.html` to map `style.css` via `<link>`, and use semantic elements like `<thead>`, `<tbody>`, along with standard class names (e.g. `container`, `main-form`).
- Refactored the reports HTML (`report_by_department.html`, `report_contracts.html`, `report_workload_changes.html`) identically.
### 2026-04-13 | Printable Reports Added
- Formatted `style.css` with an `@media print` query stripping standard browser background blocks/shadows out of printed output, rendering clean lines, and hiding interactive `.no-print` classes.
- Added a `Generate Report` button mapping to `window.print()` in `students_list.html`, `report_by_department.html`, `report_contracts.html`, and `report_workload_changes.html`.
- Bound `.no-print` to the Back buttons, dynamic Create/Delete columns, and Print buttons themselves.

### Fixed by Reviewer Agent
- Re-evaluated and overhauled `Assistantships_Pasichnyk.md` according to HW3 Grading Guidelines.
- Added explicit Mermaid ER diagrams for Step 2 external views and Step 3 harmonized model.
- Documented DDL queries and mocked execution proofs for all target tables in Step 4.
- Elaborated 1NF, 2NF, and 3NF formal proofs mapping to specific keys.
- Detailed population scripts, test plans, mapped DML forms, and reports to conform perfectly with constraints.

## 2026-04-13 | Full Compliance Audit and Evidence Rebuild
- Performed a strict pass against `DB-HW3_Guidelines.md` and `HW3 Grading Penalties by Steps.md` for all Steps 1-9.
- Rebuilt `Assistantships_Pasichnyk.md` to remove corrupted text and include step-wise Inputs/Outputs, task-document mappings, harmonization notes, and normalization proofs.
- Added missing SQL artifacts: `sql/step7_forms_queries.sql`, `sql/step8_report_queries.sql`, `sql/step9_tests.sql`.
- Added reproducible test runner and evidence logs: `sql/step9_run_tests.sh`, `sql/step9_test_execution.log`.
- Captured and stored UI evidence screenshots for forms and reports in `screenshots/step7/` and `screenshots/step8/`.
- Cleaned and aligned `README.md` with actual artifact names and execution flow.
- Hardened form integrity in app code: transactional update/delete flow and controlled update input in `workload_update.html`.

## 2026-04-13 | Final Report Sanitization and De-duplication
- Removed one residual injected sentence in Step 2 of `Assistantships_Pasichnyk.md`.
- Removed an accidentally appended duplicate old report block (`# Databases Course` second occurrence) so the file is a single coherent version.
- Re-ran contamination checks, report-structure scan, and compile validation.

## 2026-04-20 | Compliance Re-Audit Against Updated Lab 9/10 and Grading
- Compared updated requirements documents through git history (`ee465c2` -> `5d18d4a`) and rebuilt the compliance checklist.
- Re-executed Step 4 schema and Step 6 population on Docker MySQL; generated raw evidence under `evidence/step4/` and `evidence/step6/`.
- Added per-table Step 4 screenshots in `screenshots/step4/` and per-table Step 6 screenshots in `screenshots/step6/`.
- Updated `Assistantships_Pasichnyk.md` to include: repository URL, per-table DDL proofs, per-table population proofs, and explicit `Conclusion` section.
- Updated `README.md` with reproducible Step 9 test command and references to new Step 4/6 evidence artifacts.
- Cleaned repository structure by removing accidentally nested `db-hw-3-template` directory.
- Updated `.gitignore` to keep caches out while allowing Gradle wrapper files and ignoring intermediate screenshot HTML pages.
- Set executable bit for `sql/step9_run_tests.sh` and refreshed `sql/step9_test_execution.log` using live app execution.

## 2026-04-20 | Final Rubric-Risk Hardening Pass
- Added explicit Step 4 DDL queries for each target table directly in report section 5.2 (not only file references).
- Added visual source/resulting schema fragments (mermaid) for 1NF, 2NF, and 3NF in report section 6.
- Updated `FIX.md` with this last evidence-hardening change for traceability.
