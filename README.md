# Employee Attendance System (Oracle SQL + PL/SQL)

A complete employee attendance tracking solution using **Oracle SQL** and **PL/SQL** — ideal for HR departments to manage daily check-ins, leaves, and monthly reports. This project includes database schema, triggers, procedures, sample data, and reporting scripts.



## 📌 Features

- ✅ Track employee check-in/check-out
- ✅ Handle multiple attendance statuses (`PRESENT`, `ABSENT`, `ON LEAVE`, `HALF DAY`)
- ✅ Manage leave requests with automatic approval updates
- ✅ Auto-generate attendance records on approved leave
- ✅ Generate monthly attendance summaries & absentee reports
- ✅ Enforced data integrity using foreign keys, constraints, and triggers

---

## 🧱 Schema Overview

### 👤 EMPLOYEES
| Column Name      | Type    | Description                    |
|------------------|---------|--------------------------------|
| EMPLOYEE_ID      | NUMBER  | Primary key                   |
| NAME             | VARCHAR | Full name                     |
| DEPARTMENT       | VARCHAR | Department name               |
| HIRE_DATE        | DATE    | Joining date                  |

---

### 📅 ATTENDANCE
| Column Name       | Type      | Description                                |
|-------------------|-----------|--------------------------------------------|
| ATTENDANCE_ID     | NUMBER    | Primary key                                |
| EMPLOYEE_ID       | NUMBER    | Foreign key referencing EMPLOYEES          |
| ATTENDANCE_DATE   | DATE      | Specific date of attendance                |
| CHECK_IN_TIME     | TIMESTAMP | Actual check-in                            |
| CHECK_OUT_TIME    | TIMESTAMP | Actual check-out                           |
| STATUS            | VARCHAR   | PRESENT / ABSENT / ON LEAVE / HALF DAY     |

🔐 Unique Constraint on (EMPLOYEE_ID, ATTENDANCE_DATE)

---

### 📝 LEAVE_REQUESTS
| Column Name       | Type    | Description                                 |
|-------------------|---------|---------------------------------------------|
| LEAVE_ID          | NUMBER  | Primary key                                 |
| EMPLOYEE_ID       | NUMBER  | Foreign key referencing EMPLOYEES           |
| START_DATE        | DATE    | Start of leave                              |
| END_DATE          | DATE    | End of leave                                |
| REASON            | VARCHAR | Reason for leave                            |
| STATUS            | VARCHAR | PENDING / APPROVED / REJECTED               |

---

## ⚙️ Core PL/SQL Logic

### 📌 Trigger: Auto-mark leave days
When a leave request is approved, a trigger automatically inserts `ON LEAVE` entries into the ATTENDANCE table for each date in the leave range.

```plsql

AFTER UPDATE OF STATUS ON LEAVE_REQUESTS
WHEN STATUS = 'APPROVED'
→ Insert 'ON LEAVE' into ATTENDANCE for each leave day

Reporting Procedures
Monthly Attendance Summary

Shows total present, absent, on leave days per employee.

List Absentees on a Given Date

Leave Requests Status Report

You can find these in:
📁 plsql/procedures.sql

🧪 Sample Data
Includes:

5 Sample Employees

Attendance logs across multiple dates

Leave requests with varying status

📁 schema/insert_sample_data.sql

🖼️ ER Diagram
You can find the ER structure here:
📁 docs/er_diagram.png
┌──────────────────┐          ┌───────────────────┐          ┌─────────────────────┐
│     EMPLOYEES    │          │     ATTENDANCE    │          │    LEAVE_REQUESTS    │
├──────────────────┤          ├───────────────────┤          ├─────────────────────┤
│ PK: EMPLOYEE_ID  │◄───┐     │ PK: ATTENDANCE_ID │     ┌────│ PK: LEAVE_ID        │
│    NAME          │    │     │ FK: EMPLOYEE_ID   │◄────┘    │ FK: EMPLOYEE_ID     │
│    DEPARTMENT    │    │     │    DATE           │          │    START_DATE       │
│    HIRE_DATE     │    │     │    CHECK_IN_TIME  │          │    END_DATE         │
└──────────────────┘    │     │    CHECK_OUT_TIME │          │    REASON           │
                        │     │    STATUS         │          │    STATUS           │
                        │     └───────────────────┘          └─────────────────────┘
                        └─────────────────────────────────────────────┘



🚀 How to Run
1. Setup Oracle SQL Developer or any Oracle DB environment
2. Run scripts in order:
sql
Copy
Edit
-- Create tables & sequences
@schema/create_tables.sql

-- Insert sample data
@schema/insert_sample_data.sql

-- Add triggers
@plsql/triggers.sql

-- Add procedures
@plsql/procedures.sql
3. Test with sample queries and procedures

---------------------------------------------------

📂 Project Structure
pgsql
Copy
Edit
employee-attendance-system/
│
├── schema/
│   ├── create_tables.sql
│   └── insert_sample_data.sql
│
├── plsql/
│   ├── triggers.sql
│   └── procedures.sql
│
├── docs/
│   ├── ER_Diagram.txt
│   └── GitHub_Instructions.md
│
└── README.md

-------------------------------------------------
📘 GitHub Instructions
Clone the repo

bash
Copy
Edit
git clone https://github.com/Banumister/employee-attendance-system.git
Open in SQL Developer or your preferred environment

Start testing features and contribute!

📥 Contribute
Have suggestions, improvements, or want to convert this into a web-based UI?
Feel free to fork and contribute!

👨‍💻 Author
Banumister
Email: bhanumiller@gmail.com
GitHub: github.com/Banumister

🏷️ Tags
Oracle PLSQL Attendance Database HRMS SQL Developer
