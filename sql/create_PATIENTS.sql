-- Use hospitals database
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
    doctor_id INT,                                         -- Foreign key to DOCTORS table
    FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id)  -- Link to doctor_id in DOCTORS table
);

-- Verify that the PATIENTS table was created successfully
SELECT * FROM PATIENTS;

-- Add a SELECT query to view the table structure after creation
SHOW CREATE TABLE PATIENTS;
