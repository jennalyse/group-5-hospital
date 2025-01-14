-- Drop to ensure the latest version is created and used
DROP PROCEDURE IF EXISTS ListLabResultsForPatientsOver60;

-- Set DELIMITER to // to ensure the procedure is executed at once
DELIMITER //

-- Create the stored procedure to list lab results for all patients over the age of 60
CREATE PROCEDURE ListLabResultsForPatientsOver60()
BEGIN
    -- Step 1: Calculate the cutoff birth date for patients over 60
    DECLARE cutoff_birth_date DATE;
    SET cutoff_birth_date = DATE_SUB(CURDATE(), INTERVAL 60 YEAR);

    -- Step 2: Query PATIENTS table to find patients over 60 years old
    CREATE TEMPORARY TABLE patient_list AS
    SELECT patient_id, first_name, second_name, date_of_birth
    FROM PATIENTS
    WHERE date_of_birth <= cutoff_birth_date;

    -- Step 3: Check if any patients over 60 were found
    IF (SELECT COUNT(*) FROM patient_list) = 0 THEN
        SELECT "No patients found over the age of 60." AS message;
        DROP TEMPORARY TABLE patient_list;
        LEAVE;
    END IF;

    -- Step 4: Query LAB_RESULTS table to retrieve lab results for identified patients
    CREATE TEMPORARY TABLE lab_results_list AS
    SELECT lr.lab_results_id, lr.lab_test, lr.lab_date, lr.lab_result, lr.patient_id
    FROM LAB_RESULTS lr
    WHERE lr.patient_id IN (SELECT patient_id FROM patient_list);

    -- Step 5: Output lab results
    IF (SELECT COUNT(*) FROM lab_results_list) = 0 THEN
        SELECT "No lab results found for patients over 60." AS message;
    ELSE
        SELECT "List of lab results for all patients over 60:" AS header;
        SELECT * FROM lab_results_list;
    END IF;

    -- Clean up temporary tables
    DROP TEMPORARY TABLE lab_results_list;
    DROP TEMPORARY TABLE patient_list;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example call to the procedure
CALL ListLabResultsForPatientsOver60();
