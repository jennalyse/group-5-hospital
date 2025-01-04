import mysql.connector
import pandas as pd

# Connect to MySQL database.
connection = mysql.connector.connect(
    host="localhost",
    user="root",  # replace with your actual username
    password="" # replace with actual password
    database="hospitals_db" 
)

# SQL query to fetch required information.
query = """
SELECT 
    -- Patient Information
    CONCAT(p.first_name, ' ', p.second_name) AS patient_name,
    p.patient_id,
    -- Doctor Information
    CONCAT(d.first_name, ' ', d.second_name) AS doctor_name,
    d.doctor_id,
    -- Prescription Information
    pr.prescription_id,
    pr.prescription_date,
    -- Medication Information
    m.med_id,
    m.med_name,
    m.med_type,
    -- Disease Information
    dis.disease_id,
    dis.disease_name,
    dis.disease_treatment,
    -- Lab Results Information
    lr.lab_results_id,
    lr.lab_test,
    lr.lab_date,
    lr.lab_result
FROM 
    PATIENTS p
JOIN 
    PRESCRIPTIONS pr ON p.patient_id = pr.patient_id
JOIN 
    DOCTORS d ON pr.doctor_id = d.doctor_id
JOIN 
    MEDICATIONS m ON pr.medication_id = m.med_id
JOIN 
    DISEASE dis ON m.med_id = dis.med_id
LEFT JOIN 
    LAB_RESULTS lr ON p.patient_id = lr.patient_id AND d.doctor_id = lr.doctor_id;
"""

# Execute the query and fetch results into a Pandas DataFrame.
try:
    df = pd.read_sql(query, connection)

    # Save the results to a CSV file.
    output_file = "/path/to/patient_doctor_prescription_data.csv" 
    df.to_csv(output_file, index=False)

    print(f"Data has been successfully saved to {output_file}")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    # Close the database connection.
    connection.close()
