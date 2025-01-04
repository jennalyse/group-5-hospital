# 2 out of 3 patient csv amendments.

import pandas as pd
import random

# Load the dataset.
patients_file_path = '/path/to/final_patients.csv'
patients_df = pd.read_csv(patients_file_path)

# Lists to generate middle names and double-barrelled last names.
middle_names = [
    "Alex", "Taylor", "Jordan", "Morgan", "Casey", "Dylan", "Jamie", "Riley", "Avery", 
    "Cameron", "Quinn", "Reese", "Rowan", "Elliot", "Peyton", "Finley", "Harper", 
    "Logan", "Dakota", "Skyler"
]
double_barrel_suffixes = [
    "Taylor", "Harris", "Cooper", "Robinson", "Parker", "Edwards", "Hill", 
    "Morgan", "Ward", "Bell", "Scott", "Clark", "Adams", "Bennett", "Carter", 
    "Mitchell", "Morris", "Gray", "Rogers", "Collins"
]

# Function to add a middle name to some first names.
def add_middle_name(first_name):
    if random.random() < 0.3:  # 30% chance to add a middle name
        middle_name = random.choice(middle_names)
        return f"{first_name} {middle_name}"
    return first_name

# Function to make some last names double-barrelled.
def make_double_barrelled(last_name):
    if random.random() < 0.25:  # 25% chance to make double-barrelled
        suffix = random.choice(double_barrel_suffixes)
        return f"{last_name}-{suffix}"
    return last_name

# Apply the transformations to the dataset.
patients_df['first_name'] = patients_df['first_name'].apply(add_middle_name)
patients_df['last_name'] = patients_df['last_name'].apply(make_double_barrelled)

# Rename column to match ERD and doctors table.
patients_df.rename(columns={'last_name': 'second_name'}, inplace=True)

# Save the updated dataset.
updated_patients_file_path = 'path/to/final_patients.csv' 
patients_df.to_csv(updated_patients_file_path, index=False)

print(f"Updated patients dataset with names modifications saved to {updated_patients_file_path}")
