-- 1. Print a list of all doctors at a particular hospital

DELIMITER //

CREATE PROCEDURE ListDoctorsByHospital(IN input_hospital_name VARCHAR(255))
BEGIN
    -- Declare a variable to check hospital existence
    DECLARE hospital_exists INT DEFAULT 0;

    -- Validate that the hospital exists
    SELECT COUNT(*) INTO hospital_exists
    FROM HOSPITALS
    WHERE LOWER(hospital_name) = LOWER(input_hospital_name);

    -- If hospital does not exist, return an error message
    IF hospital_exists = 0 THEN
        SELECT "Hospital not found." AS message;
    ELSE
        -- Query to list doctors based on the hospital name
        SELECT d.first_name, d.second_name AS last_name, d.address
        FROM DOCTORS d
        JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
        WHERE LOWER(h.hospital_name) = LOWER(input_hospital_name);
    END IF;
END //

DELIMITER ;
