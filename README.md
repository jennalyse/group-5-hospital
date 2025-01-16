# group-5-hospital
This repository contains the Group 5 hospital database project, developed in MySQL and MS Access. The project involves the creation and population of a hospital database for use in MySQL and MS Access...

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Generation of Data](#generation-of-data)
3. [Files in the Repository](#files-in-the-repository)
4. [How to Set Up the Database](#how-to-set-up-the-database)
   - [Prerequisites](#prerequisites)
   - [Steps to Execute](#steps-to-execute)
5. [Technical Details](#technical-details)
   - [Database Schemas](#database-schemas)
   - [Data Cleaning](#data-cleaning)
6. [How to Use the SQL Files](#how-to-use-the-sql-files)

---

## Project Overview
This project is the development of a new database structure to manage a group of hospitals, with their associated Doctors and patients.  The database has been developed in MySQL and separately in ACCESS, and holds the data of 100 Doctors, based at 40 different hospitals, with the details of 600 associated patients.  Further databases outlining the patient prescriptions, diseases, lab results, medications and patient appointments have been linked in with the initial doctor, patient and hospital data set, to enable queries to be asked of the data.

Data and code provided within the project include initial prerequisites for including the relevant databases within the code, running the code and asking specific questions of the databases.  Technical informations about the database structure and query designs are provided in the Entity Relationship Diagram (ERD), flowcharts and pseudocode for each of the queries that were planned.  The MySQL queries are included to enable the code to be run using the databases to answer each specific query, and equivalent information provided for examining the data in the same way using MS ACCESS.

The databases contain AI generated data for patients, doctors and other databases, therefore enabling the structure of the database to be created without the use of real personal data.

The new databases in MySQL and ACCESS can be used to query the relationships between different datasets and evaluate the different patient details and treatments within this artifically generated dataset.

---

## Generation of Data
The starting point for the data generation was a provided list of 40 hospitals together with data on the hospital address, size (number of beds), type, whether they offer emergency services and year of accreditation.  This information was then used to create new data using generative AI to populate related tables of information.  

The doctors table was created using information from the hospitals table to enable the doctors to be selected for the different hospitals in the geographical area that their address was in.  The patients table was then created using information from the doctors table, again linking with the geogrpahical area.  Both were developed using generative AI to create the list of names, addresses, date of birth, and linking with the relevant doctor, patient and hospital IDs.

Generative AI was then used to create tables to contain information about medications, diseases, prescriptions, lab results and appointments.  This information was linked with those of the doctors, hospitals and patient information, so that, for example, doctor specialisms were related to doctor IDs.


## Files in the Repository


| File Name                                                   | Description                                                                                           |
|-------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **docs/planning/ERD.pdf**                                   | Entity-Relationship Diagram for the database schema.                                                  |
| **docs/planning/flowcharts.pdf**                            | Flowcharts illustrating the database processes and workflows.                                         |
| **docs/planning/pseudocode.md**                             | Pseudocode for implementing database functionalities.                                                 |
| **docs/python_scripts/amend_dr_address.py**                 | Python script to amend doctor addresses to modify postcodes.                                          |
| **docs/python_scripts/generate_doctor_data.py**             | Python script to generate random doctor data for the database.                                        |
| **docs/python_scripts/generate_prescriptions.py**           | Python script to generate random prescription data for the database.                                  |
| **docs/python_scripts/update_csv.py**                       | Python script to clean and prepare the original CSV data for MySQL/MS Access.                         |
| **docs/cleaned_hospitals.csv**                              | Cleaned hospital data, ready for import into MySQL/MS Access.                                         |
| **docs/cleaned_patients.csv**                               | Cleaned patient data, ready for import into MySQL/MS Access.                                          |
| **docs/doctors.csv**                                        | CSV file containing doctor data.                                                                      |
| **docs/final_doctors.csv**                                  | Cleaned and modified doctor data with updated addresses.                                              |
| **docs/patients.csv**                                       | Original patients data file.                                                                          |
| **docs/hospitals.csv**                                      | Original hospital data file.                                                                          |
| **docs/original_doctors.csv**                               | Original doctor data file.                                                                            |
| **sql/create_APPOINTMENTS.sql**                             | SQL script to create the `APPOINTMENTS` table.                                                        |
| **sql/create_DISEASE.sql**                                  | SQL script to create the `DISEASE` table.                                                             |
| **sql/create_LAB_RESULTS.sql**                              | SQL script to create the `LAB_RESULTS` table.                                                         |
| **sql/create_MEDICATIONS.sql**                              | SQL script to create the `MEDICATIONS` table.                                                         |
| **sql/create_hospitals_db.sql**                             | SQL script to create the `hospitals_db` database.                                                     |
| **sql/create_load_DOCTORS.sql**                             | SQL script to create the `DOCTORS` table and load the doctor data.                                    |
| **sql/create_load_HOSPITALS.sql**                           | SQL script to create the `HOSPITALS` table and load the cleaned hospital data.                        |
| **sql/create_load_PATIENTS.sql**                            | SQL script to create the `PATIENTS` table and load the cleaned patient data.                          |
| **sql/create_load_PRESCRIPTIONS.sql**                       | SQL script to create the `PRESCRIPTIONS` table and load generated prescription data.                  |
| **sql/queries/list_drs_by_hospital.sql**                    | SQL script for querying doctors by hospital.                                                          |



---

## How to Set Up the Database

### Prerequisites
Ensure you have the following installed:
1. **MySQL Server**: Download and install MySQL
2. **MS Access**: Download and install MS Access
3. **Python 3.x**: Install Python
4. **Git**: Install Git 

### Steps to Execute:
1. Clone the repository (in Terminal)
     git clone https://github.com/jennalyse/group-5-hospital.git
3. Set up database
     run MySQL with local_infile enabled (or enable it globally within MySQL)
        mysql --local-infile=1 -u root
     run create_hospitals_db.sql to create database 
        mysql -u root -p < create_hospitals_db.sql
     run create_load_HOSPITALS.sql to create HOSPITALS table and import the data
        mysql -u root - p < create_load_HOSPITALS.sql
4. Run the following SQL scripts in order:
     1. create_DOCTORS.sql
     2. create_PATIENTS.sql
     3. create_APPOINTMENTS.sql
     4. create_LAB_RESULTS.sql
     5. create_MEDICATIONS.sql
     6. create_load_PRESCRIPTIONS.sql
     7. create_MEDICATIONS.sql
...


---

## Technical Details

### Database Schemas
The HOSPITALS table has structure:
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `hospital_id`          | INT (Primary Key)  | Unique ID for each hospital.                          |
| `hospital_name`        | VARCHAR(255)       | Name of the hospital.                                 |
| `address`              | TEXT               | Address of the hospital.                              |
| `size`                 | INT                | Number of beds in the hospital.                       |
| `type`                 | VARCHAR(100)       | Type of the hospital (General, Teaching).             |
| `accreditation_year`   | YEAR               | Year the hospital was accredited.                     |
| `emergency_service`    | BOOLEAN            | Indicates if the hospital provides emergency services (1 Yes, 0 No).|

---

#### **DOCTORS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `doctor_id`            | INT (Primary Key)  | Unique ID for each doctor.                            |
| `first_name`           | VARCHAR(100)       | First name of the doctor.                             |
| `second_name`          | VARCHAR(100)       | Second name (last name) of the doctor.                |
| `date_of_birth`        | DATE               | Date of birth of the doctor.                          |
| `address`              | TEXT               | Address of the doctor.                                |
| `hospital_id`          | INT (Foreign Key)  | Links the doctor to their associated hospital.        |

---


#### **PATIENTS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `patient_id`           | INT (Primary Key)  | Unique ID for each patient.                           |
| `first_name`           | VARCHAR(100)       | First name of the patient.                            |
| `second_name`          | VARCHAR(100)       | Second name (last name) of the patient.               |
| `date_of_birth`        | DATE               | Date of birth of the patient.                         |
| `address`              | TEXT               | Address of the patient.                               |
| `doctor_id`            | INT (Foreign Key)  | Links the patient to their primary doctor.            |

---

#### **MEDICATIONS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `med_id`               | INT (Primary Key)  | Unique ID for each medication.                        |
| `med_name`             | VARCHAR(255)       | Name of the medication.                               |
| `med_manufacturer`     | VARCHAR(255)       | Manufacturer of the medication.                       |
| `med_type`             | VARCHAR(100)       | Type of medication (e.g., Tablet, Injection).         |

---

#### **APPOINTMENTS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `appt_id`              | INT (Primary Key)  | Unique ID for each appointment.                       |
| `appt_date`            | DATETIME           | Date of the appointment.                              |
| `appt_purpose`         | VARCHAR(100)       | Purpose of the appointment (e.g., Follow-up).         |
| `patient_id`           | INT (Foreign Key)  | Links the appointment to the patient.                 |
| `doctor_id`            | INT (Foreign Key)  | Links the appointment to the doctor.                  |

---

#### **PRESCRIPTIONS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `prescription_id`      | INT (Primary Key)  | Unique ID for each prescription.                      |
| `prescription_date`    | DATE               | Date the prescription was issued.                     |
| `patient_id`           | INT (Foreign Key)  | Links the prescription to the patient who received it.|
| `doctor_id`            | INT (Foreign Key)  | Links the prescription to the doctor who issued it.   |
| `med_id`               | INT (Foreign Key)  | Links the prescription to the mediciation required.   |

---

#### **LAB_RESULTS Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `lab_results_id`       | INT (Primary Key)  | Unique ID for each lab result.                        |
| `lab_test`             | VARCHAR(255)       | Name/type of the lab test conducted.                  |
| `lab_date`             | DATE               | Date the lab test was conducted.                      |
| `lab_result`           | VARCHAR(255)       | Result of the lab test.                               |
| `doctor_id`            | INT (Foreign Key)  | Links the lab result to the doctor who ordered it.    |
| `patient_id`           | INT (Foreign Key)  | Links the lab result to the patient.                  |

---

#### **DISEASE Table**
| **Column Name**        | **Data Type**      | **Description**                                       |
|------------------------|--------------------|-------------------------------------------------------|
| `disease_id`           | INT (Primary Key)  | Unique ID for each disease.                           |
| `disease_name`         | VARCHAR(255)       | Name of the disease.                                  |
| `disease_treatment`    | TEXT               | Description of the treatment for the disease.         |
| `doctor_id`            | INT (Foreign Key)  | Links the disease to the specialist doctor.           |
| `med_id`               | INT (Foreign Key)  | Links the disease to its primary medication.          |

---

### Data Cleaning
The hospitals CSV file given had the following issues:
  1. Incorrect Columm Headers: renamed to match the style of the MySQL table.
  2. Boolean Values: for ease of calculations, converted Yes/No to 1 or 0 in Emergency Services.
  3. Commas: removed commas in numberic fields in Size (beds).

While amending the MySQL table (or writing SQL queries to handle discrepancies), cleaning using Python ensured data was 
correctly prepared before import and could be easily reused by others. 

---

## How to Use the SQL Files
1. Print a list of all doctors based at a particular hospital

is under `list_drs_by_hospital.sql`. It retrieves a list of doctors based at a hospital given an input of a hospital name. It uses partial matching and is case-insensitive.
The stored procedure requires the hospitals_db database with the tables HOSPITALS and DOCTORS, with the corresponding data imported into each.

Run the SQL script to create the procedure by using: mysql -u root - p < list_drs_by_hospital.sql

Then call the procedure, examples below:
CALL ListDoctorsByHospital('Royal London Hospital');
CALL ListDoctorsByHospital('royal london');
CALL ListDoctorsByHospital('Stoke Mandeville');
CALL ListDoctorsByHospital('Nonexistent Hospital');

...


