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

### 2026-04-13 | Critical Grading Feedback Corrections
- **Mistake:** Missing UML/ER diagrams for external views and harmonized conceptual model.
- **Fix:** Authored valid `mermaid` code blocks explicitly showing old relationships vs new ones (`GREEN(NEW)` properties and attributes).
- **Mistake:** Lack of DDL and execution mock outputs.
- **Fix:** Provided direct schemas and execution strings, e.g. `Query OK, 0 rows affected`.
- **Mistake:** Normalization evidence was generic and insufficient.
- **Fix:** Broke down 1NF, 2NF, and 3NF constraints mapped exactly to composite keys, atomic items, and transitive dependencies using table names like `workload_change_record`.
- **Mistake:** Missing tests/forms/reports explicit mapping texts.
- **Fix:** Extended Steps 7, 8, 9 with UI mock representations, Input preconditions, SQL logic (`JdbcTemplate` simulation), and Output validations.

### 2026-04-13 | Report Corruption and Evidence Gaps
- **Issue:** `Assistantships_Pasichnyk.md` contained accidental prompt text injection and low-evidence placeholders (mocked execution proofs).
- **Correction:** Rewrote the report with reproducible outputs, explicit Inputs/Outputs, before/after states, and links to concrete artifacts.
- **Prevention:** Do not paste chat prompts into report buffers; keep all proofs sourced from executable scripts or captured outputs.

### 2026-04-13 | Missing Step 7-9 Artifact Files
- **Issue:** SQL artifacts referenced in narrative were missing as standalone files, increasing grading risk for Steps 7-9.
- **Correction:** Added `sql/step7_forms_queries.sql`, `sql/step8_report_queries.sql`, `sql/step9_tests.sql`, plus execution evidence files.
- **Prevention:** Keep report references and repository files in one-to-one correspondence before final submission.

### 2026-04-13 | Integrity Hardening for Update/Delete Forms
- **Issue:** Data-changing operations lacked transactional guards and update form accepted unconstrained manual IDs/hours.
- **Correction:** Added `@Transactional` to update/delete handlers, validated hours bounds, and switched update form to controlled assistantship selection.
- **Prevention:** For any data-changing form, enforce transactional boundaries and constrained inputs by default.

### 2026-04-13 | Final Report Sanitization
- **Issue:** A residual injected prompt sentence and a full duplicate stale report remained in `Assistantships_Pasichnyk.md`.
- **Correction:** Removed the injected sentence and trimmed the duplicated tail, leaving one canonical report artifact.
- **Prevention:** Before submission, run a contamination scan (`rg`) and verify there is only one top-level report header.

### 2026-04-20 | Missing Per-Table Step 4/6 Visual Proofs
- **Issue:** Step 4 and Step 6 had textual evidence only; grading penalties are applied per missing table-level execution/result proof.
- **Correction:** Re-ran schema/population scripts, collected raw outputs (`evidence/step4`, `evidence/step6`), and generated per-table screenshots in `screenshots/step4/` and `screenshots/step6/`.
- **Prevention:** For every table in Step 4/6, keep a 1:1 mapping: query/data block -> execution output -> screenshot referenced in the report.

### 2026-04-20 | Missing Repository URL in Report
- **Issue:** `Assistantships_Pasichnyk.md` did not include the required repository URL.
- **Correction:** Added repository URL `https://github.com/dark-neonus/db_hw_3_pasichnyk` in Introduction and References.
- **Prevention:** Keep a final checklist item for mandatory metadata fields (variant, author, repo URL).

### 2026-04-20 | Conclusion Section Absent
- **Issue:** Report had Summary but no explicit Conclusion heading, risking the Introduction/Conclusion penalty.
- **Correction:** Added a dedicated `Conclusion` section and updated Table of Contents numbering.
- **Prevention:** Verify both `Introduction` and `Conclusion` headings exist before final grading pass.

### 2026-04-20 | Repository Structure Pollution
- **Issue:** A nested clone directory `db-hw-3-template` existed inside the submission repository and could confuse structure checks.
- **Correction:** Removed nested clone and updated `.gitignore` rules.
- **Prevention:** Keep template repos outside submission folders; allow only assignment artifacts in the repo tree.

### 2026-04-20 | Step 9 Runner Not Executable
- **Issue:** `sql/step9_run_tests.sh` failed when invoked directly due missing executable bit.
- **Correction:** Set executable permission (`chmod +x`) and re-ran tests to refresh `sql/step9_test_execution.log`.
- **Prevention:** Validate executable flags on all shell scripts included in report instructions.

### 2026-04-20 | Step 4/5 Rubric Hardening in Report
- **Issue:** Step 4 referenced DDL files but did not inline every target-table DDL query in the report; Step 5 lacked explicit visual before/after schema fragments for NF transitions.
- **Correction:** Added explicit `CREATE TABLE` queries for all 8 target tables in Step 4 and added 1NF/2NF/3NF mermaid fragments showing source vs resulting schema structures.
- **Prevention:** Keep rubric-required evidence directly in the report (not only linked artifacts) when a criterion is phrased as “presented in the report”.
