USE assistantships_db;

-- Step 8 Report 1: Assistantships by Department and Type
SELECT d.department_name,
       a.assistantship_type,
       COUNT(a.assistantship_id) AS total
FROM assistantship a
JOIN department d ON a.department_id = d.department_id
GROUP BY d.department_name, a.assistantship_type
ORDER BY d.department_name, a.assistantship_type;

-- Step 8 Report 2: Workload Change Audit
SELECT w.change_id,
       w.assistantship_id,
       a.student_id,
       w.change_date,
       w.old_hours,
       w.new_hours,
       w.reason,
       w.changed_by
FROM workload_change_record w
JOIN assistantship a ON w.assistantship_id = a.assistantship_id
ORDER BY w.change_date DESC;

-- Step 8 Report 3: Current Contracts per Student
SELECT s.first_name,
       s.last_name,
       a.assistantship_id,
       a.hours_per_week,
       a.semester
FROM assistantship a
JOIN student s ON a.student_id = s.student_id
ORDER BY s.last_name, s.first_name;
