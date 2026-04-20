USE assistantships_db;

-- Step 9 test plan (SQL checks used with HTTP form invocations)
-- Test 1: Insert student form
SELECT COUNT(*) AS before_cnt
FROM student
WHERE email = 'step9.insert@ucu.edu.ua';

SELECT student_id, first_name, last_name, email
FROM student
WHERE email = 'step9.insert@ucu.edu.ua';

-- Test 2: Update workload form
SELECT assistantship_id, hours_per_week
FROM assistantship
WHERE assistantship_id = 'AST-2025-0001';

SELECT change_id, assistantship_id, old_hours, new_hours, reason
FROM workload_change_record
WHERE assistantship_id = 'AST-2025-0001'
ORDER BY change_id DESC
LIMIT 1;

-- Test 3: Delete form integrity checks
SELECT COUNT(*) AS student_rows
FROM student
WHERE student_id = ?;

SELECT COUNT(*) AS assistantship_rows
FROM assistantship
WHERE student_id = ?;

SELECT COUNT(*) AS duty_rows
FROM duty
WHERE assistantship_id = ?;

SELECT COUNT(*) AS ta_rows
FROM teaching_assistantship
WHERE assistantship_id = ?;

SELECT COUNT(*) AS wcr_rows
FROM workload_change_record
WHERE assistantship_id = ?;

-- Report correctness checks
SELECT COUNT(*) AS assistantship_rows
FROM assistantship;

SELECT SUM(x.total) AS report_total_rows
FROM (
  SELECT COUNT(*) AS total
  FROM assistantship a
  JOIN department d ON a.department_id = d.department_id
  GROUP BY d.department_name, a.assistantship_type
) x;

SELECT COUNT(*) AS contracts_rows
FROM (
  SELECT a.assistantship_id
  FROM assistantship a
  JOIN student s ON a.student_id = s.student_id
) q;
