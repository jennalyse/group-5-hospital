-- Use hospitals database
USE hospitals_db;

-- Drop LAB_RESULTS table if it already exists
DROP TABLE IF EXISTS LAB_RESULTS;

-- Create LAB_RESULTS table
CREATE TABLE LAB_RESULTS (
    lab_results_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
    lab_test VARCHAR(255) NOT NULL,                         
    lab_date DATE NOT NULL,                                 
    lab_result VARCHAR(255),                                
    patient_id INT,                                            -- Foreign key to PATIENTS table
    doctor_id INT,                                             -- Foreign key to DOCTORS table
    FOREIGN KEY (patient_id) REFERENCES PATIENTS(patient_id),  -- Link to patient_id in PATIENTS table
    FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id)      -- Link to doctor_id in DOCTORS table
);

-- Load LAB_RESULTS table using lab_results.csv
-- Importing using terminal steps:
-- 1. mysql --local-infile=1 -u root -p
-- 2. USE hospitals_db;
-- 3. 
LOAD DATA LOCAL INFILE '/path/to/final_lab_results.csv'
INTO TABLE DOCTORS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(lab_test, lab_date, lab_result, patient_id, doctor_id);

-- Verify that the LAB_RESULTS table was created successfully
SELECT * FROM LAB_RESULTS;
