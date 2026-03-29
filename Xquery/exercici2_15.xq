let $lastNames := ("Fixter", "King")
let $empNums := doc("CLASSICMODELS_BD/Employees.xml")//employee[lastName = $lastNames]/@employeeNumber
let $custNums := doc("CLASSICMODELS_BD/Customers.xml")//customer[salesRepEmployeeNumber = $empNums]/@customerNumber
for $c in doc("CLASSICMODELS_BD/Payments.xml")//check
where $c/customer/@customerNumber = $custNums
order by number($c/amount) descending
return concat("ID: ", $c/@number, ", Quantitat: ", $c/amount)