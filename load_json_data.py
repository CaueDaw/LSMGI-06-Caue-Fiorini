from dotenv import load_dotenv
import os
import json
from db import db_connection

load_dotenv()

conn = db_connection()

cursor = conn.cursor()

# ── OFFICES ──────────────────────────────────────────
cursor.execute("""
    CREATE TABLE IF NOT EXISTS offices_json (
        id INT AUTO_INCREMENT PRIMARY KEY,
        data JSON
    )
""")

with open(os.getenv('JSON_PATH') + 'offices.json', 'r', encoding='utf-8') as f:
    offices = json.load(f)

for office in offices:
    cursor.execute("INSERT INTO offices_json (data) VALUES (%s)", (json.dumps(office),))

# ── EMPLOYEES ─────────────────────────────────────────
cursor.execute("""
    CREATE TABLE IF NOT EXISTS employees_json (
        employee_id INT AUTO_INCREMENT PRIMARY KEY,
        data JSON
    )
""")

with open(os.getenv('JSON_PATH') + 'employees.json', 'r', encoding='utf-8') as f:
    employees = json.load(f)

for employee in employees:
    cursor.execute("INSERT INTO employees_json (data) VALUES (%s)", (json.dumps(employee),))


conn.commit()
print("offices.json and employees.json loaded correctly!")
conn.close()