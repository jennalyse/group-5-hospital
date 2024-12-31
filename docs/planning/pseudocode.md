# PSEUDOCODE

# Print a List of All Doctors Based at a Particular Hospital
### BEGIN

1. **Input hospital details**
   - `INPUT hospital_id` OR `hospital_name`

---

2. **Validate input – hospital exists**
   - **IF** `hospital_name` IS PROVIDED **THEN**
     - `QUERY HOSPITALS`
       - WHERE `hospital_name = input_hospital_name`
     - `SET hospital_id = input_hospital_id`
   - **END IF**

   - **IF** `hospital_id` IS NOT FOUND **THEN**
     - OUTPUT: "Hospital not found."
     - END
   - **END IF**

---

3. **Retrieve doctors**
   - `QUERY DOCTORS`
     - SELECT `first_name`, `last_name`, `address`
     - WHERE `hospital_id = input_hospital_id`

---

4. **Output list of doctors**
   - **IF** doctors exist **THEN**
     - OUTPUT: "List of doctors:"
     - DISPLAY `first_name`, `last_name`, `address`
   - **ELSE**
     - OUTPUT: "No doctors found for specified hospital."
   - **END**

---

### END
