-- Use hospitals database  (run create_load_HOSPITALS.sql first)
USE hospitals_db;

-- Drop DOCTORS table if it already exists
DROP TABLE IF EXISTS DOCTORS;

-- Create DOCTORS table
CREATE TABLE DOCTORS (
    doctor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   
    first_name VARCHAR(100) NOT NULL,                     
    second_name VARCHAR(100),                             
    date_of_birth DATE,                                   
    address TEXT,                                         
    hospital_id INT,                                             -- Foreign key to HOSPITALS table
    FOREIGN KEY (hospital_id) REFERENCES HOSPITALS(hospital_id)  -- Link to hospital_id in HOSPITALS table
);

-- Load DOCTORS table using doctors.csv
-- Importing using terminal steps:
-- 1. mysql --local-infile=1 -u root -p
-- 2. USE hospitals_db;
-- 3. 
LOAD DATA LOCAL INFILE '/path/to/doctors.csv'
INTO TABLE DOCTORS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, second_name, date_of_birth, hospital_id, address);

-- Verify that the DOCTORS table was created and data imported successfully
SELECT * FROM DOCTORS;
