import re

content = open('Assistantships_Pasichnyk.md', 'r').read()
replacement = """## 5. Step 4: Refine Database Schema
### Inputs
- Refined conceptual model from Step 3
- Existing HW2 database schema

### Outputs
- Updated logical-level schema diagram (conceptual to logical mapping)
- DDL queries for all target tables
- Screenshots/proofs of DDL execution

### Mapping
Based on the refined conceptual model, the following changes were mapped to the schema:
1. `assistantship_type` (ENUM('TA', 'RA')) was added to the `assistantship` table.
2. `workload_change_record` table was introduced to track changes to hours and store metadata (who changed it, why, when, what was the old/new workload).

### DDL Implementation
Below is the refined schema snippet covering the modifications (Full script in `sql/step4_refined_schema.sql`):

```sql
ALTER TABLE assistantship
    ADD COLUMN assistantship_type ENUM('TA', 'RA') NOT NULL
    COMMENT 'GREEN (NEW): explicitly storing type for queries' AFTER hours_per_week;

CREATE TABLE workload_change_record (
    change_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'GREEN (NEW): Surrogate PK',
    assistantship_id VARCHAR(15) NOT NULL COMMENT 'GREEN (NEW): FK to Assistantship',
    change_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'GREEN (NEW): Date of change',
    old_hours TINYINT UNSIGNED NOT NULL COMMENT 'GREEN (NEW): Previous hours per week',
    new_hours TINYINT UNSIGNED NOT NULL COMMENT 'GREEN (NEW): New hours per week',
    changed_by VARCHAR(50) NOT NULL COMMENT 'GREEN (NEW): User who made the change',
    reason VARCHAR(255) NOT NULL COMMENT 'GREEN (NEW): Justification for workload adjustment',
    CONSTRAINT fk_workload_assistantship FOREIGN KEY (assistantship_id) REFERENCES assistantship(assistantship_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB COMMENT = 'GREEN (NEW): Tracks workload modifications explicitly';
```

## 6. Step 5: Normalize Database to 3NF
### Inputs
- Refined database schema from Step 4

### Outputs
- 1NF, 2NF, 3NF proofs

### Normalization Proofs
**1NF:** All attributes in all tables (e.g., `assistantship_type` or `reason`) contain atomic values. Multi-valued attributes like duties were already normalized into the weak entity `duty`. The new `workload_change_record` correctly stores atomic timestamps, integers, and strings.
**2NF:** Tables with single-column primary keys (`student`, `supervisor`, `department`, `workload_change_record`) are automatically in 2NF since no partial dependencies can exist. For composite keys like `duty` (`assistantship_id`, `duty_id`), the `description` depends on the full primary key, making it 2NF compliant.
**3NF:** No transitive dependencies exist. For example, in `workload_change_record`, attributes like `reason` and `new_hours` exclusively depend on `change_id`. In `assistantship`, removing derived fields ensures that `hours_per_week` and `assistantship_type` depend solely on the candidate keys. Thus, the schema strictly obeys 3NF.

## 7. Step 6: Populate Normalized Database
### Inputs
- Normalized schema from Step 5
- Prepared SQL DML instructions

### Outputs
- Source population script
- Loaded data explanation

### Population Script
Sample data specifically engineered for the 'Assistantships' variant was migrated from HW2 with Step 4 additions (SQL script located in `sql/step6_populate_data.sql`).

```sql
INSERT INTO workload_change_record (assistantship_id, change_date, old_hours, new_hours, changed_by, reason) VALUES
('AST-2025-0001', '2024-09-15 10:00:00', 10, 15, 'Prof. Oleksandr Tkachenko', 'Increased class size requires more grading time'),
('AST-2025-0002', '2024-10-01 14:30:00', 20, 10, 'Assoc. Prof. Andriy Shevchenko', 'Student requested workload reduction for midterms');
```
The data represents diverse cases (TAs with grading, RAs with varying funds) ensuring coverage for web forms and reports."""

content = re.sub(r'## 5\. Step 4: Refine Database Schema.*?(?=## 8\. Step 7)', replacement, content, flags=re.DOTALL)
open('Assistantships_Pasichnyk.md', 'w').write(content)
