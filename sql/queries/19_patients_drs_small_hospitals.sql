-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS GetPatientsWithDoctorsAtSmallHospitals;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure to list patients registered with doctors at hospitals with fewer than 400 beds.
CREATE PROCEDURE GetPatientsWithDoctorsAtSmallHospitals()
BEGIN
    -- Retrieve hospitals with fewer than 400 beds.
    DECLARE small_hospitals_count INT DEFAULT 0;

    SELECT COUNT(*) INTO small_hospitals_count
    FROM HOSPITALS
    WHERE size < 400;

    --  Check if any hospitals meet the size criteria.
    IF small_hospitals_count = 0 THEN
        SELECT "No hospitals with fewer than 400 beds found." AS message;
    ELSE
        -- Retrieve patients registered with doctors at those hospitals.
        SELECT 
            p.patient_id,
            CONCAT(p.first_name, ' ', p.second_name) AS patient_full_name,
            d.doctor_id,
            CONCAT(d.first_name, ' ', d.second_name) AS doctor_full_name,
            h.hospital_name
        FROM 
            PATIENTS p
        JOIN 
            DOCTORS d ON p.doctor_id = d.doctor_id
        JOIN 
            HOSPITALS h ON d.hospital_id = h.hospital_id
        WHERE 
            h.size < 400;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Call (should be patients/drs from Addenbrooke's, G O Str, Southampton, Q Elizabeth, Norfolk/Norwich, King's College, 
-- Queen's, St. George's, Derriford, James Cook, Q Elizabeth University, Derby, and Southmead).
CALL GetPatientsWithDoctorsAtSmallHospitals();
