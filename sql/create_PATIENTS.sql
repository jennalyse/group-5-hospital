-- Use hospitals database (run create_load_HOSPITALS.sql first)
USE hospitals_db;

-- Drop PATIENTS table if it already exists
DROP TABLE IF EXISTS PATIENTS;

-- Create PATIENTS table
CREATE TABLE PATIENTS (
    patient_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
    first_name VARCHAR(100) NOT NULL,                    
    last_name VARCHAR(100) NOT NULL,                     
    date_of_birth DATE,                                  
    address TEXT,                                       
    hospital_id INT,                                              -- Foreign key to HOSPITALS table
    doctor_id INT,                                                -- Foreign key to DOCTORS table
    FOREIGN KEY (hospital_id) REFERENCES HOSPITALS(hospital_id),  -- Link to hospital_id in HOSPITALS table
    FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id)         -- Link to doctor_id in DOCTORS table
);

-- Verify that the PATIENTS table was created successfully
SELECT * FROM PATIENTS;
