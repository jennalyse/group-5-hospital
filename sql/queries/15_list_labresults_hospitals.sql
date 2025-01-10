-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ListLabResultsByAccreditation;

DELIMITER //

CREATE PROCEDURE ListLabResultsByAccreditation()
BEGIN
    -- Step 1: Retrieve lab results
    SELECT
        lr.lab_test AS LabTest,
        lr.lab_date AS TestDate,
        lr.lab_result AS Result,
        CONCAT(p.first_name, ' ', p.second_name) AS PatientName,
        CONCAT(d.first_name, ' ', d.second_name) AS DoctorName,
        h.hospital_name AS HospitalName
    FROM LAB_RESULTS lr
    JOIN PATIENTS p ON lr.patient_id = p.patient_id
    JOIN DOCTORS d ON lr.doctor_id = d.doctor_id
    JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
    WHERE h.accreditation_year BETWEEN 2013 AND 2020;

END //

DELIMITER;


-- Example calls to test the procedure...
CALL ListLabResultsByAccreditation();
