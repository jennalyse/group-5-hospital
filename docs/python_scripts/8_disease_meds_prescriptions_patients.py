import mysql.connector
import pandas as pd

# Connect to MySQL.
connection = mysql.connector.connect(
    host="localhost",
    user="root", # replace with actual username
    password="", # replace with password
    database="hospitals_db"
)

# Query.
query = """
SELECT 
    CONCAT(p.first_name, ' ', p.second_name) AS patient_name,
    p.patient_id,
    pr.prescription_id,
    pr.prescription_date,
    CONCAT(d.first_name, ' ', d.second_name) AS doctor_name,
    d.doctor_id,
    m.med_id,
    m.med_name,
    m.med_type,
    dis.disease_id,
    dis.disease_name,
    dis.disease_treatment
FROM 
    PATIENTS p
JOIN 
    PRESCRIPTIONS pr ON p.patient_id = pr.patient_id
JOIN 
    DOCTORS d ON pr.doctor_id = d.doctor_id
JOIN 
    MEDICATIONS m ON pr.medication_id = m.med_id
JOIN 
    DISEASE dis ON m.med_id = dis.med_id;
"""

# Load data into Pandas DataFrame.
df = pd.read_sql(query, connection)

# Save to CSV.
output_file = "/path/to/disease_meds_prescription_patients.csv"
df.to_csv(output_file, index=False)

print(f"Query results saved to {output_file}")
