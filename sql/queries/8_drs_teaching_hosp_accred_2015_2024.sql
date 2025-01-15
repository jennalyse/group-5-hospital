-- Drop procedure if it already exists to ensure the latest version is created
DROP PROCEDURE IF EXISTS ListDoctorsInTeachingHospitals;

-- Set DELIMITER to // to ensure the procedure is executed at once
DELIMITER //

CREATE PROCEDURE ListDoctorsInTeachingHospitals()
BEGIN
    -- Select all doctors based at teaching hospitals accredited between 2015-2024
    SELECT 
        d.doctor_id,
        d.first_name,
        d.second_name AS last_name,
        h.hospital_name,
        h.accreditation_year
    FROM 
        DOCTORS d
    INNER JOIN 
        HOSPITALS h ON d.hospital_id = h.hospital_id
    WHERE 
        LOWER(h.type) = 'teaching'
        AND h.accreditation_year BETWEEN 2015 AND 2024
    ORDER BY 
        h.accreditation_year, d.first_name, d.second_name;
END //

-- Reset DELIMITER to ;
DELIMITER ;
