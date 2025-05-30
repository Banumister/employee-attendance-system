
-- CREATING TRIGGER FOR TO AUTOMATICALLY UPDATING ATTENDANCE ON APPROVED LEAVE: -------

CREATE OR REPLACE TRIGGER trg_auto_leave_attendance
AFTER UPDATE OF STATUS ON LEAVE_REQUESTS
FOR EACH ROW
WHEN (NEW.STATUS = 'APPROVED')
DECLARE
    v_date DATE;
BEGIN
    v_date := :NEW.START_DATE;
    WHILE v_date <= :NEW.END_DATE LOOP
        INSERT INTO ATTENDANCE (
            ATTENDANCE_ID,
            EMPLOYEE_ID,
            ATTENDANCE_DATE,
            STATUS
        )
        VALUES (
            ATTENDANCE_SEQ.NEXTVAL,
            :NEW.EMPLOYEE_ID,
            v_date,
            'ON LEAVE'
        );
        v_date := v_date + 1;
    END LOOP;
END;
/
