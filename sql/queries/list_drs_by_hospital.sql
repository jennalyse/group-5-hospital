-- 1. Print a list of all doctors at a particular hospital

-DELIMITER //

-- Create a stored procedure to list doctors by hospital name
CREATE PROCEDURE ListDoctorsByHospital(IN hospital_name VARCHAR(255))
BEGIN
    -- Validate that the hospital exists
    IF (SELECT COUNT(*) FROM HOSPITALS WHERE hospital_name = hospital_name) = 0 THEN
        SELECT "Hospital not found." AS message;
        LEAVE PROCEDURE;
    END IF;

    -- Query to list doctors based on the hospital name
    SELECT d.first_name, d.second_name AS last_name, d.address
    FROM DOCTORS d
    JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
    WHERE h.hospital_name = hospital_name;
END //

DELIMITER ;
