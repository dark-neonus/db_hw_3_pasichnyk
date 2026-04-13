# Assistantships Database System (HW3)

This repository contains the Database System (DBS) for the Assistantships domain, developed for the Databases course (Homework 3). 
It includes the refined SQL schema, data population scripts, and a Spring Boot web application with forms and reports.

## Prerequisites
- Docker & Docker Compose
- Java 17+ (for running the Spring Boot application via Gradle wrapper)

## How to Run

### 1. Start the Database
Spin up the MySQL database using Docker Compose. This will expose MySQL locally on port `3308`:
```bash
docker compose up -d
```
*Tip: Wait a few seconds for the database to fully initialize before running the next steps.*

### 2. Initialize and Populate the Database
Execute the DDL and DML scripts against the running Docker container to create the schema and load the sample data.

**Apply the refined schema (Step 4):**
```bash
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step4_refined_schema.sql
```

**Populate with sample data (Step 6):**
```bash
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step6_populate_data.sql
```

### 3. Start the Web Application
Run the Spring Boot application using the provided Gradle wrapper:
```bash
./gradlew bootRun
```

### 4. Access the Application
Once the application has started, open your web browser and go to:
**http://localhost:8080/**

From the home page, you can access the required forms (Insert, Update, Delete) and dynamic reports to interact with the `assistantships_db`.

## Shutdown
To stop the web application, simply press `Ctrl+C` in the terminal where it's running.

To stop and remove the database container:
```bash
docker compose down
```
# Homework 3 - Assistantships

This repository contains HW3 artifacts for Databases course (variant: Assistantships).

## Files
- Assistantships_Pasichnyk.md: full report with Steps 1-9.
- sql/01_schema_refined.sql: refined and normalized schema.
- sql/02_load_data.sql: sample data population.
- sql/03_forms.sql: form operations (insert/update/delete).
- sql/04_reports.sql: report queries.
- sql/05_tests.sql: test plan and executable SQL tests.
- WORKLOG.md: compact progress tracking across sessions.
- FIX.md: mistakes and fixes history.

## Execution order
1. Execute sql/01_schema_refined.sql
2. Execute sql/02_load_data.sql
3. Execute sql/03_forms.sql
4. Execute sql/04_reports.sql
5. Execute sql/05_tests.sql
