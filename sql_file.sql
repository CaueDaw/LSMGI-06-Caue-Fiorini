-- 1
CREATE TABLE employees_xml (
    id INT AUTO_INCREMENT PRIMARY KEY,
    xml_data LONGTEXT
);

SELECT * FROM employees_xml;

-- 2.1
SELECT ExtractValue(xml_data, '//employee[jobTitle="VP Sales"]/email')
FROM employees_xml;

-- 2.2
SELECT ExtractValue(xml_data, 'count(//employee[office/Territory="EMEA"])')
FROM employees_xml;

-- 2.3
SELECT ExtractValue(xml_data, '//employee[reportsTo="1056"]/lastName')
FROM employees_xml;

-- 2.4
SELECT ExtractValue(xml_data, '//employee[@employeeNumber="1166"]/office/City')
FROM employees_xml;

-- 4.1
SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '$.phone')) AS phone
FROM offices_json;

-- 4.2
SELECT *
FROM employees_json
WHERE JSON_EXTRACT(data, '$.extension') LIKE '%23%';

-- 4.3
SELECT 
    employee_id,
    JSON_UNQUOTE(JSON_EXTRACT(data, '$.lastName')) AS lastName
FROM employees_json;

-- 4.4
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
