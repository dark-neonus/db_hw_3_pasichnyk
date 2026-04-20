USE assistantships_db;

-- Step 7 Form 1: Add new student (Student Profile Card)
-- Parameters: ?, ?, ?, ?, ?
INSERT INTO student (first_name, last_name, email, enrollment_date, program)
VALUES (?, ?, ?, ?, ?);

-- Step 7 Form 2: Update assistantship workload (Assistantship Change Request)
-- Parameters: new hours, assistantship id
UPDATE assistantship
SET hours_per_week = ?
WHERE assistantship_id = ?;

-- Parameters: assistantship id, old hours, new hours, changed by, reason
INSERT INTO workload_change_record (assistantship_id, old_hours, new_hours, changed_by, reason)
VALUES (?, ?, ?, ?, ?);

-- Step 7 Form 3: Delete student with child records to preserve referential integrity
-- Parameter: student id
DELETE FROM workload_change_record
WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?);

DELETE FROM duty
WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?);

DELETE FROM teaching_assistantship
WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?);

DELETE FROM research_assistantship
WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?);

DELETE FROM assistantship
WHERE student_id = ?;

DELETE FROM student
WHERE student_id = ?;
