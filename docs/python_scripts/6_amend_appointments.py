import pandas as pd
from datetime import datetime, timedelta
import random

# Load input data.
patient_doctor_file = "/path/to/patient_doctor_prescription_data.csv" 
appointments_template_file = "/path/to/appointments(in).csv"  

# Read data.
patient_doctor_df = pd.read_csv(patient_doctor_file)
appointments_df = pd.read_csv(appointments_template_file)

# Define a mix of realistic appointment purposes.
appointment_purposes = [
    "Follow-up for {disease_name}",
    "Initial consultation for {disease_name}",
    "Emergency visit",
    "Vaccination appointment",
    "Prescription refill",
    "Annual check-up",
    "Routine screening",
]

# Time intervals for appointments.
time_intervals = [0, 15, 30, 45]  # Minutes past the hour.

# Generate updated appointments.
updated_appointments = []

for _, appointment in appointments_df.iterrows():
    # Find suitable patient and doctor entries.
    suitable_entries = patient_doctor_df[
        (patient_doctor_df['patient_id'] == appointment['patient_id'])
    ]
    
    # If no match is found for the patient, sample randomly.
    if suitable_entries.empty:
        suitable_entries = patient_doctor_df.sample(1)

    selected_entry = suitable_entries.iloc[0]

    # Randomly assign a purpose with disease-specific or generic text.
    disease_name = selected_entry['disease_name']
    appt_purpose = random.choice(appointment_purposes)
    appt_purpose = appt_purpose.format(disease_name=disease_name.lower())

    # Generate a random time within working hours (9:00 AM to 8:00 PM) with appropriate intervals.
    random_hour = random.randint(9, 20)
    random_minute = random.choice(time_intervals)
    appointment_datetime = datetime.strptime(selected_entry['prescription_date'], "%Y-%m-%d") + timedelta(
        days=random.randint(1, 60)
    )
    appointment_datetime = appointment_datetime.replace(hour=random_hour, minute=random_minute, second=0)

    # Update the appointment with a diverse purpose and date-time.
    updated_appointments.append({
        "appt_date": appointment_datetime.strftime("%Y-%m-%d %H:%M:%S"),
        "appt_purpose": appt_purpose,
        "patient_id": selected_entry['patient_id'],
        "doctor_id": selected_entry['doctor_id'],
    })

# Create a DataFrame for updated appointments.
updated_appointments_df = pd.DataFrame(updated_appointments)


# Save the updated appointments to a new CSV file.
output_file = "/path/to/final_appointments.csv" 
updated_appointments_df.to_csv(output_file, index=False)

