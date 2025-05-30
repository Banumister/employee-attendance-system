CREATE OR REPLACE PROCEDURE get_monthly_attendance_report (
    p_employee_id IN NUMBER,
    p_month IN NUMBER,
    p_year IN NUMBER
)
IS
BEGIN
    FOR rec IN (
        SELECT 
            ATTENDANCE_DATE,
            STATUS
        FROM ATTENDANCE
        WHERE EMPLOYEE_ID = p_employee_id
          AND EXTRACT(MONTH FROM ATTENDANCE_DATE) = p_month
          AND EXTRACT(YEAR FROM ATTENDANCE_DATE) = p_year
        ORDER BY ATTENDANCE_DATE
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Date: ' || rec.ATTENDANCE_DATE || ' - Status: ' || rec.STATUS);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE list_absentees_by_date (
    p_date IN DATE
)
IS
BEGIN
    FOR rec IN (
        SELECT e.EMPLOYEE_ID, e.EMPLOYEE_NAME
        FROM EMPLOYEES e
        WHERE NOT EXISTS (
            SELECT 1 FROM ATTENDANCE a
            WHERE a.EMPLOYEE_ID = e.EMPLOYEE_ID
              AND a.ATTENDANCE_DATE = p_date
        )
        OR EXISTS (
            SELECT 1 FROM ATTENDANCE a
            WHERE a.EMPLOYEE_ID = e.EMPLOYEE_ID
              AND a.ATTENDANCE_DATE = p_date
              AND a.STATUS = 'ABSENT'
        )
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Absent: ' || rec.EMPLOYEE_NAME || ' (ID: ' || rec.EMPLOYEE_ID || ')');
    END LOOP;
END;
/