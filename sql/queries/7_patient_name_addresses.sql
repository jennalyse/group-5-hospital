-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS GetAllPatientDetailsWithDoctorsFromOneHospital;

-- Set DELIMITER to // to define the procedure
DELIMITER //

CREATE PROCEDURE GetAllPatientDetailsWithDoctorsFromOneHospital(
    IN input_hospital_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE hospital_exists INT DEFAULT 0;

    -- Check if the hospital exists using the input hospital name
    SELECT COUNT(*) INTO hospital_exists
    FROM HOSPITALS
    WHERE LOWER(hospital_name) LIKE LOWER(CONCAT('%', input_hospital_name, '%'));

    -- If the hospital does not exist, return an error message
    IF hospital_exists = 0 THEN
        SELECT "Hospital not found." AS message;
    ELSE
        -- If the hospital exists, retrieve the patient details
        SELECT 
            p.first_name AS PatientFirstName,
            p.second_name AS PatientSecondName,
            p.address AS PatientAddress,
            d.doctor_id AS DoctorID,
            d.first_name AS DoctorFirstName,
            d.second_name AS DoctorLastName
        FROM PATIENTS p
        JOIN DOCTORS d ON p.doctor_id = d.doctor_id
        JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
        WHERE LOWER(h.hospital_name) LIKE LOWER(CONCAT('%', input_hospital_name, '%'));
    END IF;
END //

-- Reset DELIMITER to default
DELIMITER ;

-- Example calls to the procedure
CALL GetAllPatientDetailsWithDoctorsFromOneHospital('Addenbrooke\'s');  -- Example with a hospital name
