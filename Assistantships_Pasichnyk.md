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
- Existing HW2 schema as the concrete baseline for current stored elements

### Outputs
- External view per in-scope stakeholder
- Input CM fragments with obsolete elements marked red
- New elements marked green in each external view
- Change requirements and modeling explanations

### 3.1 Purpose of the step
The purpose of Step 2 is to specialize the common Assistantships conceptual model for each in-scope stakeholder. Each external view contains only the information needed by that stakeholder, while keeping the shared core entities that already exist in the HW1/HW2 model. New stakeholder-specific data objects are added only when they are required by the input and output documents selected in Step 1.

### 3.2 External view for the Department Coordinator
#### Stakeholder role
The Department Coordinator creates and maintains assistantship records and checks whether a student, supervisor, and department are linked correctly before an assistantship is accepted into the system.

#### Relevant input documents
- Assistantship Registration Form
- Student Profile Card

#### Relevant output documents
- Assistantship Assignment Sheet

#### Required model elements in the view
- Student
- Supervisor
- Department
- Assistantship
- Teaching_Assistantship
- Research_Assistantship

#### Change requirements
1. Keep the core HW2 entities Student, Supervisor, Department, and Assistantship.
2. Keep the specialization of Assistantship into Teaching_Assistantship and Research_Assistantship because the registration form must distinguish between the two assistantship types.
3. Add a type discriminator for assistantship category if needed by the final refined model.
4. Preserve the links from Assistantship to Student, Supervisor, and Department because the coordinator needs to register these assignments in a single transaction.

#### Input CM fragment and external-view change
- Obsolete elements in the input fragment: none are removed from the shared core for this stakeholder.
- New elements in the external view: assistantship type support needed for the registration form and assignment sheet.

### 3.3 External view for the Supervisor
#### Stakeholder role
The Supervisor validates assistantship workload changes and checks whether the assigned duties match the approved workload.

#### Relevant input documents
- Assistantship Change Request

#### Relevant output documents
- Workload Change Log

#### Required model elements in the view
- Assistantship
- Duty
- Supervisor
- Student
- Department

#### Change requirements
1. Keep Assistantship, Duty, Supervisor, Student, and Department because workload changes are evaluated against the existing assignment context.
2. Add an operation-oriented structure for change tracking so that workload updates can be documented as a history item.
3. Add workload-specific attributes needed for before/after comparison of hours per week.
4. Keep the supervisor-related foreign key path so that the change can be traced to the approving or requesting supervisor.

#### Input CM fragment and external-view change
- Obsolete elements in the input fragment: none of the core entities are removed.
- New elements in the external view: workload change tracking attributes and request-oriented record structure.

### 3.4 External view for the Program Administrator
#### Stakeholder role
The Program Administrator analyzes the distribution of assistantships across departments, supervisors, semesters, and assistantship types.

#### Relevant input documents
- Report Filter Request

#### Relevant output documents
- Assistantship Allocation Summary
- Supervisor Load Summary

#### Required model elements in the view
- Assistantship
- Student
- Supervisor
- Department
- Teaching_Assistantship
- Research_Assistantship

#### Change requirements
1. Preserve the existing relational links needed for aggregation by semester, department, and supervisor.
2. Add summary-oriented attributes only if they are not derivable directly from the existing schema.
3. Keep the assistantship type distinction because the reports need to group assignments by operational category.
4. Do not duplicate stored data that can be derived from the current schema.

#### Input CM fragment and external-view change
- Obsolete elements in the input fragment: none are removed from the shared core.
- New elements in the external view: report filter support and summary-oriented reporting requirements.

### 3.5 Common additions across external views
The following additions are required across stakeholder views because they are directly implied by Step 1:
- Assistantship type handling for teaching and research assistantships.
- Workload change tracking for update operations.
- Report filtering support for aggregated summaries.

### 3.6 Step 2 output statement
The external views for the Department Coordinator, Supervisor, and Program Administrator together define the stakeholder-specific changes that will be merged in Step 3. The refined conceptual model will keep the shared core from HW1/HW2 and will absorb the new request, workload, and reporting needs without duplicating stored data.

## 4. Step 3: Harmonize External Views in a Refined Conceptual Model
### Inputs
- All external views from Step 2

### Outputs
- Merged and harmonized conceptual model
- Conflict resolution notes
- Input vs refined model comparison (red obsolete, green new)

### 4.1 Purpose of the step
This step merges the stakeholder-specific external views into one refined conceptual model. The result must keep every element required by the external views while removing duplication and resolving any differences in naming, grain, or ownership of the new data objects introduced in Step 2.

### 4.2 Inputs used for harmonization
The harmonization is based on the following inputs:
- Shared core from HW1/HW2: Student, Supervisor, Department, Assistantship, Duty, Teaching_Assistantship, Research_Assistantship.
- Coordinator-specific additions: assistantship type handling in the registration flow.
- Supervisor-specific additions: workload change tracking.
- Program Administrator-specific additions: report filtering and summary generation.

### 4.3 Harmonization decisions
1. Assistantship type is kept as a single concept, not duplicated per stakeholder.
- Decision: use the existing Teaching_Assistantship and Research_Assistantship specializations together with a common Assistantship parent.
- Reason: both the coordinator and the administrator need the distinction, but the distinction describes one shared business concept.

2. Workload change tracking is represented as one operational concept.
- Decision: introduce a single change-tracking structure for workload updates instead of separate structures for each stakeholder.
- Reason: the supervisor and coordinator both refer to the same update history.

3. Report filters are not stored as business data.
- Decision: keep report filter values as query parameters, not as permanent entities.
- Reason: filters are execution-time inputs for summary generation, not persistent domain data.

4. Shared core relationships are preserved.
- Decision: keep the existing links Assistantship -> Student, Assistantship -> Supervisor, and Assistantship -> Department.
- Reason: these links are required by registration, updates, and reports.

5. No conflicting new entity names were introduced.
- Decision: retain the naming already used in HW2 for the stored domain entities and use the same naming in the refined conceptual model.
- Reason: this avoids unnecessary schema churn and keeps the model consistent with the implemented relational schema.

### 4.4 Refined conceptual model content
The refined conceptual model contains the following elements:
- Student
- Supervisor
- Department
- Assistantship
- Duty
- Teaching_Assistantship
- Research_Assistantship
- WorkloadChangeRecord

The refined model also supports derived or report-time information without storing it as separate persistent entities:
- assistantship type summaries
- allocation summaries by semester and department
- supervisor load summaries

### 4.5 Conflict resolution notes
The external views do not introduce hard conflicts that require redesign of the shared core. The only harmonization work is the consolidation of stakeholder-specific additions into one model:
- assistantship type remains a specialization concern;
- workload history becomes one change-tracking entity/structure;
- reporting filters remain transient query parameters.

### 4.6 Comparison statement
Compared with the HW1/HW2 baseline, the refined conceptual model adds only the new elements required by Step 1 documents and keeps the obsolete or unused data out of the persistent domain model. This prepares the model for schema refinement in Step 4.

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
