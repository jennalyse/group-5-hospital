-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ListAppointmentsByDoctor;

DELIMITER //

CREATE PROCEDURE ListAppointmentsByDoctor(
    IN input_doctor_id INT,
    IN input_first_name VARCHAR(255),
    IN input_second_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE doctor_id INT;

    -- Step 1: Validate input and retrieve doctor ID
    IF input_doctor_id IS NOT NULL THEN
        SET doctor_id = input_doctor_id;
    ELSE
        SELECT d.doctor_id INTO doctor_id
        FROM DOCTORS d
        WHERE LOWER(d.first_name) = LOWER(input_first_name)
          AND LOWER(d.second_name) = LOWER(input_second_name);

        IF doctor_id IS NULL THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Doctor not found.';
        END IF;
    END IF;

    -- Step 2: Retrieve appointments
    SELECT
        a.appt_date AS AppointmentDate,
        a.appt_purpose AS Purpose,
        CONCAT(p.first_name, ' ', p.second_name) AS PatientName
    FROM APPOINTMENTS a
    JOIN PATIENTS p ON a.patient_id = p.patient_id
    WHERE a.doctor_id = doctor_id
    ORDER BY a.appt_date ASC;

END //

DELIMITER ; 

-- Example calls to test the procedure...
CALL ListAppointmentsByDoctor(45, NULL, NULL);
CALL ListAppointmentsByDoctor(NULL, 'Jayne', 'Lewis');
