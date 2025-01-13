-- Drop to ensure only one version exists.
DROP PROCEDURE IF EXISTS DoctorWithMostPrescriptions;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create stored procedure to identify the doctor with the most prescriptions.
CREATE PROCEDURE DoctorWithMostPrescriptions()
BEGIN
    -- Retrieve the doctor with the most prescriptions.
    SELECT 
        CONCAT(d.first_name, ' ', d.second_name) AS Doctor,
        COUNT(*) AS Total_Prescriptions
    FROM 
        PRESCRIPTIONS pr
    JOIN 
        DOCTORS d ON pr.doctor_id = d.doctor_id
    GROUP BY 
        d.doctor_id, d.first_name, d.second_name
    ORDER BY 
        Total_Prescriptions DESC
    LIMIT 1;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Call procedure.
CALL DoctorWithMostPrescriptions();
