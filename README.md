# Group 5 Hospital Database Project 
This repository contains the Group 5 hospital database project, developed in MySQL and MS Access. The project involves the creation and population of a hospital database to manage hospital queries around doctors, patients, medications, prescriptions, lab results, apppointments, and diseases.

The repository provides:
1. Planning and documentation for database design
2. AI-generated synthetic data
3. Python scripts for data cleaning and generation
4. Structured databases for MySQL and MS Access
5. SQL and MS Access queries

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Repository Structure](#repository-structure)
4. [Database Schema](#database-schema)
5. [Setup Instructions](#setup-instructions)
6. [Generation of Data](#generation-of-data)
7. [Technical Details](#technical-details)
8. [Data Cleaning](#data-cleaning)
9. [License](#license)

---

## Project Overview
This project is the development of a new database structure to manage a group of hospitals, with their associated Doctors and patients.  The database has been developed in MySQL and separately in MS Access, and holds the data of 100 Doctors, based at 40 different hospitals, with the details of 600 associated patients.  Further databases outlining the patient prescriptions, diseases, lab results, medications and patient appointments have been linked in with the initial doctor, patient and hospital data set, to enable queries to be asked of the data.

Data and code provided within the project include initial prerequisites for including the relevant databases within the code, running the code and asking specific questions of the databases.  Technical informations about the database structure and query designs are provided in the Entity Relationship Diagram (ERD), flowcharts and pseudocode for each of the queries that were planned.  The MySQL queries are included to enable the code to be run using the databases to answer each specific query, and equivalent information provided for examining the data in the same way using MS ACCESS.

The databases contain AI generated data for patients, doctors and other databases, therefore enabling the structure of the database to be created without the use of real personal data.

The new databases in MySQL and ACCESS can be used to query the relationships between different datasets and evaluate the different patient details and treatments within this artifically generated dataset.

---

## Features
- **AI-Generated Data**: Ensures realistic synthetic data for privacy.
- **SQL Queries**: Includes 19 MySQL queries addressing hospital operations and analytics.
- **MS Access Queries**: Includes the same 19 queries replicated in MS Access.
- **Data Cleaning**: Scripts provided to ensure replication of databases from the raw data.
- **Documentation**: Entity Relationship Diagram (ERD), flowcharts, and pseudocode for clarity.

---

## Repository Structure

### 1. Team Portfolio
- **Meeting Agendas and Minutes**: Detailed documentation of team meetings.
- **AI Declaration**: Compliance with university AI usage policies.
- **Action Plan**: A roadmap for project completion.

### 2. Docs
- **Final Data**: Contains final data used for MySQL and MS Access database creation.
- **Raw Intermediate Data**: Includes intermediate and raw datasets for cleaning.
- **Python Scripts**: Scripts for data generation and cleaning.

### 3. Planning
Found within `docs/planning`:
- **ERD**: Entity Relationship Diagram (`ERD.pdf`).
- **Flowcharts**: Visual representation of workflows (`flowcharts.pdf`).
- **Pseudocode**: Algorithmic representation of queries (`pseudocode.md`).

### 4. SQL Scripts
- **Table Creation**: Scripts for MySQL table creations within hospitals database.
- **Queries**: Analytical queries for MySQL.
- **Windows Tables**: Used if issues occur with permissions to import data into tables in the Terminal.

### 5. MS Access
- **Queries**: Amended MySQL queries for MS Access.

---

## Database Schema

The database contains the following main tables:
1. **Hospitals**: Details about hospitals (e.g., size, type, accreditation year) - 38 hospitals.
2. **Doctors**: Information about doctors and their associations - 100 doctors.
3. **Patients**: Patient details, linked to doctors and hospitals - 600 patients.
4. **Appointments**: Scheduled appointments with doctors - 3453 appointments.
5. **Medications**: Drug details and types - 50 medications.
6. **Lab Results**: Results of tests conducted on patients.
7. **Diseases**: Illnesses and their treatments - 56 diseases.

--- 

## Setup Instructions

### Prerequisites
1. **MySQL Server**: Install [MySQL](https://dev.mysql.com/downloads/).
2. **MS Access**: Ensure [MS Access](https://www.microsoft.com/en-us/microsoft-365/access) is installed.
3. **Python**: Install Python 3.x.
4. **Git**: Clone this repository.

### Steps to Execute
1. Clone the repository:
   ```bash
   git clone https://github.com/jennalyse/group-5-hospital.git
   cd group-5-hospital

### Prerequisites
1. **MySQL Server**: Download and install [MySQL](https://dev.mysql.com/downloads/).
2. **MS Access**: Download and install [MS Access](https://www.microsoft.com/en-us/microsoft-365/access)
3. **Python 3.x**: Install Python 3.x.
4. **Git**: Install Git and clone this repository.

### Steps to Execute:
1. Clone the repository (in Terminal)
   ```bash
   git clone https://github.com/jennalyse/group-5-hospital.git
   cd group-5-hospital
3. Set up database
     run MySQL with local_infile enabled (or enable it globally within MySQL)
        mysql --local-infile=1 -u root
     run create_hospitals_db.sql to create database 
        mysql -u root -p < create_hospitals_db.sql
     run create_load_HOSPITALS.sql to create HOSPITALS table and import the data
        mysql -u root - p < create_load_HOSPITALS.sql
4. Run the following SQL scripts in order:
     1. create_load_DOCTORS.sql
     2. create_load_PATIENTS.sql
     3. create_load_APPOINTMENTS.sql
     4. create_load_LAB_RESULTS.sql
     5. create_load_MEDICATIONS.sql
     6. create_load_PRESCRIPTIONS.sql
     7. create_load_MEDICATIONS.sql
   If problems are encountered with permissions to import files, follow the files above but instead of importing, use the corresponding SQL scripts in folder SQL/table_creation.
5. Run MySQL queries:
   ```MySQL
   source sql/queries/1_list_doctors.sql;
Repeat for all 19.
6. Run MS Access queries:
   Open .accdb files in ms_access/queries.
   19 queries are provided in the ms_access/queries folder, and to use them, copy them each into the query view on Access and then run the code.  For example, in the case of query 5:

INSERT INTO patients ( patient_name, address, doctor_name )
VALUES ('Jane Smith', '1 Close', 'Alice Berry');

When this code is run, the additional person will be added to the patients database.  This can be viewed on the table of patients to confirm that the person has been added to the list, with an allocated Doctor name linked with them.


## Generation of Data
The starting point for the data generation was a provided list of 40 hospitals together with data on the hospital address, size (number of beds), type, whether they offer emergency services and year of accreditation.  This information was then used to create new data using generative AI to populate related tables of information.  

The doctors table was created using information from the hospitals table to enable the doctors to be selected for the different hospitals in the geographical area that their address was in.  The patients table was then created using information from the doctors table, again linking with the geogrpahical area.  Both were developed using generative AI to create the list of names, addresses, date of birth, and linking with the relevant doctor, patient and hospital IDs.

Generative AI was then used to create tables to contain information about medications, diseases, prescriptions, lab results and appointments.  This information was linked with those of the doctors, hospitals and patient information, so that, for example, doctor specialisms were related to doctor IDs.

Python was also used for generating the tables of data, using generative AI to generate the code.  The code used for the python programming is provided in the docs/python_scripts folder.  The scripts used inputs of data such as the original hospital file to map information onto columns as required for the later tables.

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


## License

This project is licensed under the **MIT License**. You are free to use, modify, and distribute this project, provided proper credit is given. See the [LICENSE](LICENSE) file for more details.
