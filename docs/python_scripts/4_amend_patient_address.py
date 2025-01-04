# 1 out of 3 patient csv amendments.

import pandas as pd
import random
import re

# Load the datasets (replace with own path).
doctors_file_path = '/path/to/final_doctors.csv' 
patients_file_path = '/path/to/cleaned_patients.csv'

# Load datasets into pandas DataFrames.
doctors_df = pd.read_csv(doctors_file_path)
patients_df = pd.read_csv(patients_file_path)

# Assign patients to doctors.
# -- get the number of doctors and patients
num_doctors = len(doctors_df)
num_patients = len(patients_df)

# Create a distribution of patients across doctors with some variation.
patients_per_doctor = [random.randint(5, 8) for _ in range(num_doctors)]

# Adjust the distribution to match the total number of patients.
while sum(patients_per_doctor) < num_patients:
    patients_per_doctor[random.randint(0, len(patients_per_doctor) - 1)] += 1

while sum(patients_per_doctor) > num_patients:
    patients_per_doctor[random.randint(0, len(patients_per_doctor) - 1)] -= 1

# Map patients to doctors.
doctor_ids = []
for doctor_id, count in zip(doctors_df.index + 1, patients_per_doctor):
    doctor_ids.extend([doctor_id] * count)

# Shuffle the assignments and assign them to patients.
random.shuffle(doctor_ids)
patients_df['doctor_id'] = doctor_ids

# Define postcode-to-city mapping.
postcode_to_city = {
    "SE": "London", "SW": "London", "E": "London", "N": "London", "W": "London",
    "NW": "London", "EC": "London", "WC": "London",
    "B": "Birmingham", "M": "Manchester", "L": "Liverpool", "G": "Glasgow",
    "AB": "Aberdeen", "EH": "Edinburgh", "DD": "Dundee", "CF": "Cardiff",
    "BS": "Bristol", "LE": "Leicester", "NG": "Nottingham", "OX": "Oxford",
    "CB": "Cambridge", "NR": "Norwich", "SA": "Swansea", "BT": "Belfast",
    "LS": "Leeds", "NE": "Newcastle", "PO": "Portsmouth", "SO": "Southampton",
    "SR": "Sunderland", "DY": "Dudley", "WS": "Walsall", "WV": "Wolverhampton",
    "MK": "Milton Keynes", "RG": "Reading", "GU": "Guildford", "SL": "Slough",
    "CH": "Chester", "PR": "Preston", "BB": "Blackburn", "LA": "Lancaster",
    "YO": "Yorkshire", "PL": "Plymouth", "HP": "Buckinghamshire", "DE": "Derby",
    "HU": "Hull"
}

# Define address formats with different house types.
address_formats = [
    "Flat {flat_number}, {street}, {village_town}{city} {postcode}",  # flats
    "{house_number} {street}, {village_town}{city} {postcode}",      # numbered houses
    "{house_name}, {street}, {village_town}{city} {postcode}"        # named houses
]

# List of house names.
house_names = [
    "Rose Cottage", "Ivy House", "The Laurels", "Fern Lodge", "Heather View",
    "Lavender Cottage", "Fox Hollow", "Badger’s Rest", "Brook House", "Meadow View",
    "Hillside", "The Old Rectory", "The Gables", "Sunnybank", "The Coach House",
    "Oak Lodge", "Willow House", "Beechwood", "Primrose Cottage", "The Grange",
    "Maple House", "Holly Cottage", "The Barn", "The Stables", "Ashcroft House",
    "Cherry Tree Cottage", "Orchard House", "Riverside", "Stone Cottage",
    "Hillcrest", "The Homestead", "The Granary", "The Forge", "Springfield"
]

# List of street names.
street_names = [
    "Church Lane", "High Street", "Main Street", "Station Road", "Bridge Road",
    "Park Road", "Elm Road", "Willow Avenue", "Meadow Lane", "Ash Grove",
    "Chestnut Close", "Rowan Street", "Hawthorn Road", "Beech Way", "The Green",
    "Primrose Avenue", "Lime Grove", "Woodland Drive", "Hillcrest Road",
    "Rosewood Avenue", "Brookside", "Riverside Drive", "Field View",
    "Honeysuckle Way", "Bluebell Lane", "Windmill Lane", "Hilltop Crescent",
    "Fern Road", "Park Crescent", "Lake View", "Harbour Road", "Greenfield Lane"
]

# Function to generate UK postcode.
def generate_valid_uk_postcode(base_postcode):
    base_match = re.match(r'([A-Z]{1,2}\d[A-Z\d]?) (\d[A-Z]{2})', base_postcode)
    if base_match:
        outer = base_match.group(1)
        new_inner = f"{random.randint(0, 9)}{random.choice('ABCDEFGHIJKLMNOPQRSTUVWXYZ')}{random.choice('ABCDEFGHIJKLMNOPQRSTUVWXYZ')}"
        return f"{outer} {new_inner}"
    return base_postcode

# Function to generate a unique address for a patient with variety.
def generate_patient_address_with_variety(doctor_address):
    area_match = re.search(r'(, [\w\s]+,)', doctor_address)
    postcode_match = re.search(r'([A-Z]{1,2}\d[A-Z\d]?) (\d[A-Z]{2})', doctor_address)
    if area_match and postcode_match:
        village_town = area_match.group(1).strip(', ')
        base_postcode = postcode_match.group(1) + " " + postcode_match.group(2)
        outer_postcode = postcode_match.group(1)
        full_postcode = generate_valid_uk_postcode(base_postcode)
        city = postcode_to_city.get(outer_postcode[:2], postcode_to_city.get(outer_postcode[:1], ""))
        city = f", {city}" if city else ""
        address_format = random.choice(address_formats)
        flat_number = random.randint(1, 99)
        house_number = random.randint(1, 999)
        house_name = random.choice(house_names)
        street = random.choice(street_names)
        address = address_format.format(
            flat_number=flat_number,
            house_number=house_number,
            house_name=house_name,
            street=street,
            village_town=village_town,
            city=city,
            postcode=full_postcode
        )
        return address
    return doctor_address

# Create a map of doctor_id to doctor addresses.
doctor_address_map = dict(zip(doctors_df.index + 1, doctors_df['address']))

# Apply the updated address generation function to the patients dataset.
patients_df['address'] = patients_df['doctor_id'].map(lambda x: generate_patient_address_with_variety(doctor_address_map[x]))

# Save the corrected patients dataset to a new file.
corrected_patients_file_path = '/path/to/final_patients.csv' 
patients_df.to_csv(corrected_patients_file_path, index=False)

print(f"Corrected patients dataset saved to {corrected_patients_file_path}")
