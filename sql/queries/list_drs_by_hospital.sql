-- 1. Print a list of all doctors at a particular hospital

-- Drop to ensure latest version is created and used
DROP PROCEDURE IF EXISTS ListDoctorsByHospital;

-- Set DELIMITER to // to ensure procedure executed at once
-- Run this separately before procedure
DELIMITER //

    -- Created stored procedure, taking hospital_name as input
    CREATE PROCEDURE ListDoctorsByHospital(IN input_hospital_name VARCHAR(255))
    BEGIN
        -- Declare a variable to check the inputted hospital exists
        -- Initalise as 0 (false)
        DECLARE hospital_exists INT DEFAULT 0;
    
        -- Validate that the hospital exists using LIKE operator for partial matching
        -- LOWER() : search is case-insensitive
        -- CONCAT() : allows input to be matched anywhere in hospital_name 
        -- If hospital exists, retun count greater than 0
        SELECT COUNT(*) INTO hospital_exists
        FROM HOSPITALS
        WHERE LOWER(hospital_name) LIKE LOWER(CONCAT('%', input_hospital_name, '%'));  

        -- If hospital does not exist (hospital_exists = 0), return an error message
        IF hospital_exists = 0 THEN
            SELECT "Hospital not found." AS message;
        ELSE
            -- If hospital exists, query doctors who work at the hospital
            -- Use JOIN to combine DOCTORS and HOSPITALS table on hospital_id
            -- List doctors first name, second name and address
            SELECT d.first_name, d.second_name AS last_name, d.address
            FROM DOCTORS d
            JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
            WHERE LOWER(h.hospital_name) LIKE LOWER(CONCAT('%', input_hospital_name, '%'));  
        END IF;
    END //

-- Reset DELIMITER to ;
DELIMITER ;


-- Then call hospital as so... (below are examples)
CALL ListDoctorsByHospital('Royal London Hospital');
CALL ListDoctorsByHospital('royal london');
CALL ListDoctorsByHospital('Nonexistent Hospital');
