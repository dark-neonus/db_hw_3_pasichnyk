set -e
ROOT='/mnt/D/ucu/db/hw3/db_hw_3_pasichnyk'
DB='docker exec assistantships-db-hw-3-mysql mysql -N -B -uroot -psecret -D assistantships_db'

# Reset baseline
cd "$ROOT"
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step4_refined_schema.sql > /tmp/step9_schema_reset.log 2>&1
docker exec -i assistantships-db-hw-3-mysql mysql -uroot -psecret < sql/step6_populate_data.sql > /tmp/step9_data_reset.log 2>&1

echo '=== TEST 1: INSERT FORM (students/add) ==='
echo 'T1_BEFORE_COUNT'
$DB -e "SELECT COUNT(*) FROM student WHERE email='step9.insert@ucu.edu.ua';"
curl -s -o /dev/null -w 'T1_HTTP %{http_code}\n' -X POST http://localhost:8080/students/add \
  -d 'first=Step9' -d 'last=Insert' -d 'email=step9.insert@ucu.edu.ua' -d 'date=2025-09-01' -d 'program=Data Science MSc'
echo 'T1_AFTER_ROW'
$DB -e "SELECT student_id,first_name,last_name,email FROM student WHERE email='step9.insert@ucu.edu.ua';"

echo '=== TEST 2: UPDATE FORM (assistantships/update) ==='
echo 'T2_BEFORE_ASSISTANTSHIP'
$DB -e "SELECT assistantship_id,hours_per_week FROM assistantship WHERE assistantship_id='AST-2025-0001';"
echo 'T2_BEFORE_LAST_LOG'
$DB -e "SELECT change_id,assistantship_id,old_hours,new_hours,reason FROM workload_change_record WHERE assistantship_id='AST-2025-0001' ORDER BY change_id DESC LIMIT 1;"
curl -s -o /dev/null -w 'T2_HTTP %{http_code}\n' -X POST http://localhost:8080/assistantships/update \
  -d 'id=AST-2025-0001' -d 'newHours=18' -d 'user=Step9%20QA' -d 'reason=Step9 update verification'
echo 'T2_AFTER_ASSISTANTSHIP'
$DB -e "SELECT assistantship_id,hours_per_week FROM assistantship WHERE assistantship_id='AST-2025-0001';"
echo 'T2_AFTER_LAST_LOG'
$DB -e "SELECT change_id,assistantship_id,old_hours,new_hours,reason FROM workload_change_record WHERE assistantship_id='AST-2025-0001' ORDER BY change_id DESC LIMIT 1;"

echo '=== TEST 3: DELETE FORM (students/delete) ==='
$DB -e "INSERT INTO student (first_name,last_name,email,enrollment_date,program) VALUES ('Step9','Delete','step9.delete@ucu.edu.ua','2025-09-01','Computer Science BSc');"
DEL_ID=$($DB -e "SELECT student_id FROM student WHERE email='step9.delete@ucu.edu.ua' ORDER BY student_id DESC LIMIT 1;")
$DB -e "INSERT INTO assistantship (assistantship_id, registration_number, semester, academic_year, hours_per_week, assistantship_type, student_id, supervisor_id, department_id) VALUES ('AST-2025-1999','REG-25-1999','Fall','2025-2026',10,'TA',${DEL_ID},1,1);"
$DB -e "INSERT INTO duty (assistantship_id, duty_id, description) VALUES ('AST-2025-1999',1,'Step9 delete duty');"
$DB -e "INSERT INTO teaching_assistantship (assistantship_id, course_code, course_name, grading_responsibility) VALUES ('AST-2025-1999','CS1999','Step9 Delete Course',0);"
$DB -e "INSERT INTO workload_change_record (assistantship_id, old_hours, new_hours, changed_by, reason) VALUES ('AST-2025-1999',10,12,'Step9 QA','Delete verification');"
echo "T3_TARGET_ID ${DEL_ID}"
echo 'T3_BEFORE_STUDENT'
$DB -e "SELECT COUNT(*) FROM student WHERE student_id=${DEL_ID};"
echo 'T3_BEFORE_ASSISTANTSHIP'
$DB -e "SELECT COUNT(*) FROM assistantship WHERE student_id=${DEL_ID};"
echo 'T3_BEFORE_DUTY'
$DB -e "SELECT COUNT(*) FROM duty WHERE assistantship_id='AST-2025-1999';"
echo 'T3_BEFORE_TA'
$DB -e "SELECT COUNT(*) FROM teaching_assistantship WHERE assistantship_id='AST-2025-1999';"
echo 'T3_BEFORE_WCR'
$DB -e "SELECT COUNT(*) FROM workload_change_record WHERE assistantship_id='AST-2025-1999';"
curl -s -o /dev/null -w 'T3_HTTP %{http_code}\n' -X POST http://localhost:8080/students/delete -d "id=${DEL_ID}"
echo 'T3_AFTER_STUDENT'
$DB -e "SELECT COUNT(*) FROM student WHERE student_id=${DEL_ID};"
echo 'T3_AFTER_ASSISTANTSHIP'
$DB -e "SELECT COUNT(*) FROM assistantship WHERE student_id=${DEL_ID};"
echo 'T3_AFTER_DUTY'
$DB -e "SELECT COUNT(*) FROM duty WHERE assistantship_id='AST-2025-1999';"
echo 'T3_AFTER_TA'
$DB -e "SELECT COUNT(*) FROM teaching_assistantship WHERE assistantship_id='AST-2025-1999';"
echo 'T3_AFTER_WCR'
$DB -e "SELECT COUNT(*) FROM workload_change_record WHERE assistantship_id='AST-2025-1999';"

echo '=== REPORT VALIDATION CHECKS ==='
$DB -e "SELECT COUNT(*) AS assistantship_rows FROM assistantship;"
$DB -e "SELECT SUM(x.total) AS report_total_rows FROM (SELECT COUNT(*) AS total FROM assistantship a JOIN department d ON a.department_id=d.department_id GROUP BY d.department_name, a.assistantship_type) x;"
$DB -e "SELECT COUNT(*) AS contracts_rows FROM (SELECT a.assistantship_id FROM assistantship a JOIN student s ON a.student_id=s.student_id) q;"
