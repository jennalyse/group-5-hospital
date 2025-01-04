-- Drop duplicates.
DROP PROCEDURE IF EXISTS ListPrescriptionsOrderedByPatientName;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create the stored procedure.
CREATE PROCEDURE ListPrescriptionsOrderedByPatientName()
BEGIN
    -- Query prescriptions ordered by patient name alphabetically.
    SELECT 
        CONCAT(p.first_name, ' ', p.second_name) AS patient_name,
        p.patient_id,
        pr.prescription_id,
        pr.prescription_date,
        m.med_name,
        m.med_type,
        dis.disease_name,
        dis.disease_treatment
    FROM 
        PRESCRIPTIONS pr
    JOIN 
        PATIENTS p ON pr.patient_id = p.patient_id
    JOIN 
        MEDICATIONS m ON pr.medication_id = m.med_id
    JOIN 
        DISEASE dis ON m.med_id = dis.med_id
    ORDER BY 
        patient_name, pr.prescription_date;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Call procedure
CALL ListPrescriptionsOrderedByPatientName();
