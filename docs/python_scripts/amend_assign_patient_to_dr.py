import pandas as pd
import random
import re

# Load the CSV files (replace with own path)
patients_file_path = '/path/tofinal_patients.csv'
doctors_file_path = '/path/to/final_doctors.csv'

patients_df = pd.read_csv(patients_file_path)
doctors_df = pd.read_csv(doctors_file_path)

# Add a sequential doctor_id to the in-memory doctors_df.
doctors_df['doctor_id'] = range(1, len(doctors_df) + 1)

# Function to extract the postcode area.
def extract_postcode_area(address):
    match = re.search(r'\b([A-Z]{1,2})\d', address)
    return match.group(1) if match else None

# Extract postcode areas for patients and doctors.
patients_df['postcode_area'] = patients_df['address'].apply(extract_postcode_area)
doctors_df['postcode_area'] = doctors_df['address'].apply(extract_postcode_area)

# Assign patients to doctors in the same postcode area.
def assign_patients_to_doctors():
    # Iterate through each postcode area.
    for area in patients_df['postcode_area'].dropna().unique():
        # Get patients and doctors in the current area.
        area_patients = patients_df[(patients_df['postcode_area'] == area) & (patients_df['doctor_id'].isna())]
        area_doctors = doctors_df[doctors_df['postcode_area'] == area]

        if not area_doctors.empty:
            # Assign patients evenly across doctors in the same area.
            doctor_ids = area_doctors['doctor_id'].tolist()
            for i, patient_idx in enumerate(area_patients.index):
                assigned_doctor = doctor_ids[i % len(doctor_ids)]
                patients_df.loc[patient_idx, 'doctor_id'] = assigned_doctor

assign_patients_to_doctors()

# Ensure every doctor has at least two patients from the same area.
def ensure_each_doctor_has_two_patients():
    for _, doctor_row in doctors_df.iterrows():
        doctor_id = doctor_row['doctor_id']
        doctor_area = doctor_row['postcode_area']

        # Find patients assigned to this doctor.
        assigned_patients = patients_df[patients_df['doctor_id'] == doctor_id]
        if len(assigned_patients) < 2:
            # Find unassigned or reassignable patients in the same area
            area_patients = patients_df[patients_df['postcode_area'] == doctor_area]
            unassigned_patients = area_patients[area_patients['doctor_id'].isna()]
            needed = 2 - len(assigned_patients)

            # Assign unassigned patients first.
            to_assign = unassigned_patients.head(needed)

            if len(to_assign) < needed:
                # Reassign existing patients if unassigned patients are insufficient.
                remaining_needed = needed - len(to_assign)
                reassignable_patients = area_patients[area_patients['doctor_id'] != doctor_id].head(remaining_needed)
                to_assign = pd.concat([to_assign, reassignable_patients])

            # Update the doctor_id for the selected patients.
            patients_df.loc[to_assign.index, 'doctor_id'] = doctor_id

ensure_each_doctor_has_two_patients()

# Final check to ensure no cross-area assignments.
def validate_assignments():
    mismatched = patients_df.merge(doctors_df, on='doctor_id')
    mismatched = mismatched[mismatched['postcode_area_x'] != mismatched['postcode_area_y']]
    if not mismatched.empty:
        print("Warning: Some patients are assigned to doctors in a different postcode area.")
        print(mismatched)

validate_assignments()

# Ensure doctor_id is an integer.
patients_df['doctor_id'] = patients_df['doctor_id'].astype(int)

# Drop temporary columns.
patients_df.drop(columns=['postcode_area'], inplace=True)
doctors_df.drop(columns=['postcode_area'], inplace=True)

# Save the updated patients dataset.
updated_patients_file_path = '/path/to/final_patients_corrected.csv'
patients_df.to_csv(updated_patients_file_path, index=False)

print(f"Updated patients dataset saved to {updated_patients_file_path}")
