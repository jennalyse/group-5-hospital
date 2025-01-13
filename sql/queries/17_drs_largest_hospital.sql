-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS DoctorsAtLargestHospital;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure to list all doctors at the hospital with the largest size (number of beds).
CREATE PROCEDURE DoctorsAtLargestHospital()
BEGIN
    -- Declare a variable to store the hospital_id of the largest hospital.
    DECLARE largest_hospital_id INT;

    -- Identify the hospital with the largest size (number of beds).
    SELECT hospital_id
    INTO largest_hospital_id
    FROM HOSPITALS
    ORDER BY size DESC
    LIMIT 1;

    -- Retrieve list of doctors at the largest hospital.
    SELECT 
        d.first_name, 
        d.second_name,
        d.address
    FROM 
        DOCTORS d
    WHERE 
        d.hospital_id = largest_hospital_id;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Call (this will be John Radcliffe Hospital, Oxford)
CALL DoctorsAtLargestHospital();
