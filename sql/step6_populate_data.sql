USE assistantships_db;

-- 1. Department
INSERT INTO department (department_name, faculty_name) VALUES
('Computer Science', 'Faculty of Applied Sciences'),
('Data Science', 'Faculty of Applied Sciences'),
('Software Engineering', 'Faculty of Applied Sciences'),
('Mathematics', 'Faculty of Natural Sciences'),
('Physics', 'Faculty of Natural Sciences'),
('History', 'Faculty of Humanities'),
('Philosophy', 'Faculty of Humanities'),
('Psychology', 'Faculty of Social Sciences'),
('Economics', 'Faculty of Social Sciences'),
('Sociology', 'Faculty of Social Sciences');

-- 2. Supervisor
INSERT INTO supervisor (first_name, last_name, title, email, department_id) VALUES
('Oleksandr', 'Tkachenko', 'Prof.', 'oleksandr.tkachenko@ucu.edu.ua', 1),
('Mariya', 'Kovalchuk', 'Dr.', 'mariya.kovalchuk@ucu.edu.ua', 1),
('Andriy', 'Shevchenko', 'Assoc. Prof.', 'andriy.shevchenko@ucu.edu.ua', 2),
('Nataliya', 'Bondar', 'Prof.', 'nataliya.bondar@ucu.edu.ua', 3),
('Serhiy', 'Melnyk', 'Dr.', 'serhiy.melnyk@ucu.edu.ua', 4),
('Oksana', 'Moroz', 'Prof.', 'oksana.moroz@ucu.edu.ua', 5),
('Vasyl', 'Kravchenko', 'Dr.', 'vasyl.kravchenko@ucu.edu.ua', 6),
('Kateryna', 'Boiko', 'Assoc. Prof.', 'kateryna.boiko@ucu.edu.ua', 7),
('Ihor', 'Polischuk', 'Prof.', 'ihor.polischuk@ucu.edu.ua', 8),
('Yuliya', 'Lysenko', 'Dr.', 'yuliya.lysenko@ucu.edu.ua', 9),
('Dmytro', 'Sydorenko', 'Assoc. Prof.', 'dmytro.sydorenko@ucu.edu.ua', 10),
('Iryna', 'Savchenko', 'Prof.', 'iryna.savchenko@ucu.edu.ua', 2);

-- 3. Student
INSERT INTO student (first_name, last_name, email, enrollment_date, program) VALUES
('Ivan', 'Petrenko', 'ivan.petrenko@ucu.edu.ua', '2023-09-01', 'Computer Science BSc'),
('Anna', 'Shevchuk', 'anna.shevchuk@ucu.edu.ua', '2022-09-01', 'Data Science MSc'),
('Taras', 'Boyko', 'taras.boyko@ucu.edu.ua', '2023-09-01', 'Software Engineering BSc'),
('Olha', 'Koval', 'olha.koval@ucu.edu.ua', '2021-09-01', 'Mathematics MSc'),
('Mykola', 'Savchuk', 'mykola.savchuk@ucu.edu.ua', '2024-09-01', 'Physics BSc'),
('Svitlana', 'Melnyk', 'svitlana.melnyk@ucu.edu.ua', '2022-09-01', 'History MA'),
('Oleh', 'Rudenko', 'oleh.rudenko@ucu.edu.ua', '2023-09-01', 'Philosophy BA'),
('Viktoriya', 'Hryhorenko', 'viktoriya.hryhorenko@ucu.edu.ua', '2021-09-01', 'Psychology MA'),
('Pavlo', 'Kravchuk', 'pavlo.kravchuk@ucu.edu.ua', '2022-09-01', 'Economics BA'),
('Maksym', 'Lysenko', 'maksym.lysenko@ucu.edu.ua', '2023-09-01', 'Sociology MA'),
('Alina', 'Tymoshenko', 'alina.tymoshenko@ucu.edu.ua', '2022-09-01', 'Computer Science MSc'),
('Yuriy', 'Zubchenko', 'yuriy.zubchenko@ucu.edu.ua', '2024-09-01', 'Data Science BSc');

-- 4. Assistantship
INSERT INTO assistantship (assistantship_id, registration_number, semester, academic_year, hours_per_week, assistantship_type, student_id, supervisor_id, department_id) VALUES
('AST-2025-0001', 'REG-25-001-', 'Fall', '2024-2025', 10, 'TA', 1, 1, 1),
('AST-2025-0002', 'REG-25-002-', 'Fall', '2024-2025', 20, 'RA', 2, 3, 2),
('AST-2025-0003', 'REG-25-003-', 'Spring', '2024-2025', 15, 'TA', 3, 4, 3),
('AST-2025-0004', 'REG-25-004-', 'Spring', '2024-2025', 10, 'TA', 4, 5, 4),
('AST-2025-0005', 'REG-25-005-', 'Fall', '2024-2025', 20, 'RA', 5, 6, 5),
('AST-2025-0006', 'REG-25-006-', 'Summer', '2024-2025', 15, 'RA', 6, 7, 6),
('AST-2025-0007', 'REG-25-007-', 'Fall', '2024-2025', 10, 'TA', 7, 8, 7),
('AST-2025-0008', 'REG-25-008-', 'Spring', '2024-2025', 20, 'RA', 8, 9, 8),
('AST-2025-0009', 'REG-25-009-', 'Summer', '2024-2025', 15, 'TA', 9, 10, 9),
('AST-2025-0010', 'REG-25-010-', 'Fall', '2024-2025', 10, 'TA', 10, 11, 10),
('AST-2025-0011', 'REG-25-011-', 'Spring', '2024-2025', 20, 'TA', 11, 2, 1),
('AST-2025-0012', 'REG-25-012-', 'Fall', '2024-2025', 15, 'RA', 12, 12, 2);

-- 5. Duty
INSERT INTO duty (assistantship_id, duty_id, description) VALUES
('AST-2025-0001', 1, 'Grading assignments'),
('AST-2025-0002', 1, 'Data cleaning and preprocessing'),
('AST-2025-0003', 1, 'Assisting in labs'),
('AST-2025-0004', 1, 'Grading quizzes'),
('AST-2025-0005', 1, 'Setting up lab equipment'),
('AST-2025-0006', 1, 'Archival document digitization'),
('AST-2025-0007', 1, 'Leading philosophy seminar discussions'),
('AST-2025-0008', 1, 'Conducting behavioral experiments'),
('AST-2025-0009', 1, 'Compiling report'),
('AST-2025-0010', 1, 'Assisting with survey'),
('AST-2025-0011', 1, 'Managing course infrastructure'),
('AST-2025-0012', 1, 'Developing predictive models');

-- 6. Teaching_Assistantship
INSERT INTO teaching_assistantship (assistantship_id, course_code, course_name, grading_responsibility) VALUES
('AST-2025-0001', 'CS101', 'Introduction to Programming', TRUE),
('AST-2025-0003', 'SE201', 'Software Architecture', FALSE),
('AST-2025-0004', 'MA102', 'Linear Algebra', TRUE),
('AST-2025-0007', 'PL101', 'Intro to Philosophy', TRUE),
('AST-2025-0009', 'EC201', 'Macroeconomics', FALSE),
('AST-2025-0010', 'SO101', 'Foundations of Sociology', FALSE),
('AST-2025-0011', 'CS301', 'Advanced Algorithms', TRUE);

-- 7. Research_Assistantship
INSERT INTO research_assistantship (assistantship_id, project_name, research_topic, grant_funded) VALUES
('AST-2025-0002', 'Deep Learning on Edge', 'Model Quantization', TRUE),
('AST-2025-0005', 'Quantum Optics Lab', 'Photon Entanglement', TRUE),
('AST-2025-0006', 'Modern Ukrainian History Archiving', 'Digital Preservation', FALSE),
('AST-2025-0008', 'Cognitive Overload Study', 'Attention Span Metrics', TRUE),
('AST-2025-0012', 'Multilingual LLM Training', 'Zero-shot Translation', FALSE);

-- 8. WorkloadChangeRecord (NEW)
INSERT INTO workload_change_record (assistantship_id, change_date, old_hours, new_hours, changed_by, reason) VALUES
('AST-2025-0001', '2024-09-15 10:00:00', 10, 15, 'Prof. Oleksandr Tkachenko', 'Increased class size requires more grading time'),
('AST-2025-0002', '2024-10-01 14:30:00', 20, 10, 'Assoc. Prof. Andriy Shevchenko', 'Student requested workload reduction for midterms'),
('AST-2025-0008', '2025-02-10 09:15:00', 20, 15, 'Prof. Ihor Polischuk', 'Grant budget adjusted, reduced lab hours');

