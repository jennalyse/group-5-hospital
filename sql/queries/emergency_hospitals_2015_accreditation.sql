-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS GetHospitalsWithEmergencyServices;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure to list all hospitals accredited prior to 2015 with emergency services.
CREATE PROCEDURE GetHospitalsWithEmergencyServices()
BEGIN
    -- Step 1: Retrieve hospitals accredited before 2015 with emergency services.
    DECLARE no_hospitals_found INT DEFAULT 0;

    -- Step 2: Check if any hospitals meet the accreditation criteria and have emergency services.
    SELECT COUNT(*) INTO no_hospitals_found
    FROM HOSPITALS
    WHERE accreditation_year < 2015 AND emergency_service = TRUE;

    IF no_hospitals_found = 0 THEN
        SELECT "No hospitals with emergency services meet accreditation criteria." AS message;
    ELSE
        -- Step 3: Output hospitals with emergency services accredited before 2015.
        SELECT 
            hospital_name AS "Hospitals accredited before 2015 with emergency services"
        FROM 
            HOSPITALS
        WHERE 
            accreditation_year < 2015 AND emergency_service = TRUE;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Call (should return Bham City, J Radcliffe, Queen's, Freeman, and Stoke Mandeville)
CALL GetHospitalsWithEmergencyServices();
