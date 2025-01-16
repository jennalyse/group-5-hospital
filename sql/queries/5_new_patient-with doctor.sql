-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS NewCustomerWithDoctor;

-- Set DELIMITER to // to define the procedure
DELIMITER //

CREATE PROCEDURE NewCustomerWithDoctor(
    IN input_first_name VARCHAR(50),
    IN input_second_name VARCHAR(50),
    IN input_address VARCHAR(255),
    IN input_date_of_birth DATE,
    IN input_doctor_id INT -- Add a doctor_id parameter to assign a doctor
)
BEGIN
    -- Step 1: Check if the patient already exists
    IF NOT EXISTS (
        SELECT 1 
        FROM PATIENTS
        WHERE first_name = input_first_name
          AND second_name = input_second_name
          AND address = input_address
          AND date_of_birth = input_date_of_birth
    ) THEN
        -- Step 2: Insert the new patient and assign them to a doctor
        INSERT INTO PATIENTS (first_name, second_name, address, date_of_birth, doctor_id)
        VALUES (input_first_name, input_second_name, input_address, input_date_of_birth, input_doctor_id);
        
        -- Return success message
        SELECT 'New customer has been added and assigned a doctor.' AS message;
    ELSE
        -- If the patient already exists, return an error message
        SELECT 'Patient already exists in the database.' AS message;
    END IF;
END //

-- Reset DELIMITER to default
DELIMITER ;

-- Example calls to test the procedure:
-- Correct call with a doctor ID
CALL NewCustomerWithDoctor('Bryan', 'Jones', '34-124 Beech Boulevard,Lewes Rd, Haywards Heath RH16 4QU', '1955-07-24', 87);

-- Incorrect call (already existing patient)
CALL NewCustomerWithDoctor('Stephen', 'Jones', '221B Baker Street, London', '1983-04-13', 1);
