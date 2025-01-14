-- Drop to ensure the latest version is created and used
DROP PROCEDURE IF EXISTS ListDoctorsByDiseaseSpecialization;

-- Set DELIMITER to // to ensure the procedure is executed at once
DELIMITER //

-- Create the stored procedure to list doctors who specialize in a particular disease
CREATE PROCEDURE ListDoctorsByDiseaseSpecialization(IN input_disease_id INT, IN input_disease_name VARCHAR(255))
BEGIN
    -- Step 1: Declare variables to store intermediate results
    DECLARE disease_exists INT DEFAULT 0;

    -- Step 2: Validate and retrieve doctors associated with the disease
    IF input_disease_id IS NOT NULL THEN
        -- Use disease_id to find associated doctors
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASE
        WHERE disease_id = input_disease_id;

    ELSE
        -- Use disease_name to find associated doctors and set disease_id
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASE
        WHERE LOWER(disease_name) = LOWER(input_disease_name);

        -- Retrieve the disease_id for consistency
        SELECT disease_id INTO input_disease_id
        FROM DISEASE
        WHERE LOWER(disease_name) = LOWER(input_disease_name)
        LIMIT 1;
    END IF;

    -- Step 3: Validate if any doctors are associated with the disease
    IF disease_exists = 0 THEN
        SELECT "No doctors found who specialize in the specified disease." AS message;
        LEAVE;
    END IF;

    -- Step 4: Query DOCTORS table to retrieve doctor details
    SELECT DISTINCT d.doctor_id, d.first_name, d.second_name AS last_name, d.address, d.hospital_id
    FROM DOCTORS d
    WHERE d.doctor_id IN (
        SELECT doctor_id FROM DISEASE WHERE disease_id = input_disease_id
    );

    -- Step 5: Output the list of doctors
    IF ROW_COUNT() = 0 THEN
        SELECT "No doctors found who specialize in the specified disease." AS message;
    ELSE
        SELECT "List of doctors specializing in the disease:" AS header;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example calls to the procedure
CALL ListDoctorsByDiseaseSpecialization(201, NULL); -- Using disease_id
CALL ListDoctorsByDiseaseSpecialization(NULL, 'Diabetes'); -- Using disease_name
CALL ListDoctorsByDiseaseSpecialization(NULL, 'Nonexistent Disease'); -- Invalid disease name
