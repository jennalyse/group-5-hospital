-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS NewCustomerWithDoctor;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

  -- Step 1: Firstly validate whether the patient already exists on the database
CREATE PROCEDURE NewCustomerWithDoctor(
    IN input_first_name VARCHAR(50),
    IN input_second_name VARCHAR(50),
    IN input_address VARCHAR(255),
    IN input_date_of_birth DATE
)
BEGIN
        IF NOT EXISTS (
          SELECT 1 from PATIENTS
          WHERE
            first_name = first_name
            AND second_name = second_name
            AND address = address
            AND date_of_birth = date_of_birth
  )
  
   -- Step 2: If there are no records for the person detailed, then we should add them and assign them a doctor from the list of doctors
  BEGIN
        INSERT INTO PATIENTS (first_name, second_name, address, date_of_birth)
        SELECT doctor_id from DOCTORS
        
        END
  
END //

DELIMITER ;


-- Example calls to test the procedure...
CALL NewCustomerWithDoctor(NULL, NULL, NULL, NULL);
CALL NewCustomerWithDoctor('Stephen', 'Jones', 221B Baker Street London, 13.04.1983);
