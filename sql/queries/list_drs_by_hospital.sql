-- 1. Print a list of all doctors at a particular hospital

-- Use hospital database
USE hospitals_db;

-- Query to print all doctors based at a particular hospital
-- Replace 'Particular Hospital Name' with the desired hospital name when running the script
SELECT d.first_name, d.second_name AS last_name, d.address
FROM DOCTORS d
JOIN HOSPITALS h ON d.hospital_id = h.hospital_id
WHERE h.hospital_name = 'Royal London Hospital';

-- End of script
