
# University Missing Marks System Database Schema
========================================

## Project Title
----------------

**University Missing Marks System (MySQL Implementation)**

## Description
--------------

This project represents a fully-featured relational database schema for a university academic system. It models real-world entities such as **students, staff, schools, departments, courses, and units**. The system also includes reporting features for missing marks, reflecting a practical academic workflow used in many institutions.

The database is built purely in **MySQL**, designed to support:

*   **User management** (students, staff)
    
*   **Academic structure** (schools, departments, courses, units)
    
*   **Reporting system** for academic concerns like missing marks
    
*   **Enforced data integrity** through foreign keys, constraints, and enums
    

## Project Structure
--------------------

<pre> ```bash
   university-db/  
   ├── university_db_schema.sql  
   ├── README.md  
   └── ERD.png   ```</pre>

## How to Run / Setup the Project
---------------------------------

### Requirements

*   **MySQL Server** installed (5.7+ recommended)
    
*   MySQL client or GUI (e.g., MySQL Workbench, DBeaver, phpMyAdmin)
    

### Steps to Run

1.  **Clone or download** this repository.

<pre> ``` 
 git clone https://github.com/ClarenceLaria/plp-wk-8-database.git
``` </pre>
    
2.  Open your MySQL environment (CLI or GUI).
    
3.  SOURCE path/to/university\_missing\_marks.sql;Or, copy the content of university\_missing\_marks.sql and paste it directly into your MySQL interface to execute.
    

> ⚠️ The script will automatically create the database UniversityDB, switch to it, and generate all tables with constraints and enumerations.

## Features Implemented
------------------------

*   **Well-normalized schema** (up to 3NF+)
    
*   **Composite keys** for many-to-many relationships
    
*   **Enums** for fixed values like user types, semester, exam types, etc.
    
*   **Cascade deletes** to maintain referential integrity
    
*   Support for **One-to-Many**, **Many-to-One**, and **Many-to-Many** relationships
    

## Core Tables and Relationships
--------------------------------

TableDescription**School**Represents a school within the university (e.g., School of Engineering)**Department**Belongs to a school; handles specific academic disciplines**Course**Offered by a department, taken by students**Student**User entity with link to course and department**Staff**University personnel such as lecturers, CODs, and Deans**Unit**Represents a subject or class in a semester**UnitCourse**A junction table linking courses and units (many-to-many)**MissingMarksReport**Tracks issues related to unrecorded exam marks by students

## Constraints & Integrity Rules
--------------------------------

*   **Primary Keys:** Auto-incrementing INT for all main tables.
    
*   **Foreign Keys:** Enforced throughout with ON DELETE CASCADE for referential integrity.
    
*   **Unique Constraints:** Enforced on email, regNo, phoneNumber, and other key fields.
    
*   **Enums:**
    
    *   UserType (e.g., SUPERADMIN, ADMIN, DEAN, COD, LECTURER, STUDENT)
        
    *   Semester (SEMESTER1, SEMESTER2, SEMESTER3)
        
    *   ExamType (MAIN, SPECIAL, SUPPLIMENTARY, CAT, MAIN\_AND\_CAT)
        
    *   ReportStatus (PENDING, MARK\_FOUND, MARK\_NOT\_FOUND, FOR\_FURTHER\_INVESTIGATION)
        
    *   UserStatus (active, inactive)
        

## Academic Use Cases Covered
-----------------------------

*   Track and manage student information and academic progress
    
*   Assign staff to specific schools and departments
    
*   Enable course and unit registration mapping
    
*   Allow students to file reports for missing exam marks
    
*   Provide a structure for semester-based unit delivery
    

## Entity Relationship Diagram (ERD)
------------------------------------

You can view the ERD here:

> Replace the path with a URL or file name if you store the diagram elsewhere.

## Submission Instructions
--------------------------

*   Submit **one SQL file**: university\_db\_schema.sql (well-commented)
    
*   Include this **README.md** with setup and project details
    
*   Provide the **ERD** image or link    

## Contributing
---------------

Pull requests are welcome! Feel free to fork the repository and submit improvements or fixes.

## License
----------

This project is open-source and available for academic and educational use.