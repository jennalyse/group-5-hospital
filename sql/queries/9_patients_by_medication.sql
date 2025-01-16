-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS ListPatientsByMedication;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure, taking med_id or med_name as inputs.
CREATE PROCEDURE ListPatientsByMedication(
    IN input_med_id INT,
    IN input_med_name VARCHAR(255)
)
BEGIN
    -- Declare a variable to check if the medication exists.
    DECLARE medication_exists INT DEFAULT 0;

    -- Validate if the medication exists by med_id.
    IF input_med_id IS NOT NULL THEN
        SELECT COUNT(*) INTO medication_exists
        FROM MEDICATIONS
        WHERE med_id = input_med_id;

    -- Validate if the medication exists by med_name.
    ELSEIF input_med_name IS NOT NULL THEN
        SELECT COUNT(*) INTO medication_exists
        FROM MEDICATIONS
        WHERE LOWER(med_name) = LOWER(input_med_name);
    END IF;

    -- If the medication does not exist, return an error message.
    IF medication_exists = 0 THEN
        SELECT "Medication not found." AS message;
    ELSE
        -- Query patients and associated diseases by med_id.
        IF input_med_id IS NOT NULL THEN
            SELECT 
                p.patient_id,
                p.first_name,
                p.second_name,
                dis.disease_name,
                m.med_name
            FROM 
                PATIENTS p
            JOIN 
                PRESCRIPTIONS pr ON p.patient_id = pr.patient_id
            JOIN 
                MEDICATIONS m ON pr.med_id = m.med_id
            JOIN 
                DISEASES dis ON m.med_id = dis.med_id
            WHERE 
                m.med_id = input_med_id
            ORDER BY 
                p.first_name, p.second_name;

        -- Query patients and associated diseases by med_name.
        ELSEIF input_med_name IS NOT NULL THEN
            SELECT 
                p.patient_id,
                p.first_name,
                p.second_name,
                dis.disease_name,
                m.med_name
            FROM 
                PATIENTS p
            JOIN 
                PRESCRIPTIONS pr ON p.patient_id = pr.patient_id
            JOIN 
                MEDICATIONS m ON pr.med_id = m.med_id
            JOIN 
                DISEASES dis ON m.med_id = dis.med_id
            WHERE 
                LOWER(m.med_name) = LOWER(input_med_name)
            ORDER BY 
                p.first_name, p.second_name;
        END IF;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;


-- Example calls to test the procedure...
CALL ListPatientsByMedication(5, NULL);  -- By med_id
CALL ListPatientsByMedication(NULL, 'Amoxicillin');  -- By med_name
CALL ListPatientsByMedication(999, NULL);  -- Nonexistent med_id
CALL ListPatientsByMedication(NULL, 'Nonexistent Medication');  -- Nonexistent med_name
