
-----CREATING PROCEDURE TO MARK_ATTENDACE------

CREATE OR REPLACE PROCEDURE mark_attendance (
    p_employee_id IN NUMBER,
    p_date IN DATE,
    p_checkin IN TIMESTAMP,
    p_checkout IN TIMESTAMP,
    p_status IN VARCHAR2
) AS
BEGIN
    INSERT INTO ATTENDANCE (
        ATTENDANCE_ID,
        EMPLOYEE_ID,
        ATTENDANCE_DATE,
        CHECK_IN_TIME,
        CHECK_OUT_TIME,
        STATUS
    ) VALUES (
        ATTENDANCE_SEQ.NEXTVAL,
        p_employee_id,
        p_date,
        p_checkin,
        p_checkout,
        p_status
    );
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Attendance already marked for this employee and date.');
END;
/



-- PROCEDURE FOR AUDITING THE MONTHLY ATTENDANCE REPORT FOR THE EMPLOYEES --
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

--- PROCEDURE FOR TO CHECK THE LIST OF ABSENTEES BY USING DATE --
    
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
