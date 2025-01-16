-- Drop the procedure if it already exists to ensure the latest version is created and used
DROP PROCEDURE IF EXISTS ListLabResultsForPatientsOver60;

-- Set the DELIMITER to // for creating the procedure
DELIMITER //

-- Create the stored procedure to list lab results for patients over 60 years of age
CREATE PROCEDURE ListLabResultsForPatientsOver60()
BEGIN
    -- Step 1: Calculate the cutoff birth date for patients over 60
    DECLARE cutoff_birth_date DATE;
    SET cutoff_birth_date = DATE_SUB(CURDATE(), INTERVAL 60 YEAR);

    -- Step 2: Retrieve and display lab results for patients over 60
    SELECT 
        lr.lab_results_id AS LabResultID,
        lr.lab_test AS TestType,
        lr.lab_date AS TestDate,
        lr.lab_result AS ResultValue,
        p.patient_id AS PatientID,
        CONCAT(p.first_name, ' ', p.second_name) AS PatientName,
        p.date_of_birth AS DateOfBirth
    FROM 
        LAB_RESULTS lr
    INNER JOIN 
        PATIENTS p ON lr.patient_id = p.patient_id
    WHERE 
        p.date_of_birth <= cutoff_birth_date
    ORDER BY 
        p.second_name, p.first_name, lr.lab_date;

    -- Step 3: Output a message if no lab results are found
    IF ROW_COUNT() = 0 THEN
        SELECT "No lab results found for patients over the age of 60." AS Message;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example call to the procedure
CALL ListLabResultsForPatientsOver60();
