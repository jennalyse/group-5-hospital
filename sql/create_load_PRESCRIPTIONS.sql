-- Use hospitals database
USE hospitals_db;

-- Drop PRESCRIPTIONS table if it already exists
DROP TABLE IF EXISTS PRESCRIPTIONS;

-- Create PRESCRIPTIONS table
CREATE TABLE PRESCRIPTIONS (
    prescription_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
    prescription_date DATE,                                  
    patient_id INT,                                             -- Foreign key to PATIENTS table
    doctor_id INT,                                              -- Foreign key to DOCTORS table
    med_id INT,                                                 -- Foreign key to MEDICATIONS table
    FOREIGN KEY (patient_id) REFERENCES PATIENTS(patient_id),   -- Link to patient_id in PATIENTS table
    FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id),      -- Link to doctor_id in DOCTORS table
    FOREIGN KEY (med_id) REFERENCES MEDICATIONS(med_id)         -- Link to med_id in MEDICATIONS table
);

-- Load the data from the SQL file generated by the Python script (attached in docs folder)
-- Replace with server/local machine path to the CSV file (e.g. mine was cd ~/Downloads)
-- If this doesn't work, import direct using Terminal:
-- mysql -u root -p hospitals_db < /path/to/insert_prescriptions.sql
SOURCE /path/to/insert_prescriptions.sql;

-- Verify that data was imported successfully
SELECT * FROM PRESCRIPTIONS LIMIT 10;

-- Update each prescription with a random doctor_id
UPDATE PRESCRIPTIONS
SET doctor_id = (
    SELECT doctor_id
    FROM DOCTORS
    ORDER BY RAND()
    LIMIT 1
);

-- Update each prescription with a random patient_id
UPDATE PRESCRIPTIONS
SET patient_id = (
    SELECT patient_id
    FROM PATIENTS
    ORDER BY RAND()
    LIMIT 1
);

UPDATE PRESCRIPTIONS
SET medication_id = (
    SELECT med_id
    FROM MEDICATIONS
    ORDER BY RAND()
    LIMIT 1
);

-- After creation, it appeared to make logical sense to assign each patient to have their linked doctor prescribe
-- their medications, this amendment can be done as so:
UPDATE PRESCRIPTIONS p
JOIN PATIENTS pt ON p.patient_id = pt.patient_id
SET p.doctor_id = pt.doctor_id;

-- Check the updated PRESCRIPTIONS table
SELECT * FROM PRESCRIPTIONS
