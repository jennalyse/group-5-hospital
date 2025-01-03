## AI generated diseases, medications and treaments

import pandas as pd
import random

medications_df = pd.read_csv("medications.csv")

# Assign a unique med_id based on the order of medications in the medications.csv file.
medications_df["med_id"] = range(1, len(medications_df) + 1)

# Full list of diseases, medication, and treatments.
disease_data = [
    {"disease": "Hypertension", "medication": "Amlodipine", 
     "disease_treatment": "Antihypertensive medication; reduced salt intake, regular exercise"},
    {"disease": "Type 2 Diabetes Mellitus", "medication": "Metformin", 
     "disease_treatment": "Blood sugar-lowering medication; dietary adjustments"},
    {"disease": "Asthma", "medication": "Albuterol", 
     "disease_treatment": "Inhaled bronchodilator; pulmonary rehabilitation"},
    {"disease": "Major Depressive Disorder", "medication": "Sertraline", 
     "disease_treatment": "Antidepressant; cognitive behavioral therapy"},
    {"disease": "Osteoarthritis", "medication": "Ibuprofen", 
     "disease_treatment": "NSAID for pain relief; physical therapy"},
    {"disease": "Chronic Obstructive Pulmonary Disease", "medication": "Tiotropium", 
     "disease_treatment": "Bronchodilators; smoking cessation"},
    {"disease": "Coronary Artery Disease", "medication": "Atorvastatin", 
     "disease_treatment": "Statins; lifestyle changes, angioplasty if needed"},
    {"disease": "Rheumatoid Arthritis", "medication": "Methotrexate", 
     "disease_treatment": "DMARDs; joint protection, physiotherapy"},
    {"disease": "Epilepsy", "medication": "Levetiracetam", 
     "disease_treatment": "Antiepileptic drugs; ketogenic diet for refractory cases"},
    {"disease": "Parkinson's Disease", "medication": "Levodopa", 
     "disease_treatment": "Dopaminergic agents; physical therapy"},
    {"disease": "Migraine", "medication": "Sumatriptan", 
     "disease_treatment": "Triptans; avoidance of triggers, regular sleep patterns"},
    {"disease": "Anemia", "medication": "Ferrous sulfate", 
     "disease_treatment": "Iron supplements; dietary adjustments"},
    {"disease": "Hyperlipidemia", "medication": "Simvastatin", 
     "disease_treatment": "Statins; dietary changes"},
    {"disease": "Hypothyroidism", "medication": "Levothyroxine", 
     "disease_treatment": "Thyroid hormone replacement"},
    {"disease": "Psoriasis", "medication": "Adalimumab", 
     "disease_treatment": "Biologics; topical steroids"},
    {"disease": "Schizophrenia", "medication": "Risperidone", 
     "disease_treatment": "Antipsychotics; psychotherapy"},
    {"disease": "Bipolar Disorder", "medication": "Lithium", 
     "disease_treatment": "Mood stabilizers; psychoeducation"},
    {"disease": "Celiac Disease", "medication": "Gluten-free diet", 
     "disease_treatment": "Avoid gluten; vitamin supplementation"},
    {"disease": "Crohn's Disease", "medication": "Infliximab", 
     "disease_treatment": "Biologics; dietary management"},
    {"disease": "Ulcerative Colitis", "medication": "Mesalamine", 
     "disease_treatment": "Aminosalicylates; colectomy for severe cases"},
    {"disease": "Hepatitis B", "medication": "Entecavir", 
     "disease_treatment": "Antiviral medication; liver function monitoring"},
    {"disease": "Hepatitis C", "medication": "Sofosbuvir", 
     "disease_treatment": "Direct-acting antivirals; avoid alcohol"},
    {"disease": "Tuberculosis", "medication": "Rifampin", 
     "disease_treatment": "Antitubercular drugs; adherence to long-term therapy"},
    {"disease": "HIV/AIDS", "medication": "Tenofovir", 
     "disease_treatment": "Antiretroviral therapy; regular viral load monitoring"},
    {"disease": "Lupus", "medication": "Hydroxychloroquine", 
     "disease_treatment": "Immunosuppressants; regular check-ups"},
    {"disease": "Multiple Sclerosis", "medication": "Interferon beta", 
     "disease_treatment": "Disease-modifying therapies; physical therapy"},
    {"disease": "Kidney Disease", "medication": "Furosemide", 
     "disease_treatment": "Diuretics; blood pressure control"},
    {"disease": "Prostate Cancer", "medication": "Leuprolide", 
     "disease_treatment": "Hormone therapy; radiation therapy"},
    {"disease": "Breast Cancer", "medication": "Tamoxifen", 
     "disease_treatment": "Hormonal therapy; chemotherapy"},
    {"disease": "Skin Cancer", "medication": "Imiquimod", 
     "disease_treatment": "Topical therapy; surgical excision for severe cases"},
    {"disease": "Osteoporosis", "medication": "Alendronate", 
     "disease_treatment": "Bisphosphonates; calcium and vitamin D supplementation"},
    {"disease": "Pneumonia", "medication": "Amoxicillin", 
     "disease_treatment": "Antibiotics; oxygen therapy if needed"},
    {"disease": "Dengue Fever", "medication": "Acetaminophen", 
     "disease_treatment": "Supportive care; hydration therapy"},
    {"disease": "Malaria", "medication": "Artemether", 
     "disease_treatment": "Antimalarial drugs; insecticide-treated nets"},
    {"disease": "Typhoid Fever", "medication": "Ciprofloxacin", 
     "disease_treatment": "Antibiotics; fluid replacement therapy"},
    {"disease": "Cholera", "medication": "Zinc supplementation", 
     "disease_treatment": "Oral rehydration therapy; antibiotics if needed"},
    {"disease": "Leprosy", "medication": "Dapsone", 
     "disease_treatment": "Multidrug therapy; wound care"},
    {"disease": "Alzheimer's Disease", "medication": "Donepezil", 
     "disease_treatment": "Cholinesterase inhibitors; cognitive stimulation therapies"},
    {"disease": "Ebola Virus Disease", "medication": "Supportive care", 
     "disease_treatment": "Fluid resuscitation; electrolyte monitoring"},
    {"disease": "Zika Virus", "medication": "Symptomatic relief", 
     "disease_treatment": "Rest; hydration; acetaminophen for pain relief"},
    {"disease": "Marburg Virus", "medication": "Supportive care", 
     "disease_treatment": "Isolation; hydration therapy; electrolyte monitoring"},
    {"disease": "Yellow Fever", "medication": "Supportive care", 
     "disease_treatment": "Rest; fluids; pain relievers for fever management"},
    {"disease": "Anthrax", "medication": "Ciprofloxacin", 
     "disease_treatment": "Antibiotics; antitoxin therapy for severe cases"},
    {"disease": "Lyme Disease", "medication": "Doxycycline", 
     "disease_treatment": "Antibiotics; supportive therapy for chronic symptoms"},
    {"disease": "Rabies", "medication": "Rabies immunoglobulin", 
     "disease_treatment": "Post-exposure prophylaxis; wound cleaning"},
    {"disease": "Meningitis", "medication": "Ceftriaxone", 
     "disease_treatment": "Antibiotics for bacterial infection; supportive care for viral cases"},
    {"disease": "Tetanus", "medication": "Tetanus immunoglobulin", 
     "disease_treatment": "Antibiotics; wound cleaning; supportive care"},
    {"disease": "Diphtheria", "medication": "Diphtheria antitoxin", 
     "disease_treatment": "Antibiotics; supportive care for respiratory symptoms"},
    {"disease": "Pertussis", "medication": "Azithromycin", 
     "disease_treatment": "Antibiotics; supportive care to ease coughing"},
    {"disease": "Plague", "medication": "Streptomycin", 
     "disease_treatment": "Antibiotics; isolation to prevent spread"},
    {"disease": "Hookworm", "medication": "Albendazole", 
     "disease_treatment": "Anthelmintics; iron supplementation for anemia"},
    {"disease": "Ascariasis", "medication": "Albendazole", 
     "disease_treatment": "Anthelmintic medication; hygiene education"},
    {"disease": "Trichinosis", "medication": "Albendazole", 
     "disease_treatment": "Antiparasitic therapy; pain management for muscle symptoms"},
    {"disease": "Filariasis", "medication": "Diethylcarbamazine", 
     "disease_treatment": "Anthelmintic drugs; surgical management for severe lymphedema"},
    {"disease": "Onchocerciasis", "medication": "Ivermectin", 
     "disease_treatment": "Anthelmintic therapy; management of skin inflammation"},
    {"disease": "Hydatid Disease", "medication": "Albendazole", 
     "disease_treatment": "Anthelmintic therapy; surgical removal of cysts"},
]


# Convert the list of dictionaries to a pandas DataFrame.
diseases_df = pd.DataFrame(disease_data)

# Map medication names in diseases dataset to med_id in medications.csv.
medication_to_id = dict(zip(medications_df["med_name"], medications_df["med_id"]))
diseases_df["med_id"] = diseases_df["medication"].map(medication_to_id)

# Drop the original medication column.
diseases_df = diseases_df.drop(columns=["medication"])

diseases_df.rename(columns={"disease": "disease_name"}, inplace=True)

# med_id must be an integer.
diseases_df["med_id"] = diseases_df["med_id"].fillna(0).astype(int)

# Number of doctors available.
number_of_doctors = 100
doctor_ids = list(range(1, number_of_doctors + 1))

# Shuffle doctor IDs.
random.shuffle(doctor_ids)

# Assign one unique doctor per disease.
if len(diseases_df) <= number_of_doctors:
    diseases_df["doctor_id"] = doctor_ids[:len(diseases_df)]
else:
    raise ValueError("Number of diseases exceeds the number of available doctors.")

# Save the updated DataFrame back to CSV.
output_file = "diseases.csv"
diseases_df.to_csv(output_file, index=False)
