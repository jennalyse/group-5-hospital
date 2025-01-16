-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ModifyAddressExistingPatient;

-- Set DELIMITER to // to define the procedure
DELIMITER //

CREATE PROCEDURE ModifyAddressExistingPatient(
    IN input_first_name VARCHAR(50),
    IN input_second_name VARCHAR(50),
    IN input_address VARCHAR(255),
    IN input_date_of_birth DATE
)
BEGIN
    -- Step 1: Check if the patient exists based on provided details
    IF EXISTS (
        SELECT 1 FROM PATIENTS
        WHERE first_name = input_first_name
        AND second_name = input_second_name
        AND date_of_birth = input_date_of_birth
    ) THEN
        -- Step 2: Update the address if the patient exists
        UPDATE PATIENTS
        SET address = input_address
        WHERE first_name = input_first_name
        AND second_name = input_second_name
        AND date_of_birth = input_date_of_birth;
        
        -- Return success message
        SELECT 'Address has been updated' AS message;
    ELSE
        -- Step 3: Raise an error if the patient is not found
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Patient not found or incorrect data provided';
    END IF;
END //

-- Reset DELIMITER to default
DELIMITER ;

-- Example calls to test the procedure:
-- Correct call: Modify address for a patient
CALL ModifyAddressExistingPatient('Alex', 'Campbell', '560 Bluebell Lane, Rowan Fold, London WC1N 3MT', '1940-03-26');

-- Incorrect call: Test if the patient is not found
CALL ModifyAddressExistingPatient('Nonexistent', 'Patient', 'Some Address', '1990-01-01');
