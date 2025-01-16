-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS ListDoctorsByDisease;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure, taking disease_id or disease_name as inputs.
CREATE PROCEDURE ListDoctorsByDisease(
    IN input_disease_id INT,
    IN input_disease_name VARCHAR(255)
)
BEGIN
    -- Declare a variable to check if the disease exists.
    DECLARE disease_exists INT DEFAULT 0;

    -- Validate if the disease exists by disease_id.
    IF input_disease_id IS NOT NULL THEN
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASES
        WHERE disease_id = input_disease_id;

    -- Validate if the disease exists by disease_name.
    ELSEIF input_disease_name IS NOT NULL THEN
        SELECT COUNT(*) INTO disease_exists
        FROM DISEASES
        WHERE LOWER(disease_name) = LOWER(input_disease_name);
    END IF;

    -- If the disease does not exist, return an error message.
    IF disease_exists = 0 THEN
        SELECT "Disease not found." AS message;
    ELSE
        -- Query doctors by disease_id.
        IF input_disease_id IS NOT NULL THEN
            SELECT 
                d.doctor_id,
                CONCAT(d.first_name, ' ', d.second_name) AS doctor_name,
                d.date_of_birth,
                d.address,
                dis.disease_name
            FROM 
                DOCTORS d
            JOIN 
                DISEASES dis ON d.doctor_id = dis.doctor_id
            WHERE 
                dis.disease_id = input_disease_id
            ORDER BY 
                doctor_name;

        -- Query doctors by disease_name.
        ELSEIF input_disease_name IS NOT NULL THEN
            SELECT 
                d.doctor_id,
                CONCAT(d.first_name, ' ', d.second_name) AS doctor_name,
                d.date_of_birth,
                d.address,
                dis.disease_name
            FROM 
                DOCTORS d
            JOIN 
                DISEASES dis ON d.doctor_id = dis.doctor_id
            WHERE 
                LOWER(dis.disease_name) = LOWER(input_disease_name)
            ORDER BY 
                doctor_name;
        END IF;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;


-- Example calls to test the procedure...
CALL ListDoctorsByDisease(2, NULL);  -- By disease_id
CALL ListDoctorsByDisease(NULL, 'Epilepsy');  -- By disease_name
CALL ListDoctorsByDisease(999, NULL);  -- Nonexistent disease_id
CALL ListDoctorsByDisease(NULL, 'Nonexistent Disease');  -- Nonexistent disease_name
