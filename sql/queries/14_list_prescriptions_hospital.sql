-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS ListPrescriptionsByHospital;

DELIMITER //

CREATE PROCEDURE ListPrescriptionsByHospital(
    IN input_hospital_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE hospital_id INT;

    -- Step 1: Validate hospital
    SELECT h.hospital_id INTO hospital_id
    FROM HOSPITALS h
    WHERE LOWER(h.hospital_name) = LOWER(input_hospital_name);

    IF hospital_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = "Hospital not found.";
    END IF;

    -- Step 2: Retrieve prescriptions
    SELECT
        m.med_name AS MedicationName,
        CONCAT(d.first_name, ' ', d.second_name) AS DoctorName,
        CONCAT(p.first_name, ' ', p.second_name) AS PatientName,
        h.hospital_name AS HospitalName
    FROM PRESCRIPTIONS pr
    JOIN MEDICATIONS m ON pr.med_id = m.med_id
    JOIN DOCTORS d ON pr.doctor_id = d.doctor_id
    JOIN PATIENTS p ON pr.patient_id = p.patient_id
    JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
    WHERE h.hospital_id = hospital_id
    ORDER BY m.med_name ASC;

END //

DELIMITER;


-- Example calls to test the procedure...
CALL ListPrescriptionsByHospital('Royal London Hospital');
