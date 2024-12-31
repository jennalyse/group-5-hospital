import pandas as pd
import random

# Load hospital and doctors data.
hospitals_path = '/path/to/cleaned_hospitals.csv' # replace with own location
doctors_path = '/path/to/original_doctors.csv' # replace with own location

hospitals_data = pd.read_csv(hospitals_path)
doctors_data = pd.read_csv(doctors_path)

# Prepare hospital-to-address mappings for reference.
hospital_addresses = hospitals_data[['hospital_name', 'address']].copy()
hospital_addresses['hospital_id'] = range(1, len(hospital_addresses) + 1)
hospital_ids = hospital_addresses['hospital_id'].tolist()

# Generate proportional distribution of doctors across hospitals.
num_doctors = len(doctors_data)
doctors_per_hospital = [random.randint(2, 3) for _ in range(len(hospital_ids))]

# Adjust the distribution to exactly match the total number of doctors.
while sum(doctors_per_hospital) < num_doctors:
    doctors_per_hospital[random.randint(0, len(doctors_per_hospital) - 1)] += 1

while sum(doctors_per_hospital) > num_doctors:
    doctors_per_hospital[random.randint(0, len(doctors_per_hospital) - 1)] -= 1

# Create a doctor-to-hospital mapping.
doctor_hospital_map = []
for hospital_id, count in zip(hospital_ids, doctors_per_hospital):
    doctor_hospital_map.extend([hospital_id] * count)

# Shuffle the assignments.
random.shuffle(doctor_hospital_map)

# Define extended address variations.
address_variations_extended = [
    "Flat {num}, {name} Apartments, {area}",
    "{num} {name} Street, {area}",
    "{house} House, {name} Lane, {area}",
    "{name} Cottage, {name} Road, {area}",
    "{num}-{num2} {name} Boulevard, {area}",
    "Flat {num}, {name} Court, {area}",
    "{num} {name} Close, {area}",
    "{name} Villa, {name} Grove, {area}",
    "{house}, {name} Avenue, {area}",
    "{num} The {name} Walk, {area}",
    "Apartment {num}, {name} Mews, {area}",
    "{name} Lodge, {name} Crescent, {area}",
    "{num} {name} Gardens, {area}",
    "{num} {name} Parade, {area}",
    "{num} {name} Terrace, {area}",
    "{name} Manor, {name} Way, {area}",
    "{num} {name} View, {area}",
    "{house}, {name} Rise, {area}",
    "{house}, {name} Hill, {area}",
    "{num} {name} Row, {area}",
    "{name} Hall, {name} Square, {area}",
    "{house} Lodge, {name} Hill, {area}",
    "{num} The {name} Path, {area}",
    "{name} Barn, {name} Fold, {area}",
    "Flat {num}, {name} Quay, {area}",
    "{name} Tower, {name} Arcade, {area}",
    "{num} {name} Wharf, {area}",
    "{name} Mill, {name} Bridge, {area}"
]

# Random choices for road and house names.
road_name_choices = [
    'Greenwood', 'Elm', 'Oak', 'Maple', 'Willow', 'Ash', 'Chestnut', 'Beech', 'Rowan', 'Poplar',
    'Cedar', 'Linden', 'Hawthorn', 'Hazel', 'Ashcroft', 'Thornhill', 'Bramble', 'Meadow', 'Brook',
    'Fox Lane', 'Badger Street', 'Sparrow Walk', 'Kingfisher Crescent', 'Hedgehog Close', 
    'Hilltop Road', 'Silver Way', 'Raven Lane', 'The Ridge', 'Deerpath', 'Church Lane',
    'Mill Road', 'Bridge End', 'Market Street', 'High Street', 'Stonemason’s Row', 
    'Pondside', 'Fieldway', 'The Chase', 'Winding Lane', 'Buttercup Close'
]
house_name_choices = [
    'Rose Cottage', 'Ivy House', 'The Laurels', 'Fern Lodge', 'Heather View', 'Lavender Cottage', 
    'Fox Hollow', 'Badger’s Rest', 'Brook House', 'Meadow View', 'Hillside', 'The Old Rectory', 
    'The Gables', 'Sunnybank', 'The Coach House', 'The Granary', 'The Stables', 'Pheasant Rise', 
    'Deerwood Lodge', 'Raven’s Perch', 'Primrose Cottage', 'Honeysuckle Lodge', 'Thornfield', 
    'Ashcroft House', 'Owl’s Hollow', 'Willow Barn', 'Misty Vale', 'Birchwood Lodge', 
    'Elmstead Manor', 'Moonlit Cottage', 'Highfield House', 'Brackenridge', 'Foxley Manor', 
    'Rosemere', 'Springvale', 'Stonelake Lodge', 'The Old Forge', 'The White Hart', 'The Bell House'
]

# Generate addresses based on hospitals.
doctor_addresses = []
for hospital_id in doctor_hospital_map:
    hospital_info = hospital_addresses.loc[hospital_addresses['hospital_id'] == hospital_id]
    area = hospital_info['address'].values[0]
    address_type = random.choice(address_variations_extended)
    address = address_type.format(
        num=random.randint(1, 99),
        num2=random.randint(100, 999),
        name=random.choice(road_name_choices),
        house=random.choice(house_name_choices),
        area=area
    )
    doctor_addresses.append(address) 

# Build the updated doctors dataset.
doctor_data_updated = pd.DataFrame({
    "first_name": doctors_data['First Name'],
    "last_name": doctors_data['Surname'],
    "date_of_birth": pd.to_datetime(doctors_data['Date of Birth'], dayfirst=True).dt.strftime('%Y-%m-%d'),
    "hospital_id": doctor_hospital_map,
    "address": doctor_addresses
})

# Save the final dataset to a new CSV file.
doctor_data_updated.to_csv('updated_doctors_dataset.csv', index=False)

# Verify updated.
print(doctor_data_updated.head())
