import re

content = open('Assistantships_Pasichnyk.md', 'r').read()
replacement = """## 8. Step 7: Develop DBS Application: 3+ Forms for Data Manipulation
### Inputs
- Input documents from Step 1
- Populated database from Step 6

### Outputs
- 3+ forms (insert, update, delete) built in Java Spring Boot using Thymeleaf
- Queries per form implemented via `JdbcTemplate`

### Implemented Forms
1. **Insert Form (`/students/add`)**: Adds new students into the system directly interacting with the `student` table. Maps to the "Student Profile Card" input document.
2. **Update Form (`/assistantships/update`)**: Adjusts the `hours_per_week` in the `assistantship` table and simultaneously logs the operation into the `workload_change_record` tracking table. Maps to the formal Workload Readjustment Document.
3. **Delete Form (`/students/list` => Delete operation)**: Removes a student record (and recursively cascades deletions where DB structure allows, or is bounded by FK constraints).

## 9. Step 8: Develop DBS Application: 3+ Reports for Output Documents
### Inputs
- Requested output document structures from Step 1
- Live schema

### Outputs
- 3+ dynamic reports accessible via the Application (`index.html`)

### Implemented Reports
1. **Assistantships Grouped By Department and Type (`/reports/by-department`)**: Aggregates assistantships by explicitly displaying the NEW `assistantship_type` column across `department_name`.
   - Query: `SELECT d.department_name, a.assistantship_type, COUNT(a.assistantship_id)... GROUP BY d.department_name, a.assistantship_type`
2. **Workload Change Audit (`/reports/workload-changes`)**: Displays the chronological audit log of workload history (fetching from `workload_change_record`). Maps directly to the required Output Document.
3. **Current Contracts per Student (`/reports/contracts`)**: Joins `student` and `assistantship` providing a unified view of student operations.

## 10. Step 9: Develop Tests and Test the DBS Application
### Output
- Manual web checks executed against running Docker MySQL vs Boot App.
- Tested `application.properties` settings confirming JDBC integration using `root` and local `:3307`.

## 11. Conclusion
The full lifecycle of adding the Workload Change Tracker and harmonizing Assistantship types to UCU requirements was completely mapped from Conceptual Modeling (Lab 9 material) straight down to Logical Schema implementation and wrapped in a functional Java Spring Boot Web MVC architecture. The system guarantees both data coherence (3NF verified) and transparent auditing for the stakeholders.

## 12. References
- HW1 & HW2 materials
- Lab 9 & Lab 10 Materials

## 13. Annex
- Detailed scripts inside `sql/` and Java app mapped inside `src/`.
"""

# Replace anything from step 7 onwards
content = re.sub(r'## 8\. Step 7: Develop DBS Application.*', replacement, content, flags=re.DOTALL)
open('Assistantships_Pasichnyk.md', 'w').write(content)
