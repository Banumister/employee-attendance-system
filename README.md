# Employee Attendance Management System (SQL + PL/SQL)

## 📌 Description
A PL/SQL-based backend system to manage employee attendance, leave requests, and departmental hierarchy.

## 📂 Folder Structure
- `schema/` - Table creation and sample data
- `plsql/` - Triggers and procedures
- `scripts/` - Reporting queries and utilities (optional)

## ⚙️ Setup Instructions
1. Run `schema/create_tables.sql` to create the database schema.
2. Run `schema/insert_sample_data.sql` to load sample data.
3. Run `plsql/triggers.sql` to create the trigger for leave automation.
4. Update `LEAVE_REQUESTS` to `APPROVED` to auto-insert leave in attendance.

## 📊 Tables Overview
- **DEPARTMENTS**: Department master.
- **EMPLOYEES**: Employee master.
- **ATTENDANCE**: Daily attendance tracking.
- **LEAVE_REQUESTS**: Tracks leave applications.

## 🧪 Sample Query
```sql
SELECT * FROM ATTENDANCE WHERE EMPLOYEE_ID = 102 ORDER BY ATTENDANCE_DATE;
```

## 🔄 Auto Leave Attendance
Automatically updates `ATTENDANCE` table when leave is approved.

---
📁 Designed for Oracle SQL Developer / PL/SQL environments.

## 📈 Stored Procedures
- `get_monthly_attendance_report`
- `list_absentees_by_date`

## 🛠 GitHub Setup
See `docs/GitHub_Instructions.md`
## 🗺 ER Diagram Overview
See `docs/ER_Diagram.txt`
