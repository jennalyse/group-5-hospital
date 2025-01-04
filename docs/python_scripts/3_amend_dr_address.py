import pandas as pd
import random
import re

# Load the dataset.
file_path = '/path/to/doctors.csv'
doctors_df = pd.read_csv(file_path)

# Function to modify the postcode slightly.
def modify_postcode(postcode):
    # Match UK postcodes with regex.
    postcode_pattern = r'([A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2})'
    match = re.search(postcode_pattern, postcode)
    
    if match:
        original_postcode = match.group(0)
        # Split the postcode into parts.
        parts = original_postcode.split()
        
        # Modify the last part of the postcode.
        new_last_part = parts[1][:len(parts[1])-2] + random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ") + random.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        # Combine the parts back together with the modified last part.
        new_postcode = parts[0] + " " + new_last_part
        return postcode.replace(original_postcode, new_postcode)
    return postcode

# Apply the postcode modification to all addresses in the dataset.
doctors_df['modified_address'] = doctors_df['address'].apply(lambda x: modify_postcode(x))

# Save the modified dataset to a new CSV file in the current directory.
doctors_df.to_csv('final_doctors.csv', index=False)

print("Modified file saved as 'final_doctors.csv'.")
