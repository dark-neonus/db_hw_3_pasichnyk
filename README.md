# Assistantships Database System (HW3)

This repository contains the HW3 Database System for the Assistantships variant.
It includes schema refinement, normalization evidence, data population scripts,
Spring Boot forms/reports, and test artifacts.

## Prerequisites
- Docker with Compose plugin
- Java 17+

## Run Instructions

### 1. Start MySQL
```bash
docker compose up -d
```

### 2. Apply Schema (Step 4)
```bash
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step4_refined_schema.sql
```

### 3. Populate Data (Step 6)
```bash
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step6_populate_data.sql
```

### 4. Start Application
```bash
./gradlew bootRun
```

### 5. Open UI
Go to `http://localhost:8080/`.

### 6. Run Step 9 Tests (Optional, Reproducible)
```bash
./sql/step9_run_tests.sh > sql/step9_test_execution.log 2>&1
```

## Main HW3 Artifacts

### Report and Tracking
- `Assistantships_Pasichnyk.md` - full report with Steps 1-9
- `PROGRESS.md` - compact progress log across sessions
- `FIX.md` - compact fix/mistake log

### SQL Files
- `sql/step4_refined_schema.sql` - refined schema (Step 4)
- `sql/step6_populate_data.sql` - data population (Step 6)
- `sql/step7_forms_queries.sql` - form SQL operations (Step 7)
- `sql/step8_report_queries.sql` - report SQL queries (Step 8)
- `sql/step9_tests.sql` - Step 9 test/check queries
- `sql/step9_run_tests.sh` - reproducible Step 9 execution script
- `sql/step9_test_execution.log` - captured Step 9 run output

### UI Evidence
- `screenshots/step4/` - per-table DDL execution proofs
- `screenshots/step6/` - per-table population proofs
- `screenshots/step7/` - before/after screenshots for forms
- `screenshots/step8/` - report invocation and printout screenshots

### Raw Execution Evidence
- `evidence/step4/` - `SHOW TABLES` and per-table `DESCRIBE` outputs
- `evidence/step6/` - per-table counts and sample rows after load

## Shutdown
To stop the app, use `Ctrl+C` in its terminal.

To stop MySQL:
```bash
docker compose down
```
