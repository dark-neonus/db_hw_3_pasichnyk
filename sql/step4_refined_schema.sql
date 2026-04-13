-- ============================================
-- Assistantships Database Schema (Refined - Step 4)
-- Variant: Assistantships
-- Author: Pasichnyk
-- Description: Updated to include HW3 refinements (marked with "NEW" / "GREEN" in comments)
-- ============================================

DROP DATABASE IF EXISTS assistantships_db;
CREATE DATABASE IF NOT EXISTS assistantships_db
    CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

USE assistantships_db;

-- ============================================
-- ENTITY TYPE: Department (Strong Entity)
-- ============================================
DROP TABLE IF EXISTS department;
CREATE TABLE department
(
    department_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY 
                    COMMENT 'Surrogate primary key for department',
    department_name VARCHAR(100) NOT NULL 
                    COMMENT 'Name of the department',
    faculty_name    VARCHAR(100) NOT NULL 
                    COMMENT 'Name of the faculty the department belongs to'
) ENGINE = InnoDB COMMENT = 'Department entity type';

-- ============================================
-- ENTITY TYPE: Supervisor (Strong Entity)
-- ============================================
DROP TABLE IF EXISTS supervisor;
CREATE TABLE supervisor
(
    supervisor_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY 
                    COMMENT 'Surrogate primary key for supervisor',
    first_name      VARCHAR(50) NOT NULL 
                    COMMENT 'First name of the supervisor',
    last_name       VARCHAR(50) NOT NULL 
                    COMMENT 'Last name of the supervisor',
    title           VARCHAR(20) NOT NULL 
                    COMMENT 'Academic title',
    email           VARCHAR(100) NOT NULL UNIQUE 
                    COMMENT 'Email address',
    department_id   INT UNSIGNED NOT NULL 
                    COMMENT 'Foreign key to department',
    CONSTRAINT fk_supervisor_department 
        FOREIGN KEY (department_id) REFERENCES department(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB COMMENT = 'Supervisor entity type';

-- ============================================
-- ENTITY TYPE: Student (Strong Entity)
-- ============================================
DROP TABLE IF EXISTS student;
CREATE TABLE student
(
    student_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY 
                    COMMENT 'Surrogate primary key for student',
    first_name      VARCHAR(50) NOT NULL 
                    COMMENT 'First name of the student',
    last_name       VARCHAR(50) NOT NULL 
                    COMMENT 'Last name of the student',
    email           VARCHAR(100) NOT NULL UNIQUE 
                    COMMENT 'Student email',
    enrollment_date DATE NOT NULL 
                    COMMENT 'Date when student enrolled',
    program         VARCHAR(100) NOT NULL 
                    COMMENT 'Academic program'
) ENGINE = InnoDB COMMENT = 'Student entity type';

-- ============================================
-- ENTITY TYPE: Assistantship (Primary Entity Type)
-- ============================================
DROP TABLE IF EXISTS assistantship;
CREATE TABLE assistantship
(
    assistantship_id    VARCHAR(15) NOT NULL PRIMARY KEY 
                        COMMENT 'Primary key, Format: AST-YYYY-NNNN',
    registration_number VARCHAR(20) NOT NULL UNIQUE 
                        COMMENT 'Alternative unique identifier',
    semester            ENUM('Fall', 'Spring', 'Summer') NOT NULL 
                        COMMENT 'Academic semester',
    academic_year       VARCHAR(9) NOT NULL 
                        COMMENT 'Academic year, Format: YYYY-YYYY',
    hours_per_week      TINYINT UNSIGNED NOT NULL 
                        COMMENT 'Work hours per week (typically 10, 15, or 20)',
    assistantship_type  ENUM('TA', 'RA') NOT NULL
                        COMMENT 'GREEN (NEW): explicitly storing type for queries',
    student_id          INT UNSIGNED NOT NULL 
                        COMMENT 'Foreign key to student',
    supervisor_id       INT UNSIGNED NOT NULL 
                        COMMENT 'Foreign key to supervisor',
    department_id       INT UNSIGNED NOT NULL 
                        COMMENT 'Foreign key to department',
    CONSTRAINT fk_assistantship_student 
        FOREIGN KEY (student_id) REFERENCES student(student_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_assistantship_supervisor 
        FOREIGN KEY (supervisor_id) REFERENCES supervisor(supervisor_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_assistantship_department 
        FOREIGN KEY (department_id) REFERENCES department(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB COMMENT = 'Assistantship entity type';

-- ============================================
-- ENTITY TYPE: Duty (Weak Entity)
-- ============================================
DROP TABLE IF EXISTS duty;
CREATE TABLE duty
(
    assistantship_id    VARCHAR(15) NOT NULL 
                        COMMENT 'Part of composite PK',
    duty_id             SMALLINT UNSIGNED NOT NULL 
                        COMMENT 'Part of composite PK',
    description         VARCHAR(255) NOT NULL 
                        COMMENT 'Duty description',
    PRIMARY KEY (assistantship_id, duty_id),
    CONSTRAINT fk_duty_assistantship 
        FOREIGN KEY (assistantship_id) REFERENCES assistantship(assistantship_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB COMMENT = 'Duty entity type';

-- ============================================
-- ENTITY TYPE: Teaching_Assistantship (Specialization)
-- ============================================
DROP TABLE IF EXISTS teaching_assistantship;
CREATE TABLE teaching_assistantship
(
    assistantship_id        VARCHAR(15) NOT NULL PRIMARY KEY 
                            COMMENT 'FK/PK to assistantship',
    course_code             VARCHAR(20) NOT NULL 
                            COMMENT 'Code of the course',
    course_name             VARCHAR(100) NOT NULL 
                            COMMENT 'Name of the course',
    grading_responsibility  BOOLEAN NOT NULL DEFAULT FALSE 
                            COMMENT 'Grading responsibilities',
    CONSTRAINT fk_ta_assistantship 
        FOREIGN KEY (assistantship_id) REFERENCES assistantship(assistantship_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

-- ============================================
-- ENTITY TYPE: Research_Assistantship (Specialization)
-- ============================================
DROP TABLE IF EXISTS research_assistantship;
CREATE TABLE research_assistantship
(
    assistantship_id    VARCHAR(15) NOT NULL PRIMARY KEY 
                        COMMENT 'FK/PK to assistantship',
    project_name        VARCHAR(150) NOT NULL 
                        COMMENT 'Name of the research project',
    research_topic      VARCHAR(255) NOT NULL 
                        COMMENT 'Topic or field of research',
    grant_funded        BOOLEAN NOT NULL DEFAULT FALSE 
                        COMMENT 'Funded by a grant',
    CONSTRAINT fk_ra_assistantship 
        FOREIGN KEY (assistantship_id) REFERENCES assistantship(assistantship_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;

-- ============================================
-- ENTITY TYPE: WorkloadChangeRecord (NEW - Step 4)
-- ============================================
DROP TABLE IF EXISTS workload_change_record;
CREATE TABLE workload_change_record
(
    change_id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
                        COMMENT 'GREEN (NEW): Surrogate PK',
    assistantship_id    VARCHAR(15) NOT NULL
                        COMMENT 'GREEN (NEW): FK to Assistantship',
    change_date         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                        COMMENT 'GREEN (NEW): Date of change',
    old_hours           TINYINT UNSIGNED NOT NULL
                        COMMENT 'GREEN (NEW): Previous hours per week',
    new_hours           TINYINT UNSIGNED NOT NULL
                        COMMENT 'GREEN (NEW): New hours per week',
    changed_by          VARCHAR(50) NOT NULL
                        COMMENT 'GREEN (NEW): User who made the change',
    reason              VARCHAR(255) NOT NULL
                        COMMENT 'GREEN (NEW): Justification for workload adjustment',
    CONSTRAINT fk_workload_assistantship
        FOREIGN KEY (assistantship_id) REFERENCES assistantship(assistantship_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB COMMENT = 'GREEN (NEW): Tracks workload modifications explicitly';
