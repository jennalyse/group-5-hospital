-- Drop previous versions.
DROP PROCEDURE IF EXISTS ListPrescriptionsByDoctor;

-- Set DELIMITER to // to ensure the procedure is executed at once.
DELIMITER //

-- Create the stored procedure, taking doctor_id or first_name and second_name as input.
CREATE PROCEDURE ListPrescriptionsByDoctor(
    IN input_doctor_id INT,
    IN input_first_name VARCHAR(255),
    IN input_second_name VARCHAR(255)
)
BEGIN
    -- Declare a variable to check if the doctor exists.
    DECLARE doctor_exists INT DEFAULT 0;

    -- Validate if the doctor exists by doctor_id.
    IF input_doctor_id IS NOT NULL THEN
        SELECT COUNT(*) INTO doctor_exists
        FROM DOCTORS
        WHERE doctor_id = input_doctor_id;

    -- Validate if the doctor exists by first_name and second_name.
    ELSEIF input_first_name IS NOT NULL AND input_second_name IS NOT NULL THEN
        SELECT COUNT(*) INTO doctor_exists
        FROM DOCTORS
        WHERE LOWER(first_name) = LOWER(input_first_name)
          AND LOWER(second_name) = LOWER(input_second_name);
    END IF;

    -- If the doctor does not exist, return an error message.
    IF doctor_exists = 0 THEN
        SELECT "Doctor not found." AS message;
    ELSE
        -- Query prescriptions if doctor_id is provided.
        IF input_doctor_id IS NOT NULL THEN
            SELECT 
                pr.prescription_id,
                pr.prescription_date,
                CONCAT(p.first_name, ' ', p.second_name) AS patient_name,
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
            WHERE 
                pr.doctor_id = input_doctor_id
            ORDER BY 
                pr.prescription_date;

        -- Query prescriptions if first_name and second_name are provided.
        ELSEIF input_first_name IS NOT NULL AND input_second_name IS NOT NULL THEN
            SELECT 
                pr.prescription_id,
                pr.prescription_date,
                CONCAT(p.first_name, ' ', p.second_name) AS patient_name,
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
            JOIN 
                DOCTORS d ON pr.doctor_id = d.doctor_id
            WHERE 
                LOWER(d.first_name) = LOWER(input_first_name)
                AND LOWER(d.second_name) = LOWER(input_second_name)
            ORDER BY 
                pr.prescription_date;
        END IF;
    END IF;
END //

-- Reset DELIMITER to ;
DELIMITER ;

-- Example calls to test the procedure.
CALL ListPrescriptionsByDoctor(5, NULL, NULL);  -- By doctor_id
CALL ListPrescriptionsByDoctor(NULL, 'Adam', 'Clarke');  -- By doctor's first_name and second_name
CALL ListPrescriptionsByDoctor(NULL, 'Nonexistent', 'Doctor');  -- Nonexistent doctor
