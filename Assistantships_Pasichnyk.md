# Databases Course
## Homework 3 Report
## Variant: Assistantships

Author: Pasichnyk Nazar
Date: 2026-04-13

## Table of Contents
1. Introduction
2. Step 1: Specify In-Scope Stakeholders, Tasks, Input and Output Documents
3. Step 2: Elaborate External Views for In-Scope Stakeholders
4. Step 3: Harmonize External Views in a Refined Conceptual Model
5. Step 4: Refine Database Schema
6. Step 5: Normalize Database to 3NF
7. Step 6: Populate Normalized Database
8. Step 7: Develop DBS Application: 3+ Forms for Data Manipulation
9. Step 8: Develop DBS Application: 3+ Reports for Output Documents
10. Step 9: Develop Tests and Test the DBS Application
11. Conclusion
12. References
13. Annex

## 1. Introduction
This report documents the development of the database system for the Assistantships domain according to HW3 guidelines.

## 2. Step 1: Specify In-Scope Stakeholders, Tasks, Input and Output Documents
### Inputs
- HW1 Assistantships domain description and conceptual model.
- HW2 relational schema and SQL tasks (selection, insert, update, delete).
- Existing HW2 data structures for Student, Supervisor, Department, Assistantship, Duty, Teaching_Assistantship, and Research_Assistantship.

### Outputs
- Scope definition with in-scope stakeholders and their clients.
- In-scope tasks selected for automation and explanation of this selection.
- Structured input documents used by the automated tasks.
- Structured output documents (reports) generated from stored data.

### 2.1 Scoping and in-scope stakeholders
The DBS scope covers the operational data flow of assistantship administration in the university: registration of assistantships, assignment of students and supervisors, duty tracking, and reporting of workload and allocation summaries.

In-scope organizational unit:
- Assistantships Administration Unit.

Information providers to the in-scope unit:
- Students (student profile and enrollment details).
- Supervisors (approval and workload-related data).
- Departments (organizational context for assistantships).

In-scope stakeholders:
1. Department Coordinator.
- Why in scope: creates and maintains assistantship assignments; uses and updates core assistantship records.
2. Supervisor.
- Why in scope: validates duty and workload details used in updates and monitoring.
3. Program Administrator.
- Why in scope: monitors distribution of assistantships by semester, department, and assistantship type.

### 2.2 In-scope tasks selected for automation
The selected tasks are those that transform structured input documents into persistent database changes and output reports. This directly matches the HW3 requirement to automate information-processing operations.

1. Register a new assistantship assignment.
- Stakeholder: Department Coordinator.
- Input documents: Assistantship Registration Form, Student Profile Card.
- Output documents: Assistantship Assignment Sheet.
- Planned automation degree: full (form validation plus insert operations).

2. Update assistantship workload or supervision data.
- Stakeholder: Supervisor.
- Input documents: Assistantship Change Request.
- Output documents: Workload Change Log.
- Planned automation degree: full (update operations with referential integrity preservation).

3. Produce managerial summaries for assistantship planning.
- Stakeholder: Program Administrator.
- Input documents: Report Filter Request.
- Output documents: Assistantship Allocation Summary, Supervisor Load Summary.
- Planned automation degree: full (query execution, grouping, and filtering).

### 2.3 Input documents and structures (3+)
1. Assistantship Registration Form.
- Purpose: register a new assistantship with all mandatory links.
- Main fields: assistantship_id, registration_number, semester, academic_year, hours_per_week, student_id, supervisor_id, department_id, assistantship_type (TA/RA), optional specialization fields.

2. Student Profile Card.
- Purpose: provide student data referenced when assignment is created.
- Main fields: student_id, first_name, last_name, email, enrollment_date, program.

3. Assistantship Change Request.
- Purpose: request updates of an existing assistantship.
- Main fields: assistantship_id, requested_by_supervisor_id, requested_hours_per_week, requested_supervisor_id, justification, request_date.

4. Report Filter Request.
- Purpose: define report generation parameters.
- Main fields: semester, academic_year, department_id, supervisor_id, assistantship_type, aggregation_level.

### 2.4 Output documents and structures (3+)
1. Assistantship Assignment Sheet.
- Produced for each registered assignment.
- Main fields: assistantship_id, registration_number, student_name, supervisor_name, department_name, semester, academic_year, hours_per_week, assistantship_type.

2. Assistantship Allocation Summary.
- Management report by semester and department.
- Main fields: semester, academic_year, department_name, assistantship_count, avg_hours_per_week.

3. Supervisor Load Summary.
- Management report by supervisor.
- Main fields: supervisor_name, department_name, active_assistantships_count, total_hours_per_week.

4. Workload Change Log.
- Operational report for updates.
- Main fields: assistantship_id, old_hours_per_week, new_hours_per_week, changed_by, change_timestamp.

### 2.5 Consistency with HW1 and HW2 artifacts
Step 1 is grounded in the existing Assistantships model and implemented schema:
- Entity and attribute basis comes from HW1 domain and conceptual model.
- Operational basis comes from HW2 insert, update, delete, and analytical selection queries.
- Document fields are aligned with existing table columns in assistantship, student, supervisor, department, duty, teaching_assistantship, and research_assistantship.

## 3. Step 2: Elaborate External Views for In-Scope Stakeholders
### Inputs
- Stakeholders and documents from Step 1
- Existing conceptual model from HW1/HW2

### Outputs
- External view per in-scope stakeholder
- Input CM fragments with obsolete elements marked red
- New elements marked green in each external view
- Change requirements and modeling explanations

### Work Result
- To be completed.

## 4. Step 3: Harmonize External Views in a Refined Conceptual Model
### Inputs
- All external views from Step 2

### Outputs
- Merged and harmonized conceptual model
- Conflict resolution notes
- Input vs refined model comparison (red obsolete, green new)

### Work Result
- To be completed.

## 5. Step 4: Refine Database Schema
### Inputs
- Refined conceptual model from Step 3
- Existing HW2 database schema

### Outputs
- Updated logical-level schema diagram
- DDL queries for all target tables
- Screenshots/proofs of DDL execution
- Mapping explanation from conceptual to logical model

### Work Result
- To be completed.

## 6. Step 5: Normalize Database to 3NF
### Inputs
- Refined database schema from Step 4

### Outputs
- 1NF proof and required changes
- 2NF proof and required changes
- 3NF proof and required changes
- Updated normalized DDL and execution proofs

### Work Result
- To be completed.

## 7. Step 6: Populate Normalized Database
### Inputs
- Normalized schema from Step 5
- Prepared source data files

### Outputs
- Source files per table
- Population queries per table
- Execution proofs per table
- Loaded table snapshots
- Explanation of data sufficiency for testing

### Work Result
- To be completed.

## 8. Step 7: Develop DBS Application: 3+ Forms for Data Manipulation
### Inputs
- Input documents from Step 1
- Populated database from Step 6

### Outputs
- 3+ forms (insert, update, delete)
- Queries per form
- Before/after table states per operation
- Integrity preservation notes

### Work Result
- To be completed.

## 9. Step 8: Develop DBS Application: 3+ Reports for Output Documents
### Inputs
- Output documents from Step 1
- Populated database from Step 6

### Outputs
- 3+ reports implemented in application
- Code and query pipelines per report
- UI invocation screenshots
- Report printouts

### Work Result
- To be completed.

## 10. Step 9: Develop Tests and Test the DBS Application
### Inputs
- In-scope operations from Step 1
- Data elements in input/output documents
- Queries and code from Steps 7-8

### Outputs
- Test plan
- Tests for all data-changing operations
- Tests for all reports
- Before/after states and success arguments
- Report correctness proofs

### Work Result
- To be completed.

## 11. Conclusion
- To be completed.

## 12. References
- HW3 Guidelines
- HW3 Grading Penalties by Steps
- HW1 report and diagrams
- HW2 report and SQL artifacts

## 13. Annex
- Diagrams
- SQL scripts
- Screenshots
- Test evidence
