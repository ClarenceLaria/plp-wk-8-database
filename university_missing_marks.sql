
-- Create the database and use it
CREATE DATABASE IF NOT EXISTS UniversityMissingMarksDB;
USE UniversityMissingMarksDB;

-- Staff table
-- This table stores information about staff members, including their email, name, phone number, password, user type, and department.
-- The user type can be SUPERADMIN, ADMIN, DEAN, COD, LECTURER, or STUDENT.
-- The SUPERADMIN has the highest privileges(SYS-ADMIN), while STUDENT has the lowest. 
-- The ADMIN(Vice-chancelor, Deputy Dive Chancelor e.t.c), DEAN(Incharge of a school), COD(Chair of Department), and LECTURER have varying levels of access.
-- The user status can be active or inactive.
-- The departmentId and schoolId are foreign keys referencing the Department and School tables, respectively.
-- The createdAt field stores the timestamp of when the record was created.
CREATE TABLE Staff (
  id INT PRIMARY KEY AUTO_INCREMENT,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  email VARCHAR(100) UNIQUE NOT NULL,
  firstName VARCHAR(100) NOT NULL,
  secondName VARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(20) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  userType ENUM('SUPERADMIN', 'ADMIN', 'DEAN', 'COD', 'LECTURER', 'STUDENT') DEFAULT 'LECTURER',
  departmentId INT NOT NULL,
  schoolId INT NOT NULL,
  userStatus ENUM('active', 'inactive') DEFAULT 'inactive',
  FOREIGN KEY (departmentId) REFERENCES Department(id) ON DELETE CASCADE,
  FOREIGN KEY (schoolId) REFERENCES School(id) ON DELETE CASCADE
);

-- Student table
-- This table stores information about students, including their email, name, password, registration number, year of study, department, and course.
-- The user type is set to STUDENT by default, and the user status can be active or inactive.
-- The departmentId and courseId are foreign keys referencing the Department and Course tables, respectively.
-- example record of a student:
-- id: 1
-- createdAt: 2023-10-01 12:00:00
-- email: johndoe@student.university.com
-- firstName: John
-- secondName: Doe
-- password: hashed_password
-- regNo: 2023/12345
-- yearOfStudy: 2
-- departmentId: 1
-- courseId: 1
-- userType: STUDENT
-- userStatus: active
-- There is no direct relationship between a student and a school in this schema.
-- The student is associated with a department and a course, which are linked to a school through the departmentId and courseId foreign keys. 
-- The createdAt field stores the timestamp of when the record was created.
-- The email and registration number are unique identifiers for the student.
CREATE TABLE Student (
  id INT PRIMARY KEY AUTO_INCREMENT,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  email VARCHAR(100) UNIQUE NOT NULL,
  firstName VARCHAR(100) NOT NULL,
  secondName VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  regNo VARCHAR(50) UNIQUE NOT NULL,
  yearOfStudy INT,
  departmentId INT NOT NULL,
  courseId INT NOT NULL,
  userType ENUM('SUPERADMIN', 'ADMIN', 'DEAN', 'COD', 'LECTURER', 'STUDENT') DEFAULT 'STUDENT',
  userStatus ENUM('active', 'inactive') DEFAULT 'active',
  FOREIGN KEY (departmentId) REFERENCES Department(id) ON DELETE CASCADE,
  FOREIGN KEY (courseId) REFERENCES Course(id) ON DELETE CASCADE
);

-- School table
-- This table stores information about schools, including their name and abbreviation.
-- The abbreviation must be unique.
-- example of schools: School of Business, School of Engineering, School of Arts and Social Sciences, School of Law, School of Medicine, School of Education.
-- The abbreviation is a short form of the school name, such as SOB for School of Business, SOE for School of Engineering, SASS for School of Arts and Social Sciences, SOL for School of Law, SOM for School of Medicine, and SOE for School of Education.
CREATE TABLE School (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  abbreviation VARCHAR(20) UNIQUE NOT NULL
);

-- Department table
-- This table stores information about departments, including their name and the school they belong to.
-- each department is associated with a school through the schoolId foreign key.
-- example of departments: Department of Computer Science and Department of Information Technology belonging to the School of Computing and Informatics 
CREATE TABLE Department (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  schoolId INT NOT NULL,
  FOREIGN KEY (schoolId) REFERENCES School(id) ON DELETE CASCADE
);

-- Course table
-- This table stores information about courses, including their name and the department they belong to.
-- each course is associated with a department through the departmentId foreign key.
-- example of courses: Bachelor of Science in Computer Science, Bachelor of Science in Information Technology, Bachelor of Commerce, Bachelor of Arts in Sociology
CREATE TABLE Course (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  departmentId INT NOT NULL,
  FOREIGN KEY (departmentId) REFERENCES Department(id) ON DELETE CASCADE
);

-- Unit table
-- This table stores information about units, including their name, code, academic year, year of study, semester, and the lecturer teaching the unit.
-- The semester can be SEMESTER1, SEMESTER2, or SEMESTER3, with SEMESTER1 as the default.
-- The lecturerId is a foreign key referencing the Staff table, indicating the lecturer teaching the unit.
-- example of units: 
-- Unit name: Data Structures and Algorithms
-- Unit code: CS101
-- Academic year: 2023/2024
-- Year of study: 2
-- Semester: SEMESTER1
-- Lecturer: LEC001
-- The unit is associated with a course through the UnitCourse junction table.
-- The unit code is a unique identifier for the unit, and the academic year indicates the year in which the unit is being taught.
CREATE TABLE Unit (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  code VARCHAR(50) NOT NULL,
  academicYear VARCHAR(20) NOT NULL,
  yearOfStudy INT NOT NULL,
  semester ENUM('SEMESTER1', 'SEMESTER2', 'SEMESTER3') DEFAULT 'SEMESTER1',
  lecturerId INT NOT NULL,
  FOREIGN KEY (lecturerId) REFERENCES Staff(id) ON DELETE CASCADE
);

-- UnitCourse (junction table)
-- This table is a many-to-many relationship between units and courses.
-- It allows a unit to be associated with multiple courses and a course to be associated with multiple units.
-- The unitId and courseId are foreign keys referencing the Unit and Course tables, respectively.
-- The primary key is a composite key of unitId and courseId.
-- example of a unit-course association:
-- Unit: Data Structures and Algorithms UNITID- CS101
-- Course: Bachelor of Science in Computer Science COURSEID - COURSE001
CREATE TABLE UnitCourse (
  unitId INT NOT NULL,
  courseId INT NOT NULL,
  PRIMARY KEY (unitId, courseId),
  FOREIGN KEY (unitId) REFERENCES Unit(id) ON DELETE CASCADE,
  FOREIGN KEY (courseId) REFERENCES Course(id) ON DELETE CASCADE
);

-- MissingMarksReport table
-- This table stores information about missing marks reports, including the unit name, unit code, lecturer name, academic year, exam type, report status, year of study, semester, student ID, and unit ID.
-- The exam type can be MAIN, SPECIAL, SUPPLIMENTARY, CAT, or MAIN_AND_CAT.
-- The report status can be PENDING, MARK_FOUND, MARK_NOT_FOUND, or FOR_FURTHER_INVESTIGATION.
-- example of a missing marks report:
-- id: 1
-- createdAt: 2023-10-01 12:00:00
-- unitName: Data Structures and Algorithms
-- unitCode: CS101
-- lecturerName: Dr. Jane Smith
-- academicYear: 2023/2024
-- examType: MAIN
-- reportStatus: PENDING
-- yearOfStudy: 2
-- semester: SEMESTER1
-- studentId: 1
-- unitId: 1
-- The studentId and unitId are foreign keys referencing the Student and Unit tables, respectively.
CREATE TABLE MissingMarksReport (
  id INT PRIMARY KEY AUTO_INCREMENT,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  unitName VARCHAR(100) NOT NULL,
  unitCode VARCHAR(50) NOT NULL,
  lecturerName VARCHAR(100) NOT NULL,
  academicYear VARCHAR(20) NOT NULL,
  examType ENUM('MAIN', 'SPECIAL', 'SUPPLIMENTARY', 'CAT', 'MAIN_AND_CAT') NOT NULL,
  reportStatus ENUM('PENDING', 'MARK_FOUND', 'MARK_NOT_FOUND', 'FOR_FURTHER_INVESTIGATION') DEFAULT 'PENDING',
  yearOfStudy INT NOT NULL,
  semester ENUM('SEMESTER1', 'SEMESTER2', 'SEMESTER3') NOT NULL,
  studentId INT NOT NULL,
  unitId INT NOT NULL,
  FOREIGN KEY (studentId) REFERENCES Student(id) ON DELETE CASCADE,
  FOREIGN KEY (unitId) REFERENCES Unit(id) ON DELETE CASCADE
);
