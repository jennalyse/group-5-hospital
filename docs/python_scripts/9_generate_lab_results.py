import pandas as pd
import random
from datetime import datetime, timedelta

# Load CSV file (in raw_intermediate_data).
input_file = "/path/to/disease_meds_prescrips_patients.csv"
data = pd.read_csv(input_file)

# Map diseases to realistic lab tests and expected results.
disease_lab_mapping = {
    "Hypertension": [("Blood Pressure", "Elevated"), ("Potassium", "Normal"), ("Sodium", "Normal")],
    "Type 2 Diabetes Mellitus": [("Blood Sugar", "Elevated"), ("HbA1c", "High"), ("C-Reactive Protein Test", "Elevated")],
    "Asthma": [("Spirometry", "Obstructed"), ("Blood Gas Analysis", "Low O2"), ("White blood cells", "High")],
    "Chronic Obstructive Pulmonary Disease": [("Spirometry", "Reduced"), ("Chest X-ray", "Abnormal"), ("C-Reactive Protein Test", "Elevated")],
    "Anemia": [("Hemoglobin Level", "Low"), ("Iron", "Low"), ("Heamatocrit", "Low")],
    "Kidney Disease": [("Creatinine", "High"), ("Potassium", "Elevated"), ("Sodium", "Low")],
    "Hepatitis C": [("Liver Function Test", "Abnormal"), ("Alkaline phosphotase", "High"), ("C-Reactive Protein Test", "Elevated")],
    "Hyperlipidemia": [("Cholesterol Level", "Elevated"), ("Low density lipoprotein", "High"), ("High density lipoprotein", "Low")],
    "Heart Disease": [("ECG", "Abnormal"), ("Cardiac Enzymes", "Elevated"), ("Low density lipoprotein", "Elevated")],
    "Infectious Diseases": [("White Blood Cell Count", "High"), ("C-Reactive Protein Test", "Elevated"), ("Platelets", "Low")],
}

# Define fallback lab tests for diseases without specific mappings.
default_tests = [
    ("Complete Blood Count", "Normal"), 
    ("Electrolyte Panel", "Normal"), 
    ("Blood Sugar", "Normal"), 
    ("Thyroxine", "Normal"),
    ("Platelets", "Normal")
]

# Generate lab results data.
lab_results_data = []

for _, row in data.iterrows():
    # Extract patient_id, doctor_id, and disease_name.
    patient_id = row["patient_id"]
    doctor_id = row["doctor_id"]
    disease_name = row["disease_name"]

    # Combine specific and fallback tests.
    disease_specific_tests = disease_lab_mapping.get(disease_name, [])
    all_tests = disease_specific_tests + default_tests

    # Generate 1-3 relevant lab results for each patient.
    num_tests = random.randint(1, len(disease_specific_tests)) if disease_specific_tests else random.randint(1, 2)
    for test_name, expected_result in random.sample(all_tests, num_tests):
        # Adjust results based on disease context.
        result = (
            expected_result if random.random() > 0.45  # 55% chance to match expected
            else "Normal" if expected_result != "Normal"  # Occasionally show normal
            else "Abnormal"  # Flip normal to abnormal occasionally
        )
        lab_results_data.append({
            "lab_test": test_name,
            "lab_date": (datetime.now() - timedelta(days=random.randint(0, 365))).strftime("%Y-%m-%d"),
            "lab_result": result,
            "doctor_id": doctor_id,
            "patient_id": patient_id,
        })

# Create a DataFrame for lab results.
lab_results_df = pd.DataFrame(lab_results_data)

# Save the lab results to a CSV file.
output_file = "/path/to/final_lab_results.csv"
lab_results_df.to_csv(output_file, index=False)
