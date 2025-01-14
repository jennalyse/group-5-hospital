-- Drop the procedure if it already exists.
DROP PROCEDURE IF EXISTS AddNewPatient;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

CREATE PROCEDURE AddNewPatient(
    IN input_first_name VARCHAR(255),
    IN input_second_name VARCHAR(255),
    IN input_date_of_birth DATE,
    IN input_address TEXT
)
BEGIN
    -- Declare variables.
    DECLARE nearest_doctor_id INT DEFAULT NULL;
    DECLARE input_postcode_prefix VARCHAR(10);
    DECLARE last_patient_id INT;

    -- Extract the postcode prefix from the input_address.
    SET input_postcode_prefix = UPPER(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_address, ' ', -1), ' ', 1)));

    -- Find the nearest doctor by matching the postcode prefix.
    SELECT 
        d.doctor_id
    INTO 
        nearest_doctor_id
    FROM 
        DOCTORS d
    WHERE 
        UPPER(d.address) LIKE CONCAT('%', input_postcode_prefix, '%') -- Match address containing the postcode prefix.
    ORDER BY 
        CHAR_LENGTH(d.address) - CHAR_LENGTH(REPLACE(UPPER(d.address), input_postcode_prefix, '')) DESC, -- Prioritise closer matches.
        d.doctor_id -- Secondary sort for ties.
    LIMIT 1;

    -- Insert the new patient into the PATIENTS table.
    INSERT INTO PATIENTS (first_name, second_name, date_of_birth, address, doctor_id)
    VALUES (input_first_name, input_second_name, input_date_of_birth, input_address, nearest_doctor_id);

    -- Get the last inserted patient_id.
    SET last_patient_id = LAST_INSERT_ID();

    -- Check if a doctor was found.
    IF nearest_doctor_id IS NULL THEN
        -- If no doctor_id was found, remove the added patient.
        DELETE FROM PATIENTS WHERE patient_id = last_patient_id;
        SELECT "No doctor found for the given postcode prefix. Patient not added." AS message;
    ELSE
        -- If a doctor is found, output the added patient's details and their assigned doctor.
        SELECT 
            p.patient_id,
            p.first_name AS patient_first_name,
            p.second_name AS patient_second_name,
            p.date_of_birth,
            p.address AS patient_address,
            d.first_name AS doctor_first_name,
            d.second_name AS doctor_second_name,
            d.address AS doctor_address
        FROM 
            PATIENTS p
        JOIN 
            DOCTORS d ON p.doctor_id = d.doctor_id
        WHERE 
            p.patient_id = last_patient_id;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;
