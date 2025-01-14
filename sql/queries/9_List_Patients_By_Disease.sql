-- Drop to ensure the latest version is created and used
DROP PROCEDURE IF EXISTS ListPatientsByDisease;

-- Set DELIMITER to // to ensure the procedure is executed at once
DELIMITER //

-- Create the stored procedure to list patients based on prescribed medications for a disease
CREATE PROCEDURE ListPatientsByDisease(IN input_disease_id INT, IN input_disease_name VARCHAR(255))
BEGIN
    -- Step 1: Declare variables to store intermediate results
    DECLARE disease_exists INT DEFAULT 0;

    -- Step 2: Validate and retrieve medications associated with the disease
    IF input_disease_id IS NOT NULL THEN
        -- Use disease_id to find associated medications
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASE
        WHERE disease_id = input_disease_id;

    ELSE
        -- Use disease_name to find associated medications and set disease_id
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASE
        WHERE LOWER(disease_name) = LOWER(input_disease_name);
        
        -- Retrieve the disease_id for consistency
        SELECT disease_id INTO input_disease_id
        FROM DISEASE
        WHERE LOWER(disease_name) = LOWER(input_disease_name)
        LIMIT 1;
    END IF;

    -- Step 3: Validate if any medications are associated with the disease
    IF disease_exists = 0 THEN
        SELECT "No medications found for the specified disease." AS message;
        LEAVE;
    END IF;

    -- Step 4: Query PRESCRIPTIONS and PATIENTS tables to retrieve patients prescribed the medications
    SELECT DISTINCT PT.patient_id, PT.first_name, PT.second_name AS last_name, PT.address
    FROM PRESCRIPTIONS P
    JOIN PATIENTS PT ON P.patient_id = PT.patient_id
    WHERE P.med_id IN (
        SELECT med_id FROM DISEASE WHERE disease_id = input_disease_id
    );

    -- Step 5: Output the list of patients
    IF ROW_COUNT() = 0 THEN
        SELECT "No patients found for the specified disease and prescribed medications." AS message;
    ELSE
        SELECT "List of patient names and addresses:" AS header;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example calls to the procedure
CALL ListPatientsByDisease(101, NULL); -- Using disease_id
CALL ListPatientsByDisease(NULL, 'Hypertension'); -- Using disease_name
CALL ListPatientsByDisease(NULL, 'Nonexistent Disease'); -- Invalid disease name
