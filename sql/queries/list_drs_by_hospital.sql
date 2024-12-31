-- 1. Print a list of all doctors at a particular hospital

DELIMITER //

CREATE PROCEDURE ListDoctorsByHospital(
    IN input_hospital_name VARCHAR(255),
    IN input_hospital_id INT
)
BEGIN
    -- Declare variables
    DECLARE resolved_hospital_id INT DEFAULT NULL;

    -- Resolve hospital_id if hospital_name is provided
    IF input_hospital_id IS NULL AND input_hospital_name IS NOT NULL THEN
        SELECT hospital_id INTO resolved_hospital_id
        FROM HOSPITALS
        WHERE LOWER(hospital_name) = LOWER(input_hospital_name);

        -- Check if hospital exists
        IF resolved_hospital_id IS NULL THEN
            SELECT "Hospital not found by name." AS message;
            RETURN;
        END IF;
    ELSEIF input_hospital_id IS NOT NULL THEN
        -- Use input_hospital_id if provided
        SET resolved_hospital_id = input_hospital_id;

        -- Check if hospital exists
        IF (SELECT COUNT(*) FROM HOSPITALS WHERE hospital_id = resolved_hospital_id) = 0 THEN
            SELECT "Hospital not found by ID." AS message;
            RETURN;
        END IF;
    ELSE
        -- Neither hospital_id nor hospital_name is provided
        SELECT "Please provide either a hospital name or ID." AS message;
        RETURN;
    END IF;

    -- Query to list doctors
    SELECT d.first_name, d.second_name AS last_name, d.address
    FROM DOCTORS d
    WHERE d.hospital_id = resolved_hospital_id;
END //

DELIMITER ;
