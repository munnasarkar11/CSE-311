CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Student', 'Faculty', 'Advisor') NOT NULL
);


-- DEPARTMENT TABLE

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL,
    building VARCHAR(100),
    office_phone VARCHAR(20)
);


-- FACULTY TABLE

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    designation VARCHAR(100),
    phone_number VARCHAR(20),
    qualification VARCHAR(200),
    office_room VARCHAR(50),
    department_id INT,
    FOREIGN KEY (faculty_id) REFERENCES users(id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);


-- ADVISOR TABLE (Faculty subset)

CREATE TABLE advisors (
    advisor_id INT PRIMARY KEY,
    department_id INT UNIQUE,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (advisor_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);


-- STUDENTS TABLE

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    birth_date DATE,
    gender ENUM('Male','Female','Other'),
    batch VARCHAR(50),
    department_id INT,
    advisor_id INT,
    FOREIGN KEY (student_id) REFERENCES users(id),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (advisor_id) REFERENCES advisors(advisor_id)
);

CREATE TABLE student_phones (
    student_id INT,
    phone_number VARCHAR(20),
    PRIMARY KEY (student_id, phone_number),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


-- SEMESTERS TABLE

CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE
);


-- COURSES TABLE

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    credit_hours INT NOT NULL,
    prerequisites TEXT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- ENROLLMENT (Ternary Relation: Student-Course-Semester)

CREATE TABLE enrollment (
    student_id INT,
    course_id INT,
    semester_id INT,
    PRIMARY KEY (student_id, course_id, semester_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- GRADES TABLE

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester_id INT,
    grade VARCHAR(5) NOT NULL,
    grade_point FLOAT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);


-- TRANSCRIPTS (Weak Entity: Student + Semester)

CREATE TABLE transcripts (
    student_id INT,
    semester_id INT,
  
    issue_date DATE,
    remarks TEXT,
    PRIMARY KEY (student_id, semester_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);


-- ATTENDANCE (Weak Entity: Student + Course + Class Date)

CREATE TABLE attendance (
    student_id INT,
    course_id INT,
    class_date DATE,
    status ENUM('Present', 'Absent') NOT NULL,
    remarks TEXT,
    PRIMARY KEY (student_id, course_id, class_date),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- Faculty assigns student to course
CREATE TABLE assigned_courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    faculty_id INT NOT NULL,
    semester_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);
CREATE TABLE grade_scale (
    grade VARCHAR(5) PRIMARY KEY,
    grade_point FLOAT NOT NULL
);
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);
