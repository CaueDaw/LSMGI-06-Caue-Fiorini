# LSMGI06 — XML & JSON to MySQL Loader

Scripts to load XML and JSON data into a MySQL database.

---

## Prerequisites

- Python 3.11+
- MySQL Server with an existing database (e.g. `classicModels`)
- The files `Employees.xml`, `offices.json` and `employees.json`

---

## Installation

```bash
pip install python-dotenv
pip install mysql-connector-python
```

---

## Configuration

Create a `.env` file at the root of the project based on `.env.example`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=password
DB_NAME=classicModels
XML_PATH=C:/your/path/to/xml/
JSON_PATH=C:/your/path/to/json/
```

> ⚠️ Make sure the paths end with `/`

---

## Project Structure

```
LSMGI06/
├── db.py                # MySQL connection helper
├── load_xml_data.py     # Loads Employees.xml → employees_xml table
├── load_json_data.py    # Loads offices.json & employees.json → offices_json & employees_json tables
├── .env                 # Environment variables (do not commit)
├── .env.example         # Environment variables template
└── .gitignore
```

---

## Usage

### Load XML

Loads `Employees.xml` into the `employees_xml` table:

```bash
python load_xml_data.py
```

Creates the table:
```sql
employees_xml (id INT, xml_data LONGTEXT)
```

### Load JSON

Loads `offices.json` and `employees.json` into the `offices_json` and `employees_json` tables:

```bash
python load_json_data.py
```

Creates the tables:
```sql
offices_json   (id INT, data JSON)
employees_json (employee_id INT, data JSON)
```

---

## Useful SQL Queries

### XML — `ExtractValue`

```sql
-- Emails of employees with job title VP Sales
SELECT ExtractValue(xml_data, '//employee[jobTitle="VP Sales"]/email')
FROM employees_xml;

-- Number of employees in the EMEA territory
SELECT ExtractValue(xml_data, 'count(//employee[office/Territory="EMEA"])')
FROM employees_xml;

-- Last names of employees reporting to employee 1056
SELECT ExtractValue(xml_data, '//employee[reportsTo="1056"]/lastName')
FROM employees_xml;

-- Office city of employee 1166
SELECT ExtractValue(xml_data, '//employee[@employeeNumber="1166"]/office/City')
FROM employees_xml;
```

### JSON — `JSON_EXTRACT` / `JSON_UNQUOTE`

```sql
-- Phone numbers of all offices
SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '$.phone')) AS phone
FROM offices_json;

-- Employees whose extension contains "23"
SELECT * FROM employees_json
WHERE JSON_EXTRACT(data, '$.extension') LIKE '%23%';

-- Employee ID and last name of all employees
SELECT employee_id,
       JSON_UNQUOTE(JSON_EXTRACT(data, '$.lastName')) AS lastName
FROM employees_json;

-- Employee number, full name and office city (JOIN)
SELECT
    JSON_UNQUOTE(JSON_EXTRACT(e.data, '$.employeeNumber')) AS employeeNumber,
    CONCAT(
        JSON_UNQUOTE(JSON_EXTRACT(e.data, '$.firstName')), ' ',
        JSON_UNQUOTE(JSON_EXTRACT(e.data, '$.lastName'))
    ) AS fullName,
    JSON_UNQUOTE(JSON_EXTRACT(o.data, '$.city')) AS city
FROM employees_json e
JOIN offices_json o
    ON JSON_UNQUOTE(JSON_EXTRACT(e.data, '$.officeCode')) =
       JSON_UNQUOTE(JSON_EXTRACT(o.data, '$.officeCode'));
```

---

## Notes

- The `.env` file is listed in `.gitignore` and **must not be committed** to the repository.
- If the tables already exist with a different structure, drop them manually before running the scripts:
  ```sql
  SET FOREIGN_KEY_CHECKS = 0;
  DROP TABLE IF EXISTS offices_json;
  DROP TABLE IF EXISTS employees_json;
  DROP TABLE IF EXISTS employees_xml;
  SET FOREIGN_KEY_CHECKS = 1;
  ```