-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ListAppointmentsByPatient;

DELIMITER //

CREATE PROCEDURE ListAppointmentsByPatient(
    IN input_patient_id INT,
    IN input_first_name VARCHAR(255),
    IN input_second_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE patient_id INT;

    -- Step 1: Validate input and retrieve patient ID
    IF input_patient_id IS NOT NULL THEN
        SET patient_id = input_patient_id;
    ELSE
        SELECT p.patient_id INTO patient_id
        FROM PATIENTS p
        WHERE LOWER(p.first_name) = LOWER(input_first_name)
          AND LOWER(p.second_name) = LOWER(input_second_name);

        IF patient_id IS NULL THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Patient not found.';
        END IF;
    END IF;

    -- Step 2: Retrieve appointments
    SELECT
        a.appt_date AS AppointmentDate,
        a.appt_purpose AS Purpose,
        CONCAT(d.first_name, ' ', d.second_name) AS DOCTORNAME
    FROM APPOINTMENTS a
    JOIN DOCTORS d ON a.doctor_id = d.doctor_id
    WHERE a.patient_id = patient_id
    ORDER BY a.appt_date ASC;

END //

DELIMITER ;


-- Example calls to test the procedure...
CALL ListAppointmentsByPatient(123, NULL, NULL);
