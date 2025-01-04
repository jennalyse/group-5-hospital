-- Use hospitals database
USE hospitals_db;

-- Drop MEDICATIONS table if it already exists
DROP TABLE IF EXISTS MEDICATIONS;

-- Create MEDICATIONS table
CREATE TABLE MEDICATIONS (
    med_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
    med_name VARCHAR(255) NOT NULL,                   
    med_manufacturer VARCHAR(255),                    
    med_type VARCHAR(100)                             -- Type of medication (e.g., Tablet, Syrup, etc.)
);

-- Load MEDICATIONS table using medications.csv
-- Importing using terminal steps:
-- 1. mysql --local-infile=1 -u root -p
-- 2. USE hospitals_db;
-- 3. 
LOAD DATA LOCAL INFILE '/path/to/medications.csv'
INTO TABLE MEDICATIONS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(med_name, med_manufacturer, med_type);

-- Verify that the MEDICATIONS table was created successfully
SELECT * FROM MEDICATIONS;
