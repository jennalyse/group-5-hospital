import random
from datetime import datetime, timedelta

# Open a file (in write mode) to store the generated SQL INSERT statements
with open('insert_prescriptions.sql', 'w') as f:
    # Write 500 random prescriptions
    # - by looping through numbers from 1 to 500 inclusive
    for i in range(1, 501):
        # Generate a random date within the past 2 years
        # - random.random() function generates a float between 0 and 1, used to interpolate
        # - between start_date and end_date
        end_date = datetime.now()
        start_date = end_date - timedelta(days = 365 * 2)  # 2 years ago
        prescription_date = start_date + (end_date - start_date) * random.random()

        # Convert generated date into SQL compatible string format (YYYY-MM-DD)
        prescription_date_str = prescription_date.strftime('%Y-%m-%d')

        # Generate the SQL INSERT statement
        # - including unique prescription_id (i) and random prescription_date
        sql = f"INSERT INTO PRESCRIPTIONS (prescription_id, prescription_date) VALUES ({i}, '{prescription_date_str}');\n"

        # Write the SQL statement to the file
        f.write(sql)

# Confirm SQL file created successfully.
print("SQL Insert statements have been written to insert_prescriptions.sql")