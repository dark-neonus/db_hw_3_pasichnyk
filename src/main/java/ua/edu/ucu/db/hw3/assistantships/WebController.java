package ua.edu.ucu.db.hw3.assistantships;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@Controller
public class WebController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/")
    public String index(Model model) {
        return "index";
    }

    // --- STEP 7: FORMS ---

    // Form 1: Insert new Student
    @GetMapping("/students/add")
    public String addStudentForm() {
        return "students_add";
    }

    @PostMapping("/students/add")
    public String addStudentSubmit(@RequestParam String first, @RequestParam String last, @RequestParam String email, @RequestParam String date, @RequestParam String program) {
        jdbcTemplate.update("INSERT INTO student (first_name, last_name, email, enrollment_date, program) VALUES (?, ?, ?, ?, ?)", first, last, email, date, program);
        return "redirect:/students/list";
    }

    // Form 2: Delete Student
    @PostMapping("/students/delete")
    public String deleteStudent(@RequestParam int id) {
        // Because ON DELETE RESTRICT is set globally from HW2, we must manually delete child records.
        jdbcTemplate.update("DELETE FROM workload_change_record WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?)", id);
        jdbcTemplate.update("DELETE FROM duty WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?)", id);
        jdbcTemplate.update("DELETE FROM teaching_assistantship WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?)", id);
        jdbcTemplate.update("DELETE FROM research_assistantship WHERE assistantship_id IN (SELECT assistantship_id FROM assistantship WHERE student_id = ?)", id);
        jdbcTemplate.update("DELETE FROM assistantship WHERE student_id = ?", id);
        jdbcTemplate.update("DELETE FROM student WHERE student_id = ?", id);
        return "redirect:/students/list";
    }

    // Form 3: Update Workload (Assistantship)
    @GetMapping("/assistantships/update")
    public String updateWorkloadForm(Model model) {
        model.addAttribute("assistantships", jdbcTemplate.queryForList("SELECT assistantship_id, hours_per_week FROM assistantship"));
        return "workload_update";
    }

    @PostMapping("/assistantships/update")
    public String updateWorkloadSubmit(@RequestParam String id, @RequestParam int newHours, @RequestParam String user, @RequestParam String reason) {
        // Fetch old hours
        Integer oldHours = jdbcTemplate.queryForObject("SELECT hours_per_week FROM assistantship WHERE assistantship_id = ?", Integer.class, id);
        
        // Update assistantship
        jdbcTemplate.update("UPDATE assistantship SET hours_per_week = ? WHERE assistantship_id = ?", newHours, id);
        
        // Insert into WorkloadChangeRecord
        jdbcTemplate.update("INSERT INTO workload_change_record (assistantship_id, old_hours, new_hours, changed_by, reason) VALUES (?, ?, ?, ?, ?)", id, oldHours, newHours, user, reason);
        
        return "redirect:/reports/workload-changes";
    }

    // List view for testing
    @GetMapping("/students/list")
    public String listStudents(Model model) {
        model.addAttribute("students", jdbcTemplate.queryForList("SELECT * FROM student"));
        return "students_list";
    }

    // --- STEP 8: REPORTS ---

    // Report 1: Assistantships by Department
    @GetMapping("/reports/by-department")
    public String reportByDepartment(Model model) {
        String sql = "SELECT d.department_name, a.assistantship_type, COUNT(a.assistantship_id) as count " +
                     "FROM assistantship a JOIN department d ON a.department_id = d.department_id " +
                     "GROUP BY d.department_name, a.assistantship_type " +
                     "ORDER BY d.department_name";
        model.addAttribute("report", jdbcTemplate.queryForList(sql));
        return "report_by_department";
    }

    // Report 2: Workload Change Audit
    @GetMapping("/reports/workload-changes")
    public String reportWorkloadChanges(Model model) {
        String sql = "SELECT w.change_id, w.assistantship_id, a.student_id, w.change_date, w.old_hours, w.new_hours, w.reason, w.changed_by " +
                     "FROM workload_change_record w JOIN assistantship a ON w.assistantship_id = a.assistantship_id " +
                     "ORDER BY w.change_date DESC";
        model.addAttribute("report", jdbcTemplate.queryForList(sql));
        return "report_workload_changes";
    }

    // Report 3: Student Contract Summary
    @GetMapping("/reports/contracts")
    public String reportStudentContracts(Model model) {
        String sql = "SELECT s.first_name, s.last_name, a.assistantship_id, a.hours_per_week, a.semester " +
                     "FROM assistantship a JOIN student s ON a.student_id = s.student_id " +
                     "ORDER BY s.last_name";
        model.addAttribute("report", jdbcTemplate.queryForList(sql));
        return "report_contracts";
    }
}
