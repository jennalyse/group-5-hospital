-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS ListPrescriptionsByPatient;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure, taking patient_id or first_name and second_name as inputs.
CREATE PROCEDURE ListPrescriptionsByPatient(
    IN input_patient_id INT,
    IN input_first_name VARCHAR(255),
    IN input_second_name VARCHAR(255)
)
BEGIN
    -- Declare a variable to check if the patient exists.
    DECLARE patient_exists INT DEFAULT 0;

    -- Validate if the patient exists by patient_id.
    IF input_patient_id IS NOT NULL THEN
        SELECT COUNT(*) INTO patient_exists
        FROM PATIENTS
        WHERE patient_id = input_patient_id;

    -- Validate if the patient exists by first_name and second_name.
    ELSEIF input_first_name IS NOT NULL AND input_second_name IS NOT NULL THEN
        SELECT COUNT(*) INTO patient_exists
        FROM PATIENTS
        WHERE LOWER(first_name) = LOWER(input_first_name)
          AND LOWER(second_name) = LOWER(input_second_name);
    END IF;

    -- If the patient does not exist, return an error message.
    IF patient_exists = 0 THEN
        SELECT "Patient not found." AS message;
    ELSE
        -- Query prescriptions if patient_id is provided.
        IF input_patient_id IS NOT NULL THEN
            SELECT 
                pr.prescription_id,
                pr.prescription_date,
                m.med_name,
                m.med_type,
                dis.disease_name,
                dis.disease_treatment
            FROM 
                PRESCRIPTIONS pr
            JOIN 
                MEDICATIONS m ON pr.med_id = m.med_id
            JOIN 
                DISEASES dis ON m.med_id = dis.med_id
            WHERE 
                pr.patient_id = input_patient_id
            ORDER BY 
                pr.prescription_date;

        -- Query prescriptions if first_name and second_name are provided.
        ELSEIF input_first_name IS NOT NULL AND input_second_name IS NOT NULL THEN
            SELECT 
                pr.prescription_id,
                pr.prescription_date,
                m.med_name,
                m.med_type,
                dis.disease_name,
                dis.disease_treatment
            FROM 
                PRESCRIPTIONS pr
            JOIN 
                PATIENTS p ON pr.patient_id = p.patient_id
            JOIN 
                MEDICATIONS m ON pr.med_id = m.med_id
            JOIN 
                DISEASES dis ON m.med_id = dis.med_id
            WHERE 
                LOWER(p.first_name) = LOWER(input_first_name)
                AND LOWER(p.second_name) = LOWER(input_second_name)
            ORDER BY 
                pr.prescription_date;
        END IF;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;


-- Example calls to test the procedure...
CALL ListPrescriptionsByPatient(6, NULL, NULL);  -- By patient_id
CALL ListPrescriptionsByPatient(NULL, 'Jessica', 'Dixon');  -- By patient name
CALL ListPrescriptionsByPatient(NULL, 'Nonexistent', 'Person');  -- Nonexistent patient
