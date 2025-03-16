# Student Diary Console Application

## Overview
The Student Diary is a Ruby-based console application designed to help students manage their academic progress. It enables users to create and track semesters, disciplines, and lab work, while also providing detailed analytics on their performance. All data is stored in a database (MySQL or PostgreSQL) and can be exported to a CSV file for convenience.

---

## Features

### 1. **Semester Management**
- Create and manage semesters with:
    - **Custom names** (e.g., "1st Semester", "English Course").
    - **Start and end dates**.
- Support for **parallel semesters** (multiple active semesters simultaneously).

### 2. **Discipline Management**
- Add disciplines to a specific semester.
- Each discipline includes:
    - **Name** (e.g., "Mathematics", "Programming").
    - **List of lab works**.

### 3. **Lab Work Management**
- Add lab works to disciplines with:
    - **Name**.
    - **Deadline**.
    - **Status** (completed or not completed).
    - **Grade**.
- Update the status and grade of lab works.

### 4. **Analytics and Reporting**
#### Levels of Analysis
- **By a specific semester.**
- **By all active semesters.**
- **By completed semesters.**

#### Available Data
- **Semester Status**:
    - Active or completed (based on the current date).
- **Average Grades**:
    - By discipline.
    - Across all disciplines.
- **Lab Work Status**:
    - List of completed and uncompleted lab works.
    - Lab works with overdue deadlines.
- **Overall Lab Work Metrics**:
    - Total number of lab works.
    - Number and percentage of completed lab works.

#### Configurable Output
- Option to display specific data:
    - Average grades only.
    - List of uncompleted lab works.
    - Full report (all available analytics).

#### Example Output
```
Semester: 1st Semester
Status: Active
---------------------
Discipline: Mathematics
  - Average Grade: 4.5
  - Lab Works:
      [Completed] Lab 1 (Grade: 5)
      [Not Completed] Lab 2 (Deadline: 2025-02-15)
---------------------
Discipline: Programming
  - Average Grade: 3.7
  - Lab Works:
      [Completed] Lab 1 (Grade: 4)
      [Completed] Lab 2 (Grade: 3)
---------------------
Overall Average Grade: 4.1
```

### 5. **Data Export**
- Export all stored data to a **CSV file** for further analysis or sharing.

---

## User Interface
- The application runs in the **console**.
- Features a menu-driven interface where users can:
    - Create and manage semesters, disciplines, and lab works.
    - View detailed analytics.
    - Export data to CSV.
    - Exit the application by typing `exit`.

---

## Database Requirements
- Supported databases: **MySQL** or **PostgreSQL**.
- Data storage includes:
    - Semesters (name, start date, end date).
    - Disciplines (name, linked to a semester).
    - Lab works (name, deadline, status, grade).
