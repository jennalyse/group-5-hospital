-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ModifyAddressExistingPatient;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

  -- Step 1: Firstly confirm that the patient already exists on the database
CREATE PROCEDURE ModifyAddressExistingPatient(
    IN input_first_name VARCHAR(50),
    IN input_second_name VARCHAR(50),
    IN input_address VARCHAR(255),
    IN input_date_of_birth DATE
)
  --Step 2: Once confirmed then the address is changed, while other aspects remain the same
BEGIN
        IF EXISTS (
          SELECT 1 from PATIENTS
          WHERE
            first_name = input_first_name
            AND second_name = input_second_name
            AND date_of_birth = input_date_of_birth
  )
  THEN 
        UPDATE PATIENTS
        SET ADDRESS = input_new_address
        WHERE
            first_name = input_first_name
            AND second_name = input_second_name
            AND date_of_birth = input_date_of_birth
  
  SELECT 'Address has been updated' AS message;
  
   -- Step 3: If there is an error with the information then MySQL should say there is an error and return a statement explaining it
  ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Custom error 1644 (45000), Patient not found';
        ERROR 1644 (45000): Custom error           
  END IF;
  
END //

DELIMITER ;


-- Example calls to test the procedure...
CALL ModifyAddressExistingPatient(NULL, NULL, NULL, NULL);
CALL ModifyAddressExistingPatient('Stephen', 'Jones', 221B Baker Street London, 13.04.1983);
