from dotenv import load_dotenv
import os
from db import db_connection

load_dotenv()

with open(os.getenv('XML_PATH') + 'Employees.xml', 'r', encoding='utf-8') as f:
    xml_content = f.read()

conn = db_connection()

cursor = conn.cursor()

cursor.execute("""
    CREATE TABLE IF NOT EXISTS employees_xml (
        id INT AUTO_INCREMENT PRIMARY KEY,
        xml_data LONGTEXT
    )
""")

cursor.execute("INSERT INTO employees_xml (xml_data) VALUES (%s)", (xml_content,))
conn.commit()
print("xml loaded correctly!")
conn.close()