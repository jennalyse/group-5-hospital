-- Drop procedure to ensure the latest version is created
DROP PROCEDURE IF EXISTS ListPrescriptionsByPatient;

-- Set DELIMITER to // to ensure the procedure executes at once
DELIMITER //

-- Create the stored procedure
CREATE PROCEDURE ListPrescriptionsByPatient(IN input_first_name VARCHAR(255), IN input_second_name VARCHAR(255))
BEGIN
    -- Declare a variable to check if the patient exists
    DECLARE patient_exists INT DEFAULT 0;

    -- Validate that the patient exists using the provided name
    SELECT COUNT(*) INTO patient_exists
    FROM PATIENTS
    WHERE LOWER(first_name) = LOWER(input_first_name)
      AND LOWER(second_name) = LOWER(input_second_name);

    -- If the patient does not exist, return an error message
    IF patient_exists = 0 THEN
        SELECT "Patient not found." AS message;
    ELSE
        -- If the patient exists, query their prescriptions
        SELECT 
            pr.prescription_id,
            pr.prescription_date,
            pr.medicine_name,
            pr.dosage,
            pr.instructions,
            CONCAT(p.first_name, ' ', p.second_name) AS patient_name
        FROM PRESCRIPTIONS pr
        JOIN PATIENTS p ON pr.patient_id = p.patient_id
        WHERE LOWER(p.first_name) = LOWER(input_first_name)
          AND LOWER(p.second_name) = LOWER(input_second_name)
        ORDER BY pr.prescription_date;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example calls to the procedure
CALL ListPrescriptionsByPatient('Henry', 'Kelly');
CALL ListPrescriptionsByPatient('Wendy', 'Green');
