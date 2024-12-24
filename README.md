# group-5-hospital
This repository contains the Group 5 hospital database project, developed in MySQL and MS Access. The project involves the creation and population of a hospital database for use in MySQL and MS Access

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Files in the Repository](#files-in-the-repository)
3. [How to Set Up the Database](#how-to-set-up-the-database)
   - [Prerequisites](#prerequisites)
   - [Steps to Execute](#steps-to-execute)
4. [Technical Details](#technical-details)
   - [Database Schemas](#database-schemas)
   - [Data Cleaning](#data-cleaning)
5. [How to Use the SQL Files](#how-to-use-the-sql-files)

---

## Project Overview
...

---

## Files in the Repository

| **File Name**              | **Description**                                                                 |
|----------------------------|---------------------------------------------------------------------------------|
| `create_hospitals_db.sql`  | SQL script to create the `hospitals_db` database.                               |
| `create_load_HOSPITALS.sql`| SQL script to create the `HOSPITALS` table and load cleaned data into it.       |
| `update_csv.py`            | Python script to clean and prepare the original CSV data for MySQL/MS Access.   |
| `cleaned_hospitals.csv`    | Cleaned hospital data, ready for import into MySQL/MS Access.                   |
| `README.md`                | Documentation for the project.   
...

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
     git clone https://github.com/your-username/hospital-database.git
2. Set up database
     run MySQL with local_infile enabled (or enable it globally within MySQL)
        mysql --local-infile=1 -u root
     run create_hospitals_db.sql to create database 
        mysql -u root -p < create_hospitals_db.sql
     run create_load_HOSPITALS.sql to create HOSPITALS table and import the data
        mysql -u root - p < create_load_HOSPITALS.sql
   
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

### Data Cleaning
The hospitals CSV file given had the following issues:
  1. Incorrect Columm Headers: renamed to match the style of the MySQL table.
  2. Boolean Values: for ease of calculations, converted Yes/No to 1 or 0 in Emergency Services.
  3. Commas: removed commas in numberic fields in Size (beds).

While amending the MySQL table (or writing SQL queries to handle discrepancies), cleaning using Python ensured data was 
correctly prepared before import and could be easily reused by others. 

---

## How to Use the SQL Files
...


