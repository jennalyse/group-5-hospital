## AI generated medications and manufacturers.

import pandas as pd
import random

# List of medications with actual medication types.
medication_details = [
    {"med_name": "Amlodipine", "med_type": "Antihypertensive"},
    {"med_name": "Metformin", "med_type": "Antidiabetic"},
    {"med_name": "Albuterol", "med_type": "Bronchodilator"},
    {"med_name": "Sertraline", "med_type": "Antidepressant"},
    {"med_name": "Ibuprofen", "med_type": "Analgesic"},
    {"med_name": "Tiotropium", "med_type": "Anticholinergic"},
    {"med_name": "Atorvastatin", "med_type": "Statin"},
    {"med_name": "Methotrexate", "med_type": "Immunosuppressant"},
    {"med_name": "Levetiracetam", "med_type": "Antiepileptic"},
    {"med_name": "Levodopa", "med_type": "Dopaminergic"},
    {"med_name": "Sumatriptan", "med_type": "Triptan"},
    {"med_name": "Ferrous sulfate", "med_type": "Iron supplement"},
    {"med_name": "Simvastatin", "med_type": "Statin"},
    {"med_name": "Levothyroxine", "med_type": "Thyroid hormone"},
    {"med_name": "Adalimumab", "med_type": "Biologic"},
    {"med_name": "Risperidone", "med_type": "Antipsychotic"},
    {"med_name": "Lithium", "med_type": "Mood stabilizer"},
    {"med_name": "Infliximab", "med_type": "Immunosuppressant"},
    {"med_name": "Mesalamine", "med_type": "Aminosalicylate"},
    {"med_name": "Entecavir", "med_type": "Antiviral"},
    {"med_name": "Sofosbuvir", "med_type": "Antiviral"},
    {"med_name": "Rifampin", "med_type": "Antitubercular"},
    {"med_name": "Tenofovir", "med_type": "Antiviral"},
    {"med_name": "Hydroxychloroquine", "med_type": "Immunosuppressant"},
    {"med_name": "Interferon beta", "med_type": "Disease-modifying therapy"},
    {"med_name": "Furosemide", "med_type": "Diuretic"},
    {"med_name": "Leuprolide", "med_type": "Hormonal therapy"},
    {"med_name": "Tamoxifen", "med_type": "Hormonal therapy"},
    {"med_name": "Imiquimod", "med_type": "Topical therapy"},
    {"med_name": "Alendronate", "med_type": "Bisphosphonate"},
    {"med_name": "Amoxicillin", "med_type": "Antibiotic"},
    {"med_name": "Acetaminophen", "med_type": "Analgesic"},
    {"med_name": "Artemether", "med_type": "Antimalarial"},
    {"med_name": "Ciprofloxacin", "med_type": "Antibiotic"},
    {"med_name": "Zinc supplementation", "med_type": "Nutritional supplement"},
    {"med_name": "Dapsone", "med_type": "Antibiotic"},
    {"med_name": "Donepezil", "med_type": "Cognitive enhancer"},
    {"med_name": "Supportive care", "med_type": "Supportive therapy"},
    {"med_name": "Symptomatic relief", "med_type": "Supportive therapy"},
    {"med_name": "Albendazole", "med_type": "Anthelmintic"},
    {"med_name": "Ivermectin", "med_type": "Anthelmintic"},
    {"med_name": "Gluten-free diet", "med_type": "Dietary therapy"},
    {"med_name": "Doxycycline", "med_type": "Antibiotic"},
    {"med_name": "Rabies immunoglobulin", "med_type": "Post-exposure prophylaxis"},
    {"med_name": "Ceftriaxone", "med_type": "Antibiotic"},
    {"med_name": "Tetanus immunoglobulin", "med_type": "Post-exposure prophylaxis"},
    {"med_name": "Diphtheria antitoxin", "med_type": "Antitoxin"},
    {"med_name": "Azithromycin", "med_type": "Antibiotic"},
    {"med_name": "Streptomycin", "med_type": "Antibiotic"},
    {"med_name": "Diethylcarbamazine", "med_type": "Anthelmintic"}
]

# List of manufacturers.
manufacturers = [
    "Pfizer", "Novartis", "GlaxoSmithKline", "Sanofi", "Merck", "AstraZeneca", "Bayer", 
    "Roche", "Johnson & Johnson", "AbbVie", "Amgen", "Bristol-Myers Squibb", "Takeda",
    "Eli Lilly", "Novo Nordisk", "Gilead Sciences", "Teva", "Biogen"
]

# Generate medication data with randomised manufacturers.
medication_data = []
for med in medication_details:
    medication_data.append({
        "med_name": med["med_name"],
        "med_type": med["med_type"],
        "med_manufacturer": random.choice(manufacturers)
    })

# Create a DataFrame.
medications_df = pd.DataFrame(medication_data)

# Save to CSV.
output_file_path = "final_medications.csv"
medications_df.to_csv(output_file_path, index=False)

